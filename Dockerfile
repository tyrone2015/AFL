FROM debian:buster
MAINTAINER xq "seleniumhistory@gmail.com"

RUN apt update && \
    apt-get -y install make clang gcc g++

COPY . /afl/
WORKDIR /afl/

RUN make && \
    cd llvm_mode && \
    ln -s /usr/bin/llvm-config-7 /usr/bin/llvm-config && \
    make && \
    cd ../ && \
    make install && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*


CMD /usr/local/bin/afl-fuzz
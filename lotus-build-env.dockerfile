# build container stage
FROM golang:1.15.5

COPY sources.list /etc/apt/sources.list
RUN apt-get update -y && \
	apt install mesa-opencl-icd ocl-icd-opencl-dev gcc git bzr jq pkg-config curl clang build-essential hwloc libhwloc-dev -y

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o rustup-init.sh && \
	chmod +x rustup-init.sh && \
	./rustup-init.sh -y

ADD config/cargo /root/.cargo/config

ENV PATH="$PATH:/root/.cargo/bin"
ENV GOPROXY https://goproxy.cn

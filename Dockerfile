FROM golang:1.17.8 AS builder
WORKDIR /root
COPY . .
RUN make

FROM harbor.oneitfarm.com/bifrost/nettools:v1.1

RUN apt-get update -y && \
    apt-get install iptables -y

WORKDIR /

RUN ln -s /lib/aarch64-linux-gnu/libc.so.6 /lib/aarch64-linux-gnu/libc.so

COPY --from=builder /root/iptables-server .

ENTRYPOINT ["/iptables-server"]



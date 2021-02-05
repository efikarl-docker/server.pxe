FROM alpine:latest

ENV HTTP_USER=foo HTTP_PASS=bar

COPY srv /srv

RUN apk add --no-cache dnsmasq
RUN apk add --no-cache curl && curl -sL https://github.com/jpillora/webproc/releases/download/v0.3.3/webproc_0.3.3_linux_amd64.gz | gzip -d - > /usr/local/bin/webproc && chmod +x /usr/local/bin/webproc

EXPOSE 67/udp 68/udp 69/udp 4011/udp

ENTRYPOINT ["webproc","--configuration-file","/etc/dnsmasq.conf","--","dnsmasq","--no-daemon","--dhcp-broadcast"]
# CMD ["--dhcp-range=192.168.0.0, 192.168.255.255,4h"]

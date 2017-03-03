FROM golang:1.8

ENV container docker
WORKDIR /root/
COPY run.sh run.sh
EXPOSE 6060
CMD ["bash", "-c", "/root/run.sh"]

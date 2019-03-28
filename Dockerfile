FROM golang:latest

ENV container docker
WORKDIR /root/
COPY run.sh run.sh
EXPOSE 6060
CMD ["bash", "-c", "/root/run.sh"]

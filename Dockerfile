FROM registry.cn-hangzhou.aliyuncs.com/eryajf/golang:1.22.2-alpine3.19 AS builder

ENV GO111MODULE=on
ENV GOPROXY=https://goproxy.cn,direct
ENV GIN_MODE=release

WORKDIR /Users/liuyu/Server/FreeDuckDuckGo
# COPY FreeDuckDuckGoRun ./
COPY main.go ./
COPY go.mod ./
COPY go.sum ./
RUN go env -w GO111MODULE=on && \
go env -w GOPROXY=https://goproxy.cn,direct && \
go get -d -v ./ && \
CGO_ENABLED=0 go build -a -installsuffix cgo -o FreeDuckDuckGoRun .

FROM alpine:latest
WORKDIR /app
COPY --from=builder /Users/liuyu/Server/FreeDuckDuckGo/FreeDuckDuckGoRun /app/FreeDuckDuckGoRun

CMD ["/app/FreeDuckDuckGoRun"]

FROM golang:1.7.3

RUN apt-get update && apt-get install -y git-core curl jq make && apt-get clean
RUN go get -u github.com/BuoyantIO/namerctl
RUN go install github.com/BuoyantIO/namerctl
RUN go get golang.org/x/net/context google.golang.org/grpc github.com/golang/protobuf/proto golang.org/x/net/http2
ENV GOBIN=$GOPATH/bin      \
    PATH=$PATH:$GOPATH/bin

COPY service.dtab $GOPATH/src/github.com/sfroment/l5d_bug/
COPY helloworld $GOPATH/src/github.com/sfroment/l5d_bug/helloworld/

WORKDIR $GOPATH/src/github.com/sfroment/l5d_bug/

RUN go install -v ./helloworld/greeter_server

CMD ["greeter_server"]
EXPOSE 50051



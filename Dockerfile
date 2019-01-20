FROM golang:1.10.4
WORKDIR /go/src/github.com/kubesoft/kubedex/
RUN go get -u github.com/golang/dep/cmd/dep
COPY . .
RUN dep ensure
RUN CGO_ENABLED=0 GOOS=linux go build -a -o kubectl_app -ldflags "-X main.Version=$(cat VERSION)-$(git rev-parse HEAD)" ./cmd/kubectl_app

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /go/src/github.com/kubesoft/kubedex/kubectl_app .
ENTRYPOINT ["./kubectl_app"]

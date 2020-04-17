FROM golang:1.14 as builder

RUN mkdir /app
WORKDIR /app
ADD . /app/
#RUN go build -a -o smk -v -ldflags '-w' .
RUN make build


FROM scratch
COPY --from=builder /app/bin/smak /smak
ENTRYPOINT ["/smak"]

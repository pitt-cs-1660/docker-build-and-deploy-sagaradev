FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod ./
COPY main.go ./
COPY templates ./templates

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app .


FROM scratch

WORKDIR /app

COPY --from=builder /app/app .
COPY --from=builder /app/templates ./templates

EXPOSE 8000

ENTRYPOINT ["/app/app"]
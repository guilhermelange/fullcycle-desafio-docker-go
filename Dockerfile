# Builder
FROM golang:1.22-alpine as builder

WORKDIR /app

COPY go.mod ./
RUN go mod download && go mod verify

COPY src .

RUN go build -o hello

# App
FROM scratch

WORKDIR /app

COPY --from=builder /app/hello .

CMD ["./hello"]
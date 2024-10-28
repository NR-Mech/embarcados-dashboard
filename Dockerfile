FROM golang:1.23.2-alpine3.20 AS build

WORKDIR /app

COPY . .

RUN go mod tidy \
    && go build -o /app/api app/cmd/api/main.go

###############################################

FROM alpine:3.20

WORKDIR /app


COPY --from=build /app/api /app/api

EXPOSE 3000

CMD ["./api"]

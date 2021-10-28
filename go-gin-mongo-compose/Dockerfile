FROM golang:1.17-buster

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY *.go ./
COPY 1-controllers ./1-controllers
COPY 2-services ./2-services
COPY auth ./auth
COPY database ./database
COPY models ./models
COPY .env ./
RUN go mod tidy

RUN go build -o /docker-gs-ping
ENTRYPOINT ["/docker-gs-ping"]
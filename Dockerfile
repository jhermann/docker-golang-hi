# Example of a multi-stage golang build, with a run container ‘from scratch’
#
#   docker build -t jhermann/gohi -t jhermann/gohi:$(git describe --tags) .
#   docker run --rm -it jhermann/gohi

# Compile and link golang binary in a build container
FROM golang:alpine AS builder
RUN apk --update add --no-cache ca-certificates
COPY *.go ./
RUN env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
        go build -a -installsuffix cgo -ldflags="-w -s" -o /usr/local/bin/hi \
    && ls -lh /usr/local/bin/hi

# Create the runtime image
FROM scratch AS runtime
LABEL maintainer="Juergen Hermann <jh@web.de>"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="jhermann/gohi"
LABEL org.label-schema.description="Multi-stage golang build with a 'from scratch' run container"
LABEL org.label-schema.url="https://github.com/jhermann/docker-golang-hi"
LABEL org.label-schema.vcs-url="https://github.com/jhermann/docker-golang-hi.git"
LABEL org.label-schema.docker.cmd="docker run --rm -it jhermann/gohi"

# Copy root certificates
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

# Copy pre-built statically linked golang binary and make it the entrypoint
COPY --from=builder /usr/local/bin/hi /usr/local/bin/hi
ENTRYPOINT ["/usr/local/bin/hi"]

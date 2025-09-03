
FROM rust:1.71 as builder

WORKDIR /usr/src/app
COPY . .


RUN cargo build --release


FROM debian:bullseye-slim


RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/src/app/target/release/binserve /usr/local/bin/binserve
COPY --from=builder /usr/src/app/binserve.json /usr/local/bin/binserve.json

WORKDIR /usr/local/bin
EXPOSE 1337

CMD ["./binserve", "-c", "binserve.json"]




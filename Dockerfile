FROM debian:buster

RUN set -eux; \
	apt-get update; \
	apt-get install --no-install-recommends -y fuse-overlayfs; \
	mkdir /layman; \
	rm -rf /var/lib/apt/lists/*;

COPY entrypoint.sh /


CMD [ "./entrypoint.sh" ]

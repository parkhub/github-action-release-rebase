FROM docker.io/alpine:3.11

LABEL \
  "name"="ParkHub Release Rebase" \
  "repository"="https://github.com/parkhub/github-action-release-rebase" \
  "maintainer"="ParkHub"

RUN apk add --no-cache \
			bash \
			git \
			openssh-client && \
		echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

ADD entrypoint.bash /

ENTRYPOINT ["/entrypoint.bash"]

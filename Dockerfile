FROM docker.io/alpine:3.11

LABEL \
  "version"="0.0.0" \
  "name"="ParkHub Release Rebase" \
  "repository"="https://github.com/parkhub/github-action-release-rebase" \
  "maintainer"="ParkHub" \
  "com.github.actions.name"="Release Rebase" \
  "com.github.actions.description"="Automatically rebase development branches on master" \
  "com.github.actions.icon"="git-rebase" \
  "com.github.actions.color"="orange"

RUN apk add --no-cache \
      bash \
      git \
      openssh-client && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

ADD entrypoint.bash /

ENTRYPOINT ["/entrypoint.bash"]

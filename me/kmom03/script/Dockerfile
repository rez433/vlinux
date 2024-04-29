FROM debian:stretch-slim

RUN apt-get update && \
    apt-get -y install bsdmainutils

WORKDIR /scripts

COPY commands.bash /scripts/

RUN chmod +x /scripts/*.bash

# ENTRYPOINT ["/bin/bash", "-c"]

CMD ["/bin/bash", "/scripts/commands.bash"]
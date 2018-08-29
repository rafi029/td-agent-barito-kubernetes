FROM gcr.io/google_containers/ubuntu-slim:0.6

# Ensure there are enough file descriptors for running td-agent.
RUN ulimit -n 65536

# Disable prompts from apt.
ENV DEBIAN_FRONTEND noninteractive

# Copy the td-agent configuration file.
COPY td-agent.conf /etc/td-agent/td-agent.conf

COPY build.sh /tmp/build.sh
RUN ["chmod", "+x", "/tmp/build.sh"]
RUN /tmp/build.sh

ENV LD_PRELOAD /opt/td-agent/embedded/lib/libjemalloc.so

# Run the td-agent service.
ENTRYPOINT ["td-agent"]

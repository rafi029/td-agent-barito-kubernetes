FROM gcr.io/google_containers/ubuntu-slim:0.6

# Ensure there are enough file descriptors for running td-agent.
RUN ulimit -n 100000

# Disable prompts from apt.
ENV DEBIAN_FRONTEND noninteractive

COPY build.sh /tmp/build.sh
RUN ["chmod", "+x", "/tmp/build.sh"]
RUN /tmp/build.sh

ENV LD_PRELOAD /opt/td-agent/embedded/lib/libjemalloc.so

# Run the td-agent service.
ENTRYPOINT ["tini", "-v", "--", "watchexec", "-v", "-w", "/etc/td-agent", "-n", "-s", "SIGHUP", "td-agent"]

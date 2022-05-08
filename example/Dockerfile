FROM distroless-perl AS build-env
ARG modules=""
ARG script=""

COPY $script /tmp

# Install required modules and packege the script
WORKDIR /app
RUN set -eux; \
    s="${script}"; \
    local_script="/tmp/${s##*/}"; \
    if ! [ -f "$local_script" ]; then \
        echo 'Build arg 'script" is required. It is the relative path to the script."; \
        exit 1; \
    fi;

RUN set -eux; \
    if [ -n $modules ]; then \
        for m in $(echo "$modules" | tr ',' ' '); do \
            cpan $m; \
        done; \
    fi;

RUN set -eux; \
    s="${script}"; \
    local_script="/tmp/${s##*/}"; \
    pp -o exe "$local_script";

# distroless base images (c) GoogleContainerTools
# Debug: Uncomment to have an image with busybox added
# FROM gcr.io/distroless/base:debug
FROM gcr.io/distroless/base

# Needed for PAR::Packer to work
WORKDIR /lib/x86_64-linux-gnu
COPY --from=build-env /lib/x86_64-linux-gnu/libcrypt.so.1 .
COPY --from=build-env /lib/x86_64-linux-gnu/libz.so.1 .

COPY --from=build-env /tmp/par-* /tmp

# Perl script packed as an executable
WORKDIR /app
COPY --from=build-env /app/exe ./

WORKDIR /workdir
ENV PERL5DIR="/usr/local/share/perl"
ENTRYPOINT [ "/app/exe" ]

# Copyright 2022 Roberto Etcheverry

# Image to create "distroless" images, that use Debian 11 (bullseye)
FROM debian:bullseye

RUN set -eux; \
    apt-get update; apt-get upgrade -y; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        build-essential \
        perl-base \
        libperl-dev \
        perl-tk \
        libpar-perl \
        perl-doc \
        bash \
        vim \
    ; \
    cpan PAR::Packer;

ENTRYPOINT [ "/bin/bash" ]

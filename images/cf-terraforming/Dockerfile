ARG BASE_IMAGE=iboss/alpine
ARG BUILDER_IMAGE=golang:alpine

### BUILDER ####################################################################

FROM ${BUILDER_IMAGE} AS builder

ARG CF_TERRAFORMING_REPO=github.com/cloudflare/cf-terraforming

RUN set -x; \
  apk add --no-cache git; \
  go get -u -v ${CF_TERRAFORMING_REPO}/...

COPY rootfs /rootfs

RUN set -x; \
  cp /go/bin/cf-terraforming /rootfs/usr/bin/; \
  chmod +x /rootfs/usr/bin/cf-backup

### IMAGE ######################################################################

FROM ${BASE_IMAGE}

ENV \
  CHARSET="UTF-8" \
  LANG="en_US.UTF-8"

COPY --from=builder /rootfs /

################################################################################

### BASE_IMAGE #################################################################

BASE_IMAGE		?= iboss/alpine
BASE_IMAGE_TAG		?= latest

### DOCKER_IMAGE ###############################################################

DOCKER_VENDOR		?= iboss
DOCKER_NAME		?= cf-terraforming
DOCKER_IMAGE_TAG	?= latest
DOCKER_IMAGE_DESC	?= Cloudflare Terraforming
DOCKER_IMAGE_URL	?= https://github.com/cloudflare/cf-terraforming

DOCKER_BUILDKIT		?= 1

### BUILDER_IMAGE ##############################################################

CF_TERRAFORMING_REPO	?= github.com/cloudflare/cf-terraforming
BUILDER_IMAGE		?= golang:1.13-alpine
BUILD_VARS		+= BUILDER_IMAGE \
			   CF_TERRAFORMING_REPO

### MAKE_TARGETS ###############################################################

# Build an image, run tests, and then clean
.PHONY: all
all: image
	@$(MAKE) clean

# Build an image and run tests
.PHONY: image
image: lint build start wait logs test

# Pull all images from the Docker Registry
.PHONY: pull
pull: docker-pull

# Publish the image into the Docker Registry
.PHONY: publish
publish: docker-push

# Lint project files
.PHONY: lint
lint: docker-lint

# Lint shell scripts
.PHONY: shellcheck
shellcheck:
	@echo "+++ shellcheck help: https://github.com/koalaman/shellcheck/wiki/Checks" > /dev/stderr
	@for FILE in $(shell cd $(PROJECT_DIR); ls rootfs/usr/bin/*); do ( \
		set -x; \
		docker run --rm --volume "$(PROJECT_DIR):/mnt" koalaman/shellcheck:stable $${FILE} \
	); done

# Build an image with using the Docker layer caching
.PHONY: build
build: docker-build

# Build an image without using the Docker layer caching
.PHONY: rebuild
rebuild: docker-rebuild

# Show make variables
.PHONY: vars
vars: docker-makevars

# Remove all containers and then run them fresh
.PHONY: up
up: docker-up

# Create the containers
.PHONY: create
create: docker-create

# Start the containers
.PHONY: start
start: create docker-start

# Wait for the containers to start
.PHONY: wait
wait: start docker-wait

# List running containers
.PHONY: ps
ps: docker-ps

# Show the container logs
.PHONY: logs
logs: start docker-logs

# Follow the container logs
.PHONY: tail
tail: start docker-logs-tail

# Run the shell in the container
.PHONY: sh
sh: start docker-shell

# Run the tests
.PHONY: test
test: start docker-test

# Run the shell in the test container
.PHONY: tsh
tsh: start
	@$(MAKE) test TEST_CMD=/bin/bash RSPEC_FORMAT=documentation

# Restart the containers
.PHONY: restart
restart: start docker-restart

# Stop the containers
.PHONY: stop
stop: docker-stop

# Delete the containers
.PHONY: down
down: docker-rm

# Delete the containers and working files
.PHONY: clean
clean: docker-clean

### MK_DOCKER_IMAGE ############################################################

BUILD_DIR		?= $(CURDIR)
PROJECT_DIR		?= $(CURDIR)/../..
MK_DIR			?= $(PROJECT_DIR)/../Mk
include $(MK_DIR)/docker.image.mk

################################################################################

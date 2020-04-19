SUBDIRS		?= cf-terraforming

# Build and test all images
.PHONY: all
all:
	@$(MAKE) $(SUBDIRS) TARGET=all

# Pull all images from Docker registry
.PHONY: pull
pull:
	@$(MAKE) $(SUBDIRS) TARGET=pull

# Publish all images into Docker registry
.PHONY: publish
publish:
	@$(MAKE) $(SUBDIRS) TARGET=publish

# Clean all images
.PHONY: clean
clean:
	@$(MAKE) $(SUBDIRS) TARGET=clean

# Build and test the image
.PHONY: $(SUBDIRS)
$(SUBDIRS):
	@cd $@; make docker-version $(or $(TARGET),all)


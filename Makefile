SUBDIRS		?= images

# Build all
.PHONY: all
all:
	@$(MAKE) $(SUBDIRS) TARGET=all

# Clean all
.PHONY: clean
clean:
	@$(MAKE) $(SUBDIRS) TARGET=clean

# Build subdirs
.PHONY: $(SUBDIRS)
$(SUBDIRS):
	@cd $@; make $(or $(TARGET),all)


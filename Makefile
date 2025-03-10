BK_PREFIX := backup
BK_ROOT := $(CURDIR)/$(BK_PREFIX)
SUDO_USER ?= $(shell whoami)

.DEFAULT_GOAL := archive

# don't print $(MAKE) directory by default
MAKEFLAGS += $(if $(value VERBOSE),,--no-print-directory)

_load/%:
	ARCHIVE_REL=$(patsubst _load/%,%,$@); \
	ARCHIVE_DEST="$$(dirname "$(BK_ROOT)/$${ARCHIVE_REL}")"; \
	mkdir -p "$${ARCHIVE_DEST}"; \
	cp -r "/$${ARCHIVE_REL}" "$${ARCHIVE_DEST}"

_chown:
	chown -R "$(SUDO_USER):$(SUDO_USER)" "$(BK_ROOT)"

load:
	@$(MAKE) _load/etc
	@$(MAKE) _load/usr/local/bin
	@$(MAKE) _load/root/.config
	@$(MAKE) _load/~$(SUDO_USER)/.xinitrc
	@$(MAKE) _load/~$(SUDO_USER)/.profile
	@$(MAKE) _chown

archive:
	BK_ARCHIVE="$(BK_PREFIX)_$$(date +"%Y-%m-%d-%H:%M:%S")"; \
	tar cfz $(CURDIR)/$${BK_ARCHIVE}.tar.gz -C $(BK_ROOT) .

clean:
	rm -rf *.{tar,tar.gz}
	rm -rf $(BK_ROOT)

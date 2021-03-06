include Makefile.inc

DIRMAN = man

DIRTOOLS = tools

DIRSCRIPTS = scripts

DIRSERVICES = services-scripts

.PHONY: all


all:
	$(MAKE) -C $(DIRTOOLS) all
	$(MAKE) -C $(DIRSCRIPTS) all
	$(MAKE) -C $(DIRMAN) all

install: all

	$(MAKE) -C $(DIRTOOLS) install
	$(MAKE) -C $(DIRSCRIPTS) install
	$(MAKE) -C $(DIRMAN) install
	$(MAKE) -C $(DIRSERVICES) install-service-setup-nutyx
man:
	$(MAKE) -C $(DIRMAN) man
clean:

	$(MAKE) -C $(DIRSCRIPTS) clean
	$(MAKE) -C $(DIRMAN) clean

install-%:
	$(MAKE) -C $(DIRSERVICES) $@

dist: distclean

	git archive --format=tar --prefix=$(NAME)/ HEAD | tar -x
	git log > $(NAME)/ChangeLog
	tar cJvf $(NAME).tar.xz $(NAME)
	rm -rf $(NAME)
	sed -i "/yaolinux-/d" scripts/wget_nutyx_list
	md5sum $(NAME).tar.xz >> scripts/wget_nutyx_list

distclean:
	rm -rf $(NAME).tar.xz

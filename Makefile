BUILD_DIR = build
DESCRIPTION = CS50 Library for Python
MAINTAINER = CS50 <sysadmins@cs50.harvard.edu>
NAME = lib50-python
VERSION = 1.2.1

.PHONY: bash
bash:
	docker run -i --rm -t -v "$(PWD)":/root cs50/cli

.PHONY: build
build: clean
	mkdir -p "$(BUILD_DIR)"/usr/lib/python2.7/dist-packages/cs50
	cp src/* "$(BUILD_DIR)"/usr/lib/python2.7/dist-packages/cs50
	mkdir -p "$(BUILD_DIR)"/usr/lib/python3/dist-packages/cs50
	cp src/* "$(BUILD_DIR)"/usr/lib/python3/dist-packages/cs50

.PHONY: clean
clean:
	rm -rf "$(BUILD_DIR)"

.PHONY: deb
deb: build
	fpm \
	-C "$(BUILD_DIR)" \
	-m "$(MAINTAINER)" \
	-n "$(NAME)" \
	-p "$(BUILD_DIR)" \
	-s dir \
	-t deb \
	-v "$(VERSION)" \
	--after-install after-install.sh \
	--deb-no-default-config-files \
	--depends python \
	--depends python3 \
	--description "$(DESCRIPTION)" \
	--provides "$(NAME)" \
	usr

# Makefile for the Docker image bandsintown/alpine
# MAINTAINER: Bandsintown Devops <devops@bandsintown.com>

SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.PHONY: all build release test

IMAGE = bandsintown/alpine
IMAGE_TEST=$(IMAGE)-test
VERSIONS = 3.4 3.5
VERSION =
BUILD_NUM = $(shell git rev-parse --short HEAD)

all:
	@echo "Supported versions: $(VERSIONS)"
	@echo "Available targets:"
	@echo "  * build - build images"
	@echo "  * test  - run integration tests"
	@echo "  * release  - git tag build and push to Docker Hub"

build:
	@$(foreach var,$(VERSIONS),$(MAKE) do/build VERSION=$(var);)
	@$(MAKE) do/tag-latest VERSION=$(word $(words $(VERSIONS)),$(VERSIONS))

do/build:
	@echo "=> building $(IMAGE):$(VERSION)-$(BUILD_NUM)"
	docker build -t $(IMAGE):$(VERSION) -f versions/$(VERSION)/Dockerfile .
	docker tag $(IMAGE):$(VERSION) $(IMAGE):$(VERSION)-$(BUILD_NUM)

test:
	@$(foreach var,$(VERSIONS),$(MAKE) do/test VERSION=$(var);)

do/test: do/build-test
	@echo "=> running tests for $(IMAGE):$(VERSION)-$(BUILD_NUM)"
	docker run -e VERSION=$(VERSION) $(IMAGE_TEST):$(VERSION)-$(BUILD_NUM) bats /tests/image
	docker run -e VERSION=$(VERSION) --dns=8.8.4.4 --dns-search=10.0.0.1.xip.io $(IMAGE_TEST):$(VERSION)-$(BUILD_NUM) bats /tests/dnsmasq/01-resolve_dns.bats
	docker run -e VERSION=$(VERSION) --dns 8.8.4.4 --dns 8.8.8.8 --dns-search google.com --dns-search video.google.com $(IMAGE_TEST):$(VERSION)-$(BUILD_NUM) bats /tests/dnsmasq/02-resolve_dns_multiple.bats

do/build-test:
	docker build -t $(IMAGE_TEST):$(VERSION)-$(BUILD_NUM) -f versions/$(VERSION)/Dockerfile-tests .

release: git-tag
	@$(foreach var,$(VERSIONS),$(MAKE) do/release VERSION=$(var);)
	docker push $(IMAGE):latest

do/release:
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE):$(VERSION)-$(BUILD_NUM)

git-tag:
	git tag -f -a build-$(BUILD_NUM) -m "Release CI build $(BUILD_NUM)"
	git push -f --tags

do/tag-latest:
	docker tag $(IMAGE):$(VERSION) $(IMAGE):latest

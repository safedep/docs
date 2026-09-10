MINTLIFY_IMAGE ?= safedep-docs-mintlify
MINTLIFY_VERSION ?= 4.2.882
PREVIEW_HOST ?= 127.0.0.1
PORT ?= 3000

.PHONY: dev
dev:
	docker build \
		--build-arg MINTLIFY_VERSION=$(MINTLIFY_VERSION) \
		--tag $(MINTLIFY_IMAGE) \
		.
	docker run --rm --interactive --tty --init \
		--publish $(PREVIEW_HOST):$(PORT):$(PORT) \
		--volume "$(CURDIR):/docs" \
		--volume safedep-docs-mintlify-cache:/home/node/.mintlify \
		$(MINTLIFY_IMAGE) \
		mintlify dev --host 0.0.0.0 --port $(PORT) --no-open

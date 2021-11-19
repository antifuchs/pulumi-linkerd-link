VERSION ?= $(patsubst v%,%,$(shell git describe))

bin/pulumi-sdkgen-linkerd-link: cmd/pulumi-sdkgen-linkerd-link/*.go
	go build -o bin/pulumi-sdkgen-linkerd-link ./cmd/pulumi-sdkgen-linkerd-link

python-sdk: bin/pulumi-sdkgen-linkerd-link
	rm -rf sdk
	bin/pulumi-sdkgen-linkerd-link $(VERSION)
	cp README.md sdk/python/
	cd sdk/python/ && \
		sed -i.bak -e "s/\$${VERSION}/$(VERSION)/g" -e "s/\$${PLUGIN_VERSION}/$(VERSION)/g" setup.py && \
		rm setup.py.bak

.PHONY: install
install:
	go install ./cmd/pulumi-resource-linkerd-link

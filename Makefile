TIMESTAMP             	:= $(shell /bin/date "+%F %T")
NAME					:= regioncn-mysql
VERSION					:= 1.0.0

default:
	@echo "no default target" && false

release:
	docker image build -t quay.io/yingzhuo/$(NAME):$(VERSION) --build-arg VERSION=$(VERSION) $(CURDIR)
	docker login --username=yingzhuo --password="${QUAY_PASSWORD}" quay.io &> /dev/null
	docker image push quay.io/yingzhuo/$(NAME):$(VERSION)
	docker image tag  quay.io/yingzhuo/$(NAME):$(VERSION) quay.io/yingzhuo/$(NAME):latest
	docker image push quay.io/yingzhuo/$(NAME):latest
	docker logout quay.io &> /dev/null

.PHONY: release

TIMESTAMP             	:= $(shell /bin/date "+%F %T")
NAME					:= regioncn-mysql
VERSION					:= 1.0.0

default:
	@echo "no default target" && false

clean:
	docker image rm quay.io/yingzhuo/$(NAME):$(VERSION) &> /dev/null || true
	docker image rm quay.io/yingzhuo/$(NAME):latest &> /dev/null || true

release:
	docker image build -t quay.io/yingzhuo/$(NAME):$(VERSION) --build-arg VERSION=$(VERSION) $(CURDIR)
	docker login --username=yingzhuo --password="${QUAY_PASSWORD}" quay.io &> /dev/null
	docker image push quay.io/yingzhuo/$(NAME):$(VERSION)
	docker image tag  quay.io/yingzhuo/$(NAME):$(VERSION) quay.io/yingzhuo/$(NAME):latest
	docker image push quay.io/yingzhuo/$(NAME):latest
	docker logout quay.io &> /dev/null

github: clean
	git add .
	git commit -m "$(TIMESTAMP)"
	git push

.PHONY: default clean release github

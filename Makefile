TIMESTAMP             	:= $(shell /bin/date "+%F %T")
NAME					:= regioncn-mysql
VERSION					:= 1.0.0

default:
	@echo "no default target" && false

clean:
	@docker image rm registry.cn-shanghai.aliyuncs.com/yingzhor/$(NAME):$(VERSION) &> /dev/null || true
	@docker image rm registry.cn-shanghai.aliyuncs.com/yingzhor/$(NAME):latest     &> /dev/null || true

build:
	docker image build -t registry.cn-shanghai.aliyuncs.com/yingzhor/$(NAME):$(VERSION) --build-arg VERSION=$(VERSION) $(CURDIR)
	docker image tag      registry.cn-shanghai.aliyuncs.com/yingzhor/$(NAME):$(VERSION) registry.cn-shanghai.aliyuncs.com/yingzhor/$(NAME):latest

release: build
	docker login --username=yingzhor@gmail.com --password="${ALIYUN_PASSWORD}" registry.cn-shanghai.aliyuncs.com
	docker image push registry.cn-shanghai.aliyuncs.com/yingzhor/$(NAME):$(VERSION)
	docker image push registry.cn-shanghai.aliyuncs.com/yingzhor/$(NAME):latest
	docker logout registry.cn-shanghai.aliyuncs.com &> /dev/null

github: clean
	git add .
	git commit -m "$(TIMESTAMP)"
	git push

.PHONY: default clean build release github

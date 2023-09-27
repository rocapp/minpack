
export AWS_ACCOUNT_ID := $(shell grep -oP 'AWS_ACCOUNT_ID=\K.*' .env)

build_ubuntu_python: 
	./scripts/build_ubuntu_python.sh

install_minpack: 
	./scripts/install_minpack.sh

build-lambda:
	./scripts/build_lambda.sh

push2ecr: 
	./scripts/push2ecr.sh

setup-lambda-layer: build-lambda push2ecr
	./scripts/setup-lambda-layer.sh

.PHONY: build_ubuntu_python install_minpack push2ecr setup-lambda-layer

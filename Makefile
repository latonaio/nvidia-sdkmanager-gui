.DEFAULT_GOAL := help
.SHELL := bash

.PHONY: setup
setup: ## ホスト環境の事前準備
	sudo bash ./scripts/setup-host.sh

.PHONY: _load
_load:
	docker load < sdkmanager-$(version)_docker.tar.gz

# _load の後に実行される
.PHONY: _tag
_tag: _load
	docker tag sdkmanager:$(version) sdkmanager:latest

# _load, _tag の後に実行される
.PHONY: docker-build
docker-build: _load _tag ## Docker イメージのビルド (引数: version)
	docker compose build

.PHONY: launch
launch: ## ビルド済み Docker イメージの実行
	@# SDK Manager が内部で呼び出す qemu-aarch64-static のためのカーネルモジュールのロード
	sudo modprobe binfmt_misc
	@# localhost による X サーバへの接続の際の認証を無効化
	xhost +local: > /dev/null
	@# 実行, 終了時に必ずコンテナごと削除・展開済みファイルも削除する
	docker compose run --rm sdkmanager-gui --delete-extracted

.PHONY: icon
icon: ## デスクトップアイコンを作成する (イメージビルド後に実行してください)
	bash ./scripts/make-desktop-icon.sh

.PHONY: shell
shell: ## 実行中の Docker コンテナ内でシェルを実行 (トラブルシューティング用)
	docker compose exec sdkmanager-gui /bin/bash


# Self-Documented Makefile
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

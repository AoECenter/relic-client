JS_SRC = $(shell find src/js)
RS_SRC = $(shell find src/js)

.PHONY: dev-server
dev-server: node_modules
	./node_modules/.bin/vite dev

node_modules: pnpm-lock.yaml
	pnpm install

build/.server: node_modules $(JS_SRC) svelte.config.js vite.config.js jsconfig.json
	./node_modules/.bin/vite build --debug
	touch $@

build/.client: build/.server node_modules Cargo.lock Cargo.toml tauri.conf.json
	./node_modules/.bin/tauri build --verbose
	touch $@

.PHONY: dev build test clean new

dev:
	hugo server -D

build:
	hugo --minify

test:
	./scripts/test-code-copy.sh

clean:
	rm -rf public resources

new:
	./scripts/new-note.sh "$(slug)" "$(title)"

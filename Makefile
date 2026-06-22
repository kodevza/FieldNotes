.PHONY: dev build clean new

dev:
	hugo server -D

build:
	hugo --minify

clean:
	rm -rf public resources

new:
	./scripts/new-note.sh "$(slug)" "$(title)"

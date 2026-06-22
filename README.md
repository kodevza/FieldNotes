# Owner Notes Hugo Starter

Minimal Hugo setup for Markdown field notes with screenshots.

## Install Hugo on Ubuntu

```bash
sudo snap install hugo
# or, if you want the latest Debian package manually, install from Hugo releases
```

## Run locally

```bash
make dev
```

Open the local URL printed by Hugo.

## Add a new note

```bash
make new slug=entra-risk-review title="Field Note: Entra Risk Review"
```

Each note is a Hugo page bundle:

```text
content/notes/my-note/
  index.md
  001-screenshot.png
  002-screenshot.png
```

Reference screenshots from `index.md`:

```md
![Short description](001-screenshot.png)
```

## Build static HTML

```bash
make build
```

Output goes to `public/`.

## Deploy

This starter includes `.github/workflows/deploy.yml` for GitHub Pages.
In GitHub repo settings, set Pages source to GitHub Actions.

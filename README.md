# tomasmiguez.github.io

Personal site: a CV landing page plus a blog. Built with [Hugo](https://gohugo.io/) and
deployed to GitHub Pages by `.github/workflows/hugo.yaml` on every push to `master`.

## Local

```sh
hugo server -D        # http://localhost:1313
hugo --gc --minify    # production build into public/
```

## Updating the CV

Edit `data/cv.yaml`. It is the only source: `layouts/home.html` renders it as the landing
page, and the deploy workflow prints that page to `public/cv.pdf` with headless Chrome via
`scripts/render-pdf.sh`, so the PDF is regenerated on every push.

To build the PDF locally (needs Chrome or Chromium on the PATH):

```sh
hugo --gc --minify && scripts/render-pdf.sh public
```

`hugo server` does not run that step, so `/cv.pdf` returns 404 in the dev server.

## Style

Everything visual is `assets/css/main.css`, in three layers: layout (all media), the screen
theme (a Caves of Qud terminal look, with its palette in the custom properties at the top of
the layer), and the print layer that becomes `cv.pdf`. Screen decorations never reach the PDF.
Body text uses "Site Mono", a self-hosted Latin subset of Iosevka Term in `static/fonts/`
(renamed because Iosevka's OFL licence reserves its name; licence file alongside).

## Writing a post

```sh
hugo new content posts/my-post.md
```

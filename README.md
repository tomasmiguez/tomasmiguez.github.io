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

## Writing a post

```sh
hugo new content posts/my-post.md
```

# tomasmiguez.github.io

Personal site: a CV landing page plus a blog. Built with [Hugo](https://gohugo.io/) and
deployed to GitHub Pages by `.github/workflows/hugo.yaml` on every push to `master`.

## Local

```sh
hugo server -D        # http://localhost:1313
hugo --gc --minify    # production build into public/
```

## Updating the CV

The HTML CV is rendered by `layouts/home.html` from `data/cv.yaml`. The PDF is built from
the LaTeX source in the sibling `curriculum` repo and copied in as `static/cv.pdf`:

```sh
cd ../curriculum && latexmk -xelatex main.tex && cp main.pdf ../tomasmiguez.github.io/static/cv.pdf
```

`data/cv.yaml` and `curriculum/main.tex` are kept in sync by hand.

## Writing a post

```sh
hugo new content posts/my-post.md
```

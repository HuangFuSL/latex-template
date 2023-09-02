# latex-template

My latex template

## Features

Four modes are provided within the template, specify using document class arguments

* Article mode: `\documentclass[article]{huangfusl-template}`
* Beamer mode: `\documentclass[beamer]{huangfusl-template}`
* Book mode: `\documentclass[book]{huangfusl-template}`
* Standalone mode: `\documentclass[standalone]{huangfusl-template}`

### Common features

* Abbreviation for single letter `\mathbb`, `\mathbf`, `\mathcal`, `\mathrm` and `\boldsymbol`.
* Abbreviation for some math operators.
* CJK support provided by `ctex` package, use `cn` argument to enable, `en` to disable.
* `\ssection`, `\ssubsection` and `\ssubsubsection` to hide section numbering while keeps table of contents entry.
* Produce PDF-A documents (but metadata is left empty).
* `\remember` and `\recall` to repeat equations.

### Article mode

* Pre-configured font, spacing, header and footer.
* `\subtitle` command to set document subtitle.
* `\articlefront` as shortcut for a title and toc page.
* `\watermarkon` and `\watermarkoff` to toggle watermark.

### Beamer mode

* Theme pre-configured and locked.
* Support for [Présentation.app](http://iihm.imag.fr/blanch/software/osx-presentation/)

### Book mode

* Pre-configured font, spacing, header and footer.
* `\watermarkon` and `\watermarkoff` to toggle watermark.

### Backward compatibility

Use `version=<version>` to specify the template version. Newer version of template is backward-compatible.

```tex
\documentclass[article, cn, version=2.0]{huangfusl-template}
```

For changelog, refer to [Releases](https://github.com/HuangFuSL/latex-template/releases)

## Configuration

### Use directly

Before compiling any documents, simply add the path containing `huangfusl-template.cls` to `TEXINPUTS` environment variable.

```bash
export TEXINPUTS=/path-to-template//:
```

### Use via makefile

* Copy or link `makefile.latex.template` to `/usr/include`.
* Edit `export TEXINPUTS = /opt/template//:` line to match the path to `huangfusl-template.cls`
* Create a `makefile` in the project:

    ```makefile
    TARGET = <file-to-compile-without-extension>

    include makefile.latex.template
    ```

* Execute `make default` to compile the document.

Use `make help` to check all the build targets and environment variable options.

### Use via docker

The docker image contains the template itself, together with a full texlive installation. Using docker, one can achieve compiling `.tex` documents pure remotely on a docker host. It does not require the local machine to have texlive installed. However, as all texlive packages have been installed in the docker image, the size of image is kind of large (~5GB).

The workflow has been integrated into `makefile` process. Simply pass `DOCKER=1` environment variable to switch to docker.

```bash
make default DOCKER=1
```

## LaTeX Workshop integration

### Use directly

Add `env` option to toolchain in `settings.json`:

```json
{
    "name": "XeLaTeX",
    "command": "xelatex",
    "args": [
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "%DOCFILE%"
    ],
    "env": {
        "TEXINPUTS": "<path-to-template>//:"
    }
}
```

### Use makefile

First configure `makefile.latex.template`, write a `makefile`. Add the following compile tools in `latex-workshop.latex.tools` section of `settings.json`.

```json
{
    "name": "Make",
    "command": "make",
    "args": [ "default" ]
}
```

Add `DOCKER=1` environment variable to use docker, add `DOCKER_CONTEXT` environment variable to switch context

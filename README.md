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

### Use via docker

The docker image contains the template itself, together with a full texlive installation. Using docker, one can achieve compiling `.tex` documents pure remotely on a docker host. It does not require the local machine to have texlive installed. However, as all texlive packages have been installed in the docker image, the size of image is kind of large (~5GB).

First, create a volume container to store document files. The container does not need to be running.

```bash
docker create --name data -v /data:/data alpine
```

The workflow contains the following steps:

1. Clear remote workspace

    ```bash
    docker run --rm -v /data/document:/data ghcr.io/huangfusl/template:latest \
        find . -mindepth 1 -delete
    ```

2. Copy source file to docker container

    ```bash
    docker cp source-dir/. data:/data/document
    ```

3. Execute `xelatex` in the container (multiple times)

    ```bash
    docker run --rm -v /data/document:/data ghcr.io/huangfusl/template:latest \
        xelatex -synctex=1 -interaction=nonstopmode -output-directory=/data \
        -file-line-error document-to-compile.tex
    ```

4. (Optional) Execute `bibtex` in the container

    ```bash
    docker run --rm -v /data/document:/data ghcr.io/huangfusl/template:latest \
        bibtex document-to-compile
    ```

5. (Optional) Remove auxiliary files

    ```bash
    docker run --rm -v /data/document:/data ghcr.io/huangfusl/template:latest \
        find . -not -name *.pdf -mindepth 1 -delete
    ```

6. Copy compiled document back

    ```bash
    docker cp data:/data/document/. source-dir
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

### Docker workflow

To configure LaTeX Workshop to use pre-built docker image, add the following compile tools in `latex-workshop.latex.tools` section of `settings.json`.

```json
{
    "name": "CopyDocker",
    "command": "docker",
    "args": [
        "cp",
        "%DIR%/.",
        "data:/data/document"
    ]
},
{
    "name": "CopyLocal",
    "command": "docker",
    "args": [
        "cp",
        "data:/data/document/.",
        "%DIR%"
    ]
},
{
    "name": "CleanRemoteFile",
    "command": "docker",
    "args": [
        "run",
        "--rm",
        "-v",
        "/data/document:/data",
        "ghcr.io/huangfusl/template:latest",
        "find",
        ".",
        "-mindepth",
        "1",
        "-delete"
    ]
},
{
    "name": "CleanRemoteAuxiliary",
    "command": "docker",
    "args": [
        "run",
        "--rm",
        "-v",
        "/data/document:/data",
        "ghcr.io/huangfusl/template:latest",
        "find",
        ".",
        "-not",
        "-name",
        "*.pdf",
        "-mindepth",
        "1",
        "-delete"
    ]
},
{
    "name": "RemoteXeLaTeX",
    "command": "docker",
    "args": [
        "run",
        "--rm",
        "-v",
        "/data/document:/data",
        "ghcr.io/huangfusl/template:latest",
        "xelatex",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-output-directory=/data",
        "-file-line-error",
        "/data/%DOCFILE_EXT%"
    ]
},
{
    "name": "RemoteBibTeX",
    "command": "docker",
    "args": [
        "run",
        "--rm",
        "-v",
        "/data/document:/data",
        "ghcr.io/huangfusl/template:latest",
        "bibtex",
        "/data/%DOCFILE_EXT%"
    ]
}
```

Further customization:

* Add `--context <context>` argument if a non-default context is used.
* Add `--pull always` to keep image updated.
* Add `-i` to bind log to output panel (but do not add `-t`)

Compose tools into the following recipes (`latex-workshop.latex.recipes` section of `settings.json`)

```json
{
    "name": "Remote Build",
    "tools": [
        "CleanRemoteFile",
        "CopyDocker",
        "RemoteXeLaTeX",
        "RemoteXeLaTeX",
        "CleanRemoteAuxiliary",
        "CopyLocal"
    ]
},
{
    "name": "Clear Remote",
    "tools": ["CleanRemoteFile"]
}
```

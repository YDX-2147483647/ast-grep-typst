# Typst rules based on [ast-grep](https://ast-grep.github.io)

## Usage

```shell
$ just scan glossarium/0.5.8
ast-grep scan …/preview/glossarium/0.5.8
warning[show-function]:
     ┌─ …/preview/glossarium/0.5.8/themes/default.typ:1361:5
     │
1361 │     show ref: refrule.with(update: false)
     │     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

warning[show-function]:
    ┌─ …/preview/glossarium/0.5.8/themes/default.typ:901:3
    │
901 │ ╭     show figure.where(kind: __glossarium_figure): it => {
    │ │ ╭─────────────────────────────────────────────────'
902 │ │ │     align(start, it.body)
903 │ │ │   }
    │ ╰─│───^
    │   ╰───'

note[context]:
    ┌─ …/preview/glossarium/0.5.8\themes\default.typ:568:35
    │
568 │ #let style-entries(attr, style) = context _style-entries(attr, style)
    │                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

note[stateful]:
   ┌─ …/preview/glossarium/0.5.8/themes/default.typ:18:27
   │
18 │ #let __glossary_entries = state("__glossary_entries", (:))
   │                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

…
```

## Development

### Online

Use [ast-grep playground (forked version)][playground].

[playground]: https://ydx-2147483647.github.io/ast-grep.github.io/playground.html#eyJtb2RlIjoiQ29uZmlnIiwibGFuZyI6InR5cHN0IiwicXVlcnkiOiIiLCJyZXdyaXRlIjoiIiwic3RyaWN0bmVzcyI6ImFzdCIsInNlbGVjdG9yIjoiIiwiY29uZmlnIjoiaWQ6IGNvbnRleHRcbmxhbmd1YWdlOiB0eXBzdFxuc2V2ZXJpdHk6IHdhcm5pbmdcbnJ1bGU6XG4gIGtpbmQ6IGNvbnRleHRcbiIsInNvdXJjZSI6IiNjb250ZXh0IGNvdW50ZXIoaGVhZGluZykuZGlzcGxheSgpXG4ifQ==

### Local

First, put the tree-sitter-typst dynamic library beside this README. It will [add typst support to ast-grep](https://ast-grep.github.io/advanced/custom-language.html).

You could do so by any of the following methods:

- Run `just setup` to download it with GitHub CLI.

- Manually download it from [![Build tree-sitter-typst](https://github.com/YDX-2147483647/ast-grep-typst/actions/workflows/build-tree-sitter.yml/badge.svg)](https://github.com/YDX-2147483647/ast-grep-typst/actions/workflows/build-tree-sitter.yml).

  Choose the latest run, scroll down to _Artifacts_, select `*.so` for Linux or `*.dll` for Windows, and extract the downloaded zip file.

- (For professionals only) Compile it from https://github.com/uben0/tree-sitter-typst.

  You could open that repo with GitHub Codespaces or Gitpod. Please refer to [the workflow file](./.github/workflows/build-tree-sitter.yml) for more info.

After that, you can use `ast-grep`. Please refer to [Quick Start | ast-grep](https://ast-grep.github.io/guide/quick-start.html) for more information.

```shell
ast-grep test
# Or just add-test
```

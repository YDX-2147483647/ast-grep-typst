# Typst rules based on [ast-grep](https://ast-grep.github.io)

## Development

### Online

Use [ast-grep playground (forked version)][playground].

[playground]: https://ydx-2147483647.github.io/ast-grep.github.io/playground.html#eyJtb2RlIjoiQ29uZmlnIiwibGFuZyI6InR5cHN0IiwicXVlcnkiOiIiLCJyZXdyaXRlIjoiIiwic3RyaWN0bmVzcyI6ImFzdCIsInNlbGVjdG9yIjoiIiwiY29uZmlnIjoiaWQ6IGNvbnRleHRcbmxhbmd1YWdlOiB0eXBzdFxuc2V2ZXJpdHk6IHdhcm5pbmdcbnJ1bGU6XG4gIGtpbmQ6IGNvbnRleHRcbiIsInNvdXJjZSI6IiNjb250ZXh0IGNvdW50ZXIoaGVhZGluZykuZGlzcGxheSgpXG4ifQ==

### Local

First, compile https://github.com/uben0/tree-sitter-typst to [add typst support](https://ast-grep.github.io/advanced/custom-language.html).

You could use GitHub Codespaces or Gitpod to compile:

```shell
gh repo clone uben0/tree-sitter-typst -- --filter=blob:none
npm install -g tree-sitter-cli

# Compile for Linux
tree-sitter build --output tree-sitter-typst.so

# Cross-compile for Windows
apt install mingw-w64
CC=x86_64-w64-mingw32-gcc CFLAGS="-D_WIN32" tree-sitter build --output tree-sitter-typst.dll
# At the end of the build process, tree-sitter will complain that “tree-sitter-typst.dll: invalid ELF header”, because it fails to verify dll on Linux.
# You could ignore this error and manually verify the dll on Windows.
```

Download `tree-sitter-typst.{so,dll}` and put it at the root directory of this project.

After that, you can use `ast-grep`. Please refer to [Quick Start | ast-grep](https://ast-grep.github.io/guide/quick-start.html) for more information.

```shell
ast-grep test --skip-snapshot-tests
ast-grep test --update-all
ast-grep test
```

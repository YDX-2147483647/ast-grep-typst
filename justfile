typst_preview := replace(cache_directory(), '\', '/') + "/typst/packages/preview"
tree-sitter-typst := "tree-sitter-typst." + if os_family() == "windows" { "dll" } else { "so" }

# List available recipes
@list:
    just --list

# Download tree-sitter-typst from GitHub Actions
setup:
    {{ \
        if path_exists(tree-sitter-typst) != "true" { \
            "gh run download --name " + tree-sitter-typst \
        } else { \
            "echo 'Found existing " + tree-sitter-typst + ".'" \
        } \
    }}

# Scan code by rules, e.g., `just scan headcount`, `just scan tidy/0.3.0 --filter=eval`, `just scan physica/0.9.5 --hint=hard-coded-str --filter=hard-coded-str`
scan PREVIEW_PACKAGE_PATH *OPTIONS:
    ast-grep scan {{ OPTIONS }} {{ typst_preview }}/{{ PREVIEW_PACKAGE_PATH }}

# Normal procedure after adding new tests; see also https://ast-grep.github.io/guide/test-rule.html
add-test: && test
    ast-grep test --skip-snapshot-tests
    ast-grep test --interactive

[private]
test:
    ast-grep test --include-off

# Check rule files match their IDs and tests
check:
    #!/usr/bin/env -S uv run --script
    # /// script
    # requires-python = ">=3.12"
    # dependencies = [
    #     "ruamel-yaml",
    # ]
    # ///
    from pathlib import Path

    from ruamel.yaml import YAML

    yaml = YAML(typ="safe")
    root = Path.cwd()


    def load_id(file: Path) -> str:
        return yaml.load(file.read_text(encoding="utf-8"))["id"]


    def human(file: Path) -> str:
        return file.relative_to(root).as_posix()


    for rule in (root / "rules").iterdir():
        if not rule.is_file():
            continue

        assert rule.suffix == ".yml", f"Rule file {human(rule)} must be a .yml file"
        assert rule.stem == load_id(rule), f"Rule file {human(rule)} stem must match its ID"

        test = root / "rules-tests" / f"{rule.stem}-test.yml"
        assert test.exists() and test.is_file(), f"Test file {human(test)} must exist"
        assert rule.stem == load_id(test), f"Test file {human(test)} stem must match its ID"

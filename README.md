# Python Project Template 🐍

This is a template for a Python project. It includes a basic project structure, a Justfile with some useful commands, and a README.md template.

## Packages management

This project uses [uv](https://docs.astral.sh/uv/) as a package manager. To install it, please follow the instructions in the [uv documentation](https://docs.astral.sh/uv/getting-started/installation/).

This template intentionally sets `tool.uv.exclude-newer = "P7D"` as a
dependency cooldown to reduce exposure to newly published supply-chain attacks.
See [ADR 0001](docs/architecture/0001-adopt-uv-dependency-cooldowns-with-exclude-newer.md)
for the rationale and trade-offs, including the related
[PyPI incident report](https://blog.pypi.org/posts/2026-04-02-incident-report-litellm-telnyx-supply-chain-attack/).

Here are some useful commands to manage dependencies:

### Install Python version

To install a specific Python version, run the following command:

```bash
uv python install <version>
```

### Create a virtual environment

To create a virtual environment, run the following command:

```bash
uv venv
```

### Add dependencies

To add a new dependency, run the following command:

```bash
uv add <package>
```

### Remove dependencies

To remove a dependency, run the following command:

```bash
uv remove <package>
```

### Development dependencies

To add a development dependency, run the following command:

```bash
uv add  <package> --dev
```

See the [uv documentation](https://docs.astral.sh/uv/) for more information.

## Resources

- [python-package-template by asmitul](https://github.com/asmitul/python-package-template/tree/main)
- [python-package-template by alvarobartt](https://github.com/alvarobartt/python-package-template)
- [python-poetry-template by Diapolo10](https://github.com/Diapolo10/python-poetry-template/tree/main)
- [python-boilerplate by smarlhens](https://github.com/smarlhens/python-boilerplate/tree/main)

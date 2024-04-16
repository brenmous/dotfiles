# Requirements for pylsp

```shell
pip install python-lsp-server[all]
pip install pylsp-rope
```

# Using mason

After installing Mason, use :Mason to install plugins.

## Configuring pylsp with Mason install

- Provide pylsp lspconfig as normal

- Run `:PylspInstall <package>` for the following plugins:
    - pylsp-mypy
    - python-lsp-black
    - pylsp-rope
    - python-lsp-ruff



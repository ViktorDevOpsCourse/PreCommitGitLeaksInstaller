# Pre-commit install
Repo contain a script which install [gitleaks](https://github.com/gitleaks/gitleaks) 
to root project /bin folder and set pre-commit git hook to check secret leaks in repo

## Dependencies

* Golang
* Make
* Git
* Bash

------

## Install

run:
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ViktorDevOpsCourse/preCommitGitLeaksInstaller/main/install.sh)"
```

Script installed gitleaks in project root dir and build pre-commit hook to git

If you want disable or enable hook
```
git config hooks.pre-commit true
```

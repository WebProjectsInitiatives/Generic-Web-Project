![](readme-sources/web-project-initiatives.png)

# Web Projects Initiatives - Generic-Web-Project

*Warning:* this project template is only designed to work with Windows 10 so far.

This project aims at setting up a new web project instantly via Docker.
This is not a working project *per se*, it's rather a shell to extend when starting a new one.

It is based on a directory structure that allows other projects to run simultaneously on the same machine.

It lays new projects expected standards, among which:
- a Clean Architecture-oriented directory tree
- a Clean Architecture-oriented naming
- Clean Coding-inspired sources
- an industrialization shell for projects
- the future addition of quality and automatic tools

It only serves a simple "Hello world!", through an NginX container.

It lays the basics to set up three working environments: `dev`, `qa` and `prod`.

## Setup

The setup is lightning fast, you just have to replace:

- `[new-project-template]` with your slugified project name, for example "my-project".
- `localfakedomain` with the fake local domain name you want to use, like "mydomain", for instance
- `dummyextension` with the fake local TLD name you want to use, like "local", for instance

in:

- the **file names**
- the file **contents**

(basically, `Ctrl+Shift+N` to search for file names and `Ctrl+Shift+R` to replace in contents in PHPStorm with default keymaps)

Then, under Windows 10, in a shell, call:

```
init-project.bat
build-all-docker-containers.bat
```

Then, if you need it, just copy the contents of directory `git-hooks-sources` to your current `.git/hooks` directory.

Then modify your hosts file (usually `C:\Windows\System32\drivers\etc\hosts` or `/etc/hosts`) as follows:

```
    # Local URLs -- routed to respective environments
    # "prod" environment on local devices
    127.0.0.1 prod.[new-project-template].localfakedomain.dummyextension
    127.0.0.1 cdn.prod.[new-project-template].localfakedomain.dummyextension
    # "qa" environment on local devices
    127.0.0.1 qa.[new-project-template].localfakedomain.dummyextension
    127.0.0.1 cdn.qa.[new-project-template].localfakedomain.dummyextension
    # "dev" environment on local devices
    127.0.0.1 dev.[new-project-template].localfakedomain.dummyextension
    127.0.0.1 cdn.dev.[new-project-template].localfakedomain.dummyextension
```

And then you just have to type in your browser (after doing all the replacements above):

`http(s)://[env].[new-project-template].localfakedomain.dummyextension:101[env-number]1`

With \[env-number] being (look at the appropriate docker-compose files):

* prod: 0
* qa:   1
* dev:  2


*Note:*
This project explicits all containers virtual internal IP adresses and TCP ports instead of using Docker auto networking.
This requires users to do this for all projects, but has the advantage of offering 100% copy/paste URL + ports between
any person working in the project (especially during Docker setup).

## 🌲 The directory tree (as expected and generated by `init-project.bat`)

```
    + [Your project name, root directory]
    |
    |---+ /devops-sources
    |   |
    |   +--- Here you can put everywhere linked to continuous quality and integration (analysis, formatting, auto-fixing, ...)
    |   +--- ...
    |
    |---+ /docker-sources -- your docker sources
    |   |
    |   +---+ /containers-config
    |   |   |
    |   |   +---+ /[technology]
    |   |   |   |
    |   |   |   +---+ /[dev]-[technology]
    |   |   |   |   |
    |   |   |   |   +--- dev-[technology]-container-config.docker
    |   |   |   |   +--- ... plus any other necessary files to set up development
    |   |   |   |
    |   |   |   +---+ /[qa]-[technology]
    |   |   |   |   |
    |   |   |   |   +--- qa-[technology]-container-config.docker
    |   |   |   |   +--- ... plus any other necessary files to set up qa
    |   |   |   |
    |   |   |   +---+ /[prod]-[technology]
    |   |   |   |   |
    |   |   |   |   +--- prod-[technology]-container-config.docker
    |   |   |   |   +--- ... plus any other necessary files to set up prod
    |   |   |
    |   |   +---+ /[another technology]
    |   |       |
    |   |       +--- ...
    |   |
    |   +--- dev-docker-compose.yaml -- your docker-compose sources for each environment
    |   +--- global-docker-compose.yaml
    |   +--- prod-docker-compose.yaml
    |   +--- qa-docker-compose.yaml
    |
    |---+ /environment-files -- all your local environment files, shared between Docker and the containers technologies
    |   |
    |   +--- .env -- the global key/values for all your containers on all environments
    |   +--- .env.[environment].local-dist -- your local template to create local .env files
    |   +--- .env.dev -- one for each environment
    |   +--- .env.qa
    |   +--- .env.prod
    |
    |---+ /git-hooks-sources -- this directory contains the sources of what you should put into your git `.git/hooks` directory
    |   |
    |   +--- commit-msg
    |   +--- commit-msg.bat
    |   +--- pre-commit
    |   +--- pre-commit.bat
    |
    |---+ /ci-jobs
    |   |
    |   +--- Here you can put any backup of your CI integration jobs and tasks (better save them than sorry ^^)
    |
    |---+ /readme-sources
    |   |
    |   +--- Here you put whatever files `README.md` uses
    |
    +--- .dockerignore
    +--- .gitignore
    |
    +--- init-project.bat -- initalizes or reapplies project basic configuration
    +--- build-all-docker-containers.bat
    +--- build-dev-docker-containers.bat
    +--- build-qa-docker-containers.bat
    +--- build-prod-docker-containers.bat
    |
    +--- README.md
```

## Git

The `git commit` hook checks your commit messages to be formed as follows:

    [EXAMPLE-1111] example
    [devops] example
    WIP: example

Don't forget to add further git hooks if need and to save them here.

## 🐳 Docker

Everything lies in the `docker-sources` directory. You'll find explained and detailed
Dockerfiles. Don't forget to keep their verbosity.

To set up all containers and start the app, just use:

     build-all-docker-containers.bat

Or any other one if you just want to rebuild and start one environment at a time.

## Special thanks

Also, special thanks to Aurélien Tricard (AurelienTRICARD) for the initial setup help and the work on this project.
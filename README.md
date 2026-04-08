# docker-bootstrap

modular docker bootstrap framework

## Motivation

Have you ever had to deal with docker entrypoint scripts that were big and hard to understand?

If not, count your blessings.

If you do, then this is DEFINITELY for you!

Instead of rewriting an entrypoint for every container image, you can simply include this simple script, add a bootstrap directory, if necessary, set some variables, and Bob's your uncle! (Or words to that effect!)

With the obvious advantage that due to its modular nature, this solution allows users to both bundle scripts and hot plug start up scripts.

This is a drop-in replacement for both existing images and new images.

## Usage

1. Copy and include the docker_bootstrap.sh script into your image.
2. Add scripts[1] and relevant environment variables to your image/build.
3. ???
4. Profit!

[1]: suggested form is to use numerically ordered scripts to ensure ordering.
    e.g. 00-bootstrap-banner, 99-custom-banner

TLDR: Copy the script and set up your scripts.

## Environment Variables

| Variable              | Description                                                                                                                                             | Default                                                        |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| BOOTSTRAP_BUILDONLY   | Disable executing entrypoint scripts                                                                                                                    | _none_ (any value other than '0' value enables this setting.)  |
| BOOTSTRAP_BYPASS      | Disable executing bootstrap scripts                                                                                                                     | _none_ (any value other than  '0' value enables this setting.) |
| BOOTSTRAP_DIR         | Override default scripts directory                                                                                                                      | `/etc/docker-bootstrap.d`                                      |
| BOOTSTRAP_DIRS        | Add more default script directories, which take precedence over the BOOTSTRAP_DIR                                                                       | _none_                                                         |
| BOOTSTRAP_ENTRYPOINT  | Call a legacy entrypoint that's not running from the CMD instruction                                                                                    | _none_                                                         |
| BOOTSTRAP_SHELL       | Override default shell                                                                                                                                  | `/bin/sh`                                                      |
| CUSTOM_BOOTSTRAP_DIRS | Custom directories for bootstrap scripts. This allows you to add additional directories for more custom scripts that might expand on an existing image. | _none_                                                         |

## Install

You can install docker-bootstrap using any of the options below:

### Manual

1. Simply copy the `docker_bootstrap.sh` script to a location of your choosing.
2. Adjust environment variables as necessary.
3. Add scripts.
4. Point your entrypoint or build to the `docker_bootstrap.sh`.

### Script/Automate

1. Use curl or wget to get the install script, and either pipe it through to a shell or download it and make it executable.
2. Use the environment variables below to customize the execution.

#### Environment Variables

| Variable           | Description                                                                                                                                                                                                                                                                                                                                                                                       | Default                                      |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------- |
| DEFAULT_SCRIPTS    | Specifies which default scripts to install                                                                                                                                                                                                                                                                                                                                                        | `00-bootstrap-banner.sh` from the repository |
| INSTALL_COMMIT     | Supports pinning scripts by specifying which commit to install from                                                                                                                                                                                                                                                                                                                               | Latest commit                                |
| INSTALL_CONF_D_DIR | The location to install the script files.                                                                                                                                                                                                                                                                                                                                                         | `/etc/docker-bootstrap.d`                    |
| INSTALL_SCRIPT_DIR | The location to install the `docker_bootstrap.sh` script.                                                                                                                                                                                                                                                                                                                                         | `/`                                          |
| INSTALL_SCRIPTS    | Names or URLs of scripts to install beyond the default scripts. These can also be specified through the command-line.      <br />  NOTE: If the script name does not start with a common URL protocol prefix (ftp/http/https), the install script will assume that they are located in the `docker-bootstrap.d` directory of the repository. This allows you to fetch scripts from a wget source. | ""                                           |

#### Examples

##### Quick bootstrap with runtime user generation

```cli
wget -q -O - https://raw.githubusercontent.com/TyIsI/docker-bootstrap/refs/heads/main/install-docker-bootstrap.sh | INSTALL_SCRIPTS=50-add-build-user.sh sh -
```

##### Directed

The command below will install the main script into `/docker-bootstrap` while the extra scripts will be installed into `/docker-bootstrap/conf.d`. Besides the default banner script, the `50-add-build-user.sh` script will be installed.

```cli
INSTALL_SCRIPT_DIR=/docker-bootstrap INSTALL_CONF_D_DIR=/docker-bootstrap/conf.d ./install-docker-bootstrap.sh 50-add-build-user.sh
```

## Contributing

See the [Ethical Code](./ETHICAL-CODE.md)

If you do not agree with this Ethical Code, e.g. if you don't agree with healthcare for trans people or that Black, Brown, Indigenous, or Trans Lives Matter, then this project is not for you.

Subject to the ethical code, contributions are welcome!

### Commits

This project uses conventional commits, editorconfig and `shfmt` (for script formatting).

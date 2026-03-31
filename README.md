# docker-bootstrap

modular docker bootstrap framework

## Motivation

Have you ever had to deal with docker entrypoint scripts that were big and hard to understand?

If not, count your blessings.

If you do, then this is DEFINITELY for you!

Instead of rewriting an entrypoint for every container image, you can simply include this simple script, add a bootstrap directory, if necessary, set some variables, and Bob's your uncle! (Or words to that effect!)

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

| Variable              | Description                                                                                                                                             | Default                                          |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ |
| BOOTSTRAP_BYPASS      | Disable executing bootstrap scripts                                                                                                                     | _none_ (any non '0' value enables this setting.) |
| BOOTSTRAP_DIR         | Override default scripts directory                                                                                                                      | `/etc/bootstrap.d`                               |
| BOOTSTRAP_DIRS        | Add more default script directories, which take precedence over the BOOTSTRAP_DIR                                                                       | _none_                                           |
| BOOTSTRAP_ENTRYPOINT  | Call a legacy entrypoint that's not running from the CMD instruction                                                                                    | _none_                                           |
| BOOTSTRAP_SHELL       | Override default shell                                                                                                                                  | `/bin/sh`                                        |
| CUSTOM_BOOTSTRAP_DIRS | Custom directories for bootstrap scripts. This allows you to add additional directories for more custom scripts that might expand on an existing image. | _none_                                           |

## Contributing

See the [Ethical Code](./ETHICAL-CODE.md)

If you do not agree with this Ethical Code, e.g. if you don't agree with healthcare for trans people or that Black, Brown, Indigenous, or Trans Lives Matter, then this project is not for you.

Subject to the ethical code, contributions are welcome!

### Commits

This project uses conventional commits, editorconfig and `shfmt` (for script formatting).

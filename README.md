# Prolog binding for ImageMagick

A Prolog binding for ImageMagick, allowing properties of images files
to be inquired.

## Dependencies

  1. Install [SWI-Prolog](https://www.swi-prolog.org).

  2. Install the ImageMagick library:

```sh
apt install libmagick++-dev       # Debian, Ubuntu
dnf install ImageMagick-c++-devel # Fedora, Red Hat
```

## Installation

Install this library:

```sh
swipl -g 'pack_install(prolog_imagemagick)' -t halt
```

# Prolog ImageMagick binding

A Prolog binding for ImageMagick, allowing properties of images files
to be inquired.

## Dependencies

The ImageMagick library must be installed system-wide:

```sh
apt install libmagick++-dev       # Debian, Ubuntu
dnf install ImageMagick-c++-devel # Fedora, Red Hat
```

## Installation

Make the following call in [SWI-Prolog](https://www.swi-prolog.org):

```pl
pack_install(prolog_imagemagick).
```

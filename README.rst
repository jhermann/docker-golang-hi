================
docker-golang-hi
================

:Name:          jhermann/docker-golang-hi
:Description:   A golang multi-stage build container image example.
:Maintainer:    Jürgen Hermann <jh@web.de>

The following commands build and run a golang binary from the source in ``hi.go``,
putting it into a from-scratch Docker image. The resulting image is only
slightly larger than the contained golang binary.

It doesn't get easier than this. ☺

.. code-block:: shell

    docker build -t jhermann/gohi -t jhermann/gohi:$(git describe --tags) .
    docker run --rm -it jhermann/gohi

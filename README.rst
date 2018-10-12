================
docker-golang-hi
================

:Name:          jhermann/gohi
:Description:   A golang multi-stage build container image example.
:Maintainer:    Jürgen Hermann <jh@web.de>

The following commands build and run a golang binary from the source in ``hi.go``,
putting it into a from-scratch Docker image.

.. code-block:: shell

   docker build -t jhermann/gohi -t jhermann/gohi:$(git describe --tags) .
   docker run --rm -it jhermann/gohi

It doesn't get easier than this. ☺

The resulting image is only slightly larger than the contained golang binary.

.. code-block:: console

    $ dockviz images --tree jhermann/gohi
    └─927b6ad2e4fa Virtual Size: 1.4 MB Tags: jhermann/gohi:latest, jhermann/gohi:v0-1-g93bf073

To look at the image's metadata, use ``docker inspect``:

.. code-block:: shell

    docker inspect jhermann/gohi:latest | jq -CS

Leave out the ``jq`` part if you don't have that installed,
it just colorizes the output.

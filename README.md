# README #

This repo contains a list of Dockerfiles used to generate the images found at eboraas/debian on Docker Hub.

Each image is essentially an "apt-get dist-upgrade" wrapper around a minbase debootstrap image that I build manually on an occasional basis, so that Docker Hub's Automated Build system can be used to keep them up-to-date without my having to rebuild the debootstrap image daily.

No warranty, etc. Just putting them out there in case anyone wants them and/or wants to see how they were made.

-Ed


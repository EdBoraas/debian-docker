#!/bin/bash

# Quick & dirty batch build wrapper for producing minimal Debian base images
#
# This is intended to be used on an existing Debian system, requiring: 
#   apt-get install docker.io debootstrap

# Set TAGPREFIX based on your desired naming; e.g.,
# for jdoe/debian:<suite> use
#   TAGPREFIX=jdoe/debian: 
# and for jdoe/somerepo:debian-<suite> use
#   TAGPREFIX=jdoe/somerepo:debian-
TAGPREFIX=debian:
#TAGPREFIX=eboraas/debootstrap:minbase-

# Set SUITES to the space-delimited list of suites you wish to build
SUITES="oldstable stable testing wheezy jessie stretch buster sid"

# Set PUSH to 0 (the default) to build without pushing, or
# set PUSH to 1 to push each image after it's built, or
# set PUSH to 2 to push the repo ($TAGPREFIX up to the first colon) after
PUSH=0

# Where is mkimage.sh? Two options...
# Using docker.io (from Debian):
MKIMAGE=/usr/share/docker.io/contrib/mkimage.sh
# Using docker-engine (from Docker):
#MKIMAGE=/usr/share/docker-engine/contrib/mkimage.sh

# Enjoy!
#
# -Ed

for suite in ${SUITES}; do 
  ${MKIMAGE} -t ${TAGPREFIX}${suite} debootstrap --variant=minbase ${suite} http://httpredir.debian.org/debian
  if [ ${PUSH} -eq 1 ]; then
    /usr/bin/docker push ${TAGPREFIX}${suite}
  fi
done

if [ ${PUSH} -eq 2 ]; then
  /usr/bin/docker push $(echo ${TAGPREFIX}${suite} |cut -f1 -d:)
fi


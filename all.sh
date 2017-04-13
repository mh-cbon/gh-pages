#!/bin/bash

wget -O - https://raw.githubusercontent.com/mh-cbon/gh-pages/master/setup.sh | sh -x
source ~/.rvm/scripts/rvm
wget -O - https://raw.githubusercontent.com/mh-cbon/gh-pages/master/update-ghpages.sh | sh -x

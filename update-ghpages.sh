#!/bin/bash

# GH='mh-cbon/test-repo'
# JEKYLL="pietromenna/jekyll-cayman-theme"

git reset --hard HEAD
git checkout master

if type "jekyll" > /dev/null; then
  echo "jekyll already installed"
else
  gem install bundler jekyll
fi

gem -v
jekyll -v

REPOPATH=`pwd`

cd ~

rm -fr jekyll
git clone https://github.com/${JEKYLL}.git jekyll
cd ~/jekyll
rm -fr ~/jekyll/_posts/*
rm -fr ~/jekyll/_site
rm -fr ~/jekyll/*md

cp ${REPOPATH}/README.md ~/jekyll/index.md
echo "---" | cat - ~/jekyll/index.md > /tmp/out && mv /tmp/out ~/jekyll/index.md
echo "---" | cat - ~/jekyll/index.md > /tmp/out && mv /tmp/out ~/jekyll/index.md

cd ${REPOPATH}

cp config.jekyll.sh ~

if [ `git symbolic-ref --short -q HEAD | egrep 'gh-pages$'` ]; then
  echo "already on gh-pages"
else
  if [ `git branch -a | egrep 'remotes/origin/gh-pages$'` ]; then
    # gh-pages already exist on remote
    git checkout gh-pages
  else
    git checkout -b gh-pages
    find . -maxdepth 1 -mindepth 1 -not -name .git -exec rm -rf {} \;
    git commit -am "clean up"
  fi
fi

cd ~/jekyll

sh ~/config.jekyll.sh

bundle install
bundle exec jekyll build


cd ${REPOPATH}

cp -fr ~/jekyll/_site/* .

git add -A
git commit -am "generate gh-pages"
set +x # disable debug output because that would display the token in clear text..
echo "git push --force --quiet https://GH_TOKEN@github.com/${GH}.git gh-pages"
git push --force --quiet "https://${GH_TOKEN}@github.com/${GH}.git" gh-pages \
2>&1 | sed -re "s/${GH_TOKEN}/GH_TOKEN/g"

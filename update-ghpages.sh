#!/bin/sh

# GH='mh-cbon/test-repo'
# JEKYLL="pietromenna/jekyll-cayman-theme"

if ["${GH}" == ""]; then
  echo "GH is not properly set. Check your travis file."
  exit 1
fi

if ["${JEKYLL}" == ""]; then
  echo "JEKYLL is not properly set. Check your travis file."
  exit 1
fi

if ["${GH_TOKEN}" == ""]; then
  echo "GH_TOKEN is not properly set. Check your travis file."
  exit 1
fi

REPO=`echo ${GH} | cut -d '/' -f 2`
USER=`echo ${GH} | cut -d '/' -f 1`

REPOPATH=`pwd`

if type "jekyll" > /dev/null; then
  echo "jekyll already installed"
else
  gem install bundler jekyll
fi

gem -v
jekyll -v

git reset --hard HEAD
git checkout master

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

if [ ! -f "${REPOPATH}/config.jekyll.sh" ]; then
  wget https://raw.githubusercontent.com/mh-cbon/gh-pages/master/config.jekyll.sh -O ~/config.jekyll.sh
else
  cp ${REPOPATH}/config.jekyll.sh ~
fi

sh ~/config.jekyll.sh

bundle install
bundle exec jekyll build


# cd ..
# rm -fr ${REPOPATH}

# git clone https://github.com/${GH}.git ${REPOPATH}
cd ${REPOPATH}

git config user.name "${USER}"
git config user.email "${EMAIL}"

git remote update
git fetch
git remote show origin
git remote -v
git branch -avv
git checkout -b gh-pages | echo "not remote gh pages"
git checkout -b gh-pages origin/gh-pages | echo "not remote gh pages"

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

cp -fr ~/jekyll/_site/* ${REPOPATH}/

git add -A
git commit -am "generate gh-pages"
set +x # disable debug output because that would display the token in clear text..
echo "git push --force --quiet https://GH_TOKEN@github.com/${GH}.git gh-pages"
git push --force --quiet "https://${GH_TOKEN}@github.com/${GH}.git" gh-pages \
2>&1 | sed -re "s/${GH_TOKEN}/GH_TOKEN/g"

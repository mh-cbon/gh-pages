#!/bin/sh

# expected to exist
# GH=mh-cbon/emd
# EMAIL=mh-cbon@users.noreply.github.com

if ["${GH}" == ""]; then
  echo "GH is not properly set. Check your travis file."
  exit 1
fi

if ["${EMAIL}" == ""]; then
  echo "EMAIL is not properly set. Check your travis file."
  exit 1
fi

REPO=`echo ${GH} | cut -d '/' -f 2`
USER=`echo ${GH} | cut -d '/' -f 1`

git config --global user.name "$USER"
git config --global user.email "$EMAIL"

REPOINFO=`wget -q --no-check-certificate -O - https://api.github.com/repos/${GH}`

TAGLINE=`echo "${REPOINFO}" | grep '"description": ' | head -n 1 | cut -d '"' -f 4`
TITLE=`echo "${REPOINFO}" | grep '"name": ' | head -n 1 | cut -d '"' -f 4`
OWNER=`echo "${REPOINFO}" | grep '"login": ' | head -n 1 | cut -d '"' -f 4`
REPOURL=`echo "${REPOINFO}" | grep '"html_url": ' | head -n 1 | cut -d '"' -f 4`


cat <<EOT > _config.yml
# Setup
title:        ${TITLE}
tagline:      ${TAGLINE}
baseurl:      /${TITLE}/

# About/contact
author:
  name:       ${OWNER}
  url:        ${REPOURL}

defaults:
  -
    scope:
      path: ""
      type: "pages"
    values:
      layout: "default"

# Gems
gems:
  - github-pages

exclude: [Gemfile, Gemfile.lock]

#Others
markdown: kramdown
repository: ${GH}
kramdown:
  input: GFM
  hard_wrap: false
EOT

rm Gemfil*
cat <<EOT > Gemfile
source 'https://rubygems.org'
gem 'github-pages', group: :jekyll_plugins
EOT


cat <<EOT > _includes/page-header.html
<section class="page-header">
  <h1 class="project-name">{{ site.title }}</h1>
  <h2 class="project-tagline">{{ site.tagline }}</h2>
  <a href="{{ site.github.repository_url }}" class="btn">View on GitHub</a>
  <a href="{{ site.github.zip_url }}" class="btn">Download .zip</a>
  <a href="{{ site.github.tar_url }}" class="btn">Download .tar.gz</a>
</section>
EOT

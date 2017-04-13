# gh-pages

toolset to generate gh-pages content.

# vagrant

```sh
vagrant up
vagrant ssh -c "cd /vagrant/ && wget -O - https://raw.githubusercontent.com/mh-cbon/gh-pages/master/setup.sh | sh -x"
vagrant ssh -c "source ~/.rvm/scripts/rvm"
vagrant ssh -c "cd /vagrant/ && wget -O - https://raw.githubusercontent.com/mh-cbon/gh-pages/master/update-ghpages.sh | GH=mh-cbon/gh-pages JEKYLL=pietromenna/jekyll-cayman-theme sh -x"
vagrant ssh -c "cd ~/jekyll && jekyll serve --host=0.0.0.0"
xdg-open http://localhost:8080/gh-pages/
```

# travis

```yml
sudo: required

language: c # or whatever else you need

before_install:
  - rvm use 2.2 --install --binary --fuzzy
  - gem update --system
  - gem --version

env:
  global:
    - GH=YOUR/REPO
    - EMAIL=YOUR@EMAIL
    - JEKYLL=pietromenna/jekyll-cayman-theme # define here the gh slug to the jekyll theme
    - secure: GH_TOKEN=xxx

script:
  - wget -O - https://raw.githubusercontent.com/mh-cbon/gh-pages/master/all.sh | sh -x
```

then run
```sh
travis encrypt --add -r YOUR/REPO GH_TOKEN=xxxx
# you might do it for your email also.
travis lint
```

then create a file `config.jekyll.sh` at repository root,

If such file does not exist, it will default to [this one](https://raw.githubusercontent.com/mh-cbon/gh-pages/master/config.jekyll.sh)

configure git, configure the jekyll folder,

```sh
#!/bin/bash

git config --global user.name "your usernmae"
git config --global user.email "your email"

cat <<EOT > _config.yml
# Put the new jekyll config here for the theme you have selected
EOT

# Update the Gemfile if you d like, this is a gh-pages like Gemfile
cat <<EOT > Gemfile
source 'https://rubygems.org'
gem 'github-pages', group: :jekyll_plugins
EOT

# update the jekyll theme if something needs to
cat <<EOT > _includes/page-header.html
... New html content here
EOT

```

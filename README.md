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
language: ruby

env:
  global:
    - GH=mh-cbon/gh-pages
    - JEKYLL=pietromenna/jekyll-cayman-theme
    - secure: GH_TOKEN=xxx

script:
  - wget -O - https://raw.githubusercontent.com/mh-cbon/gh-pages/master/setup.sh | sh -x
  - source ~/.rvm/scripts/rvm
  - wget -O - https://raw.githubusercontent.com/mh-cbon/gh-pages/master/update-ghpages.sh |  sh -x

```

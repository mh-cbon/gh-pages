# gh-pages

toolset to generate gh-pages content.

# vagrant

```sh
vagrant up
vagrant ssh -c "cd /vagrant/ && wget -O - https://raw.githubusercontent.com/mh-cbon/gh-pages/master/setup.sh sh"
vagrant ssh -c "cd /vagrant/ && wget -O - https://raw.githubusercontent.com/mh-cbon/gh-pages/master/update-ghpages.sh | GH=mh-cbon/gh-pages JEKYLL=pietromenna/jekyll-cayman-theme sh"
vagrant ssh -c "cd ~/jekyll && jekyll serve --host=0.0.0.0"
```

# travis

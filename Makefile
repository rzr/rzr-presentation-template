NAME?="default"
target=index
url?=https://github.com/hakimel/reveal.js/archive/master.zip

all: COPYING ${target}.html

%.html: %.org Makefile
	NAME=${NAME} emacs --batch\
 -u ${USER} \
  --eval '(load user-init-file)' \
  $< \
  -f org-reveal-export-to-html
	x-www-browser $@
help:
	@echo "https://github.com/yjwen/org-reveal/issues/171"

clean:
	rm -rfv *~ tmp


setup:
	sudo apt-get install wget emacs sudo unzip git

config:
	wget -O- ${url} > tmp.zip && unzip tmp.zip

deploy: all
	-git add . 
	-git commit -sam 'WIP'
	git push origin -f  HEAD:gh-pages

web_url?=https://${USER}.github.io/${USER}-example/
test:
	x-www-browser ${web_url}


licence_url?=https://licensedb.org/id/CC-BY-SA-4.0.txt
COPYING:
	@echo "Update ${CURDIR}/Makefile to setup licence"
	@echo "Fetching default one at:"
	@echo "URL: ${licence_url}"
	wget -O $@ "${licence_url}"
all: preview

build:
	properdocs build -f mkdocs.yml

deploy:
	properdocs gh-deploy --force -f mkdocs.yml

check test:
	properdocs build --strict -f mkdocs.yml

preview serve:
	properdocs serve -f mkdocs.yml

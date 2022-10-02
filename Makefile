default: help
help:
	@echo "Please use \`make <target>' where <target> is one of:"
	@echo "  help             to show this message"
	@echo "  test             to run unit tests"
	@echo "  docs             to build the collection documentation"
	@echo "  clean            to remove temporary build files"

test:
	molecule test --all

docs:
	mkdir -p docs/roles
	cat ./docs/roles.rst.template > ./docs/roles/index.rst
	echo "# Overview" > docs/README.md
	tail --lines +2 README.md >> docs/README.md
	for role_readme in roles/*/README.md; do \
		ln -f -s ../../$$role_readme ./docs/roles/$$(basename $$(dirname $$role_readme)).md; \
		echo " * :doc:\`$$(basename $$(dirname $$role_readme))\`" >> ./docs/roles/index.rst; \
	done
	make -C docs html

clean:
	rm -rf docs/_build docs/roles docs/README.md *.tar.gz

.PHONY: help test docs clean

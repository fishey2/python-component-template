get-latest-commit-hash:
	$(eval COMMIT_HASH=$(shell git log --pretty=format:'%h' -n 1))
	echo 'Latest commit hash ${COMMIT_HASH}'

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f  {} +

clean-env: clean-pyc
	rm -fr build/
	rm -fr dist/
	rm -fr *.egg-info

install:
	pip install -r requirements.txt

build: clean-env install
	pip install .

test-unit: build
	echo 'Testing unit tests for commit ${COMMIT_HASH}...'
	python -m unittest

test-integration: build get-latest-commit-hash
	echo 'Testing integration tests for commit ${COMMIT_HASH}...'
	python -m unittest discover -p integration*.py

lint: clean-env
	flake8

test:
	py.test --verbose --color=yes $(TEST_PATH)

run:
	python manage.py runserver

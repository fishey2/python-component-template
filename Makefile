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
	rm -fr test-results/

clean: clean-env clean-pyc

install:
	pip install -r requirements.txt

build: install
	pip install .

test: clean build _test_unit _test_integration
	echo 'Running all tests fror commit ${COMMIT_HASH}'

_test_unit:
	echo 'Running unit tests for commit ${COMMIT_HASH}...'
	python -m xmlrunner -o ./test-results/unit

test-unit: build get-latest-commit-hash _test_unit

_test_integration:
	echo 'Running integration tests for commit ${COMMIT_HASH}...'
	python -m xmlrunner discover -p integration*.py -o ./test-results/integration

test-integration: build get-latest-commit-hash _test_integration

lint: clean
	flake8

test:
	py.test --verbose --color=yes $(TEST_PATH)

run:
	python manage.py runserver

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

test: clean install _test_unit _test_integration
	echo 'Running all tests fror commit ${COMMIT_HASH}'

_test_unit:
	echo 'Running unit tests for commit ${COMMIT_HASH}...'
	python -m xmlrunner discover -s component_template -o ./test-results/unit

test-unit: install get-latest-commit-hash _test_unit

_test_integration:
	echo 'Running integration tests for commit ${COMMIT_HASH}...'
	python -m xmlrunner discover -s component_template -p itest*.py -o ./test-results/integration

test-integration: install get-latest-commit-hash _test_integration

_test_coverage:
	echo 'Running integration tests for commit ${COMMIT_HASH}...'
	coverage run -m unittest discover -s component_template -p *test*.py
	coverage xml -o ./test-results/coverage/coverage-all.xml --omit="**/test/*.py,venv/*"


test-coverage: install get-latest-commit-hash _test_coverage


lint: clean
	flake8

run:
	python manage.py runserver

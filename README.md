### Install

```bash
// Installs packages from requirements.txt
$ pip install -r requirements.txt

// Saves currently installed requirements to requirements.txt
$ pip freeze > requirements.txt
```

## Technology

1. CirlceCI

1. Flask


## CircleCI


## Process

### Create Virtual Environment

```bash
// Pip could also be pip3 depending on your default installation of python
$ pip install virtualenv

// Create a virtual enviornment
(Project Root)$ virtualenv venv

// Activate the virtual environment
(Project Root)$ source venv/bin/activate
```

### Setting up Project (venv) in PyCharm

1. `CMD + ,` to open the system preferences.
1. `Project: <project name>` tab on the left.
1. `> Project Interpreter` to select the interpreter
1. `> Settings > Add` to add the virtual environment
1. Select `Existing environment` and if not auto-populated, navigate to `venv/bin/python`
1. Select and Apply



# Testing

## UnitTest Example

An example of a test case in Python

```python
import unittest


class TestHelloWorld(unittest.TestCase):

    def test_true(self):
        self.assertTrue(True)


if __name__ == '__main__':
    unittest.main()
```

To run this you can use ` python -m unittest discover tests/`, the default.

## Packages

`__init__.py` denotes that it is a package allows you to group modules to export.

The following example is used in this project to keep the same structure between src and test.

```python
#!/usr/bin/env python

from distutils.core import setup

setup(name='component_template',
      version='1.0',
      description='Python Component Template',
      author='Brett Fisher',
      author_email='brett.fisher@thoughtworks.com',
      packages=['component_template'],
      package_dir={'component_template': 'src/component_template'}
      )
```

`pip install .` will install the source using the information provided. This can then be used as
an import to the tests.

```python
import unittest
from component_template import helloworld


class TestHelloWorld(unittest.TestCase):

    def test_hello(self):
        self.assertTrue(helloworld.hello())


if __name__ == '__main__':
    unittest.main()

```


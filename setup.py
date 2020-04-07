#!/usr/bin/env python

from distutils.core import setup

setup(name='component_template',
      version='1.0',
      description='Python Component Template',
      author='Brett Fisher',
      author_email='brett.fisher@thoughtworks.com',
      packages=['component_template'],
      package_dir={'component_template': 'component_template/component_template'}
      )

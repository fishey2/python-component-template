import unittest
from component_template import helloworld


class TestHelloWorld(unittest.TestCase):

    def test_hello(self):
        self.assertTrue(helloworld.hello())


if __name__ == '__main__':
    unittest.main()

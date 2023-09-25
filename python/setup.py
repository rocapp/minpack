from setuptools import setup
import os

setup(
    cffi_modules=["ffi-builder.py:ffibuilder"],
    package_data={"minpack": ["_libminpack*.so"]},
    include_dirs=[os.path.abspath(os.path.join(os.path.dirname(__file__), '../include'))]
)


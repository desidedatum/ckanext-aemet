# -*- coding: utf-8 -*-
from setuptools import setup, find_packages

version = '0.1.0'

setup(
    name='ckanext-aemet',
    version=version,
    description="CKAN extension for AEMET weather data visualization",
    long_description="""\
    A CKAN extension that provides visualization tools for Spanish Meteorological
    Agency (AEMET) weather prediction data.
    """,
    classifiers=[
        "Development Status :: 3 - Alpha",
        "License :: OSI Approved :: GNU Affero General Public License v3 or later (AGPLv3+)",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
    ],
    keywords='CKAN extension weather AEMET visualization',
    author='Desidedatum',
    author_email='',
    url='https://github.com/desidedatum/ckanext-aemet',
    license='AGPL-3.0',
    packages=find_packages(exclude=['ez_setup', 'examples', 'tests']),
    namespace_packages=['ckanext'],
    include_package_data=True,
    zip_safe=False,
    install_requires=[
        # Base CKAN requirement
        'ckan>=2.11.0',
    ],
    entry_points='''
        [ckan.plugins]
        aemet=ckanext.aemet.plugin:AemetPlugin

        [babel.extractors]
        ckan = ckan.lib.extract:extract_ckan
    ''',
    message_extractors={
        'ckanext': [
            ('**.py', 'python', None),
            ('**.js', 'javascript', None),
            ('**/templates/**.html', 'ckan', None),
        ],
    }
)

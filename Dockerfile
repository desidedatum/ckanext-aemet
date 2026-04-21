FROM ckan/ckan-base:2.11

USER root

COPY pyproject.toml setup.py /srv/app/src_extensions/ckanext-aemet/
COPY ckanext /srv/app/src_extensions/ckanext-aemet/ckanext

RUN pip install --no-cache-dir -e /srv/app/src_extensions/ckanext-aemet

USER ckan

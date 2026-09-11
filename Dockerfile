ARG CKAN_VERSION=2.12
FROM ckan/ckan-base:${CKAN_VERSION}

USER root

COPY pyproject.toml setup.py /srv/app/src_extensions/ckanext-aemet/
COPY ckanext /srv/app/src_extensions/ckanext-aemet/ckanext

RUN pip install --no-cache-dir -e /srv/app/src_extensions/ckanext-aemet

USER ckan

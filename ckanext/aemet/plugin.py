# -*- coding: utf-8 -*-
import ckan.plugins as plugins
import ckan.plugins.toolkit as toolkit


class AemetPlugin(plugins.SingletonPlugin):
    plugins.implements(plugins.IConfigurer)
    plugins.implements(plugins.IResourceView)

    def update_config(self, config_):
        toolkit.add_template_directory(config_, "templates")
        toolkit.add_public_directory(config_, "public")

    def info(self):
        return {
            "name": "aemet_view",
            "title": toolkit._("AEMET Weather Forecast"),
            "default_title": toolkit._("Weather Forecast"),
            "icon": "cloud",
            "schema": {},
            "iframed": False,
        }

    def can_view(self, data_dict):
        resource = data_dict.get("resource", {})
        fmt = resource.get("format", "").lower()
        return fmt == "aemet-json"

    def setup_template_variables(self, context, data_dict):
        return {}

    def view_template(self, context, data_dict):
        return "aemet/aemet_view.html"

    def form_template(self, context, data_dict):
        return "aemet/aemet_form.html"

#
# Cookbook Name:: commerce-gics
# Recipe:: default
#
# Copyright (c) 2016 Gannett Co., Inc, All Rights Reserved.
include_recipe 'ruby-deployment::nginx_deploy'

# These 3 go together to create an internal NGINX w/status page
include_recipe 'nginx::http_stub_status_module'
#include_recipe 'datadog::process'
#include_recipe 'datadog::nginx'
#include_recipe 'datadog::http_check'
#include_recipe 'nginx'
include_recipe 'ruby-deployment::nginx_deploy'

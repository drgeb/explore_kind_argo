#
# Cookbook:: bootstrap
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.
directory '/home/vagrant/.ssh' do
    owner 'vagrant'
    group 'vagrant'
    mode '0700'
    action :create
end

cookbook_file '/home/vagrant/.ssh/id_rsa_bb' do
    source 'id_rsa_bb'
    owner 'vagrant'
    group 'vagrant'
    mode '0600'
    action :create
end

cookbook_file '/home/vagrant/.ssh/config' do
    source 'config'
    owner 'vagrant'
    group 'vagrant'
    mode '0600'
    action :create
end

cookbook_file '/home/vagrant/.ssh/.ansible_vault_system_configs' do
    source 'ansible_vault_system_configs'
    owner 'vagrant'
    group 'vagrant'
    mode '0600'
    action :create
end

group 'drgeb' do
    append                true
    comment               "user group"
    group_name            "drgeb"
    action                :create
end

user 'drgeb' do
    comment 'A random user'
    uid 1234
    gid 'drgeb'
    home '/home/drgeb'
    shell '/bin/bash'
    password '$1$JJsvHslasdfjVEroftprNn4JHtDi'
end

group 'dev' do
    append                true
    comment               "Developers group"
    group_name            "dev"
    users                 "drgeb"
    action                :create
end

# roles/example.rb
sudo 'admins' do
    users 'drgeb'
    nopasswd true
    groups 'sysadmins, dev'
end

# Additional User
directory '/home/drgeb/' do
    owner 'drgeb'
    group 'drgeb'
    action :create
end

directory '/home/drgeb/.ssh' do
    owner 'drgeb'
    group 'dev'
    mode '0700'
    action :create
end

cookbook_file '/home/drgeb/.ssh/id_rsa_bb' do
    source 'id_rsa_bb'
    owner 'drgeb'
    group 'dev'
    mode '0600'
    action :create
end

cookbook_file '/home/drgeb/.ssh/config' do
    source 'config'
    owner 'drgeb'
    group 'dev'
    mode '0600'
    action :create
end

cookbook_file '/home/drgeb/.ssh/.ansible_vault_system_configs' do
    source 'ansible_vault_system_configs'
    owner 'drgeb'
    group 'dev'
    mode '0600'
    action :create
end

# 'http request' do
#     url "http://drgeb.com/bootstrap"
#     message <xml request>
#     action :get
#   end
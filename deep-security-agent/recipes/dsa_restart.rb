#
# Cookbook Name:: deep-security-agent
# Recipe:: Activate the Deep Security agent
#
# Copyright 2018, Trend Micro
#
# License as per [repo](master/LICENSE)
#
# *********************************************************************
# * Restart deep security agent
# *********************************************************************

execute 'activate_ds_agent' do
    command "service ds_agent stop"
    command "service ds_agent start"
end

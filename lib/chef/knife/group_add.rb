#
# Author:: Seth Falcon (<seth@chef.io>)
# Author:: Jeremiah Snapp (<jeremiah@chef.io>)
# Copyright:: Copyright 2011-2016 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module OpscodeAcl
  class GroupAdd < Chef::Knife
    category "OPSCODE HOSTED CHEF ACCESS CONTROL"
    banner "knife group add MEMBER_TYPE MEMBER_NAME GROUP_NAME"

    deps do
      require 'chef/knife/acl_base'
      include OpscodeAcl::AclBase
    end

    def run
      member_type, member_name, group_name = name_args

      if name_args.length != 3
        show_usage
        ui.fatal "You must specify member type [client|group|user], member name and group name"
        exit 1
      end

      validate_member_name!(group_name)
      validate_member_type!(member_type)
      validate_member_name!(member_name)

      if group_name.downcase == "users"
        ui.fatal "knife-acl can not manage members of the Users group"
        ui.fatal "please read knife-acl's README.md for more information"
        exit 1
      end

      add_to_group!(member_type, member_name, group_name)
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  dobt_user_id          :integer
#  profile               :hstore
#  needs_remote_refresh  :boolean          default(FALSE)
#  created_at            :datetime
#  updated_at            :datetime
#  organizations         :text
#  local_remember_token  :string(255)
#  global_remember_token :string(255)
#


class User < ActiveRecord::Base

end

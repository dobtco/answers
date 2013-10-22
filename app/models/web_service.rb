# == Schema Information
#
# Table name: articles
#
#  id                      :integer          not null, primary key
#  updated                 :datetime
#  title                   :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  content_type            :string(255)
#  preview                 :text
#  contact_id              :integer
#  tags                    :text
#  service_url             :string(255)
#  slug                    :string(255)
#  category_id             :integer
#  access_count            :integer          default(0)
#  author_pic_file_name    :string(255)
#  author_pic_content_type :string(255)
#  author_pic_file_size    :integer
#  author_pic_updated_at   :datetime
#  author_name             :string(255)
#  author_link             :string(255)
#  type                    :string(255)
#  content_main            :text
#  content_main_extra      :text
#  content_need_to_know    :text
#  user_id                 :integer
#  published               :boolean
#  pending_review          :boolean
#

class WebService < Article
  include TankerArticleDefaults

end

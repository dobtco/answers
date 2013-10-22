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

class Guide < Article
  include TankerArticleDefaults

  has_many :guide_steps

  TEXT_ANALYSE_FIELDS = ['guide_step_contents', 'guide_step_titles',
    'guide_step_previews', 'title', 'preview']

  tankit do
    indexes :content do
      guide_step_contents
    end

    indexes :title do
      guide_step_titles << title
    end

    indexes :preview do
      guide_step_previews << preview
    end
  end

  def guide_steps
    GuideStep.where("article_id = #{self.id}").order("step")
  end

  def guide_step_contents
    guide_steps.map(&:content).join(" ")
  end

  def guide_step_titles
    guide_steps.map(&:title).join(" ")
  end

  def guide_step_previews
    guide_steps.map(&:preview).join(" ")
  end
end

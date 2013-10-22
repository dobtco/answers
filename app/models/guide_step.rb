# == Schema Information
#
# Table name: guide_steps
#
#  id         :integer          not null, primary key
#  article_id :integer
#  title      :string(255)
#  content    :text
#  preview    :text
#  step       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GuideStep < ActiveRecord::Base
  belongs_to :guide, :class_name => 'Article', :foreign_key => 'article_id'

  delegate :category, :tags, :keywords, :to => :guide

  # after_save { guide.update_tank_indexes }
  # after_destroy { guide.delete_tank_indexes }

  after_create do
    guide.create_analysis
  end

  after_update do
    guide.text_analyser.delay(:priority => 1).update_analysis
  end

  after_destroy do
    guide.destroy_analysis
  end

end

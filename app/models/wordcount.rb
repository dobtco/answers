# == Schema Information
#
# Table name: wordcounts
#
#  id         :integer          not null, primary key
#  article_id :integer
#  keyword_id :integer
#  count      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Wordcount < ActiveRecord::Base

  belongs_to :article
  belongs_to :keyword

  before_validation :set_count_if_nil

  private

  def set_count_if_nil
    self.count = 0 if self.count.nil?
  end

end

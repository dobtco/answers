# == Schema Information
#
# Table name: keywords
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  metaphone  :string(255)
#  stem       :string(255)
#  synonyms   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Keyword < ActiveRecord::Base
  serialize :metaphone, Array
  serialize :synonyms, Array

  has_many :wordcounts
  has_many :articles, :through => :wordcounts

  after_create :analyse

  after_save do
    Rails.cache.delete('additional_words')
  end

  # returns the total number of occurrences of this keyword across all articles
  def count
    self.wordcounts.map(&:count).inject(0, :+)
  end

  def analyse
    raise "Cannot analyse keyword with no name" if self.name.blank?
    self.stem = Text::PorterStemming.stem( self.name )
    self.metaphone = Text::Metaphone.double_metaphone( self.name )
    self.synonyms = BigHugeThesaurus.synonyms( self.name )
    self.save
  end

end

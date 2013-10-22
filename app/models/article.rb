# encoding: utf-8
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

class Article < ActiveRecord::Base
  include RailsNlp
  include RailsNlp::ActiveRecordIncluded

  include TankerArticleDefaults

  require_dependency 'keyword'

  extend FriendlyId

  # Permalinks. :slugged option means it uses the 'slug' column for the url
  #             :history option means when you change the article title, old slugs still work
  friendly_id :title, use: [:slugged, :history, :finders]

  belongs_to :contact
  belongs_to :category
  belongs_to :user

  scope :by_access_count, order('access_count DESC')
  scope :drafts, where(:pending_review => false).where(:published => false)
  scope :pending_review, where(:pending_review => true)
  scope :published, where(:published => true)

  has_attached_file :author_pic,
    :storage => :s3,
    :bucket => ENV['S3_BUCKET'] || 'foo',
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    },
    :s3_protocol => :https,
    :path => "/:style/:id/:filename",
    :styles => { :thumb => "100x100" }

  validates_attachment_size :author_pic, :less_than => 5.megabytes
  validates_attachment_content_type :author_pic, :content_type => ['image/jpeg', 'image/png']

  validates_presence_of :access_count

  # Tanker callbacks to update the search index
  # after_save :update_tank_indexes
  # after_destroy :delete_tank_indexes

  # priority 2 to ensure it is run after text analysis
  # handle_asynchronously :update_tank_indexes, :priority => 2
  # handle_asynchronously :delete_tank_indexes, :priority => 2

  TEXT_ANALYSE_FIELDS = ['title', 'content_main', 'content_main_extra',
    'content_need_to_know', 'preview', 'tags', 'category_name']

  before_validation :set_access_count_if_nil

  def category_name
    category.try(:name) || "Uncategorized"
  end

  def self.search( query )
    begin
      self.search_tank query
    rescue Exception => exception
      []
    end
  end

  def self.find_by_type( content_type )
    return Article.where(:type => content_type).order('category_id').order('access_count DESC')
  end

  def to_s
    if self.category
      "#{self.title} (#{self.id}) [#{self.category}]"
    else
    end
  end

  def published?
    published
  end

  def pending_review?
    pending_review
  end

  def draft?
    !(pending_review || published)
  end

  def md_to_html( field )
    return '' if instance_eval(field.to_s).blank?
    Kramdown::Document.new( instance_eval(field.to_s), :auto_ids => false).to_html
  end

  def raw_md_to_html( field )
    return '' if field.to_s.blank?
    Kramdown::Document.new( field.to_s, :auto_ids => false).to_html
  end

  def related
    Rails.cache.fetch("#{self.id}-related") {
      return [] if wordcounts.empty?
      (Article.search(self.wordcounts.all(:order => 'count DESC', :limit => 10).map(&:keyword).map(&:name).join(" OR ")) - [self]).first(4)
    }
  end

  def set_access_count_if_nil
    self.access_count = 0 if self.access_count.nil?
  end

end

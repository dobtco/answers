# == Schema Information
#
# Table name: sites
#
#  id                       :integer          not null, primary key
#  dobt_organization_app_id :integer
#  name                     :string(255)
#  username                 :string(255)
#  custom_domain            :string(255)
#

class Site < ActiveRecord::Base

  extend FriendlyId
  include DobtAuth::Site

  friendly_id :username, use: [:finders]

  validates :name, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  def self.find_by_domain(x)
    self.where("custom_domain = ? OR custom_domain = ?", x.downcase, x.downcase.gsub(/^www\./, '')).first
  end

  def self.resolve_username(x)
    x.downcase!

    result = Site.select('username').where('username LIKE ?', "#{x}%").order('LENGTH(username) DESC, username DESC').first

    if result
      current_counter = result.username.match(/[0-9]+$/).try(:[], 0).try(:to_i)
      "#{x}-#{current_counter ? current_counter + 1 : 1}"
    else
      x
    end
  end

  after_validation :move_friendly_id_error_to_username

  def move_friendly_id_error_to_username
    if (error = errors.messages.delete(:friendly_id))
      errors.messages[:username] = error
    end
  end

  def url
    if self.custom_domain.presence
      "http://#{self.custom_domain}"
    else
      protocol = Rails.configuration.dobt[:ssl] ? 'https' : 'http'
      URI::join(protocol + '://' + Rails.configuration.dobt[:base_domain], "/#{self.username}").to_s
    end
  end

  def self.create_dobt_app(payload)
    new_site = Site.new(
      dobt_organization_app_id: payload['dobt_organization_app_id'],
      username: Site.resolve_username(payload['organization_name'].parameterize),
      name: "#{payload['organization_name']} Answers"
    )

    new_site.save ? new_site.dobt_params : false
  end

end

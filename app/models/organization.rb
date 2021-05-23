# == Schema Information
#
# Table name: organizations
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  domain      :string
#  logo_url    :string
#  logo_source :integer
#  user_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Organization < ApplicationRecord
	DOMAIN_REGEX = /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\z/ix
	LOGO_URL_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix

	belongs_to :user, optional: true
	has_many :match_rules

	enum logo_source: [:clearbit, :manual]

  validates :name, presence: true
  validates :domain, presence: true
  
	validates_format_of :domain, with: DOMAIN_REGEX
	validates_format_of :logo_url, with: LOGO_URL_REGEX, allow_blank: true

	before_save :update_logo_url_based_on_source

	private
	def update_logo_url_based_on_source
		if self.clearbit?
			self.logo_url = "https://logo.clearbit.com/#{domain}"
		end
	end
end

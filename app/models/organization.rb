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
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Organization < ApplicationRecord

	enum logo_source: [:clearbit]

  validates :name, presence: true
  
  validates :domain, url: true
	validates :logo_url, url: { allow_nil: true }
end

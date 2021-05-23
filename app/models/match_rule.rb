# == Schema Information
#
# Table name: match_rules
#
#  id              :bigint           not null, primary key
#  rule_type       :integer
#  match_string    :string
#  organization_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class MatchRule < ApplicationRecord
  belongs_to :organization

  enum rule_type: [:exact_match, :regex]
  validates :match_string, presence: true

  before_save :clean_the_string
  scope :matches, -> (str) { where(clean_match_string: self.clean_string(str)) }

  def self.clean_string str
    str.downcase.strip.gsub(/\s\s+/, ' ')
  end

  private
  def clean_the_string
    self.clean_match_string = match_string
  end
end

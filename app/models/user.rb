# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  require 'securerandom'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :organizations
  has_many :match_rules, through: :organizations

  before_create :update_api_key

  def regenerate_api_key
    update(api_key: "hyak_#{SecureRandom.hex}")
  end

  private
  def update_api_key
    self.api_key = "hyak_#{SecureRandom.hex}" 
  end
end

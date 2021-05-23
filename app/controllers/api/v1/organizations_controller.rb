class Api::V1::OrganizationsController < Api::V1::ApplicationController
  skip_before_action :authenticate_user!

  def search
    search_query = params[:query] || ''
    match_rules = filtered_match_rules.matches(search_query)
    if match_rules.present?
      render json: {success: true, data: response_data(match_rules.first)}
    else
      render json: {success: false}
    end
  end

  private
  def filtered_match_rules
    if user_signed_in?
      current_user.match_rules
    else
      default_organizations = Organization.where(user_id: nil)
      MatchRule.where(organization: default_organizations)
    end
  end

  def response_data match_rule
    {
      id: match_rule.id,
      organization: {
        id: match_rule.organization.id,
        name: match_rule.organization.name,
        logo_url: match_rule.organization.logo_url,
      }
    }
  end
end
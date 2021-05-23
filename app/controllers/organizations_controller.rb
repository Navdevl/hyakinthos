class OrganizationsController < ApplicationController

  before_action :set_organization, only: [:show, :edit, :update, :destroy, :new_match_rules, :match_rules]

  def index
    @organizations = current_user.organizations
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    @organization.user = current_user
    if @organization.save
      redirect_to(@organization, notice: 'Organization was successfully created.')
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @organization.update(organization_params)
      redirect_to(@organization, notice: 'Organization was successfully updated.')
    else
      render :edit
    end
  end

  def destroy
    @organization.destroy if @organization.user.present?
    redirect_to organizations_path
  end

  def match_rules
    match_rule = @organization.match_rules.new(match_rule_params)
    if match_rule.save
      redirect_to @organization, notice: 'Rule was successfully added.'
    else
      render :new_match_rules
    end
  end

  def new_match_rules
    @match_rule = @organization.match_rules.new
  end

  private
  def organization_params
    params.require(:organization).permit([:name, :description, :domain, :logo_url, :logo_source])
  end

  def match_rule_params
    params.require(:match_rule).permit([:match_string, :rule_type])
  end

  def set_organization
    @organization = current_user.organizations.find_by(id: params[:id])
    redirect_to organizations_path unless @organization.present?
  end
end

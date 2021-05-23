class MatchRulesController < ApplicationController
	before_action :set_match_rule
	
	def edit
	end

	def update
    if @match_rule.update(match_rule_params)
      redirect_to(@match_rule.organization, notice: 'Match rule was successfully updated.')
    else
      render :edit
    end
	end

	def destroy
    @match_rule.destroy if @match_rule.user.present?
    redirect_to @match_rule.organization
	end

	private
	def set_match_rule
		@match_rule = current_user.match_rules.find_by(id: params[:id])
		redirect_to organizations_path unless @match_rule.present?
	end

  def match_rule_params
    params.require(:match_rule).permit([:match_string, :rule_type])
  end
end

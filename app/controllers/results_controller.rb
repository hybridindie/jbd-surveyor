require 'iconv'
class ResultsController < ApplicationController
  helper 'surveyor'
  layout 'admin' 
  def index
    @surveys = Survey.all
  end

  def show
    @survey = Survey.find_by_access_code(params[:survey_code])
    if params[:q] && !params[:q].blank?
      filter = User.where("first_name LIKE :q OR last_name LIKE :q", :q => params[:q])
      @response_sets = ResponseSet.where("survey_id = ? AND response_sets.agent_id = ?", @survey, filter)#@survey.response_sets.where
    else
      @response_sets = @survey.response_sets
    end
    @questions = @response_sets.first.survey.sections_with_questions.map(&:questions).flatten
    respond_to do |format|
      format.html
#      format.csv { export_csv(@response_sets) }
    end
  end

protected

#  def export_csv(projects)
#    filename = I18n.l(Time.now, :format => :short) + "- Reports.csv"
#    content = Project.to_csv(projects)
#    content = BOM + Iconv.conv("utf-16le", "utf-8", content)
#    send_data content, :filename => filename
#  end
end
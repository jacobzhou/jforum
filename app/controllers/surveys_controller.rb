# encoding: utf-8
class SurveysController < ApplicationController
  layout "jk"

  def show
    @survey = Survey.find(params[:id])
    @survey_questions = @survey.survey_questions
  end

  def update
  	@survey_user_sheet = SurveyUserSheet.create(:user_id => current_user.id, :survey_id => @survey.id)
		params[:answer].each do |k, v|
			@survey_user_sheet.survey_user_answers.create(:survey_question_id => k, :answers => v)
		end  
  end

 	def index
 		@surveys = Survey.includes([:survey_user_sheets]).page(params[:page])
    @breadcrumbs = ["健康管理"]
 	end

  def create
    render :text => params
  end

  def health_record

  end

end

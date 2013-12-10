# encoding: utf-8
class SurveyUserSheetsController < ApplicationController
  def index
    @survey_user_sheets = SurveyUserSheet.order('created_at DESC').page(params[:page])
    @title = '健康问卷管理'
  end

  def new
    @survey = Survey.find(params[:survey_id])
    @survey_questions = @survey.survey_questions
    @survey_user_sheet = SurveyUserSheet.new(:survey_id => params[:survey_id])
    @survey_questions.each do |survey_question|
      @survey_user_sheet.survey_user_answers.build(:survey_question_id => survey_question.id)
    end
  end

  def create
    @survey_user_sheet = SurveyUserSheet.create(params[:survey_user_sheet])
    respond_with :admin, @survey_user_sheet, :location => admin_survey_user_sheets_path
  end

  def edit
    @survey_user_sheet = SurveyUserSheet.find(params[:id])
    1.times { @survey_user_sheet.survey_user_sheet_questions.build } if @survey_user_sheet.survey_user_sheet_questions.blank?
    @title = '编辑健康问卷'
  end

  def update
    @survey_user_sheet = SurveyUserSheet.find(params[:id])
    @survey_user_sheet.update_attributes(params[:survey_user_sheet])
    respond_with :admin, @survey_user_sheet, :location => admin_survey_user_sheets_path
  end

  def destroy
    @survey_user_sheet = SurveyUserSheet.find(params[:id])
    if @survey_user_sheet.destroy
      redirect_to admin_survey_user_sheets_path
    else
      redirect_to admin_root_path
    end
  end
end

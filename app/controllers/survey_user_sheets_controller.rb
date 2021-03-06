# encoding: utf-8
class SurveyUserSheetsController < ApplicationController
  layout "jk"

  def index
    @survey_user_sheets = SurveyUserSheet.includes(:survey).order('created_at DESC').page(params[:page])
    @title = '健康问卷'
  end

  def new
    @survey = Survey.find(params[:survey_id])
    @survey_questions = @survey.survey_questions
    @survey_user_sheet = SurveyUserSheet.new(:survey_id => params[:survey_id])
    @survey_questions.each do |survey_question|
      @survey_user_sheet.survey_user_answers.build(:survey_question_id => survey_question.id)
    end
    @can_edit = true
    @bread = ["健康问卷", @survey.name]
  end

  def create
    if current_user.survey_user_sheets.find_by_id(params[:survey_id]).try(:in_period?)
      flash[:error] = "抱歉，还不能更新。"
      redirect_to :back and return
    end
    @survey_user_sheet = SurveyUserSheet.new(:survey_id => params[:survey_id], :user_id => current_user.id)
    params[:q].each do |k, v| 
      if v.class.to_s == "ActionDispatch::Http::UploadedFile" 
        @survey_user_sheet.survey_user_answers.build(:survey_question_id => k).photos.build(:file => v)
      else
        @survey_user_sheet.survey_user_answers.build(:survey_question_id => k, :answers => v)
      end
    end
    flash[:success] = "提交成功" if @survey_user_sheet.save
    respond_with @survey_user_sheet, :location => survey_user_sheets_path
  end

  def edit
    @survey_user_sheet = SurveyUserSheet.find(params[:id])
    authorize! :update, @survey_user_sheet
    @survey = @survey_user_sheet.survey
    @survey_questions = @survey.survey_questions
    if current_user.id == @survey_user_sheet.user_id && !@survey_user_sheet.audit?
      @bread = ["健康问卷", @survey.name]
      @can_edit = true
    else
      @bread = ["健康管理", "健康档案 - #{@survey_user_sheet.user.nickname}", @survey.name]
      @can_edit = false
    end
  end

  def update
    @survey_user_sheet = SurveyUserSheet.find(params[:id])
    params[:q].each do |k, v| 
      @survey_user_sheet.survey_user_answer(k).update_attribute(:answers, v)
    end
    respond_with @survey_user_sheet, :location => survey_user_sheets_path
  end

  def destroy
    @survey_user_sheet = SurveyUserSheet.find(params[:id])
    flash[:success] = "删除成功" if @survey_user_sheet.destroy
    redirect_to :back
  end
end

# encoding: utf-8
class Admin::SurveysController < Admin::BaseController
  def index
    @surveys = Survey.order('created_at DESC').page(params[:page])
    @title = '健康问卷管理'
  end

  def new
    @survey = Survey.new
    @title = '新建健康问卷'
  end

  def create
    @survey = Survey.create(params[:survey])
    respond_with :admin, @survey, :location => admin_surveys_path
  end

  def edit
    @survey = Survey.find(params[:id])
    @title = '编辑健康问卷'
  end

  def update
    @survey = Survey.find(params[:id])
    @survey.update_attributes(params[:survey])
    respond_with :admin, @survey, :location => admin_surveys_path
  end

  def destroy
    @survey = Survey.find(params[:id])
    if @survey.destroy
      redirect_to admin_surveys_path
    else
      redirect_to admin_root_path
    end
  end

  def edit_survey_questions
    @survey = Survey.find(params[:id])
    @title = "编辑问题 - #{@survey.name}"
  end
end

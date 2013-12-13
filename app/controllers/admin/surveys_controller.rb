# encoding: utf-8
class Admin::SurveysController < Admin::BaseController
  def index
    @surveys = Survey.order('created_at DESC').page(params[:page])
    @title = '健康问卷管理'
  end

  def new
    @survey = Survey.new
    1.times { @survey.survey_questions.build }
    @title = '新建健康问卷'
  end

  def create
    @survey = Survey.create(params[:survey])
    respond_with :admin, @survey, :location => admin_surveys_path
  end

  def edit
    @survey = Survey.find(params[:id])
    1.times { @survey.survey_questions.build } if @survey.survey_questions.blank?
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

  def records
    @users = User.has_records.includes(:survey_user_sheets => :survey).page(params[:page])
    #@survey_user_sheets = SurveyUserSheet.order('created_at DESC').page(params[:page])
  end

  def notify
    survey_user_answer = SurveyUserAnswer.find(params[:survey_user_answer_id])
    flash[:success] = "提醒成功" if SurveyNotice.find_or_create_by(:user_id => survey_user_answer.survey_user_sheet.user_id, :survey_question_id => survey_user_answer.survey_question_id, :noticer_id => current_user.id)
    redirect_to :back
  end
end

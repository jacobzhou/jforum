# encoding: utf-8
class Admin::SurveyRepliesController < Admin::BaseController
  def index
    @survey_replies = SurveyReply.includes([:user, :survey_user]).page(params[:page])
  end

  def new
    @user = User.find_by_id(params[:survey_user_id])
    unless @user
      flash_msg(:error, "无答复人员")
      redirect_to :action => :index and return
    end 
    @survey_reply = SurveyReply.new(:title => "#{@user.nickname}健康服务方案",:survey_user_id => params[:survey_user_id], :user_id => current_user.id)
    @title = "营养师答复 @#{@user.nickname}"
  end

  def create
    @survey_reply = SurveyReply.new(params[:survey_reply])
    flash_msg(:success) if @survey_reply.save
    if params[:zc]
      redirect_to :action => :show, :id => @survey_reply
    else
      # 发邮件
      respond_with :admin, @survey_reply, :location => admin_survey_replies_path
    end
  end

  def edit
    @survey_reply = SurveyReply.find(params[:id])
  end

  def update
    @survey_reply = SurveyReply.find(params[:id])
    flash_msg(:success) if @survey_reply.update_attributes(params[:survey_reply])
    respond_with :admin, @survey_reply, :location => admin_survey_replies_path
  end

  def destroy
    if @survey_reply.destroy
      respond_to do |format|
        flash_msg(:success) 
        format.html{respond_back(@survey_reply)}
        format.json{render :json => true}
        # format.json{render :json => {status:'success'}}
      end
    end
  end

  def show
    @survey_reply = SurveyReply.find(params[:id])
  end
end

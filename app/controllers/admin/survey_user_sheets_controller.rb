# encoding: utf-8
class Admin::SurveyUserSheetsController < Admin::BaseController
  def index
    @users = User.has_records.includes(:survey_user_sheets => :survey).page(params[:page])
  end

  def audit
    UserMailer.test(current_user).deliver
    sheet = SurveyUserSheet.find(params[:id])
    sheet.audit!(current_user)
    flash[:success] =  sheet.audit? ? "审核通过！" : "撤销成功！"
    redirect_to :back
  end

end

# encoding: utf-8
class UserMailer < ActionMailer::Base
  default from: DataDict.mail_from

  # 调用方法: UserMailer.test(current_user).deliver
  def test(user)
    @user = user
    @content  = '测试一下'
    mail(to: @user.email, subject: 'yggc测试邮件')
  end

end

# encoding: utf-8
class SurveyReply < ActiveRecord::Base
  attr_protected
  belongs_to :user
  belongs_to :survey_user, :class_name => "User", :foreign_key => "survey_user_id"
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"

  def send?
    self.send_at.present?
  end

  def food_to_ary(column_name)
    self.send(column_name).split.map do |r, index|
      [r.split("-")[0], r.split("-")[1]]
    end
  end
end

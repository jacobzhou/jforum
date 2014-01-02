# encoding: utf-8
class SurveyUserSheet < ActiveRecord::Base
  attr_protected

  belongs_to :survey
  belongs_to :user
  has_many :survey_user_answers
  has_many :notifications, :as => :notifiable, :dependent => :destroy

  def survey_user_answer(survey_quetion_id)
    self.survey_user_answers.find_by_survey_question_id(survey_quetion_id)
  end

  def in_period?
    (self.created_at + survey.period.days) > Time.now
  end

  def next_days
    ((self.created_at + survey.period.days).to_date - Date.today).to_i
  end

  def audit!(user)
    audit? ? clean_audit : self.update_attributes(:auditor_id => user.id, :auditor_name => user.nickname, :audit_at => Time.now)
  end

  def clean_audit
    self.update_attributes(:auditor_id => nil, :auditor_name => nil, :audit_at => nil)
  end

  def audit? 
    self.audit_at.present? && self.auditor_id.present? && self.auditor_name.present?
  end
end

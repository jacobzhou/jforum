# encoding: utf-8
class SurveyNotice < ActiveRecord::Base
  attr_protected

  validates :user_id, :presence => true
  validates :survey_question_id, :presence => true

  belongs_to :user
  belongs_to :survey_question

  default_value_for :status, 0
end

# encoding: utf-8
class SurveyUserSheet < ActiveRecord::Base
  attr_protected

  belongs_to :survey
  belongs_to :user
  has_many :survey_user_answers
end

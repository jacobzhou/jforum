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
end

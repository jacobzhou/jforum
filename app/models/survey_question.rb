# encoding: utf-8
class SurveyQuestion < ActiveRecord::Base
  attr_accessible :survey_id

  belongs_to :survey
end

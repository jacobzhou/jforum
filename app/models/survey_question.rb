# encoding: utf-8
class SurveyQuestion < ActiveRecord::Base
  attr_protected

  belongs_to :survey
end

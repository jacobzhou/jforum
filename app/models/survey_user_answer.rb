# encoding: utf-8
class SurveyUserAnswer < ActiveRecord::Base
  attr_protected

  belongs_to :survey_user_sheet
  belongs_to :survey_question

  has_many :photos, :as => :photoable
  accepts_nested_attributes_for :photos, :reject_if => lambda { |item| item[:file].blank? }, :allow_destroy => true
end

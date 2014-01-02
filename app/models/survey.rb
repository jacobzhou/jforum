# encoding: utf-8
class Survey < ActiveRecord::Base
  attr_accessible :period, :desc, :content, :name, :survey_questions_attributes	

  validates :name, :presence => true

  has_many :survey_questions
  has_many :survey_user_sheets
  accepts_nested_attributes_for :survey_questions, :reject_if => lambda { |item| item[:title].blank? }, :allow_destroy => true

  def roots
  	survey_questions.select{|q| q.is_root?}
  end
end

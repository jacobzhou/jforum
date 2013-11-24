# encoding: utf-8
class Survey < ActiveRecord::Base
  attr_accessible :name

  validates :name, :presence => true

  has_many :survey_questions
  accepts_nested_attributes_for :survey_questions, :reject_if => lambda { |item| item[:title].blank? }, :allow_destroy => true

end

# encoding: utf-8
class SurveyQuestion < ActiveRecord::Base
  attr_protected

  validates :title, :presence => true
  validates :qtype, :presence => true
  # validates :score, :presence => true, :numericality => true

  belongs_to :survey

  has_ancestry

  default_scope order("position ASC")
end

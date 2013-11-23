# encoding: utf-8
class Survey < ActiveRecord::Base
  attr_accessible :name

  validates :name, :presence => true
end

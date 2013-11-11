class Photo < ActiveRecord::Base
  belongs_to :photoable, :polymorphic => true
  attr_accessible :description, :file
  mount_uploader :file, PhotoUploader

end

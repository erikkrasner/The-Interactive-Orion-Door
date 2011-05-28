class Orion < ActiveRecord::Base
  validates :name, :presence => true
  validates :contributor, :presence => true
  validates :imgsrc, :presence => true
  validates :timgsrc, :presence => true
  validates :x, :presence => true
  validates :y, :presence => true
end

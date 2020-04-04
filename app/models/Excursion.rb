class Excursion < ActiveRecord::Base
  belongs_to :user
  has_many :places


end 
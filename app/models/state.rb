class State < ApplicationRecord
  validates_presence_of :name,
                        :lat,
                        :long,
                        :zoom

  validates_uniqueness_of :name
end

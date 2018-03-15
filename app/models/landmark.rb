class Landmark <ActiveRecord::Base
  # A Landmark belongs_to a figure and a figure has_many landmarks.
  belongs_to :figure
end

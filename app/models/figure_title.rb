class FigureTitle <ActiveRecord::Base
  # A figure_title belongs_to a figure and a title.
  belongs_to :figure
  belongs_to :title
end

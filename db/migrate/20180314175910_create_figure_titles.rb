class CreateFigureTitles < ActiveRecord::Migration[5.1]
  def change
    # id	title_id	figure_id
    create_table :figure_titles do |t|
      t.integer :title_id
      t.integer :figure_id
    end
  end
end

class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :url_name
    end
  end
end

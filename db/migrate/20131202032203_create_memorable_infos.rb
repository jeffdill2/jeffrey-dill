class CreateMemorableInfos < ActiveRecord::Migration
  def change
    create_table :memorable_infos do |t|
      t.string :subject
      t.text :description
      t.string :image
      t.date :date

      t.timestamps
    end
  end
end

class AddExamples < ActiveRecord::Migration[7.1]
  def change
    create_table :examples do |t|
      t.string :name
      t.timestamps
    end
  end
end

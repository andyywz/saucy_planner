class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.references :person, foreign_key: true
      t.references :event, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end

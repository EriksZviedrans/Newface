class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :name
      t.string :facebook_event_id
      t.string :descritption
      t.string :location
      t.date :startTime
      t.date :endTime
      t.boolean :privacy

      t.timestamps
    end
   Event.getevents
  end
end

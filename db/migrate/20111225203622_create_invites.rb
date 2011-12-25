class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :facebook_event_id
      t.string :name
      t.string :rsvp_status

      t.timestamps
    end
    Invite.getinvite
  end
end

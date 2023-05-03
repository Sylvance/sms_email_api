class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :from
      t.string :to
      t.string :subject
      t.string :body
      t.string :medium
      t.boolean :is_received
      t.datetime :sent_at
      t.datetime :received_at

      t.timestamps
    end
  end
end

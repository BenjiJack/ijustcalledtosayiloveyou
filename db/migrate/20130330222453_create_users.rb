class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :sendername
      t.string :recipientname
      t.string :recipientphone

      t.timestamps
    end
  end
end

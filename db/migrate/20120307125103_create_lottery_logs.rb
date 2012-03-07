class CreateLotteryLogs < ActiveRecord::Migration
  def change
    create_table :lottery_logs do |t|
      t.string :fb_uid
      t.string :fb_email
      t.boolean :win, default: false
      t.integer :stage, default: 1

      t.timestamps
    end
    
    add_index :lottery_logs, [:stage, :win]
  end
end

class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.decimal :amount_in_cents, deafult: 0.0, null: false
      t.string :currency, null: false
      t.string :purpose, null: false
      t.integer :status, null: false, default: 0, index: true
      t.integer :lock_version

      t.references :account, foreign_key: { to_table: :users }, index: true, null: false
      t.references :creator, foreign_key: { to_table: :users }, index: true, null: false
      t.references :updater, foreign_key: { to_table: :users }, index: true, null: false

      t.timestamps
    end
  end
end

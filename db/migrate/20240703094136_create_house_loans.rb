class CreateHouseLoans < ActiveRecord::Migration[7.1]
  def change
    create_table :house_loans do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address

      t.integer :loan_term
      t.integer :purchase_price
      t.integer :repair_budget
      t.integer :after_repair_value

      t.timestamps
    end
  end
end

class HouseLoan < ApplicationRecord
  validates :address, presence: true
  validates :loan_term, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  validates :purchase_price, presence: true, numericality: { only_integer: true }
  validates :repair_budget, presence: true, numericality: { only_integer: true }
  validates :after_repair_value, presence: true, numericality: { only_integer: true }
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true
end

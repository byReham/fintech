class Payment < ApplicationRecord
  include Stampable
  include Payments::StateMachine

  belongs_to :account, class_name: 'User'

  enum status: %i[initial executed declined]

  validates_presence_of :amount_in_cents, :currency, :purpose, :account_id

  monetize :amount_in_cents, as: :amount, with_currency: ->(payment) { payment.currency }
  has_paper_trail ignore: [:id, :created_at, :updated_at, :updater_id, :creator_id, :lock_version]
end

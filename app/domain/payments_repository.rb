# app/infrastructure/persistence/active_record_payment_repository.rb

require 'active_record'
require_relative '../../domain/payment'

class ActiveRecordPaymentRepository
  def create_payment(order_id, payment_method, amount)
    record = PaymentRecord.create(
      order_id: order_id,
      payment_method: payment_method,
      amount: amount,
      payment_status: 'Pending'
    )
    Payment.new(
      id: record.id,
      order_id: record.order_id,
      payment_method: record.payment_method,
      amount: record.amount,
      payment_status: record.payment_status,
      transaction_id: record.transaction_id,
      created_at: record.created_at,
      updated_at: record.updated_at
    )
  end

  def update_payment(payment_id, attributes)
    record = PaymentRecord.find(payment_id)
    record.update(attributes)
    Payment.new(
      id: record.id,
      order_id: record.order_id,
      payment_method: record.payment_method,
      amount: record.amount,
      payment_status: record.payment_status,
      transaction_id: record.transaction_id,
      created_at: record.created_at,
      updated_at: record.updated_at
    )
  end

  # Otros métodos según sea necesario
end

# Define el modelo ActiveRecord para Payments
class PaymentRecord < ActiveRecord::Base
  self.table_name = 'Payments'

  # Relaciones
  belongs_to :order, foreign_key: 'order_id'

  # Validaciones si es necesario
end

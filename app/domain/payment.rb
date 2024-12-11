# app/domain/payment.rb

class Payment
    attr_reader :id, :order_id, :payment_method, :amount, :payment_status, :transaction_id, :created_at, :updated_at
  
    def initialize(attributes = {})
      @id = attributes[:id]
      @order_id = attributes[:order_id]
      @payment_method = attributes[:payment_method]
      @amount = attributes[:amount]
      @payment_status = attributes[:payment_status] || 'Pending'
      @transaction_id = attributes[:transaction_id]
      @created_at = attributes[:created_at] || Time.now
      @updated_at = attributes[:updated_at] || Time.now
    end
  
    # Métodos de dominio adicionales pueden agregarse aquí
  end
  
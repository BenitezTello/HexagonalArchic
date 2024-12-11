# app/domain/order.rb

class Order
    attr_reader :id, :user_id, :total, :status, :created_at, :updated_at
  
    def initialize(attributes = {})
      @id = attributes[:id]
      @user_id = attributes[:user_id]
      @total = attributes[:total]
      @status = attributes[:status] || 'Pending'
      @created_at = attributes[:created_at] || Time.now
      @updated_at = attributes[:updated_at] || Time.now
    end
  
    # Métodos de dominio adicionales pueden agregarse aquí
  end
  
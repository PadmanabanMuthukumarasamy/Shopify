# frozen_string_literal: true

class TenantNotFoundError < StandardError
  def initialize(msg = "The requested tenant (store) was not found")
    super
  end
end

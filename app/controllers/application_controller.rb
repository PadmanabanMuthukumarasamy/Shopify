class ApplicationController < ActionController::Base
  rescue_from TenantNotFoundError, with: :handle_tenant_not_found

  private

  def handle_tenant_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end
end

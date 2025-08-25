# frozen_string_literal: true

class TenantMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    #binding.break
    rq = Rack::Request.new(env)

    store_id = rq.get_header("HTTP_X_TENANT")

    if store_id.blank?
      host = rq.host
      part = host.split(".")
      store_id = part[0]
    end

    CurrentTenant.tenant = Store.find_by(store_id: store_id)

    @app.call(env)
  ensure
    CurrentTenant.reset
  end
end

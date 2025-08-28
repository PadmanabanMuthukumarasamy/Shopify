# frozen_string_literal: true

# Current holds per-request global attributes.
# It behaves like a thread-safe container (similar to ThreadLocal in Java).
class CurrentTenant< ActiveSupport::CurrentAttributes
  attribute :tenant
end

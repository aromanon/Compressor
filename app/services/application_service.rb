# frozen_string_literal: true

# This is a parent class for service objects in application.
# It allows share common behavior among services.
class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end
end

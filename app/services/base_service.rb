class BaseService < ApplicationService
  def on_success
    yield if errors.blank?
  end

  def on_failure
    yield if errors.present?
  end
end

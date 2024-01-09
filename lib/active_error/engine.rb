# frozen_string_literal: true

module ActiveError
  class Engine < ::Rails::Engine
    isolate_namespace ActiveError

    initializer "active_error.middleware" do |_app|
      ActionController::Base.before_action do
        Rails.error.set_context(active_error_request: request)
      end
      Rails.error.subscribe(::ActiveError::ErrorSubscriber.new)
    end
  end
end
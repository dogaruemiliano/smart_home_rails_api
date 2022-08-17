class ApplicationController < ActionController::API
  include Pundit::Authorization

  before_action :doorkeeper_authorize!, except: :show
  after_action :verify_authorized, except: :show
  after_action :verify_policy_scoped, only: :index

  def current_user
    @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
  end

  def user_not_authorized(exception)
    render json: {
      error: "Unauthorized #{exception.policy.class.to_s.underscore.camelize}.#{exception.query}"
    }, status: :unauthorized
  end

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end
end

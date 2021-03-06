class ApplicationController < ActionController::Base
  include BackendClient

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from BackendClient::APIError do |error|
    flash[:error] = error.meta.present? ? error.meta : error.message
    go_back(error.is_a?(::BackendClient::NotFound) ? root_path : :back)
  end

  rescue_from BackendClient::RequestError do
    flash[:error] = 'Something unexpected occurred while sending the request. Please contact techincal support'
    go_back root_path
  end

  rescue_from ActionController::ParameterMissing do |error|
    flash[:error] = 'Required fields must be filled out. Please consult the manual'
    go_back
  end

  def index
  end

  protected

  def id
    params.require(:id)
  end

  def update_resource(resource, update_params)
    resource.merge!(update_params)
    resource.update!(*update_params.keys.map(&:to_sym))
    resource
  end

  def go_back(back = nil)
    redirect_to (back || params[:back] || :back)
  end
end

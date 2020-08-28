class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_up_path_for(resource)
    mypage_path(resource)
  end
  
  def after_sign_in_path_for(resource)
    mypage_path(resource)
  end
#404ページ
  unless Rails.env.development?
    rescue_from Exception,                      with: :render_500
    rescue_from ActiveRecord::RecordNotFound,   with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
  end
 
  def routing_error
    raise ActionController::RoutingError, params[:path]
  end
 
  private
  
  def counts(user)
    @count_posts = user.posts.count
  end
  
  def render_404
    render 'error/404', status: :not_found
  end
 
  def render_500
    render 'error/500', status: :internal_server_error
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image]) 
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image])
  end
end

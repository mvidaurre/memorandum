class ApplicationController < ActionController::API
	before_filter :require_api_token
  
  private
 
  def require_api_token
    unless logged_in?
      render json: {error: "USER SHOULD BE LOGGED IN TO SEE CONTENT"}
    end
  end

  def logged_in?
  		session[:current_user_id] != nil
  end	
end

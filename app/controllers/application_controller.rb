class ApplicationController < ActionController::API
	before_filter :require_api_token

  
  private
 
  def require_api_token
  	if params[:api_token] 
  		user = User.where('api_token = ? ', params[:api_token]).first
  		api_token = user.api_token unless user.nil?
  	else
  		head :unauthorized unless api_token
  	end
  end

end

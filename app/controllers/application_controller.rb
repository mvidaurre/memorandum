class ApplicationController < ActionController::API
	before_filter :require_api_token

  
  private
 
  def require_api_token
  	if params[:api_token] 
  		api_token = current_user.api_token unless current_user.nil?
  		logger.info "Parametros: #{params} api_token: #{api_token}" 
  	else
  		head :unauthorized unless api_token
  	end
  end

  def current_user
  	User.where('api_token = ? ', params[:api_token]).first if params[:api_token] 	
  end

end

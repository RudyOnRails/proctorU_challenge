class ApplicationController < ActionController::API
  before_action :log_api_request

  rescue_from ActionController::ParameterMissing do |e|
    render json: e.message.to_json, status: 400
  end

  private
    def log_api_request
      ApiRequest.create(
        # user: api_user,
        endpoint: request.fullpath,
        remote_ip: request.remote_ip,
        payload: params,
      )
    end
end

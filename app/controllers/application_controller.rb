class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing do |e|
    render json: e.message.to_json, status: 400
  end
end

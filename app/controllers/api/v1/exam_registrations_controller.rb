class Api::V1::ExamRegistrationsController < ApplicationController

  rescue_from ActionController::ParameterMissing do
    head :bad_request
  end

  def create
    user = User.find_or_create_by(first_name: exam_registration_params[:first_name])
  end

  private
    def exam_registration_params
      params.require(:exam_registration).tap do |params|
        params.require(:first_name)
      end
    end
end

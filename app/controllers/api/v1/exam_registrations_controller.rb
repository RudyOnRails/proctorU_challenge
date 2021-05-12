class Api::V1::ExamRegistrationsController < ApplicationController

  before_action :get_college, :get_exam

  rescue_from ActionController::ParameterMissing do |e|
    render json: e.message.to_json, status: 400
  end

  def create
    user = User.find_or_create_by(first_name: exam_registration_params[:first_name])
    head :ok
  end

  private
    def exam_registration_params
      [:first_name, :last_name, :phone_number, :college_id, :exam_id].each_with_object(params) do |key, obj|
        obj.require(key)
      end
    end

    def get_college
      begin
        id = exam_registration_params[:college_id]
        @college = College.find(id)
      rescue ActiveRecord::RecordNotFound
        render json: "College id #{id} not found".to_json, status: 400
      end
    end

    def get_exam
      begin
        id = exam_registration_params[:exam_id]
        @exam = Exam.find(id)
      rescue ActiveRecord::RecordNotFound
        render json: "Exam id #{id} not found".to_json, status: 400
      end
    end
end

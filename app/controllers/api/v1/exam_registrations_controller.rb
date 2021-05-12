class Api::V1::ExamRegistrationsController < ApplicationController

  before_action :get_college, :get_exam

  rescue_from ActionController::ParameterMissing do |e|
    render json: e.message.to_json, status: 400
  end

  def create
    @user = User.find_or_create_by(first_name: exam_registration_params[:first_name])

    if @user.save
      render json: "#{@user.first_name} assigned to exam #{@exam.id}".to_json, status: 200
    else
      render json: @user.errors.to_json, status: 400
    end
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
        render json: "Exam #{id} not found".to_json, status: 400
      else
        render json: "Exam #{id} does not belong to College #{@college.id}".to_json, status: 400 if @exam.college_id != @college.id
      end
    end
end

class Api::V1::ExamRegistrationsController < ApplicationController

  before_action :get_college, :get_exam, :check_start_time

  def create
    @user = User.create_or_find_by(first_name: exam_registration_params[:first_name],
                                   last_name: exam_registration_params[:last_name],
                                   phone_number: exam_registration_params[:phone_number])

    @user.exam_id = @exam.id

    if @user.save
      render json: "#{@user.first_name} assigned to exam #{@exam.id}".to_json, status: 200
    else
      render json: @user.errors.to_json, status: 400
    end
  end

  private
    def exam_registration_params
      [:first_name, :last_name, :phone_number, :college_id, :exam_id, :start_time].each_with_object(params) do |key, obj|
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

    def check_start_time
      unless (@exam.starts_at..@exam.ends_at).cover? exam_registration_params[:start_time]
        render json: "Requested start_time does not fall within exam's time window".to_json, status: 400
      end
    end
end

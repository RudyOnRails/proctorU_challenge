class Api::V1::ExamRegistrationsController < ApplicationController
  def create
    user = User.upsert(user_params)
  end

  private
    def user_params
      params.require(:first_name)
    end
end

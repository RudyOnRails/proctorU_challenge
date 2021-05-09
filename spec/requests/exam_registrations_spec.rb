require 'rails_helper'

describe 'api/v1/exam_registrations.json', type: :request do
  describe 'POST /create' do

    let(:college) { College.create }
    let(:exam)    { college.exams.create(start_time: 3.days.ago, end_time: 1.days.from_now) }

    let(:valid_attributes) do
      {
        first_name: "Kevin",
        last_name: "Musiorski",
        phone_number: "13127725636",
        college_id: college.id,
        exam_id: exam.id,
      }
    end

    fit "returns 200 with good params" do
      get('/api/v1/exam_registrations.json', params)
      expect(response).to have_http_status :ok
    end
  end
end

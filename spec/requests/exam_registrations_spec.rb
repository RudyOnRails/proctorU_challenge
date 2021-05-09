require 'rails_helper'

describe 'api/v1/exam_registrations.json', type: :request do
  describe 'POST /create' do

    let(:college) { College.create }
    let(:exam)    { college.exams.create(starts_at: 3.days.ago, ends_at: 1.days.from_now) }

    let(:valid_attributes) do
      {
        first_name: "Kevin",
        last_name: "Musiorski",
        phone_number: "13127725636",
        college_id: college.id,
        exam_id: exam.id,
      }
    end
    
    it "returns 400 when first_name is missing" do
      get('/api/v1/exam_registrations', params: valid_attributes.except(:first_name), as: :json)
      expect(response).to have_http_status 400
    end

  end
end

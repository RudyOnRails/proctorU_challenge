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
    
    %i[first_name last_name phone_number college_id exam_id].each do |param|
      it "returns detailed 400 when #{param} is missing" do
        post('/api/v1/exam_registrations.json', params: valid_attributes.except(param))
        expect(response).to have_http_status 400
        expect(response.body).to include(param.to_s)
      end
    end
    
    it "returns 400 when college_id is not found" do
      post('/api/v1/exam_registrations.json', params: valid_attributes.merge(college_id: "888"))
      expect(response).to have_http_status 400
    end
  end
end

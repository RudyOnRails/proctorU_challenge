require 'rails_helper'

describe 'api/v1/exam_registrations.json', type: :request do
  describe 'POST /create' do
    let(:college)  { College.create }
    let(:exam)     { college.exams.create(starts_at: 3.days.ago, ends_at: 1.days.from_now) }
    let(:college2) { College.create }
    let(:exam2)    { college2.exams.create(starts_at: 3.days.ago, ends_at: 1.days.from_now) }

    let(:valid_attributes) do
      {
        first_name: "Kevin",
        last_name: "Musiorski",
        phone_number: "13127725636",
        college_id: college.id,
        exam_id: exam.id,
        start_time: Time.now
      }
    end

    it "returns detailed 200 when request is perfect" do
      post('/api/v1/exam_registrations.json', params: valid_attributes)
      expect(response).to have_http_status 200
      expect(response.body).to include("Kevin assigned to exam #{exam.id}")
    end
    
    %i[first_name last_name phone_number college_id exam_id].each do |param|
      it "returns detailed 400 when #{param} is missing" do
        post('/api/v1/exam_registrations.json', params: valid_attributes.except(param))
        expect(response).to have_http_status 400
        expect(response.body).to include(param.to_s)
      end
    end
    
    it "returns detailed 400 when college_id is not found" do
      post('/api/v1/exam_registrations.json', params: valid_attributes.merge(college_id: "xyz123"))
      expect(response).to have_http_status 400
      expect(response.body).to include("College id xyz123 not found")
    end
    
    it "returns 400 when exam_id is not found" do
      post('/api/v1/exam_registrations.json', params: valid_attributes.merge(exam_id: "abc123"))
      expect(response).to have_http_status 400
      expect(response.body).to include("Exam abc123 not found")
    end
    
    it "returns 400 when exam_id does not belong to college" do
      post('/api/v1/exam_registrations.json', params: valid_attributes.merge(exam_id: exam2.id))
      expect(response).to have_http_status 400
      expect(response.body).to include("Exam #{exam2.id} does not belong to College #{college.id}")
    end
    
    it "returns 400 when requested start_time does not fall within an exam's time window" do
      post('/api/v1/exam_registrations.json', params: valid_attributes.merge(start_time: 5.days.ago))
      expect(response).to have_http_status 400
    end
  end
end

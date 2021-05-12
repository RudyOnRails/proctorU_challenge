require 'rails_helper'

describe User do
  let(:user) { User.new(phone_number: "xyz") }
  it "validates phone number" do
    expect(user).to be_invalid
  end
end

require 'spec_helper'

describe User do
  let!(:user) { create(:user) }
  let(:facebook_user) { create(:facebook_user) }

  context "FactoryGirl :user" do
    it "works" do
      user.should be_valid
    end
  end

  context "Validations" do
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:email) }
  end
end

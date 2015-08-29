require 'spec_helper'

describe SharedMediaFile do
  let!(:user) { create(:user) }
  let!(:media_file) { create(:media_file, user: user) }
  let!(:shared_media_file) { create(:shared_media_file, user: user, media_file: media_file) }

  context "FactoryGirl :asset" do
    it "works" do
      shared_media_file.should be_valid
    end
  end

  context "Relationships" do
    it { should belong_to(:user) }
    it { should belong_to(:media_file) }
  end

  context "Validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:media_file_id) }
  end
end

require 'spec_helper'

describe User do
  let!(:user) { create(:user) }

  context "FactoryGirl :user" do
    it "works" do
      user.should be_valid
    end
  end

  context "Relationships" do
    it { should have_many(:media_files).dependent(:destroy) }
    it { should have_many(:shared_media_files).dependent(:destroy) }
  end

  context "Validations" do
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:email) }
  end

  context "Methods" do
    describe "#all_files" do
      let!(:another_user) { create(:user) }
      let!(:media_file_1) { create(:media_file, user: user) }
      let!(:media_file_2) { create(:media_file, user: another_user) }
      let!(:shared_media_file) { create(:shared_media_file, user: user, media_file: media_file_2) }

      it "should return all shared and uploaded files" do
        user.all_files.should == [media_file_1, media_file_2]
      end
    end
  end
  end

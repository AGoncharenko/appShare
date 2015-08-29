require 'spec_helper'

describe MediaFile do
  let!(:user) { create(:user) }
  let!(:shared_user) { create(:user) }
  let!(:media_file) { create(:media_file, user: user) }

  context "FactoryGirl :asset" do
    it "works" do
      media_file.should be_valid
    end
  end

  context "Relationships" do
    it { should belong_to(:user) }
    it { should have_many(:shared_media_files).dependent(:destroy) }
  end

  context "Validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:uploaded_file) }
  end

  context "Methods" do
    describe "#belongs_to?(user)" do
      it "should return true if media_file belongs to user" do
        media_file.belongs_to?(user).should == true
      end

      it "should return false ifmedia_file dosn't belong to user" do
        media_file.belongs_to?(shared_user).should == false
      end
    end
  end
end

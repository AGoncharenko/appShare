FactoryGirl.define do
  factory :media_file do
    user
    uploaded_file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'file.png')) }
  end
end
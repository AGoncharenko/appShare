class SharedMediaFile < ActiveRecord::Base
  belongs_to :user
  belongs_to :media_file

  validates_presence_of :user_id, :media_file_id
end

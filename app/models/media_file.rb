class MediaFile < ActiveRecord::Base
  belongs_to :user
  has_many :shared_media_files, dependent: :destroy

  validates_presence_of :user_id, :uploaded_file
  mount_uploader :uploaded_file, MediaUploader

  def belongs_to?(user)
    self.user == user
  end
end

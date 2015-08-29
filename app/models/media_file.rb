class MediaFile < ActiveRecord::Base
  belongs_to :user
  has_many :shared_media_files, dependent: :destroy

  validates_presence_of :user_id
  mount_uploader :uploaded_file, MediaUploader

  auto_html_for :link_url do
    html_escape
    image
    youtube(:width => 400, :height => 250, :autoplay => true)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  def belongs_to?(user)
    self.user == user
  end

  def title
    self.uploaded_file.present? ? self.uploaded_file_identifier : self.link_url
  end
end

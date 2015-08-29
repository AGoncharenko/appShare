class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, :presence => true, :uniqueness => true
  has_many :media_files, dependent: :destroy
  has_many :shared_media_files, dependent: :destroy

  def all_files
    result = self.media_files.to_a || []
    result = result + self.shared_media_files.map {|smf| smf.media_file}
    result.uniq
  end
end

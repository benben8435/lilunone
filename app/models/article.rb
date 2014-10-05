class Article < ActiveRecord::Base

  acts_as_taggable
  acts_as_taggable_on :tags
  scope :by_join_date, order("created_at DESC")

  has_many :comments, dependent: :destroy
  
  
  
  validates :text, presence: true


  has_attached_file :photo, :styles => { :small => "200x200#", :medium => "400x400#" },
                  :url  => "/assets/articles/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/articles/:id/:style/:basename.:extension"
  has_attached_file :audio, 
                  :url  => "/assets/articles/:id/:basename.:extension",
                  :path => ":rails_root/public/assets/articles/:id/:basename.:extension"
  
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 8.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg']

  
end

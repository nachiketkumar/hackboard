class Pin < ActiveRecord::Base
  # set model relationships/associations
  belongs_to :board
  has_many :comments

  #allow mass assignment of these attributes
  attr_accessible :description, :image, :url, :board_id

  #add an attribute 'image' which is an attachment
  #attachments are implemented with the 'paperclip' gem
  #default size is 200px, full image size is 600px
  has_attached_file :image, styles: {default: '200', full: '600'}

  #calling the method 'board_name' will call the method of that name in the board model.
  delegate :name, to: :board, prefix: true

  #calling the method 'user' will call the method of that name in the board model.
  delegate :user, to: :board

  #calling 'user_name' or 'user_image_url' will call the method of that name in the user model
  delegate :name, :image_url, to: :user, prefix: true

  #When this active-record object is saved, validate that board
  #and image attributes are not blank.
  validates :board, presence: true
  validates :image, presence: true

  def self.latest
    #get all records and order them in descending order by the 'updated at' attribute
    order("updated_at DESC")
  end
end

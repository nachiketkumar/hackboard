class Board < ActiveRecord::Base
  # set model relationships/associations
  belongs_to :user
  has_many :pins

  #allow mass assignment of these attributes
  attr_accessible :name, :description, :user_id

  #when the methods "name" and "image_url" are called on this
  #model, have the user model respond
  #and expect the prefix "user" on these methods: "user_name"
  delegate :name, :image_url, to: :user, prefix: true

  #When this active-record object is saved, validate that name
  #and user attributes are not blank.
  validates :name, presence: true
  validates :user, presence: true

  def cover
    #get collection of associated pins
    #call the custom method "latest" on this collection of pins
    #get the first item in the collection, which will be most recent pin
    pin = pins.latest.first

    #if pin exists and has an image. Return the image.
    pin && pin.image
  end
end
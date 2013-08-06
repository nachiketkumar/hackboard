class Comment < ActiveRecord::Base
  # set model relationships/associations
  belongs_to :pin
  belongs_to :user

  #allow mass assignment of these attributes
  attr_accessible :body, :pin

  #When this active-record object is saved, validate that user
  #and pin attributes are not blank.
  validates :user, presence: true
  validates :pin, presence: true

  #when the methods "name" and "image_url" are called on this
  #model, have the user model respond
  #and expect the prefix "user" on these methods: "user_name"
  delegate :name, :image_url, to: :user, prefix: true
end

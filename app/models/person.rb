class Person < ApplicationRecord

  ## Virtual Attribute
  attr_accessor :name

  ## Libraries
  require "csv"
  require "namae"

  ## Validations
  validates :first_name, presence: true

  ## Callbacks
  before_validation :split_name

  ## Associations
  has_many :affiliations
  has_many :locations

  ## Class Methods

  ## Instance Methods

  private

    def split_name
      return if name.blank?

      names = ::Namae::Name.parse(name.upcase_first)

      self.first_name = names.given
      self.last_name = names.family&.upcase_first
    end

end

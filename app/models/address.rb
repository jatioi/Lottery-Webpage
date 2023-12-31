class Address < ApplicationRecord
  # def self.table_name_prefix
  #   "address_"
  # end

  enum genre: { home:0, office:1 }
  validates :name, presence: true
  validates :street_address, presence: true
  validates :phone_number, phone: {
    possible: true,
    allow_blank: true,
    types: %i[voip mobile],
    countries: [:ph]
  }
  validates :remark, presence: true


  belongs_to :user
  belongs_to :region
  belongs_to :province
  belongs_to :city
  belongs_to :barangay
  before_save :validate_address_count
  has_many :users

  scope :default, -> { find_by(is_default: true) }


  private

  def validate_address_count
    if self.user.addresses.count >= 5
      self.errors.add(:base, "You can't have more than 5 address.")
      false
    end
  end

end

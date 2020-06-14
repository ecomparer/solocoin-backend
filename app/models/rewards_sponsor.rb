class RewardsSponsor < ApplicationRecord
  include RewardsSponsorsRailsAdminConf

  mount_base64_uploader :brand_logo, BrandLogoUploader

  belongs_to :user, inverse_of: :rewards_sponsors
  belongs_to :category
  validates_presence_of :offer_name, :company_name, :terms_and_conditions, :coupon_code
  validates_uniqueness_of :company_name
  validates_length_of :offer_name, minimum: 3, maximum: 50, allow_blank: false
  before_create :set_status

  enum status: [:draft, :published]

  scope :published, -> { where(status: :published) }

  private

  def set_status
    self.status = :draft
  end
end

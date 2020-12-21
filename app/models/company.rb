class Company < ApplicationRecord
  has_rich_text :description
  validates :email, format: { with: /\A[\w+\-.]+@getmainstreet.com\z/i,  message: 'will be only specific to getmainstreet.com domain' }, allow_blank: true
  before_save :fetch_city_and_state, if: :will_save_change_to_zip_code?

  def fetch_city_and_state
    rv = ZipCodes.identify(zip_code)

    unless rv
      self.state = ''
      self.city = ''
    else
      self.state = rv[:state_name]
      self.city = rv[:city]
    end
  end
end #__End of class 'Company'__

class User < ApplicationRecord
  has_one :folio
  has_many :folio_crypto_currencies, through: :folio

  def self.registered
    where(role: 'user')
  end
end

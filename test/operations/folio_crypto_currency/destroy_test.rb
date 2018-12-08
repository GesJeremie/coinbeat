require 'test_helper'

class FolioCryptoCurrencyDestroyTest < ActiveSupport::TestCase

  setup :user
  setup :folio
  setup :crypto_currency
  setup :folio_crypto_currency

  def user
    @user = UserAnonymous::Create.()['model']
  end

  def folio
    @folio = Folio::Create.({}, 'current_user' => user)['model']
  end

  def crypto_currency
    @crypto_currency = CryptoCurrency.where(symbol: 'BTC').first
  end

  def folio_crypto_currency
    @folio_crypto_currency = FolioCryptoCurrency::Create.({crypto_currency_id: @crypto_currency.id}, 'current_user' => @user.reload)['model']
  end


  test 'destroy crypto currency' do
    result = FolioCryptoCurrency::Destroy.({id: @folio_crypto_currency.id}, 'current_user' => @user.reload)

    assert result.success?
  end
end

require 'test_helper'

class FolioCryptoCurrencyUpdateTest < ActiveSupport::TestCase

  setup :user
  setup :folio
  setup :crypto_currency
  setup :folio_crypto_currency

  def user
    @user = UserAnonymous::Create.()['model']
  end

  def folio
    @folio = Folio::Create.({}, 'current_user' => @user)['model']
  end

  def crypto_currency
    @crypto_currency = CryptoCurrency.where(symbol: 'BTC').first
  end

  def folio_crypto_currency
    @folio_crypto_currency = FolioCryptoCurrency::Create.({crypto_currency_id: @crypto_currency.id}, 'current_user' => @user.reload)['model']
  end

  test 'update folio crypto currency' do
    result = FolioCryptoCurrency::Update.({id: @folio_crypto_currency.id, holding: 10.85}, 'current_user' => user)

    assert result.success?
    assert_equal(result['model'].holding, 10.85)
  end

end

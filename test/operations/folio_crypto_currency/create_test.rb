require 'test_helper'

class FolioCryptoCurrencyCreateTest < ActiveSupport::TestCase

  setup :user
  setup :folio
  setup :crypto_currency

  def user
    @user = UserAnonymous::Create.()['model']
  end

  def folio
    @folio = Folio::Create.({}, 'current_user' => @user)['model']
  end

  def crypto_currency
    @crypto_currency = CryptoCurrency.where(symbol: 'BTC').first
  end

  test 'create folio crypto currency' do
    folio = FolioCryptoCurrency::Create.({crypto_currency_id: @crypto_currency.id}, 'current_user' => @user.reload)

    assert folio.success?
    assert_equal folio['model'].crypto_currency_id, @crypto_currency.id
    assert_equal folio['model'].folio_id, @folio.id
  end

  test 'cannot add duplicate crypto currency' do
    folio = FolioCryptoCurrency::Create.({crypto_currency_id: @crypto_currency.id}, 'current_user' => @user.reload)
    duplicated_folio = FolioCryptoCurrency::Create.({crypto_currency_id: @crypto_currency.id}, 'current_user' => @user.reload)

    assert folio.success?
    refute duplicated_folio.success?
  end
end

require 'test_helper'

class SettingsCurrencyCreateTest < ActiveSupport::TestCase

  def user
    @user ||= UserAnonymous::Create.()['model']
  end

  def currency_id
    @currency_id ||= Currency.last.id
  end

  def create_folio
    Folio::Create.({}, 'current_user' => user)
  end

  test 'update currency' do
    create_folio

    result = SettingsCurrency::Create.({currency_id: currency_id}, 'current_user' => user.reload)

    assert result.success?
    assert_equal(result['model'].currency_id, currency_id)
  end

  test 'cannot update if no folio' do
    result = SettingsCurrency::Create.({currency_id: currency_id}, 'current_user' => user)

    refute result.success?
  end

  test 'cannot update if currency does not exist' do
    create_folio

    result = SettingsCurrency::Create.({currency_id: 150}, 'current_user' => user)

    refute result.success?
  end

end

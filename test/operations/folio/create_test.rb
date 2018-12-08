require 'test_helper'

class FolioCreateTest < ActiveSupport::TestCase

  setup :user

  def user
    @user = UserAnonymous::Create.()['model']
  end

  test 'create folio' do
    result = Folio::Create.({}, 'current_user' => @user)
    model = result['model']

    assert result.success?
    assert model.currency_id.present?
    assert model.user_id.present?
  end

  test 'no duplicate folio' do
    folio = Folio::Create.({}, 'current_user' => @user)
    duplicated_folio = Folio::Create.({}, 'current_user' => @user)

    assert folio.success?
    refute duplicated_folio.success?
  end

end

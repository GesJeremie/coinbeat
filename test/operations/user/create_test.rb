require 'test_helper'

class UserCreateTest < ActiveSupport::TestCase

  def create_user
    User::Create.(email: 'hello@example.com', password: 'fakePassword')
  end

  test 'create user' do
    result = create_user
    user = result['model']

    assert result.success?
    assert user.email.present?
    assert user.password.present?
    assert user.token.present?
  end

  test 'password is encrypted' do
    result = create_user
    user = result['model']

    refute_equal(user.password, 'fakePassword')
  end

  test 'cannot create user with same email' do
    user = create_user
    duplicated_user = create_user

    assert user.success?
    refute duplicated_user.success?
  end
end

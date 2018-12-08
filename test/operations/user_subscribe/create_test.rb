require 'test_helper'

class UserSubscribeCreateTest < ActiveSupport::TestCase

  test 'subscribe user anonymous to role user' do
    user = UserAnonymous::Create.()['model']

    result = UserSubscribe::Create.({email: 'jeremie@gmail.com', password: 'fakePassword'}, 'current_user' => user)
    model = result['model']

    assert result.success?
    assert model.email = 'jeremie@gmail.gmail.com'
    assert model.password != 'fakePassword'
    assert model.role = 'user'
  end

  test 'cannot subscribe a  roler user' do
    user = UserAnonymous::Create.()['model']

    # Convert to role user
    user = UserSubscribe::Create.({email: 'jeremie@gmail.com', password: 'fakePassword'}, 'current_user' =>  user)['model']

    result =  UserSubscribe::Create.(email: 'fake@email.com', password: 'fakePassword', 'current_user' => user)
    model = result['model']

    assert !result.success?
  end

  test 'no duplicate email' do
    user1 = UserAnonymous::Create.()['model']
    user2 = UserAnonymous::Create.()['model']

    user1 = UserSubscribe::Create.({email: 'ges@gmail.com', password: 'fakePassword'}, 'current_user' => user1)
    user2 = UserSubscribe::Create.({email: 'ges@gmail.com', password: 'fakePassword'}, 'current_user' => user2)

    assert user1.success?
    assert !user2.success?

  end

end

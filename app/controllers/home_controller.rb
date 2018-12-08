class HomeController < ApplicationController

  def index

    op = Home::Index.({}, 'current_user' => current_user)

    if op['data.new_user'] and current_user.nil?
      session['current_user_id'] = op['data.user'].id
    end

    @user = op['data.user']
    @folio = op['data.folio']
    @crypto_currencies = op['data.crypto_currencies']
  end
end

class SettingsController < ApplicationController

  def index
    # TODO: if current user nil? redirect to home page
    @user = current_user
    @currencies = Currency.all
    @folio_crypto_currencies = current_user.folio.folio_crypto_currencies.all
  end
end

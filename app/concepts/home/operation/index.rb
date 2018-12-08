class Home::Index < Trailblazer::Operation
  extend Contract::DSL

  success :create_user_and_folio_needed?
  success :fetch_crypto_currencies_not_added_by_user

  def create_user_and_folio_needed?(options, params:, **)
    if options['current_user'].nil?
      user = create_user_anonymous
      folio = create_folio(user)
      add_crypto_currencies(user)
      options['data.new_user'] = true
    else
      user = options['current_user']
      folio = Folio.where(user_id: user.id).first
      options['data.new_user'] = false
    end

    options['data.user'] = user
    options['data.folio'] = folio
  end

  def fetch_crypto_currencies_not_added_by_user(options, params:, **)
    options['data.crypto_currencies'] = CryptoCurrency.not_added_by_user(options['data.user'])
  end

  private

    def create_user_anonymous
      UserAnonymous::Create.()['model']
    end

    def create_folio(user)
      Folio::Create.({}, 'current_user' => user)['model']
    end

    def add_crypto_currencies(user)
      user.reload

      %w(BTC BCH ETH LTC XRP XLM ADA XVG).each do |symbol|
        add_crypto_currency(user, symbol)
      end
    end

    def add_crypto_currency(user, crypto_currency_symbol)
      crypto_currency = CryptoCurrency.where(symbol: crypto_currency_symbol).first

      result = FolioCryptoCurrency::Create.({
                crypto_currency_id: crypto_currency.id,
               }, 'current_user' => user)
    end

end

class Tasks::SeedCurrencies < Trailblazer::Operation

  success  :seed

  def seed(options, params:, **)
    puts 'Seeding currencies ...'

    currencies = [
      {code: 'USD',  symbol: '$',  name: 'United States Dollar'},
      {code: 'EUR',  symbol: '€',  name: 'Euro'},
      {code: 'GBP',  symbol: '£',  name: 'British Pound'},
      {code: 'AUD',  symbol: 'A$', name: 'Australian Dollar'},
      {code: 'CAD',  symbol: 'C$', name: 'Canadian Dollar'},
      {code: 'JPY',  symbol: '¥',  name: 'Japanese Yen'},
      {code: 'PLN',  symbol: 'zł', name: 'Polish Złoty'},
      {code: 'SGD',  symbol: 'S$', name: 'Singapore Dollar'},
      {code: 'RUB',  symbol: '₽',  name: 'Russian Ruble'},
      {code: 'HKD',  symbol: 'HK$', name: 'Hong Kong Dollar'}
    ]

    currencies.each do |currency|

      return if Currency.exists?(code: currency[:code])

      Currency.new(
        code: currency[:code],
        name: currency[:name],
        symbol: currency[:symbol]
      ).save

      puts "Currency #{currency[:code]} added"
    end
  end

end

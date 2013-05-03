# encoding: utf-8

# "Валютность" - один из элементов природы объявления.
#
# При создании объявления имеется возможность указать конкретную валюту из списка доступных.
#
module Notice::Currencies
  extend ActiveSupport::Concern

  included do
    validates :currency, presence: {if: :price?}, inclusion: {in: Currency.all, allow_blank: true}
  end

  def human_currency
    Currency.human_name(currency)
  end


  module Currency

    RUB = 'RUB'
    USD = 'USD'
    EUR = 'EUR'
    UAH = 'UAH'  # украинская Гривна

    def self.all
      constants.map { |name| self.const_get(name) }
    end

    def self.human_name(currency)
      case currency
        when RUB then 'руб.'
        when USD then 'usd'
        when EUR then 'евро'
        when UAH then 'грн.'
        else nil
      end
    end

  end

end

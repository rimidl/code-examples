# encoding: utf-8

# Объявление
#
# @note Некорректное обзывание объявления словом Notice исторически сложившееся явление
#
class Notice < ActiveRecord::Base
  ## included modules, constants, attr_*
  include Promotions

  ## associations, delegates
  ## plugins
  ## callbacks
  def call_after_advance(promotion)
    if promotion.is_a?(UpPromotion)
      self.published_at = Time.zone.now
    end
  end
  private :call_after_advance

  ## validations
  ## scopes
  ## class methods

  # ...

end

# == Schema Information
#
# Table name: ads
#
#  id                :integer          not null, primary key
#  title             :string(255)      not null
#  content           :text             not null
#  published_at      :datetime
#  up_until         :datetime
#  vip_until         :datetime
#  highlight_until   :datetime
#  main_page_until   :datetime
#  top_until         :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null

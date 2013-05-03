# encoding: utf-8

# Объявление
#
# @note Некорректное обзывание объявления словом Notice исторически сложившееся явление
#
class Notice < ActiveRecord::Base
  ## included modules, constants, attr_*
  include Currencies

  ## associations, delegates
  ## plugins
  ## callbacks
  ## validations
  ## scopes
  ## class methods

  # ...

end

# == Schema Information
#
# Table name: notices
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  title             :string(255)      not null
#  content           :text             not null
#  currency          :string(255)      not null

# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale_param

  private

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale_param
    locale = params[:locale] || I18n.default_locale
    I18n.locale = locale.to_sym
  end
end
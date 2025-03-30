# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    if Rails.env.production?
      set_locale_from_headers
    elsif Rails.env.development?
      set_locale_from_params
    end
  end

  def set_locale_from_params
    locale = params[:locale] || I18n.default_locale
    I18n.locale = locale.to_sym
  end

  def set_locale_from_headers
    logger.debug(request.env['HTTP_ACCEPT_LANGUAGE'])

    locale = request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first

    logger.debug("LOCALE: #{locale}")

    I18n.locale = if locale.present? && I18n.available_locales.include?(locale.to_sym)
                    locale
                  else
                    I18n.default_locale
                  end
  end
end

# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale_headers

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale_headers
    logger.debug(request.env['HTTP_ACCEPT_LANGUAGE'])
    locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first

    I18n.locale = if I18n.available_locales.include?(locale.to_sym)
                    locale
                  else
                    I18n.default_locale
                  end
  end
end

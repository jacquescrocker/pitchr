# Be sure to restart your server when you modify this file.

cookie_options = {}
cookie_options[:key] = Settings.cookie.key
cookie_options[:expires] = Settings.cookie.expire_in_days.to_i.days.from_now
cookie_options[:domain] = Settings.cookie.domain if Settings.cookie.domain.present?

Pitchr::Application.config.session_store :cookie_store, cookie_options

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Pitchr::Application.config.session_store :active_record_store

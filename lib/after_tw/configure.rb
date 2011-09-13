# coding: utf-8

require 'omniauth'
require 'twitter'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, AfterTw.config[:consumer_key], AfterTw.config[:consumer_secret]
end
Twitter.configure do |config|
  config.consumer_key = AfterTw.config[:consumer_key]
  config.consumer_secret = AfterTw.config[:consumer_secret]
end

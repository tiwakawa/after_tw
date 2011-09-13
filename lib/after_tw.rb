# coding: utf-8

module AfterTw
  mattr_accessor :config

  def self.configure!
    self.config = YAML.load_file("#{Rails.root}/config/initializers/after_tw.yml")[Rails.env].symbolize_keys
    require 'after_tw/configure'
  end

  autoload :Base, 'after_tw/base'
end

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Base.class_eval { include AfterTw::Base }
end
ActiveSupport.on_load(:after_initialize) do
  AfterTw.configure!
end

# coding: utf-8

module AfterTw
  require 'after_tw/engine' if defined?(Rails)

  mattr_accessor :config

  def self.configure!
    self.config = AfterTw::Engine.config.after_tw
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

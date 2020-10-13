module Doddle
  module Apis
    extend self

    attr_reader :registered
    @registered = []

    def register(class_name, autoload_require)
      autoload(class_name, autoload_require)
      self.registered << class_name
    end

  end
end

Doddle::Apis.register :Order,            'doddle/apis/order'

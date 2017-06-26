module ReflectionUtils
  module CreateClassMethodsUponInclude
    def self.included(base)
      base.define_singleton_method :included do |base|
        base.extend(self)
      end
    end
  end
end

module Hookable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def hook(method_name, hook_name)
      alias_method "unhooked_#{method_name}", method_name
      define_method method_name do |*args, &block|
        send "unhooked_#{method_name}", *args, &block
        send hook_name, method_name, *args, &block
      end
      private "unhooked_#{method_name}"
    end
  end
end

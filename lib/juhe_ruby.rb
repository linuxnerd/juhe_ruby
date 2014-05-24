require "juhe_ruby/version"
require "juhe_ruby/express"

module Juhe
  class << self
    modules = Juhe.constants.map{ |el| Juhe.const_get(el) }.select{ |m| m.instance_of?(Module) }
    modules.each do |mod|
      attr_accessor "#{$1.downcase}_app_key".to_sym if mod.to_s =~ /\AJuhe::(.*)/
    end
  end
end

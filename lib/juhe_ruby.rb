require "juhe_ruby/version"
require "juhe_ruby/express"

module Juhe
  class << self
    # Array of module names
    modules = Juhe.constants.map{ |el| Juhe.const_get(el) }.select{ |m| m.instance_of?(Module) }
    modules.each do |mod|
      if mod.to_s =~ /\AJuhe::(.*)/
        mod.module_eval do
          class << self
            attr_accessor :app_key
          end # class << self
        end # module_evale
      end # if
    end # modules.each
  end
end

module Badgeable
  module Adapters

    class << self
      attr_accessor :current_adapter
    end

    def self.use(adapter)
      @current_adapter = adapter
    end

    def self.supported_adapters
      [:active_record, :mongoid]
    end

    def self.connect(klass)
      puts "%%%%%%%%%%%%%%%%%%%% Klass is: #{klass}"
      raise ArgumentError, "Badgeable needs a database adapter to work. Add one of the following to your Gemfile: #{Badgeable::Adapters.supported_adapters.map {|name| 'badgeable_' + name.to_s }}" unless Badgeable::Adapters.current_adapter && (Badgeable::Adapters.supported_adapters.include? Badgeable::Adapters.current_adapter)
      klass.send(:include, "Badgeable::Adapters::#{current_adapter.to_s.camelize}Adapter".constantize)
    end
  end
end

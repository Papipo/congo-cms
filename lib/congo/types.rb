Dir.glob(File.join(File.dirname(__FILE__), 'types', '*.rb')).each {|f| require f }

module Congo
  module Types
    private
    def self.const_missing(name)
      if metadata = Congo::Database.load_type(name.to_s)
        const_set(name, from_metadata(metadata))
      else
        super
      end
    end
  end
end
module Congo
  class Types
    [String, Integer, Float, Boolean, Array, Hash, Time, Date, Binary].each do |native_type|
      const_set(native_type.to_s, native_type)
    end
  end
end
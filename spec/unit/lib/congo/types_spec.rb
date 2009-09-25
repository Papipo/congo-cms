require File.join(File.dirname(__FILE__), '..', '..', 'unit_spec_helper')

describe Congo::Types do
  MongoMapper::Key::NativeTypes.each do |native_type|
    it "should have a #{native_type} constant" do
      "Congo::Types::#{native_type}".constantize.should be(native_type)
    end
  end
  
  describe "when a missing constant is accessed" do
    describe "and it does not exist in the database" do
      before do
        DynamicType.stubs(:find).with('MyType').returns(nil)
      end
      
      it "should raise a NameError" do
        lambda { Congo::Types::MyType }.should raise_error NameError
      end
    end
    
    describe "and it exists in the database" do
      before do
        DynamicType.stubs(:find).with('MyType').returns(type_metadata = stub('Type metadata'))
        Congo::Types.stubs(:from_metadata).with(type_metadata).returns(@new_class = stub('New class'))
      end

      it "should create a new constant in the namespace with the class from the metadata" do
        Congo::Types::MyType.should == @new_class
      end
    end
  end
end
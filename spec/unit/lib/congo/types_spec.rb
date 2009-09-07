require File.join(File.dirname(__FILE__), '..', '..', 'unit_spec_helper')

describe Congo::Types do
  it "should have a String constant" do
    Congo::Types::String.superclass.should be(String)
  end
  
  it "should have an Integer constant" do
    Congo::Types::Integer.superclass.should be(Integer)
  end
  
  it "should have a Float constant" do
    Congo::Types::Float.superclass.should be(Float)
  end
  
  describe "when a missing constant is accessed" do
    describe "and it does not exist in the database" do
      before do
        Congo::Database.stubs(:load_type).with('MyType').returns(nil)
      end
      
      it "should raise a NameError" do
        lambda { Congo::Types::MyType }.should raise_error NameError
      end
    end
    
    describe "and it exists in the database" do
      before do
        Congo::Database.stubs(:load_type).with('MyType').returns(type_metadata = stub('Type metadata'))
        Congo::Types.stubs(:from_metadata).with(type_metadata).returns(@new_class = stub('New class'))
      end

      it "should create a new constant in the namespace with the class from the metadata" do
        Congo::Types::MyType.should == @new_class
      end
    end
  end
end
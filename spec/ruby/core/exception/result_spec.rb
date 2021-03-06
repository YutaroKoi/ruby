require_relative '../../spec_helper'

describe "StopIteration#result" do
  before :each do
    obj = Object.new
    def obj.each
      yield :yield_returned_1
      yield :yield_returned_2
      :method_returned
    end
    @enum = obj.to_enum
  end

  it "returns the method-returned-object from an Enumerator" do
    @enum.next
    @enum.next
    -> { @enum.next }.should raise_error(StopIteration) { |error|
      error.result.should equal(:method_returned)
    }
  end
end

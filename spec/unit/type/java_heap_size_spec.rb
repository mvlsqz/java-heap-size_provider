require 'spec_helper'
require 'pp'
java_heap_size = Puppet::Type.type(:java_heap_size)

describe java_heap_size do
  describe 'when validating attributes' do
    %i[target].each do |parameter|
      it "expect to contain #{parameter} parameter" do
        expect(java_heap_size.attrtype(parameter)).to eq(:param)
      end
    end
    %i[ensure argument value].each do |property|
      it "expect to contain #{property} property" do
        expect(java_heap_size.attrtype(property)).to eq(:property)
      end
    end
  end
end

# unit test for java_heap_size
require 'spec_helper'
require 'pp'
java_heap_size = Puppet::Type.type(:java_heap_size)

describe java_heap_size do
  describe 'when validating attributes' do
    %i[name].each do |parameter|
      it "expect to contain #{parameter} parameter" do
        expect(java_heap_size.attrtype(parameter)).to eq(:param)
      end
    end
    %i[ensure target size].each do |property|
      it "expect to contain #{property} property" do
        expect(java_heap_size.attrtype(property)).to eq(:property)
      end
    end
  end
  describe 'validating resource attributes' do
    %i[present absent].each do |attribute|
      it "should support #{attribute}" do
        expect do
          java_heap_size.new(
            name: 'xms',
            target: '/tmp/fake_target.sh',
            size: '15m',
            ensure: attribute
          )
        end.to_not raise_error
      end
    end
    it 'should not support invalid path as target parameter' do
      expect do
        java_heap_size.new(
          name: 'xmn',
          target: 'not_valid_path'
        )
      end.to raise_error(Puppet::ResourceError, /Must be a valid file path/)
    end
    it 'should not support invalid java heap argument' do
      expect do
        java_heap_size.new(
          name: 'invalid',
          target: '/tmp/fake_target.sh'
        )
      end.to raise_error(Puppet::ResourceError, /Name must be valid xms xmn or xmx/)
    end
    it 'should not support invalid sizes' do
      expect do
        java_heap_size.new(
          name: 'xmx',
          target: '/tmp/fake_target.sh',
          size: '64L'
        )
      end.to raise_error(Puppet::ResourceError, /Value must be a valid size/)
    end
  end
end

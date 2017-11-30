require 'spec_helper'
describe 'java_heap_size_provider' do
  context 'with default values for all parameters' do
    it { should contain_class('java_heap_size_provider') }
  end
end

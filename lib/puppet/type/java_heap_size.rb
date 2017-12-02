require 'pathname'
Puppet::Type.newtype(:java_heap_size) do
  desc 'Manage java heap values'

  ensurable

  newproperty(:target) do
    desc 'Target java env file'
    validate do |value|
      Pathname.new(value).absolute? || raise(ArgumentError, 'Must be a valid file path')
    end
  end

  newparam(:name, namevar: true) do
    desc 'Variable name'
    validate do |value|
      value =~ /(xms|xmn|xmx)/ || raise(ArgumentError, 'Name must be valid xms xmn or xmx')
    end
  end

  newproperty(:size) do
    desc 'The value of the variable'
    validate do |value|
      value =~ /^\d+(m|M|g|G)$/ || raise(ArgumentError, 'Value must be a valid size like 64m, 64M, 1g or 1G')
    end
  end
end

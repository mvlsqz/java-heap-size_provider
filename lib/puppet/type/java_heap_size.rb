require 'pathname'
Puppet::Type.newtype(:java_heap_size) do
  desc 'Manage java heap values'

  ensurable

  newparam(:target, namevar: true) do
    desc 'Target java env file'
    validate do |value|
      unless Pathname.new(value).absolute?
        fail('Must be a valid file path')
      end
    end
  end

  newproperty(:argument) do
    desc 'Variable name'
    validate do |value|
      unless value.match(/(xms|xmn|xmx)/)
        fail('Argument must be a valid java env argument like xms xmn xmx')
      end
    end
  end

  newproperty(:size) do
    desc 'The value of the variable'
    validate do |value|
      unless value.match(/^\d+(m|M|g|G)$/)
        fail('Value must be a valid size like 64m, 64M, 1g or 1G')
      end
    end
  end
end

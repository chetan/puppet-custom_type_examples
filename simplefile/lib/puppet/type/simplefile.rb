Puppet::Type.newtype(:simplefile) do

  desc "Manage a file (the simple version)."

  newparam(:name) do
    desc "The full path to the file."
  end

  # properties result in method calls on the type/provider.
  # if a property is defined, the getter will be called and checked against
  # the defined value. if they differ, the setter will be called.
  #
  # in this case, mode() and mode=() are defined by the provider.
  newproperty(:mode) do
    desc "Manage the file's mode."

    defaultto "640"
  end

  # ensurable requires that certain methods (create, destroy, exists?) be
  # declared. in this case, they are implemented by the provider. the
  # alternative form below could used in cases w/o a provider as well.
  ensurable

  # alternative method for using ensurable:

  # ensurable do
  #
  #   newvalue(:present) do
  #     if provider and provider.respond_to?(:create)
  #       provider.create
  #     else
  #       create
  #     end
  #     nil # return nil so the event is autogenerated
  #   end
  #
  #   newvalue(:absent) do
  #     if provider and provider.respond_to?(:destroy)
  #       provider.destroy
  #     else
  #       destroy
  #     end
  #     nil # return nil so the event is autogenerated
  #   end
  #
  # end

end

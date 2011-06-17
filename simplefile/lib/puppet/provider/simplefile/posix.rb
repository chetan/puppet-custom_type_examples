
# NOTE: the full path of this file is important and is required by Puppet's
#       autoloading mechanism.
#
#       Providers must be placed in the following path:
#       lib/puppet/provider/<type>/<provider>.rb
#
#       Puppet will essentially require lib/puppet/provider/<type>/*.rb
#       for each type found in lib/puppet/type/


# example for loading arbitrary code shipped with your module
require File.join(File.dirname(__FILE__), "../../../", "foobar")

Puppet::Type.type(:simplefile).provide(:posix, :parent => Puppet::Provider) do

  desc "Normal Unix-like POSIX support for file management."

  # if you have multpile providers, use these methods to automatically select
  # the correct one based on facts provided by facter

  # confine    :operatingsystem => [ :darwin ]
  # defaultfor :operatingsystem => :darwin

  # must be implemented for ensurable()
  def create
    self.class.send_log(:debug, "call create()")
    File.open(@resource[:name], "w") { |f| f.puts "" } # Create an empty file
    # Make sure the mode is correct
    should_mode = @resource.should(:mode)
    unless self.mode == should_mode
      self.mode = should_mode
    end
  end

  # must be implemented for ensurable()
  def destroy
    self.class.send_log(:debug, "call destroy()")
    File.unlink(@resource[:name])
  end

  # must be implemented for ensurable()
  def exists?
    self.class.send_log(:debug, "call exists? #{@resource[:name]} => #{File.exists?(@resource[:name])}")
    File.exists?(@resource[:name])
  end

  # Return the mode as an octal string, not as an integer.
  def mode
    self.class.send_log(:debug, "call mode()")
    if File.exists?(@resource[:name])
      "%o" % (File.stat(@resource[:name]).mode & 007777)
    else
      :absent
    end
  end

  # Set the file mode, converting from a string to an integer.
  def mode=(value)
    self.class.send_log(:debug, "call mode=(#{value})")
    File.chmod(Integer("0" + value), @resource[:name])
  end

end

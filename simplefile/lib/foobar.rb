
# This class/file only exists to demonstrate how to ship & load an arbitrary
# piece of ruby code along with your other auto-loading code (i.e. types)
#
# see puppet/provider/simplefile/posix.rb

class Foobar
  class << self
    include Puppet::Util::Logging
  end
  send_log(:debug, "class Foobar was loaded")
end





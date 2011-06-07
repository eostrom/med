# Much thanks to Matt Aimonetti:
# http://merbist.com/2010/01/17/controlling-itunes-with-macruby/

framework 'ScriptingBridge'
load_bridge_support_file 'etc/iTunes.bridgesupport'

require 'forwardable'

module Med
  class ITunes
    def self.app
      @app = SBApplication.applicationWithBundleIdentifier('com.apple.itunes')
    end
  end
end

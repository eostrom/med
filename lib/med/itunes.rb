# Much thanks to Matt Aimonetti:
# http://merbist.com/2010/01/17/controlling-itunes-with-macruby/

framework 'ScriptingBridge'
load_bridge_support_file 'etc/iTunes.bridgesupport'

require 'forwardable'

# nicer syntax for scripting bridge access
class SBElementArray
  def [](value)
    self.objectWithName(value)
  end
end

module Med
  class ITunes
    def self.app
      @app = SBApplication.applicationWithBundleIdentifier('com.apple.itunes')
    end

    # There must be a better way to search the iTunes library than
    # pulling in all the tracks and grepping through them, but I don't
    # know it.
    def self.find(params)
      app.sources['Library'].libraryPlaylists.first.fileTracks.find do |track|
        params.all? do |key, value|
          track.send(key).to_s == value.to_s
        end
      end
    end

    def self.convert(file)
      app.convert(file)
    end
  end
end

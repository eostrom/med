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

    def self.find(params)
      search_terms = params
        .values_at(:name, :album, :artist, :composer)
        .join(' ')
        
      app.sources['Library'].libraryPlaylists.first
        .searchFor(search_terms, :only => ITunesESrAAll).find do |track|
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

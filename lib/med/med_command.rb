gem 'clamp'
require 'clamp'

module Med
  class MedCommand < Clamp::Command 
    attr_accessor :track
    
    subcommand 'add', 'Add an audio file to the iTunes library.' do
      parameter 'FILE', 'the file to add', :attribute_name => :path

      def execute
        url = NSURL.fileURLWithPath(path)
        track = ITunes.app.add(url, to:nil)
        puts track.inspect
      end
    end
  end
end

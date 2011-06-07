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
        if track
          puts "Added #{path} to iTunes"
        else
          puts "ERROR: Couldn't add #{path} to iTunes"
        end
      end
    end
  end
end

gem 'clamp'
require 'clamp'

module Med
  class MedCommand < Clamp::Command 
    attr_accessor :track
    
    subcommand 'add', 'Add an audio file to the iTunes library.' do
      parameter 'FILE', 'the file to add', :attribute_name => :path
      option ['-g', '--genre'], 'GENRE', "the track's genre"
      option ['-a', '--artist'], 'ARTIST', "the track's artist"
      
      def execute
        url = NSURL.fileURLWithPath(path)
        track = ITunes.app.add(url, to:nil)
        if track
          track.albumArtist = 'Erik Ostrom'
          track.artist = artist || 'Erik Ostrom'
          track.album = 'Music Every Day'
          track.year = Time.now.year
          track.genre = genre || 'Electronic'
          if track.name =~ /^([0-9]+) (.*)/
            track.trackNumber = $1.to_i
            track.name = $2
          end
              
          puts "Added #{path} to iTunes"
        else
          puts "ERROR: Couldn't add #{path} to iTunes"
        end
      end
    end

    subcommand 'convert', 'Convert a track to MP3.' do
      parameter 'TRACK', 'track number to upload', :attribute_name => :number

      def execute
        track = 
          Track.find(:trackNumber => number, :kind => 'WAV audio file') ||
          Track.find(:trackNumber => number, :kind => 'AIFF audio file')
        
        if track
          ITunes.convert(track)
        else
          "ERROR: Couldn't find track #{number}"
        end
      end
    end
  end
end

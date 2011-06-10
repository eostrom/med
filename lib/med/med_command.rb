require 'uri'

gem 'clamp', :version => '~> 0.2.0'
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
          puts "ERROR: Couldn't find track #{number}"
        end
      end
    end
    
    subcommand 'upload', 'Upload a track to the web site.' do
      parameter 'TRACK', 'track number to upload', :attribute_name => :number

      def execute
        track = Track.find(
          :trackNumber => number, :kind => 'MPEG audio file')
        if !track
          puts "ERROR: couldn't find track #{number}"
          return
        end

        file = track.location
        host = 'erikostrom.com'
        remote_path = "med/Erik Ostrom - MED - #{file.pathComponents.last}"
        
        puts "Uploading to http://#{host}/#{URI::escape(remote_path)}"
        system('scp', file.path, "#{host}:\"#{host}/#{remote_path}\"")
      end
    end
  end
end

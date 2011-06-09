module Med
  class Track
    def self.find(params)
      default_params = {
        :album => 'Music Every Day',
        :albumArtist => 'Erik Ostrom'
      }
      
      ITunes.find(default_params.merge(params))
    end
  end
end

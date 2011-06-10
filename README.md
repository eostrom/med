# Music Every Day

This is a support script for my [Music Every Day][music] project. I
have very specific needs, and I haven't made any effort to make the
code more general than that, so I don't think anyone else will want
to use it. But the code might be of interest, especially to anyone who
wants to use MacRuby to script iTunes (and didn't get enough out of 
[Matt Aimonetti's post][itunes-macruby]).

[music]: http://slapdash.erikostrom.com/tagged/music%20every%20day
[itunes-macruby]: http://merbist.com/2010/01/17/controlling-itunes-with-macruby/

## Usage

There are three commands (as of this writing... but check `med --help`
for current info):

    med add [-g GENRE] [-a ARTIST] PATH

Adds a file to your iTunes library. Automatically sets the album name
and album artist to "Music Every Day" and me. Sets "year" to the
current year. If the filename starts with an integer, extracts that
and uses it as the track number.

    med convert TRACK_NUMBER

Finds the track in my "Music Every Day" album with the given number,
and creates an MP3 version (or whatever iTunes is configured to
create in its preferences).

    med upload TRACK_NUMBER

Finds the track (a la `med convert`) and uploads it to my web site,
with more info in the filename because sometimes MP3s get separated
from their context and it's nice to be able to identify them at a
glance.

## Commentary

The most interesting parts of the code are the parts that control
iTunes:

1. add a track to the library
2. modify track metadata
3. search for an existing track

iTunes might not be the right tool for this job. Certain things can't
be controlled by this script - for example, the output format of the
`convert` command, and the question of whether the library gets its
own copy of the original audio file or uses the existing copy in
place. And I might not even want the tracks in my library when the
process is over.

But it was a good chance to finally get some experience with MacRuby!
Which is pretty neat.

## To Do

The main thing I want to add is a command that drafts a Tumblr post
with some tags and the track URL and a link to the project, so I only
have to enter my notes about the new track.

It might also be fun to add a GUI, but I'm pretty comfortable with the
command line.

## Credits

Obviously [MacRuby is key][macruby]. Other dependencies, for which I'm
grateful: 

* Mike Williams's [Clamp][clamp], a nice library for parsing
  command-line options and subcommands.
* [require_all][require_all] by Tony Arciero and Jarmo Pertman, which
  lets me load all my code without listing all of it.

[macruby]: http://www.macruby.org/
[clamp]: https://github.com/mdub/clamp
[require_all]: https://github.com/jarmo/require_all

## License

Copyright &copy; 2011 Erik Ostrom. All rights reserved.

The code is available under a [simplified BSD license][license].

[license]: LICENSE.md

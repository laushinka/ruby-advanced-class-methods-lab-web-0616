require 'pry'

class Song
  attr_accessor :name, :artist_name; :new_by_name
  @@all = []

  # def initialize(song)
  #   @song = song
  #   # @@all - do I need this?
  # end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    song = Song.new
    song.save
    song
  end

  def self.new_by_name(name)
    song = Song.new
    song.name = name
    song
  end

  def self.create_by_name(name)
    song = Song.create
    song.name = name
    song.save
    song
  end

# Build a class finder Song.find_by_name
# that accepts the string name of a song
# and returns the matching instance of the song with that name.
  def self.find_by_name(name)
    @@all.find { |song| song.name == name }
  end

# In order to prevent duplicate songs being created
# that actually represent the same song based on the song name
# we're going to build a class method Song.find_or_create_by_name.
# This method will accept a string name for a song
# and either return a matching song instance with that name
# or create a new song with the name and return the song instance.
  def self.find_or_create_by_name(name)
    if @@all.include?(name)
      @@all.find { |song| song.name == name }
    else
      name = Song.create
      name
    end
  end

  def self.alphabetical
    @@all.uniq.sort_by { |song| song.name }
  end

  # Build a class constructor that accepts a filename in the format of " - .mp3",
  # for example "Taylor Swift - Blank Space.mp3".
  # Given Song.new_from_filename("Taylor Swift - Blank Space.mp3"),
  # the constructor should return a new Song instance
  # with the song name set to Blank Space and the artist_name set to Taylor Swift.
  # The filename input sent to Song.new_from_filename in the format of Taylor Swift - Blank Space.mp3
  # must be parsed for the relevant components.
  # Separate the artist name from the rest of the data based on the - delimiter.
  # Don't forget that when you parse the song name,
  # you have to remove the '.mp3' part of the string.
  def self.new_from_filename(file)
    song = Song.new
    # song = song.split(" - ")
    song_array = file.split(" - ")
    song_name = song_array[1].chomp(".mp3")
    song.name = song_name
    song.artist_name = song_array[0]
    song
    # artist_name = song.split[0]
    #   # binding.pry
    #   # if s.include?(".mp3")
    #   s.chomp(".mp3")
    # # end
    # song = song[0]
  end

  def self.create_from_filename(file)
    song = self.new_from_filename(file)
    song.save
  end

  def self.destroy_all
    @@all.clear
  end

end

# song = Song.new("Taylor Swift - Blank Space.mp3")
# song.new_from_filename

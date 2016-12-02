require 'pry'
class Book
  attr_reader :title, :summary
  attr_accessor :author
  
  @@all = []
  ALL = []

  def initialize(title, summary)
    @title = title
    @summary = summary
  end
end

book = Book.new('1984', 'A book about the dystopian future')

binding.pry

class Author
  attr_accessor :books

end

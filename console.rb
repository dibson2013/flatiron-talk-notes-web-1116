require 'pry'
class Pet
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class Iguana < Pet
  def be_smelly
    "Pee-ew!"
  end
end

class Dog < Pet
  def bark
    "Woof!!"
  end
end

class Cat < Pet
  def meow
    "meow"
  end
end

Pry.start

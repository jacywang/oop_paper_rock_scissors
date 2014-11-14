class Hand
  include Comparable
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def <=>(another_hand)
    if value == another_hand.value
      0
    elsif (value == "R" && another_hand.value == "S") || 
          (value == "P" && another_hand.value == "R") ||
          (value == "S" && another_hand.value == "P")
      1
    else
      -1
    end
  end
end


class Player
  attr_accessor :hand
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def make_choice  
  end   
end

class Human < Player
  def make_choice
    begin 
      puts "Choose one: (#{Game::OPTIONS.keys.join("/")})"
      c = gets.chomp.upcase
    end until Game::OPTIONS.keys.include?(c)
    self.hand = Hand.new(c)
  end
end

class Computer < Player
  def make_choice
    self.hand = Hand.new(Game::OPTIONS.keys.sample)
  end
end

class Game
  OPTIONS = { "P" => "Paper", "R" => "Rock", "S" => "Scissor" }

  def initialize
    @player = Human.new("Jacy")
    @computer = Computer.new("Z3")
  end

  def welcome
    puts "-----Play Paper Rock Scissors!-----"
  end

  def run
    welcome
    @player.make_choice
    @computer.make_choice
    display_choice
    check_winner
    play_again
  end

  def display_choice
    puts "#{@player.name} chose #{OPTIONS[@player.hand.value]}!"
    puts "#{@computer.name} chose #{OPTIONS[@computer.hand.value]}!"
  end

  def check_winner
    if @player.hand == @computer.hand
      puts "It's a tie!"
    elsif @player.hand > @computer.hand
      puts "#{@player.name} won!"
    else
      puts "#{@computer.name} won!"
    end
  end

  def play_again
    begin
      puts "Play again? Y/N"
      user_chocie = gets.chomp.upcase
    end until ["Y", "N"].include?(user_chocie)
    self.run if user_chocie == "Y"
    exit if user_chocie == "N"
  end
end

Game.new.run

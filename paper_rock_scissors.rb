
module Reference
  REFERENCE = { "P" => "Paper", "R" => "Rock", "S" => "Scissor" }
end

class Player

  include Reference
  attr_accessor :player_choice

  def initialize
  end

  def choice
    begin 
      puts "Choose one: (#{REFERENCE.keys.join("/")})"
      self.player_choice = gets.chomp.upcase
    end until REFERENCE.keys.include?(player_choice)
    player_choice
  end 
  
end

class Human < Player; end

class Computer < Player

  def choice
    REFERENCE.keys.sample
  end

end

class PaperRockScissors

  include Reference

  def initialize
    @player = Human.new
    @computer = Computer.new
  end

  def welcome
    puts "-----Play Paper Rock Scissors!-----"
  end

  def run
    welcome
    player_choice = @player.choice
    computer_choice = @computer.choice
    display_choice(player_choice, computer_choice)
    check_winner(player_choice, computer_choice)
    play_again
  end

  def display_choice(player_choice, computer_choice)
    puts "You chose #{REFERENCE[player_choice]}"
    puts "Computer chose #{REFERENCE[computer_choice]}"
  end

  def check_winner(player_choice, computer_choice)
    if player_choice == computer_choice
      puts "It's a tie!"
    elsif (player_choice == "R" && computer_choice == "S") || 
          (player_choice == "P" && computer_choice == "R") ||
          (player_choice == "S" && computer_choice == "P")
      puts "You won!"
    else
      puts "Computer won!"
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

PaperRockScissors.new.run

VALID_CHOICES = %w(rock paper scissors lizard spock)

def prompt(message)
  puts("=> #{message}")
end

WIN_SCENARIO = {
  'rock'     => %w(scissors lizard),
  'paper'    => %w(rock spock),
  'scissors' => %w(paper lizard),
  'spock'    => %w(scissors rock),
  'lizard'   => %w(spock paper)
}

def win?(first, second)
  WIN_SCENARIO[first].include?(second)
end

def display_result(player, computer)
  if win?(player, computer)
    prompt "You won!"
  elsif win?(computer, player)
    prompt "Computer won!"
  else
    prompt "Its a tie!"
  end
end

request_input = <<-MSG
Choose your weapon:
    Type 'r' for rock
    Type 'p' for paper
    Type 's' for scissors
    Type 'l' for lizard
    Type 'sp' for spock
  MSG

prompt "Welcome to rock, papers, scissors, spock, lizard !!!
        The first to 5 points wins."

loop do
  choice = ''
  cpu = 0
  player = 0
  until (cpu == 5) || (player == 5)

    loop do
      prompt(request_input)
      choice = gets.chomp
      if %w(r p s l sp).include?(choice)
        break
      else
        prompt "Please type a valid answer"
      end
    end

    input = case choice
            when 'r'
              'rock'
            when 'p'
              'paper'
            when 's'
              'scissors'
            when 'l'
              'lizard'
            when 'sp'
              'spock'
            end

    computer_choice = VALID_CHOICES.sample
    puts "You chose: #{input}. Computer chose: #{computer_choice}"

    display_result(input, computer_choice)

    if win?(input, computer_choice)
      player += 1
    elsif win?(computer_choice, input)
      cpu += 1
    else
      "That was a tie"
    end
    prompt "Score: \n Computer: #{cpu} \n Player: #{player}"

  end

  prompt "Do you want to play again?"
  answer = gets.chomp

  break unless answer.downcase.start_with?('y')
end

prompt "Thank you for playing. Good Bye!"

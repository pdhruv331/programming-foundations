require 'pry'
INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]] # diagonals

SETTING = 'pick'.freeze # use 'pick', 'computer', or 'player'
PLAYER = 'player'.freeze
COMPUTER = 'computer'.freeze

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  puts "You're a #{PLAYER_MARKER}. Computer is a #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts "     |     |"
  puts ""
end

# rubocop:enable Metrics/AbcSize
def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(arr, char1 = ', ', char = "or")
  if arr.size > 1
    last_element = arr.pop
    arr.insert(arr.length, "#{char} #{last_element}").join(char1)
  else
    arr.join
  end
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, thats not a valid choice"
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = offense(brd) # offense first
  square = defense(brd) if !square # defense

  # Pick number 5
  if !square && empty_squares(brd).include?(5)
    square = 5
  end

  if !square
    square = empty_squares(brd).sample
  end
  brd[square] = COMPUTER_MARKER
end

def offense(board)
  square = nil
  WINNING_LINES.each do |line|
    square = risk_square(line, board, COMPUTER_MARKER)
    break if square
  end
  square
end

def defense(board)
  square = nil
  WINNING_LINES.each do |line|
    square = risk_square(line, board, PLAYER_MARKER)
    break if square
  end
  square
end

def risk_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    board.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def turn_order
  prompt "Type y to play first or any other key to play second"
  choice = gets.chomp
  if choice.casecmp('y').zero?
    return PLAYER
  else
    return COMPUTER
  end
end

current_player = nil
case SETTING
when 'pick'
  current_player = turn_order
when PLAYER
  current_player = PLAYER
when COMPUTER
  current_player = COMPUTER
end

def place_piece!(board, current_player)
  if current_player == PLAYER
    player_places_piece!(board)
  else
    computer_places_piece!(board)
  end
end

def alternate_player(player)
  if player == PLAYER
    COMPUTER
  else
    PLAYER
  end
end

def continue_game?
  loop do
    prompt "Press Enter to start next round"
    input = gets
    if input == "\n"
      return
    else
      prompt "Thats not a valid input"
    end
  end
end

loop do
  computer_score = 0
  player_score = 0
  until (computer_score == 5) || (player_score == 5)

    board = initialize_board
    loop do
      system 'clear'
      display_board(board)
      prompt "Score: \n Computer: #{computer_score} \n Player: #{player_score}"
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      if someone_won?(board) || board_full?(board)
        display_board(board)
        continue_game?
        break
      end
    end

    if detect_winner(board) == 'Player'
      player_score += 1
    elsif detect_winner(board) == 'Computer'
      computer_score += 1
    else
      prompt "It's a tie!"
    end
  end

  display_board(board)
  puts player_score == 5 ? "Congratulations, the Player won!!!" : "Computer won"
  prompt "Type y to play again or any other key to exit"
  answer = gets.chomp
  break unless answer.casecmp('y').zero?
end

prompt "Thanks for playing Tic Tac Toe! Good Bye!"

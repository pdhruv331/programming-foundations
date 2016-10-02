require 'pry'
SUITS = %w(hearts diamonds clubs spades).freeze
RANK = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace).freeze
player_hand = []
dealer_hand = []
PLAYER = 'player'.freeze
DEALER = 'dealer'.freeze
WINNING_SCORE = 21
DEALER_HIT_SCORE = 17

VALUES = {
  '2' => 2,
  '3' => 3,
  '4' => 4,
  '5' => 5,
  '6' => 6,
  '7' => 7,
  '8' => 8,
  '9' => 9,
  '10' => 10,
  'Jack' => 10,
  'Queen' => 10,
  'King'  => 10
}.freeze

def prompt(msg)
  puts "=> #{msg}"
end

def deal(hand1 = [], hand2 = [])
  2.times do |card|
    until hand1[card] != hand2[card]
      hand1[card] = [RANK.sample, SUITS.sample]
      hand2[card] = [RANK.sample, SUITS.sample]
    end
  end
end

def display_initial_cards(player_cards, dealer_cards)
  system 'clear'
  string = ""
  player_cards.each do |card|
    string += card[0] + " "
  end
  prompt "Player has #{string.split.join(' and ')}"
  prompt "Your total is #{total(player_cards)}"

  str = ""
  dealer_cards.each do |card|
    str += card[0] + " "
  end

  arr = str.split
  arr.pop
  prompt "Dealer has #{arr.join(' and ')} and unknown"
end

def display_dealer_cards(cards)
  str = ""
  cards.each do |card|
    str += card[0] + " "
  end
  prompt "Dealer has #{str.split.join(' and ')}"
end

def hit(hand, player_hand, dealer_hand)
  card = []
  loop do
    card = [RANK.sample, SUITS.sample]
    while player_hand.include?(card) || dealer_hand.include?(card)
      card = [RANK.sample, SUITS.sample]
    end
    hand << card
    break
  end
end

def value_of_ace(current_total)
  current_total > 10 ? 1 : 11
end

def total(hand)
  total = 0
  hand.each do |cards|
    total += if cards[0] == 'Ace'
               value_of_ace(total)
             else
               VALUES[cards[0]]
             end
  end
  total
end

def bust?(hand)
  total(hand) > WINNING_SCORE
end

def not_hit(hand)
  if bust?(hand)
    prompt "You busted. Dealer Wins!!!!!"
  else
    prompt "You stayed"
  end
end

def player_turn(hand, player_hand, dealer_hand)
  answer = nil
  loop do
    break if answer == 'stay' || bust?(hand)
    puts "hit or stay?"
    answer = gets.chomp
    if !(answer == 'hit' || answer == 'stay')
      prompt "Enter a valid response"
      next
    end
    hit(hand, player_hand, dealer_hand) if answer == 'hit'
    display_initial_cards(player_hand, dealer_hand)
  end
  not_hit(hand)
end

def dealer_turn(hand, player_hand, dealer_hand)
  until total(hand) >= DEALER_HIT_SCORE
    prompt "Dealer hits"
    hit(hand, player_hand, dealer_hand)
    display_dealer_cards(hand)
  end
  if bust?(hand)
    prompt "Dealer busted. You Win!!!!!"
  else
    prompt "Dealer stayed"
  end
end

def display_total(player_hand, dealer_hand)
  prompt "Player has #{total(player_hand)}"
  prompt "Dealer has #{total(dealer_hand)}"
end

def compare_total(player_hand, dealer_hand)
  prompt "Comparing Totals ............."
  display_total(player_hand, dealer_hand)
  if total(player_hand) > total(dealer_hand)
    prompt "Player Wins !!!"
  elsif total(dealer_hand) > total(player_hand)
    prompt "Dealer Wins !!!"
  else
    prompt "Its a tie"
  end
end

def continue_game
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

def winner(player_hand, dealer_hand)
  if bust?(player_hand)
    DEALER
  elsif bust?(dealer_hand)
    PLAYER
  elsif total(player_hand) > total(dealer_hand)
    PLAYER
  elsif total(dealer_hand) > total(player_hand)
    DEALER
  end
end

loop do
  dealer_score = 0
  player_score = 0
  until (dealer_score == 5) || (player_score == 5)
    player_hand.clear
    dealer_hand.clear
    loop do
      prompt "Welcome, lets play 21 !!!!!"
      prompt "---------------------------"
      prompt "Now dealing cards ........."

      deal(player_hand, dealer_hand)
      display_initial_cards(player_hand, dealer_hand)
      player_turn(player_hand, player_hand, dealer_hand)
      break if bust?(player_hand)

      dealer_turn(dealer_hand, player_hand, dealer_hand)
      if !bust?(player_hand) && !bust?(dealer_hand)
        compare_total(player_hand, dealer_hand)
      end
      break
    end

    if winner(player_hand, dealer_hand) == DEALER
      dealer_score += 1
    elsif winner(player_hand, dealer_hand) == PLAYER
      player_score += 1
    end
    prompt "Score: \n Dealer: #{dealer_score} \n Player: #{player_score}"
    continue_game
  end

  prompt "All rounds have concluded."
  prompt "Type y to play again or any other key to exit"
  answer = gets.chomp
  break unless answer.casecmp('y').zero?
end

prompt "Thank you for playing twenty one."

# p = loan amount, n = loan duration in months, j = monthly rate

def prompt(message)
  print(message)
  gets.chomp
end

def valid_number?(amount)
  amount.to_i > 0 && amount.to_i
end

def decimal?(num)
  num.to_f > 0 && num.to_f < 1
end

loop do
  input = ''
  loop do
    input = prompt "Please enter your total loan amount: $"
    if valid_number?(input)
      break
    else
      puts "Thats not a valid loan amount. "
    end
  end
  p = input.to_i

  input = ''
  apr = 0
  loop do
    input = prompt "Please enter your Annual Percentage Rate (APR): "
    if valid_number?(input)
      apr = input.chomp("%").to_f
      break
    elsif decimal?(input)
      puts "Please enter the APR as a Percentage"
    else
      puts "Thats not a valid APR"
    end
  end
  j = apr / 12 / 100

  input = ''
  loop do
    input = prompt "How many years is your auto loan for? "
    if decimal?(input)
      puts "Please enter a whole number for years"
    elsif valid_number?(input)
      break
    else
      puts "Thats not a valid time duration"
    end
  end
  duration = input.to_i
  n = duration * 12

  m = p * (j / (1 - (1 + j)**-n))

  puts "Your monthly payment for you new car will be $#{m.round(2)}"

  answer = prompt "Want to perform another calculation? (Y to calcualte again)"
  break unless answer.downcase.start_with?('y')
end
puts "Thank you for choosing our loan calculator"

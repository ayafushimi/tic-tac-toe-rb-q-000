def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0;
  board.each do |board|
    if(board != " ")
      counter += 1;
    end
  end
  return counter;
end

def current_player(board)
  turn = turn_count(board);
  if(turn % 2 == 0)
    return "X";
  else
    return "O";
  end
end

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def won?(board)
  WIN_COMBINATIONS.detect do |win_conbination| # [0,1,2], ...
    position_taken?(board, win_conbination[0]) && board[win_conbination[0]] == board[win_conbination[1]] && board[win_conbination[0]] == board[win_conbination[2]]
  end
end

def full?(board)
  indexes = [0,1,2,3,4,5,6,7,8];
  indexes.all? do |index|
    position_taken?(board, index);
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true;
  else
    return false;
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true;
  else
    return false;
  end
end

def winner(board)
  if won?(board)
    winner = board[won?(board)[0]];
  end
  return winner;
end

def play(board)
  while !over?(board)
    turn(board);
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!";
  elsif draw?(board)
    puts "Cats Game!";
  end
end

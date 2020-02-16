class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  
  
 attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = '' 
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

  def word_with_guesses
    result = ''
    @word.split('').each do |str|
      if !@guesses.include? str
        result << '-'
      else
        result << str
      end
    end
    
    return result
  end

  def guess(str)
if str.nil? or /[^A-Za-z]/.match(str) != nil or str == ''
		  raise ArgumentError.new("Invalid Letter. Please guess again")
end
	str.downcase!
  
	  if @guesses.include? str or @wrong_guesses.include? str
		  return false
	  end
  
	  if @word.include? str
		  @guesses = @guesses + str
		  return true
	  else
		  @wrong_guesses = @wrong_guesses + str
		  return true
	  end
  end
def check_win_or_lose
    
    if @wrong_guesses.length >= 7
      return :lose  
    elsif word_with_guesses.downcase == @word.downcase
      return :win
    else
      return :play
    end
end  
 

end

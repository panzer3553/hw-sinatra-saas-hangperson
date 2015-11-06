class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word_with_guesses
  attr_accessor :check_win_or_lose
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @last_word = []
    @guesses_count = 0
    @check_win_or_lose = :play
    @word_with_guesses = '-' * word.length
  end

  def guess(w)
    if not w =~ /^\w+$/
      raise ArgumentError
      return
    end
    w = w.downcase
    if not @last_word.include? w
    if self.word.include? w
      self.guesses = w
      self.wrong_guesses = ''
    else
      self.guesses = ''
      self.wrong_guesses = w
    end
    else
      self.guesses = w
      return false
    end
    check_word(w)
    @last_word << w
    @guesses_count += 1
    check_win
    return true
  end

  def check_word(word)
    (0..@word.length).each do |i|
      if @word[i] == word
        @word_with_guesses[i] = word
      end
    end
  end

  def check_win
    if @guesses_count >= 7
      @check_win_or_lose = :lose
    elsif @guesses_count < 7 && @word_with_guesses == @word
      @check_win_or_lose = :win
    else
      puts @word_with_guesses
      return
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end



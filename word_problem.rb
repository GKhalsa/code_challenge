require 'pry'

class WordProblem
    attr_reader :word_string, :calculations

  def initialize(word_string)
    @word_string = word_string[0..-2].split
    @calculations = []
  end

  def answer
    translation
  end

  def translation
    calculation = []
    word_string.each do |word|
      calculation << word.to_i if word.to_i != 0
      calculation << :+ if word == 'plus'
      calculation << :- if word == 'minus'
      calculation << :* if word == 'multiplied'
      calculation << :/ if word == 'divided'
    end
    calculator(calculation)
  end

  def calculator(calculation)
    if calculation.empty? || !irrelevance_checker(calculation)
      raise ArgumentError
    end

    calculation.each_with_index do |char, index|
      if char == :/
        computer(calculation, index, :/)
      elsif char == :+
        computer(calculation, index, :+)
      elsif char == :*
        computer(calculation, index, :*)
      elsif char == :-
        computer(calculation, index, :-)
      end
    end
    calculations[0]
  end

  def empty_calculation(index, calculation, operator)
    calculations << calculation[index - 1]
    calculations << calculation[index + 1]
    @calculations = [calculations.reduce(operator)]
  end

  def non_empty_calculation(index, calculation, operator)
    calculations << calculation[index + 1]
    @calculations = [calculations.reduce(operator)]
  end

  def irrelevance_checker(calculation)
    calculation.any? do |char|
      [:+,:-,:*,:/].include?(char)
    end
  end

  def computer(calculation, index, operator)
    if calculations.empty?
      empty_calculation(index, calculation, operator)
    else
      non_empty_calculation(index,calculation, operator)
    end
  end

end

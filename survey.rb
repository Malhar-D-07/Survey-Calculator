class Survey
  attr_accessor :question_answers, :no_of_yes, :name
  def initialize(store)
    @question_answers = []
    @no_of_yes = 0
  end

  QUESTIONS = {
    "q1" => "Can you code in Ruby?",
    "q2" => "Can you code in JavaScript?",
    "q3" => "Can you code in Swift?",
    "q4" => "Can you code in Java?",
    "q5" => "Can you code in C#?"
  }.freeze

  ACCEPTABLE_ANSWERS = ["Y", "N", "YES", "NO"]
  AFFIRMATIVE_ANSWERS = ["Y", "YES"]

  def do_prompt(store)
    unless @name
      print "Please enter your name: \n"
      @name = gets.chomp.downcase.gsub(' ', '')
      store.transaction do
        store[@name] = {} if !store[@name]
        store[@name][:data] = [] if !store[@name][:data]
        if store[@name].has_key?(:no_of_runs)
          store[@name][:no_of_runs] += 1
        else
          store[@name][:no_of_runs] = 1
        end
      end
    end

    QUESTIONS.each_with_index do |(question_key, question_value), index|
      print "\n #{question_value}"
      ans = gets.chomp
      while !answer_acceptable?(ans, ACCEPTABLE_ANSWERS)
        print "Please type answer from these options: Yes, No, Y, N\n"
        ans = gets.chomp
      end
      @question_answers << QuestionAnswer.new(question_value, ans)
      @no_of_yes += 1 if answer_acceptable?(ans, AFFIRMATIVE_ANSWERS)
    end

    print "Yayyy!!! You have completed the Survey\n"
    print "Your rating for this survey is #{calculate_rating()}\n"
  end

  def calculate_rating
    (100 * @no_of_yes) / QUESTIONS.size
  end

  def answer_acceptable?(user_input, array)
    array.any? { |answer| answer.downcase == user_input.downcase }
  end

end

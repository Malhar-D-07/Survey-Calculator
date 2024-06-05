require "pstore"
require_relative "survey"
require_relative "question_answer"

STORE_NAME = "tendable.pstore"
store = PStore.new(STORE_NAME)

# This method presents the Survey questions to user.
def generate_survey(store)
  survey = Survey.new(store)
  survey.do_prompt(store)
  store.transaction do
    store[survey.name][:data] << survey
  end
end

# This method calculates the average rating till now for a user
def calculate_average_rating(store)
  print "\nPlease enter your name: "
  @name = gets.chomp.downcase.gsub(' ', '')
  @total_rating = 0
  @no_of_runs = 0
  store.transaction do
    while !store[@name]
      print "No data associated with entered name. Please enter correct name\n"
      @name = gets.chomp.downcase.gsub(' ', '')
    end

    store[@name][:data].each do |survey|
      @total_rating += survey.calculate_rating
    end
    @no_of_runs = store[@name][:no_of_runs]
  end
  print "Your Average rating is: #{@total_rating / @no_of_runs}\n"
end


# This is the Driving Code for the Program
@input = ''
while @input != 'exit'
  print "\n"
  print "Press 1 for Filling the Survey\n"
  print "Press 2 for getting your Average Rating\n"
  print "Enter exit for exiting the Program\n"

  @input = gets.chomp.downcase.gsub(' ', '')

  if @input == '1'
    generate_survey(store)
  elsif @input == '2'
    calculate_average_rating(store)
  else
    exit
  end
end

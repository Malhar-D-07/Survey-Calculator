# Tendable Coding Assessment

## Usage

```sh
bundle
ruby questionnaire.rb
```

## Goal

The goal is to implement a survey where a user should be able to answer a series of Yes/No questions. After each run, a rating is calculated to let them know how they did. Another rating is also calculated to provide an overall score for all runs.

## Requirements

Possible question answers are: "Yes", "No", "Y", or "N" case insensitively to answer each question prompt.

The answers will need to be **persisted** so they can be used in calculations for subsequent runs >> it is proposed you use the pstore for this, already included in the Gemfile

After _each_ run the program should calculate and print a rating. The calculation for the rating is: `100 * number of yes answers / number of questions`.

The program should also print an average rating for all runs.

The questions can be found in questionnaire.rb

Ensure we can run your exercise

## Bonus Points

Updated readme with an explanation of your approach

Unit Tests

Code Comments

Dockerfile / Bash script if needed for us to run the exercise

## Answer

#### For running the program: `ruby questionnaire.rb`

The Data Structure in pstore is as follows

```{name1 => {no_of_runs: 2, data: [SurveyInstance1, SurveyInstance1]}```

```name2 => {no_of_runs: 2, data: [SurveyInstance1, SurveyInstance1]}}```

Survey object is having the following structure:

`{name: 'UserName', question_answers: [QuestionAnswerInstance1, QuestionAnswerInstance2, QuestionAnswerInstance3, QuestionAnswerInstance4, QuestionAnswerInstance5], no_of_yes: 2}`

The QuestionAnswer has following structure: `{question: "", answer: ""}`

One Survey _has_many_ QuestionAnswer

Based on the no_of_yes, the rating for each survey is calculated using the `calculate_rating` method.

For calculating the Average rating, each survey's rating is calculated and then divided by the `no_of_runs`

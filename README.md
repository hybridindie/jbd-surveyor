# Surveys On Rails

Surveyor is a ruby gem and developer tool that brings surveys into Rails applications. Surveys are written in the Surveyor DSL (Domain Specific Language). Before Rails 2.3, it was implemented as a Rails Engine. It also existed previously as a plugin. Today it is a gem only.

## Why you might want to use Surveyor

If your Rails app needs to asks users questions as part of a survey, quiz, or questionnaire then you should consider using Surveyor. This gem was designed to deliver clinical research surveys to large populations, but it can be used for any type of survey.

The Surveyor DSL defines questions, answers, question groups, survey sections, dependencies (e.g. if response to question 4 is A, then show question 5), and validations. Answers are the options available for each question - user input is called "responses" and are grouped into "response sets". A DSL makes it significantly easier to import long surveys (no more click/copy/paste). It also enables non-programmers to write out, edit, re-edit... any number of surveys.

## DSL example

The Surveyor DSL supports a wide range of question types (too many to list here) and complex dependency logic. Here are the first few questions of the "kitchen sink" survey which should give you and idea of how it works. The full example with all the types of questions available if you follow the installation instructions below.

    survey "Kitchen Sink survey" do
    
      section "Basic questions" do
        # A label is a question that accepts no answers
        label "These questions are examples of the basic supported input types"
    
        # A basic question with radio buttons
        question_1 "What is your favorite color?", :pick => :one
        answer "red"
        answer "blue"
        answer "green"
        answer "yellow"
        answer :other
    
        # A basic question with checkboxes
        # "question" and "answer" may be abbreviated as "q" and "a"
        q_2 "Choose the colors you don't like", :pick => :any
        a_1 "red"
        a_2 "blue"
        a_3 "green"
        a_4 "yellow"
        a :omit
    
        # A dependent question, with conditions and rule to logically join them  
        # the question's reference identifier is "2a", and the answer's reference_identifier is "1"
        # question reference identifiers used in conditions need to be unique on a survey for the lookups to work
        q_2a "Please explain why you don't like this color?"
        a_1 "explanation", :text
        dependency :rule => "A or B or C or D"
        condition_A :q_2, "==", :a_1
        condition_B :q_2, "==", :a_2
        condition_C :q_2, "==", :a_3
        condition_D :q_2, "==", :a_4
    
        # ... other question, sections and such. See surveys/kitchen_sink_survey.rb for more.
     end 
    
    end
   
The first question is "pick one" (radio buttons) with "other". The second question is "pick any" (checkboxes) with the option to "omit". It also features a dependency with a follow up question. Notice the dependency rule is defined as a string. We support complex dependency such as "A and (B or C) and D" or "A or ((B and C) or D)". The conditions are evaluated separately using the operators "==","!=","<>", ">=","<" the substituted by letter into to the dependency rule and evaluated.

# Installation

As a gem (with bundler):

    # in environment.rb
    gem "surveyor"

    bundle install

Generate assets, run migrations:
    
    script/rails generate surveyor:install
    rake db:migrate

3. Try out the "kitchen sink" survey. The rake task above generates surveys from our custom survey DSL (a good format for end users and stakeholders).

`rake surveyor FILE=surveys/kitchen_sink_survey.rb`

The rake tasks above generate surveys in our custom survey DSL (which is a great format for end users and stakeholders to use). 
After you have run them start up your app:
    
    script/rails server

(or however you normally start your app) and goto:

http://localhost:3000/surveys

Try taking the survey and compare it to the contents of the DSL file kitchen\_sink\_survey.rb. See how the DSL maps to what you see.

There are two other useful rake tasks for removing (only surveys without responses) and un-parsing (from db to DSL file) surveys:

`rake surveyor:remove`
`rake surveyor:unparse`

# Customizing surveyor

Surveyor's controller, models, and views may be customized via classes in your app/models, app/helpers and app/controllers directories. To generate a sample custom controller and layout, run:

    script/generate surveyor:custom

and check out surveys/EXTENDING\_SURVEYOR

# Dependencices

Surveyor depends on Ruby (1.8.7 - 1.9.1), Rails 2.3 and the SASS style sheet language, part of HAML (http://haml.hamptoncatlin.com/download). It also depends on fastercsv for csv exports. For running the test suite you will need rspec and have the rspec plugin installed in your application.

# Test Suite and Development

To work on the plugin code (for enhancements, and bug fixes, etc...) fork this github project. Then clone the project under the vendor/plugins directory in a Rails app used only for development:

# Changes

0.16.1

* fixed surveyor.sections translation line
* changed map resources order to access results survey success
* add translations for Sections title
* Add I18n to Sections title
* updated date on license
* updating results views and controller for new paths
* new results routes

0.16.0

* minor fixes to unparsing
* refining unparser. added rake task to unparse survey. closes #79
* unparsing for groups, dependencies, validations
* starting work on unparser for basic survey, section and question.

0.15.0

* prevent duplicate survey titles by appending incrementing numbers
* rake task to remove a survey. closes #64
* cleanup of old parsing strategy
* features and specs and new parser. closes #62
* first test driven work on parser
* moving parser and common specs so they run automatically. fixing some spec errors
* first shot a surveyor parser. some parts untested, but coded to determine style. references #62
* refactoring counters
* fixing failing specs. fixes acts\_as\_response issues

0.14.5

* use modules to include model methods. re-closes #77
* rails init. destroy dependent models

0.14.4

* explicitly require surveyor models and helper. update sweeper syntax. closes #77
* cleanup and requires
* fixing instructions for extending surveyor. closes #76

0.14.3

* remove manual numbering until it works. refactoring to use common methods.

0.14.2

* lowercase localization. feature instead of story in cucumber feature
* add results section
* add simple admin section for displaying survey result set
* Added manual numbering to labels as well

0.14.1

* typo in repeaters - use survey\_section\_id instead of section\_id

0.14.0

* view my survey specs fixed, fragment caching for surveyor#edit, localization. thanks bnadav

0.13.0

* simpler customization of surveyor.
* spec plugins task
* Feature instead of Story for cucumber. http://wiki.github.com/aslakhellesoy/cucumber/upgrading

0.12.0

* fix parser error in ruby 1.9, where instance_variables are symbols. closes #61
* added fastercsv as dependency. closes #59
* typo fix and test
* fixed broken spec for survey urls, made pending surveyor_controller specs pass
* Added explicit dependencycondition and validationcondition to DSL
* have authentication work with authlogic
* added "correct_answer" to parser, so you can specify one correct answer per question

0.11.0

* basic csv export. closes #21
* add unique indicies. closes #45
* add one_integer renderer. closes #51
* constrain surveys to have unique access_codes. closes #45. closes #42
* covering the extremely unlikely case that response_sets may have a non-unique access_code. closes #46. thanks jakewendt.
* current user id not needed in the view, set in SurveyorController. closes #48. thanks jakewendt

0.10.0

* surveyor config['extend'] is now an array. custom modules (e.g. SurveyExtensions are now included from within surveyor models, allowing 
the customizations to work on every request in development. closes #39. thanks to mgurley and jakewendt for the suggestions.
* remove comment from surveyor_includes
* css tweak
* automatically add backslashes and eliminate multiple backslashes in relative root for routes
* readme spelling and line breaks
* fixing a failing spec with factory instead of mock parent model
* upgrading cucumber to 0.6

0.9.11

* adding rails init.rb to make gem loading work. thanks mike gurley. closes #52.
* Repeater changed to only have +1, not +3 as previous
* added locking and transaction to surveyor update action. Prevents bug that caused duplicated answers
* some light re-factoring and code readability changes
* some code formatting changes
* added require statement to specs so the factory_girl test dependency was more clear
* spiced up the readme... may have some typos
* readme update

0.9.10

* styles, adding labels for dates, correcting labels for radio buttons

0.9.9

* count label and image questions complete when mandatory. closes #38
* validate by other responses. closes #35

0.9.8

* @current\_user.id if @current\_user isn't nil. Closes #37

0.9.7

* fixing typos
* remove surveyor controller from load\_once\_paths. fixes issue with dependencies and unloading in development. closes #36

0.9.6

* response set reports progress and mandatory questions completeness. closes #33
* adding correctness to response sets
* adding correctness to responses

0.9.5

* allow append for survey parser. closes #32

0.9.4

* making tinycode compatible with ruby 1.8.6

0.9.3

* fix for survey parser require

0.9.2

* fixing specs for namespacing and move of tinycode
* namespacing SurveyParser models to avoid conflict with model extensions

0.9.1

* fix for tinycode, more descriptive missing method

0.9.0

* validations in dsl and surveyor models
* preserve underscores in reference identifiers
* dsl specs, refactoring into base class
* adding display order to surveys
* moving columnizer and tiny column functionality to surveyor module
* columnizer (and tiny code) refactoring, columnizer spec extracted from answer spec
* cleanup of scopes with joins
* refactoring dependency

and read surveys/EXTENDING\_SURVEYOR

# Requirements

Surveyor depends on Ruby (1.8.7 - 1.9.1), Rails 2.3 and HAML/SASS http://haml.hamptoncatlin.com/. It also depends on fastercsv for csv exports.

# Contributing, testing

To work on the code fork this github project. Run:

`rake -f init_testbed.rakefile`

which will generate a test app in testbed. Run rake spec and rake cucumber there, and start writing tests!

Copyright (c) 2008-2010 Brian Chamberlain and Mark Yoon, released under the MIT license

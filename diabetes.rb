survey "Diabetes Survey" do

  section "Appropriateness of Survey" do
    label "This question assesses whether you are appropriate for this questionnaire."
    
    question_1 "Do you have diabetes?", :pick => :one
    a_1 "Yes"
    a_2 "No"
    a_3 "Not sure"
    
    label "You already have a diagnosis of diabetes, so this risk questionnaire is not relevant. You can go ahead and continue if you want, but our recommendations may not be accurate."
    dependency :rule => "A"
    condition_A :q_1, "==", :a_1
    
    q_2 "Do you have any of the following symptoms?", :pick => :any
    a_1 "unusual thirst"
    a_2 "frequent urination"
    a_3 "rapid weight change (loss or gain)"
    a_4 "extreme fatigue or lack of energy"
    a_5 "blurred vision"
    a_6 "frequent or recurring infections"
    a_7 "cuts and bruises that are slow to heal"
    a_8 "tingling or numbness in the hands or feet"
    a_9 "trouble getting or maintaining an erection"
    a :omit
        
    label "You said yes to one of the classic symptoms of Type 2 Diabetes. This does not necessarily mean you have diabetes, but based on your answer we suggest you see your family doctor immediately for a work-up. Feel free to continue with the questionnaire in light of this advice."
    dependency :rule => "A or B or C or D or D or E or F or G or H or I"
    condition_A :q_2, "==", :a_1
    condition_B :q_2, "==", :a_2
    condition_C :q_2, "==", :a_3
    condition_D :q_2, "==", :a_4
    condition_E :q_2, "==", :a_5
    condition_F :q_2, "==", :a_6
    condition_G :q_2, "==", :a_7
    condition_H :q_2, "==", :a_8
    condition_I :q_2, "==", :a_9
  end

  section "Gender and age" do
    q_3 "Are you male or female?", :pick => :one
    a_1 "Male"
    a_2 "Female"
    
    q_4 "What is your date of birth?" #, :custom_renderer => "/partials/custom_question"
    a :date, :custom_renderer => "/partials/date_answer"
  end
  
  section "Height and Weight + Waist Circumference" do
    q "Adjust the slider to reflect your height", :pick => :one, :display_type => :slider 
    (4..7).to_a.each{|num| a num.to_s}
    
    q "Adjust the slider to reflect your weight", :pick => :one, :display_type => :slider 
    (50..400).to_a.each{|num| a num.to_s}
    
    q "Adjust the slider to reflect your waist circumference (cm)", :pick => :one, :display_type => :slider 
    (90..120).to_a.each{|num| a num.to_s}
  end

  section "Exercise" do
    q "How many hours of exercise do you do per day?", :pick => :one, :display_type => :slider 
    (0..8).to_a.each{|num| a num.to_s}
  end
  
  section "Diet" do
    q "How often do you eat vegetables, fruit or berries?", :pick => :one
    a_1 "Every day"
    a_2 "Less than every day"
  end
  
  section "Hypertension and Diabetes" do
    q "Have you ever had to take high blood pressure medication regularly?", :pick => :one
    a_1 "Yes"
    a_2 "No"
  end
  
  section "Diabetes History" do
    q "Have you ever been found to have high blood glucose (e.g. in a health examination)?", :pick => :one
    a_1 "Yes"
    a_2 "No"
    
    repeater "Who in your family has diabetes?" do 
      q "Family member", :pick => :one, :display_type => :dropdown
      a "Mother"
      a "Father"
      a "Sister"
      a "Brother"
      a "Grandma"
      a "Grandpa"
      a "No one"
     end
     
   end
     
   section "Other risk factors" do
     q "What is your ethnicity", :pick => :one, :display_type => :dropdown
     a "Caucasian"
     a "Aboriginal/Native American"
     a "Hispanic"
     a "South Asian"
     a "Asian"
     a "African"
     a "Middle Eastern"

     q_smoke "Do you smoke?", :pick => :one
     a_1 "Yes"
     a_2 "No"  
     a_3 "I used to"    
  
     q_smokea "How much do you or did you smoke?"
     a_1 "Yes", :integer
     dependency :rule => "A or B"
     condition_A :q_smoke, "==", :a_1
     condition_B :q_smoke, "==", :a_3
   end

   section "Screening" do
     q "When did you last have your blood sugar checked?" #, :custom_renderer => "/partials/custom_question" 
     a_1 :datetime
     
     q "Enter the value of your Fasting Plasma Blood glucose"
     a_1 :string
     
     q "Enter the value of your last HbA1c blood test"
     a_1 :string
   end
end


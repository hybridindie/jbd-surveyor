module Surveyor
  module Models
    module ResponseMethods
      def self.included(base)
        # Associations
        base.send :belongs_to, :response_set
        base.send :belongs_to, :question
        base.send :belongs_to, :answer
       @@validations_already_included ||= nil
        unless @@validations_already_included
          # Validations
          base.send :validates_presence_of, :response_set_id, :question_id, :answer_id
          
          @@validations_already_included = true
        end
       base.send :include, Surveyor::ActsAsResponse # includes "as" instance method
      end

      # Instance Methods
      def answer_id=(val)
        write_attribute :answer_id, (val.is_a?(Array) ? val.detect{|x| !x.to_s.blank?} : val)
      end

      def correct?
        question.correct_answer_id.nil? or self.answer.response_class != "answer" or (question.correct_answer_id.to_i == answer_id.to_i)
      end

      def to_s # used in dependency_explanation_helper
        if self.answer_id and self.answer.response_class == "answer" 
          return self.answer.text
        else
          return "#{(self.string_value || self.text_value || self.integer_value || self.float_value || nil).to_s}"
        end
      end

     def value
       self.string_value || self.text_value || self.integer_value || self.float_value || nil
     end 
     
    end
  end
end

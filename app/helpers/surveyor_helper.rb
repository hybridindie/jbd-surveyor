module SurveyorHelper
  # Layout: stylsheets and javascripts
  def surveyor_includes
    surveyor_stylsheets + surveyor_javascripts    
  end
  def surveyor_stylsheets
    stylesheet_link_tag 'surveyor/reset', 'surveyor/dateinput', 'surveyor'
  end
  def surveyor_javascripts
    javascript_include_tag 'surveyor/jquery.tools.min', 'surveyor/jquery.surveyor'
  end
  # Helper for displaying warning/notice/error flash messages
  def flash_messages(types)
    types.map{|type| content_tag(:div, "#{flash[type]}".html_safe, :class => type.to_s)}.join.html_safe
  end
  # Section: dependencies, menu, previous and next
  def dependency_explanation_helper(question,response_set)
    # Attempts to explain why this dependent question needs to be answered by referenced the dependent question and users response
    trigger_responses = []
    dependent_questions = Question.find_all_by_id(question.dependency.dependency_conditions.map(&:question_id)).uniq
    response_set.responses.find_all_by_question_id(dependent_questions.map(&:id)).uniq.each do |resp|
      trigger_responses << resp.to_s
    end
    "&nbsp;&nbsp;You answered &quot;#{trigger_responses.join("&quot; and &quot;")}&quot; to the question &quot;#{dependent_questions.map(&:text).join("&quot;,&quot;")}&quot;".html_safe
  end
  def menu_button_for(section)
    submit_tag(section.title, :name => "section[#{section.id}]")
  end
  def previous_section
    # submit_tag("#{t ('surveyor.previous_section')} &raquo;", :name => "section[#{@section.previous.id}]") unless @section.previous.nil?
    # refactored to use copy in memory instead of making extra db calls
    submit_tag(t('surveyor.previous_section'), :name => "section[#{@sections[@sections.index(@section)-1].id}]") unless @sections.first == @section
  end
  def next_section
    # use copy in memory instead of making extra db calls
#    @sections.last == @section ? submit_tag(t('surveyor.click_here_to_finish'), :name => "finish") : submit_tag(t('surveyor.next_section'), :name => "section[#{@sections[@sections.index(@section)+1].id}]")
    @sections.last == @section ? submit_tag( "finish", :name => "finish") : submit_tag("Next section &raquo;".html_safe,  :name => "section[#{@sections[@sections.index(@section)+1].id}]") 
  end
  
  # Questions
  def q_text(obj)
    @n ||= 0
    return image_tag(obj.text) if obj.is_a?(Question) and obj.display_type == "image"
    return obj.text if obj.is_a?(Question) and (obj.dependent? or obj.display_type == "label" or obj.part_of_group?)
    "#{@n += 1}) #{obj.text}"
  end
  # def split_text(text = "") # Split text into with "|" delimiter - parts to go before/after input element
  #   {:prefix => text.split("|")[0].blank? ? "&nbsp;" : text.split("|")[0], :postfix => text.split("|")[1] || "&nbsp;"}
  # end
  # def question_help_helper(question)
  #   question.help_text.blank? ? "" : %Q(<span class="question-help">#{question.help_text}</span>)
  # end
  
  # Answers
  def rc_to_attr(type_sym)
    case type_sym.to_s
    when /^date|time$/ then :datetime_value
    when /(string|text|integer|float|datetime)/ then "#{type_sym.to_s}_value".to_sym
    else :answer_id
    end
  end
  def rc_to_as(type_sym)
    case type_sym.to_s
    when /(integer|float)/ then :string
    else type_sym
    end
  end
  
  # Responses
  def response_for(response_set, question, answer = nil, response_group = nil)
    return nil unless response_set && question && question.id
    result = response_set.responses.detect{|r| (r.question_id == question.id) && (answer.blank? ? true : r.answer_id == answer.id) && (r.response_group.blank? ? true : r.response_group.to_i == response_group.to_i)}
    result.blank? ? response_set.responses.build(:question_id => question.id, :response_group => response_group) : result
  end
  def response_idx(increment = true)
    @rc ||= 0
    (increment ? @rc += 1 : @rc).to_s
  end  
end

module ResultsHelper
  def display_response(r_set,question)
    sets = r_set.responses.select{|r| r.question.display_order == question.display_order}
	  	if sets.size == 0
  			return "-"
  		elsif sets.size == 1
  			return (sets.first.string_value || sets.first.text_value || show_answer(sets.first))
  		else
  		  txt = ""
        sets.each do |set|
          txt << show_answer(set)
        end
        return txt
		  end
  end
  
  def show_answer(set)
     set.answer.text
  end

  # TODO: Need to add a column for weighting response values and recording them
  def result_total_for_set(rs)
    result_total = 0
    rs.responses.each do |question|
      case question.answer.text
        when "Yes"
        result_total += 10
        
        when "No" || "N/A"

        else
        result_total += question.answer.text.to_i
      end
    end
    return result_total
  end
end
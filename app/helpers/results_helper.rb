module ResultsHelper
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
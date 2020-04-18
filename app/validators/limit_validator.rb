class LimitValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, _)
    return true unless record.send(attribute).attached?

    files = Array.wrap(record.send(attribute)).compact.uniq
    errors_options = { min: options[:min], max: options[:max] }

    return true if files_count_valid?(files.count)
    record.errors.add(attribute, "out of range(#{options[:min]},#{options[:max]})")
  end

  def files_count_valid?(count)
    if options[:max].present? && options[:min].present?
      count >= options[:min] && count <= options[:max]
    elsif options[:max].present?
      count <= options[:max]
    elsif options
      count >= options[:min]
    end
  end
end
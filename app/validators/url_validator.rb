class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "must be a valid URL") unless url_valid?(value)    
  end

  
  def url_valid?(url)
    url =~ URI.regexp(["https"])
  end 
end
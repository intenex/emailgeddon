# adapted from a gem 'validates_email_address'

 class EmailAddressValidator < ActiveModel::EachValidator

  def default_options
    @default_options ||= {:format => true, :mx => true, :smtp => true, :message => "invalid email address"}
  end

  def default_options
    @default_options ||= {:smtp => true, :message => "invalid email address"}
  end

 def validate_each (record, attribute, value)
    options = default_options.merge(self.options)

    if options[:smtp] && check_smtp(value) == false
      record.errors.add(attribute, options[:message])
    end
 end
end



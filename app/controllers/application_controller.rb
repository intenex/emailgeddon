require "validates_email_address_of/version"
require "resolv"
require "net/smtp"

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception




def default_options
  @default_options ||= {:format => true, :mx => true, :smtp => true, :message => "invalid email address"}
end

def validate_each (record, attribute, value)
  options = default_options.merge(self.options)

  if options[:format] && check_format(value) == false
    record.errors.add(attribute, options[:message])
    return
  end

  if options[:mx] && check_mx(value) == false
    record.errors.add(attribute, options[:message])
    return
  end

  if options[:smtp] && check_smtp(value) == false
    record.errors.add(attribute, options[:message])
  end

end

private

def check_format (value)
  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.match(value).to_s == value
end

def check_mx (value)
  @mx = get_mx(value)
  @mx.size > 0
end

def check_smtp (value)
  @mx ||= get_mx(value)
  return unless @mx.size > 0
  Net::SMTP.start(@mx[0].exchange.to_s) do |smtp|
    begin
      smtp.mailfrom("yu@benyu.org")
      smtp.rcptto(value)
    rescue
      nil
    end
  end
end

def get_mx(value)
  # Basic email validation
  email_match = /\@(.+)/.match(value)
  if email_match
    domain = email_match[1]
    Resolv::DNS.open do |dns|
      dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
    end
  end
end



end

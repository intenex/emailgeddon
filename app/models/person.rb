class Person < ActiveRecord::Base
    validates_presence_of :firstname
    validates_presence_of :lastname
    validates_presence_of :domain
    validates_length_of :firstname, :maximum => 50
    validates_length_of :lastname, :maximum => 50
    validates_length_of :domain, :maximum => 50
end

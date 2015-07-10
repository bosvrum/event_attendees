require "csv"
require 'rubygems'
require 'sunlight'
require 'open-uri'


Sunlight::Base.api_key = "28ec1945859a4502a1477f6e42d8e36e"
puts "EventManager Initialized!"


def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zipcode)
  legislators = Sunlight::Legislator.all_in_zipcode(zipcode)

  legislator_names = legislators.map do |legislator|
    if legislator.nil?
      no name
    else
      "#{legislator.first_name} #{legislator.last_name}"
    end
  end
  legislator_names.join(", ")
end

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

contents.each do |row|
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)
  puts "#{name} #{zipcode} #{legislators}"
end
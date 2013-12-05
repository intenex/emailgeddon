json.array!(@people) do |person|
  json.extract! person, :firstname, :lastname, :domain
  json.url person_url(person, format: :json)
end
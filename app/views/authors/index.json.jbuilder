json.array!(@authors) do |author|
  json.extract! author, :id, :name, :bio, :image_url, :date
  json.url author_url(author, format: :json)
end

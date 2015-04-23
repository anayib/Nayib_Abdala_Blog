json.array!(@tips) do |tip|
  json.extract! tip, :id, :title, :content, :strategy_id
  json.url tip_url(tip, format: :json)
end

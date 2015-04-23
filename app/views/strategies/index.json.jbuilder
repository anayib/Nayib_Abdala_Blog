json.array!(@strategies) do |strategy|
  json.extract! strategy, :id, :title, :intro, :date, :user_id
  json.url strategy_url(strategy, format: :json)
end

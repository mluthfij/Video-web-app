json.extract! video, :id, :title, :body, :created_at, :updated_at
json.url video_url(video, format: :json)

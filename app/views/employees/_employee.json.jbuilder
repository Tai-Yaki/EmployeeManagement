json.extract! employee, :id, :name, :join_date, :gender, :position, :created_at, :updated_at
json.url employee_url(employee, format: :json)

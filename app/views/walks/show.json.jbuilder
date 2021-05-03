json.walk do
  json.extract! @walk, :start_address, :end_address
end
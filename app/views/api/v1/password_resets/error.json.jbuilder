json.errors do
  json.messages @password_reset.user.errors.to_a
end

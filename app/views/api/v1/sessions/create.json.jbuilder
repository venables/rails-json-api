json.session do
  json.token @session.signed_token
end

json.user do
  json.id @user.id
  json.email @user.email
end

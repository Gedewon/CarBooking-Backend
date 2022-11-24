json.(user, :id, :email, :username, :admin)
json.token user.generate_jwt
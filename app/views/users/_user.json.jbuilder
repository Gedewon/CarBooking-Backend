# frozen_string_literal: true

json.call(user, :id, :email, :username, :role)
json.token user.generate_jwt

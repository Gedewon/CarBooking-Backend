# frozen_string_literal: true

json.call(user, :id, :email, :username, :admin)
json.token user.generate_jwt

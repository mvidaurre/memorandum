class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :api_token, :password, :created_at
end

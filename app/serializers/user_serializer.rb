class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :email
end

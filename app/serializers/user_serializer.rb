class UserSerializer < JSONAPI::Serilizable::Resource
  type 'users'

  attributes :name, :email

  link :self do
    @url_helpers.api_user_url(@object.id)
  end
end

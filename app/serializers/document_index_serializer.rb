class DocumentIndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :slug
end
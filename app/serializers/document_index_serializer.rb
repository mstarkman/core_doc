class DocumentIndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :body
end
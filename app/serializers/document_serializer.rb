class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :slug
  has_one :parent_document, key: :parent, serializer: DocumentShortSerializer
  has_many :child_documents, key: :children, serializer: DocumentShortSerializer

end

class DocumentsController < ApplicationController
  respond_to :json

  def index
    documents = Document.without_parent
    render json: documents, each_serializer: DocumentIndexSerializer
  end

  def show
    document = Document.find(params[:id])
    respond_with document
  end

  def create
    document = Document.new(document_params)
    if document.save
      respond_with document
    end
  end

  def update
    document = Document.find(params[:id])
    if document.update_attributes document_params
      respond_with document
    end
  end

  def destroy
    document = Document.find(params[:id])
    document.destroy
    render json: nil, status: :no_content
  end

  private
  def document_params
    params.require(:document).permit(:title, :body, :parent_document_id)
  end
end

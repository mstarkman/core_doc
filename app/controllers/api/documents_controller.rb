class Api::DocumentsController < ApplicationController
  respond_to :json
  before_filter :load_document, only: [:show, :update, :destroy]

  def index
    documents = Document.without_parent
    render json: documents, each_serializer: DocumentIndexSerializer
  end

  def show
    respond_with @document
  end

  def create
    document = Document.new(document_params)
    if document.save
      render json: document
    end
  end

  def update
    if @document.update_attributes document_params
      respond_with @document
    end
  end

  def destroy
    @document.destroy
    render json: nil, status: :no_content
  end

  private
  def document_params
    params.require(:document).permit(:title, :body, :parent_document_id)
  end

  def load_document
    @document = Document.find(params[:id])
  end
end

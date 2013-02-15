CoreDoc::Application.routes.draw do
  class FormatTest
    attr_accessor :mime_type

    def initialize(format)
      @mime_type = Mime::Type.lookup_by_extension(format)
    end

    def matches?(request)
      request.format == mime_type
    end
  end

  resources :documents, except: [:edit, :new], :constraints => FormatTest.new(:json)
  get 'templates/:model/:partial_type', to: "templates#index"
  get '*foo', :to => 'core_doc#index', :constraints => FormatTest.new(:html)
  get '/', :to => 'core_doc#index', :constraints => FormatTest.new(:html)
end

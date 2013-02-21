@CoreDoc.controller 'DocumentNewCtrl', [
  "$scope",
  "$location",
  "$routeParams",
  "Document",
  ($scope, $location, $routeParams, Document) ->
    document = $scope.document = if $routeParams.parent_id then new Document(parent_document_id: Document.loadedDocument.id) else new Document()
    $scope.cancelPath = if $routeParams.parent_id then $scope.routes.document.show(id: $routeParams.parent_id) else $scope.routes.documents()
    $scope.addDocument = ->
      $scope.startSaving()
      document.create().then ->
        $scope.endSaving "Document Added!"
        $location.path $scope.routes.document.show(document)
]

@CoreDoc.resolves["document.newChild"] =
  data: ["$rootScope", "$q", "$route", "Document", ($rootScope, $q, $route, Document) ->
    defer = $q.defer()

    docOnSuccess = (document) ->
      Document.loadedDocument = document
      defer.resolve()

    docOnFailure = (response) ->
      # response.status = 404
      $rootScope.setFlashMessage "Error loading parent document!"
      defer.reject()

    doc = Document.get($route.current.pathParams.parent_id)
    doc.then docOnSuccess, docOnFailure

    defer.promise
  ]
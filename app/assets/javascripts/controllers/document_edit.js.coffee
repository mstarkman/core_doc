@CoreDoc.controller 'DocumentEditCtrl', [
  "$scope",
  "$location",
  "Document",
  ($scope, $location, Document) ->
    currentDocument = null

    $scope.currentTitle = Document.loadedDocument.title
    $scope.document = currentDocument = Document.loadedDocument

    $scope.saveDocument = ->
      $scope.startSaving()
      currentDocument.update().then (document) ->
        $scope.endSaving "Document Saved!"
        $location.path $scope.routes.document.show(document)

    $scope.deleteDocument = ->
      if confirm("Are you sure you want to delete \"#{currentDocument.title}\"?")
        currentDocument.delete().then ->
          $scope.setFlashMessage "Document Deleted!"
          $location.path $scope.routes.documents()
]

@CoreDoc.resolves["document.edit"] =
  data: ["$rootScope", "$q", "$route", "Document", ($rootScope, $q, $route, Document) ->
    defer = $q.defer()

    docOnSuccess = (document) ->
      Document.loadedDocument = document
      defer.resolve()

    docOnFailure = (response) ->
      # response.status = 404
      $rootScope.setFlashMessage "Error editing document!"
      defer.reject()

    doc = Document.get($route.current.pathParams.id)
    doc.then docOnSuccess, docOnFailure

    defer.promise
  ]

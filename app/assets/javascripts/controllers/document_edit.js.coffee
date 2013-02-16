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
        $location.path "/documents/#{document.id}"

    $scope.deleteDocument = ->
      if confirm("Are you sure you want to delete \"#{currentDocument.title}\"?")
        currentDocument.delete().then ->
          $scope.setFlashMessage "Document Deleted!"
          $location.path '/documents'
]

@CoreDoc.resolves["document.edit"] =
  data: ["$q", "$route", "Document", ($q, $route, Document) ->
    defer = $q.defer()

    Document.get($route.current.pathParams.id).then (document) ->
      Document.loadedDocument = document
      defer.resolve()

    defer.promise
  ]

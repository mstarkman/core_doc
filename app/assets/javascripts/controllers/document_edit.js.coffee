@CoreDoc.controller 'DocumentEditCtrl', ["$scope", "$location", "$routeParams", "Document", ($scope, $location, $routeParams, Document) ->
  id = $routeParams.id
  currentDocument = null

  Document.get(id).then (document) ->
    $scope.currentTitle = document.title
    $scope.document = currentDocument = document

  $scope.saveDocument = ->
    currentDocument.update().then (document) ->
      $location.path "/documents/#{document.id}"

  $scope.deleteDocument = ->
    if confirm("Are you sure you want to delete \"#{currentDocument.title}\"?")
      currentDocument.delete().then ->
        $location.path '/documents'
]

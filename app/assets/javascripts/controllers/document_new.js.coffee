@CoreDoc.controller 'DocumentNewCtrl', ["$scope", "$location", "$routeParams", "Document", ($scope, $location, $routeParams, Document) ->
  document = $scope.document = if $routeParams.parent_id then new Document(parent_document_id: $routeParams.parent_id) else new Document()
  $scope.cancelPath = if $routeParams.parent_id then $scope.routes.document.show(id: $routeParams.parent_id) else $scope.routes.documents()
  $scope.addDocument = ->
    $scope.startSaving()
    document.create().then ->
      $scope.endSaving "Document Added!"
      $location.path $scope.routes.document.show(document)
]

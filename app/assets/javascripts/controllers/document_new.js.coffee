@CoreDoc.controller 'DocumentNewCtrl', ["$scope", "$location", "Document", ($scope, $location, Document) ->
  document = $scope.document = new Document()
  $scope.addDocument = ->
    $scope.startSaving()
    document.create().then ->
      $scope.endSaving "Document Added!"
      $location.path "/documents/#{document.id}"
]

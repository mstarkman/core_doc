#= require_tree .

@CoreDoc.controller 'CoreDocCtrl', ["$scope", "TemplatePaths", ($scope, TemplatePaths) ->
  $scope.templatePaths = TemplatePaths
]

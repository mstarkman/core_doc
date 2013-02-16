#= require template_paths

@CoreDoc.config ["$routeProvider", "$locationProvider", "TemplatePaths", ($routeProvider, $locationProvider, TemplatePaths) ->
  $locationProvider.html5Mode(true).hashPrefix('!')

  $routeProvider
    .when('/', templateUrl: TemplatePaths["documents/index.html"], controller: "DocumentsCtrl")
    .when('/documents', redirectTo: "/")
    .when('/documents/new', templateUrl: TemplatePaths["documents/new.html"], controller: "DocumentNewCtrl")
    .when('/documents/:id', templateUrl: TemplatePaths["documents/show.html"], controller: "DocumentCtrl")
    .when('/documents/:id/edit', templateUrl: TemplatePaths["documents/edit.html"], controller: "DocumentEditCtrl")
    .otherwise(redirectTo: "/")
]

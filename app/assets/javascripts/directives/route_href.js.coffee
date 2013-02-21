@CoreDoc.directive "cdRouteHref", [ ->
  (scope, element, attrs) ->
    element.attr("href", scope.$eval("routes.#{attrs.cdRouteHref}"))
]

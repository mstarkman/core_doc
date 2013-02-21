@CoreDoc.directive "cdDocumentDisplayer", [ ->
  {
    restrict: "E"
    replace: true
    scope:
      body: "="
    template: '<div class="document-displayer-container"></div>'
    link:  (scope, element) ->
      element.append marked(scope.body) if scope.body?
  }
]
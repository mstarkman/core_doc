@CoreDoc.directive "cdDocumentDisplayer", [ ->
  {
    restrict: "E"
    replace: true
    scope:
      body: "@"
    template: '<div class="document-displayer-container"></div>'
    link:  (scope, element, attrs) ->
      console.log scope
      console.log element
      console.log attrs.body

      element.append marked(attrs.body)
  }
]
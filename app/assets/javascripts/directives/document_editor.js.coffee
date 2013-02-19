@CoreDoc.directive "cdDocumentEditor", [ ->
  editorOpts =
    container: "document-editor"
    basePath: '/epiceditor'
    clientSideStorage: false
    theme:
      editor: '/themes/editor/epic-light.css'

  {
    restrict: "E"
    replace: true
    scope:
      body: "="
    template: '<div class="document-editor-container"><div id="document-editor"></div></div>'
    link:  (scope) ->
      editor = new EpicEditor(editorOpts)

      editor.load ->
        editor.importFile 'coreDocDocument', scope.body

      editor.on "save", ->
        scope.body = editor.exportFile()
        scope.$apply()
  }
]
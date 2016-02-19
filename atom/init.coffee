# atom.workspace.observeTextEditors (editor) ->
#   view = atom.views.getView(editor)
#   gutter = view.querySelector('::shadow .gutter-container')
#   scrollbar = view.querySelector('::shadow .horizontal-scrollbar')
#
#   scrollbar.addEventListener 'scroll', (e) ->
#     className = 'non-zero'
#     if scrollbar.scrollLeft > 0
#       gutter.classList.add(className)
#     else
#       gutter.classList.remove(className)

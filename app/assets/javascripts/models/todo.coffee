  window.Todo = Backbone.Model.extend
    url: ->
      if @id then '/to2dos/' + @id  else '/to2dos'

    toggle: ->
      @save done: !@get("done")
      return

    initialize: ->
      done: false
      return

    clear: ->
      @destroy()
      @view.remove()


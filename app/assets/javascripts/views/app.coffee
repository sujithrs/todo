jQuery ->
  window.AppView = Backbone.View.extend
    el: $("#todoapp")

    # Our template for the line of statistics at the bottom of the app.
    #statsTemplate: _.template($('#stats-template').html())
    statsTemplate: JST["templates/stats"]

    # Delegated events for creating new items, and clearing completed ones.
    events: 
      "keypress #new-todo":  "createOnEnter"
      "keyup #new-todo":     "showTooltip"
      "click .todo-clear a": "clearCompleted"

    # At initialization we bind to the relevant events on the `Todos`
    # collection, when items are added or changed. Kick things off by
    # loading any preexisting todos that might be saved in *localStorage*.
    initialize: ->
      _.bindAll(this, 'addOne', 'addAll', 'render')

      this.input    = this.$("#new-todo")

      window.Todos.bind('add',     this.addOne)
      window.Todos.bind('refresh', this.addAll)
      window.Todos.bind('all',     this.render)

      window.Todos.fetch()

    # Re-rendering the App just means refreshing the statistics -- the rest
    # of the app doesn't change.
    render: ->
      done = window.Todos.done().length
      this.$('#todo-stats').html(this.statsTemplate
          total:      window.Todos.length
          done:       window.Todos.done().length
          remaining:  window.Todos.remaining().length
        )

    # Add a single todo item to the list by creating a view for it, and
    # appending its element to the `<ul>`.
    addOne: (todo)->
      view = new window.TodoView model: todo
      this.$("#todo-list").append(view.render().el)

    # Add all items in the **Todos** collection at once.
    addAll: ->
      window.Todos.each(this.addOne)

    # Generate the attributes for a new Todo item.
    newAttributes: ->
      content: this.input.val(),
      order:   window.Todos.nextOrder(),
      done:    false

    # If you hit return in the main input field, create new **Todo** model,
    # persisting it to *localStorage*.
    createOnEnter: (e) ->
      return if (e.keyCode != 13)
      window.Todos.create(this.newAttributes())
      this.input.val('')

    # Clear all done todo items, destroying their models.
    clearCompleted: ->
      _.each(window.Todos.done(), 
        (todo) -> 
          todo.clear() 
          return
      )
      false

    # Lazily show the tooltip that tells you to press `enter` to save
    # a new todo item, after one second.
    showTooltip: (e) ->
      tooltip = this.$(".ui-tooltip-top")
      val = this.input.val()
      tooltip.fadeOut()
      clearTimeout(this.tooltipTimeout) if (this.tooltipTimeout)
      return if (val == '' || val == this.input.attr('placeholder'))
      show = -> tooltip.show().fadeIn()
      this.tooltipTimeout = _.delay(show, 1000)

  window.App = new window.AppView

jQuery ->
  # Todo Item View
  # --------------

  # The DOM element for a todo item...
  window.TodoView = Backbone.View.extend
      #... is a list tag.
      tagName:  "li"

        # Cache the template function for a single item.
      #template: _.template($('#item-template').html())
      template: JST["templates/item"]

      # The DOM events specific to an item.
      events: 
        "click .check"              : "toggleDone"
        "dblclick div.todo-content" : "edit"
        "click span.todo-destroy"   : "clear"
        "keypress .todo-input"      : "updateOnEnter"

      # The TodoView listens for changes to its model, re-rendering. Since there's
      # a one-to-one correspondence between a **Todo** and a **TodoView** in this
      # app, we set a direct reference on the model for convenience.
      initialize: ->
        _.bindAll(@, 'render', 'close')
        @model.bind('change', @render)
        @model.view = this

      # Re-render the contents of the todo item.
      render:  ->
        $(@el).html(@template(@model.toJSON()))
        @setContent()
        return this

      # To avoid XSS (not that it would be harmful in this particular app),
      # we use `jQuery.text` to set the contents of the todo item.
      setContent: ->
        content = @model.get('content')
        this.$('.todo-content').text(content)
        @input = this.$('.todo-input')
        @input.bind('blur', @close)
        @input.val(content)

      # Toggle the `"done"` state of the model.
      toggleDone: ->
        @model.toggle()

        # Switch this view into `"editing"` mode, displaying the input field.
      edit: ->
        $(@el).addClass("editing")
        @input.focus()

      # Close the `"editing"` mode, saving changes to the todo.
      close: ->
        @model.save content: @input.val()
        $(@el).removeClass("editing")

      # If you hit `enter`, we're through editing the item.
      updateOnEnter: ->
        @close() if (e.keyCode is 13) 

      # Remove this view from the DOM.
      remove: ->
        $(@el).remove()
        return

      # Remove the item, destroy the model.
      clear: ->
        @model.clear()
        return

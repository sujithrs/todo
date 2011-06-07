jQuery ->
  window.TodoList = Backbone.Collection.extend
      model: window.Todo
        
      url: '/to2dos'
      done: ->
        @filter (todo) ->
          todo.get('done')

      remaining: ->
        @without.apply(@, @done())

      nextOrder: ->
        return 1 if (!@length)
        @last().get('order') + 1

      comparator: (todo) ->
        todo.get 'order'

      pluralize: ->
        if count == 1 then 'item' else 'items'

  window.Todos = new window.TodoList
  return

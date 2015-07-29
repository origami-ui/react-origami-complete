
var
  React $ require :react
  Immutable $ require :immutable
  classnames $ require :classnames
  keycode $ require :keycode

var
  div $ React.createFactory :div
  input $ React.createFactory :input

= module.exports $ React.createClass $ {}
  :displayName :origami-complete

  :propTypes $ {}
    :options $ React.PropTypes.instanceOf Immutable.Map
    :onSubmit React.PropTypes.func.isRequired
    :placeholder React.PropTypes.string

  :getDefaultProps $ \ ()
    {} (:placeholder :)

  :getInitialState $ \ ()
    {} (:index 0) (:showMenu false) (:value :) (:memory :)

  :selectAbove $ \ ()
    var items $ this.filterOptions
    var nextIndex $ cond (> this.state.index 0)
      - this.state.index 1
      , items.size
    var current $ items.get $ - nextIndex 1
    this.setState $ {} (:index nextIndex)
      :value $ cond (is nextIndex 0) this.state.memory
        current.get 0

  :selectBelow $ \ ()
    var items $ this.filterOptions
    var nextIndex $ cond (< this.state.index items.size)
      + this.state.index 1
      , 0
    var current $ items.get $ - nextIndex 1
    this.setState $ {} (:index nextIndex)
      :value $ cond (is nextIndex 0) this.state.memory
        current.get 0

  :filterOptions $ \ ()
    ... this.props.options
      map $ \ (count key)
        Immutable.List $ [] key count
      filter $ \\ (pair)
        var key $ pair.get 0
        = key $ key.toLowerCase
        >= (key.indexOf (this.state.memory.toLowerCase)) 0
      toList
      sort $ \ (a b)
        if (> (a.get 1) (b.get 1)) $ do (return -1)
        if (< (a.get 1) (b.get 1)) $ do (return 1)
        return 0

  :onChange $ \ (event)
    console.log event.target.value
    this.setState $ {}
      :showMenu true
      :index 0
      :value event.target.value
      :memory event.target.value

  :onKeyDown $ \ (event)
    var items $ this.filterOptions
    switch (keycode event.keyCode)
      :enter
        this.props.onSubmit this.state.value
        this.setState $ {} (:showMenu false)
      :up
        this.selectAbove
        event.stopPropagation
      :down
        this.selectBelow
        event.stopPropagation
      :esc
        this.setState $ {} (:showMenu false)
        event.stopPropagation
    return undefined

  :onFocus $ \ (event)
    this.setState $ {}
      :showMenu true

  :onMouseLeave $ \ (event)
    this.setState $ {}
      :showMenu false

  :onItemClick $ \ (key)
    this.setState $ {}
      :showMenu false
      :value :
      :memory :
    this.props.onSubmit key

  :onMouseEnter $ \ (event)
    event.target.select

  :renderItems $ \ ()
    ... (this.filterOptions)
      map $ \\ (pair index)
        var onClick $ \\ ()
          this.onItemClick $ pair.get 0
        var className $ classnames :complete-item
          {} $ :is-selected $ is index (- this.state.index 1)
        div ({} (:className className) (:onClick onClick) (:key (pair.get 0)))
          pair.get 0
      toArray

  :render $ \ ()
    div
      {} (:className :origami-complete)
        :onMouseEnter this.onMouseEnter
        :onMouseLeave this.onMouseLeave
      input $ {}
        :className :complete-text
        :value this.state.value
        :onChange this.onChange
        :onFocus this.onFocus
        :onKeyDown this.onKeyDown
        :placeholder this.props.placeholder
      cond this.state.showMenu
        div ({} (:className :complete-menu))
          this.renderItems
        , undefined

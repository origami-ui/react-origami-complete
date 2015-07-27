
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
    :value React.PropTypes.string.isRequired
    :onChange React.PropTypes.func.isRequired
    :onSubmit React.PropTypes.func.isRequired
    :placeholder React.PropTypes.string

  :getDefaultProps $ \ ()
    {} (:placeholder :Complete)

  :getInitialState $ \ ()
    {} (:index 0) (:showMenu false)

  :selectCurrent $ \ (data)
    this.props.onSubmit data

  :selectAbove $ \ (size)
    this.setState $ {}
      :index $ cond (> this.state.index 0)
        - this.state.index 1
        - size 1

  :selectBelow $ \ (size)
    this.setState $ {}
      :index $ cond (< this.state.index (- size 1))
        + this.state.index 1
        , 0

  :filterOptions $ \ ()
    ... this.props.options
      map $ \ (count key)
        Immutable.List $ [] key count
      filter $ \\ (pair)
        var key $ pair.get 0
        = key $ key.toLowerCase
        >= (key.indexOf this.props.value) 0
      toList
      sortBy $ \ (pair)
        pair.get 1

  :onChange $ \ (event)
    this.setState $ {}
      :showMenu true
      :index 0
    this.props.onChange event.target.value

  :onKeyDown $ \ (event)
    var items $ this.filterOptions
    switch (keycode event.keyCode)
      :enter
        var current $ items.get this.state.index
        this.selectCurrent current
        this.setState $ {} (:showMenu false)
      :up
        this.selectAbove items.size
        event.stopPropagation
      :down
        this.selectBelow items.size
        event.stopPropagation
    return undefined

  :onFocus $ \ (event)
    this.setState $ {}
      :showMenu true

  :onBlur $ \ (event)
    setTimeout
      \\ ()
        this.setState $ {}
          :showMenu false
      , 10

  :onItemClick $ \ (index)
    var items $ this.filterOptions
    var current $ items.get index
    this.selectCurrent current

  :renderItems $ \ ()
    ... (this.filterOptions)
      map $ \\ (pair index)
        var onClick $ \\ ()
          this.onItemClick index
        div
          {}
            :className $ classnames :complete-item
              {} $ :is-selected $ is index this.state.index
            :key (pair.get 0)
            :onClick onClick
          pair.get 0
      toArray

  :render $ \ ()
    div ({} (:className :origami-complete))
      input $ {}
        :className :complete-text
        :value this.props.value
        :onChange this.onChange
        :onFocus this.onFocus
        :onBlur this.onBlur
        :onKeyDown this.onKeyDown
        :placeholder this.props.placeholder
      cond this.state.showMenu
        div ({} (:className :complete-menu))
          this.renderItems
        , undefined

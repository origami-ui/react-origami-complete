
var
  React $ require :react
  Immutable $ require :immutable

var
  Complete $ React.createFactory $ require :./complete
  div $ React.createFactory :div

var
  options $ Immutable.fromJS $ {}
    :/usr/local/bin/cirru 1
    :/Users/chen/repo/Cumulo/termina 10
    :ls 10
    ":cd repo" 10

var pageComponent $ React.createClass $ {}
  :displayName :app-page

  :getInitialState $ \ ()
    {} (:placeholder ":Type Here")

  :onSubmit $ \ (data)
    this.setState $ {} (:placeholder data)

  :render $ \ ()
    div ({} (:className :app-page))
      Complete $ {}
        :options options
        :onSubmit this.onSubmit
        :placeholder this.state.placeholder

var Page $ React.createFactory pageComponent

React.render (Page) document.body

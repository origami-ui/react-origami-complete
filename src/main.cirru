
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
    {} (:text :)

  :onChange $ \ (text)
    this.setState $ {} (:text text)

  :onSubmit $ \ (data)
    this.setState $ {} (:text data)

  :render $ \ ()
    div ({} (:className :app-page))
      Complete $ {}
        :options options
        :value this.state.text
        :onChange this.onChange
        :onSubmit this.onSubmit
        :placeholder :Complete

var Page $ React.createFactory pageComponent

React.render (Page) document.body

module Main exposing (main)

import Browser
import Html exposing (Html, Attribute, input, div, text)
import Html.Events exposing (onInput)
import Html.Attributes exposing (..)

main =
  Browser.sandbox { init = init, update = update, view = view }

type Msg = Change String

type alias Model =
  {content: String}

init : Model
init = {content = ""}

update msg model =
  case msg of
    Change newContent ->
      {model | content = newContent}

view model =
  div []
    [ input [ placeholder "Text to reverse ", value model.content, onInput Change ] []
    , div [] [ text (String.reverse model.content) ]
    ]

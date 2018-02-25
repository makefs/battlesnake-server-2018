module Game.SnakeImages.Tails exposing (..)

import Svg.Styled as Svg exposing (..)
import Svg.Styled.Attributes as Attrs exposing (..)


getSnakeTail : String -> List (Attribute msg) -> List (Svg msg) -> Svg msg
getSnakeTail tailType =
    case tailType of
        "regular" ->
            regular

        _ ->
            regular


regular : List (Attribute msg) -> List (Svg msg) -> Svg msg
regular attrs children =
    g (attrs ++ [ viewBox "0 0 1 1", transform "scale(1.4)" ])
        (children
            ++ [ Svg.path
                    [ d "M 36,0 0,0 0,72 36,72 72,36 Z" ]
                    []
               ]
        )

module Game.SnakeImages.Heads exposing (..)

import Svg.Styled as Svg exposing (..)
import Svg.Styled.Attributes as Attrs exposing (..)


getSnakeHead : String -> List (Attribute msg) -> List (Svg msg) -> Svg msg
getSnakeHead headType =
    case headType of
        "bendr" ->
            bendr

        "dead" ->
            dead

        "fang" ->
            fang

        "regular" ->
            regular

        _ ->
            regular


bendr : List (Attribute msg) -> List (Svg msg) -> Svg msg
bendr attrs children =
    g (attrs ++ [ viewBox "0 0 1 1" ])
        (children
            ++ [ Svg.path
                    [ d "M25.91,21.49a3.65,3.65,0,0,1,.58.05,9.64,9.64,0,1,0,0,13.8,3.65,3.65,0,0,1-.58.05c-2.75,0-4.9-3.05-4.9-6.95S23.16,21.49,25.91,21.49Z" ]
                    []
               , Svg.path
                    [ d "M100,43.78v-8.7a35,35,0,0,0-35-35L0,0V100H65.6c18.49,0,33-10.34,34.23-28.5H92.59V43.78Zm-80.22-2.7A12.64,12.64,0,1,1,32.41,28.44,12.65,12.65,0,0,1,19.78,41.08ZM50,57.64A13.85,13.85,0,0,1,60.33,44.25V71A13.85,13.85,0,0,1,50,57.64ZM64.6,71.5V43.78h9.74V71.5Zm23.73,0H78.59V43.78h9.74Z" ]
                    []
               ]
        )


dead : List (Attribute msg) -> List (Svg msg) -> Svg msg
dead attrs children =
    g (attrs ++ [ viewBox "0 0 1 1" ])
        (children
            ++ [ Svg.polygon
                    [ fill "none"
                    , points "18.52 18.86 12.75 24.64 6.97 18.86 2.62 23.23 8.39 29 2.62 34.77 6.97 39.13 12.75 33.36 18.52 39.13 22.89 34.77 17.11 29 22.89 23.23 18.52 18.86"
                    ]
                    []
               , Svg.path
                    [ d "M100,.11,0,0V100H100L56,55.39,100,15.5ZM22.89,34.77l-4.36,4.36-5.77-5.77L7,39.14,2.61,34.77,8.39,29,2.61,23.23,7,18.86l5.77,5.77,5.77-5.77,4.36,4.36L17.11,29Z" ]
                    []
               ]
        )


fang : List (Attribute msg) -> List (Svg msg) -> Svg msg
fang attrs children =
    g (attrs ++ [ viewBox "0 0 1 1" ])
        (children
            ++ [ Svg.path
                    [ d "M92.11,43.77l-.34-1.42a26.91,26.91,0,0,0-9-14.32h0L93.45,21.7l1.15,4.82a18.28,18.28,0,0,1-.08,9.67Z" ]
                    []
               , Svg.path
                    [ d "M0,100H100L56,55.39,100,15.5V.11L0,0ZM21.78,28.55a9.26,9.26,0,1,1-9.26-9.26A9.26,9.26,0,0,1,21.78,28.55Z" ]
                    []
               ]
        )


pixel : List (Attribute msg) -> List (Svg msg) -> Svg msg
pixel attrs children =
    g (attrs ++ [ viewBox "0 0 1 1" ])
        (children
            ++ [ Svg.rect [ fill "none", x "5", y "20.33", width "15.4", height "15.4" ] []
               , Svg.polygon [ points "89.51 36.5 89.38 36.5 89.38 36.63 89.51 36.5" ] []
               , Svg.polygon [ points "78.85 47.12 78.76 47.12 78.76 47.2 78.85 47.12" ] []
               , Svg.path
                    [ d "M0,100l89.38.07V89.45l-.14-.14H78.76V78.9l-.21-.21H68.14V68.55l-10.62-.17V57.74H68.14V47.12H78.76V36.5H89.38V25.88H100V.11L0,0ZM5,20.33H20.4v15.4H5Z" ]
                    []
               ]
        )


regular : List (Attribute msg) -> List (Svg msg) -> Svg msg
regular attrs children =
    g (attrs ++ [ viewBox "0 0 1 1" ])
        (children
            ++ [ Svg.circle
                    [ fill "none", cx "12.52", cy "28.55", r "9.26" ]
                    []
               , Svg.path
                    [ d "M0,100H100L56,55.39,100,15.5V.11L0,0ZM12.52,19.29a9.26,9.26,0,1,1-9.26,9.26A9.26,9.26,0,0,1,12.52,19.29Z" ]
                    []
               ]
        )

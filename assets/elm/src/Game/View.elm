module Game.View exposing (..)

import Css exposing (..)
import Game.BoardView
import Game.Types exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr exposing (..)
import Html.Styled.Events exposing (..)
import Md exposing (..)
import Route exposing (..)
import Scale exposing (..)
import Theme exposing (..)
import Types exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ viewPort []
            [ div
                [ css
                    [ displayFlex
                    , flexDirection Css.column
                    , alignItems center
                    , flexGrow (int 2)
                    ]
                ]
                [ model.gameState
                    |> Maybe.map .board
                    |> Maybe.map Game.BoardView.view
                    |> Maybe.withDefault (text "")
                , column [ css [ flexGrow (int 0) ] ]
                    [ div [ css [ alignSelf center ] ] [ text (turn model) ]
                    , avControls []
                        [ btn
                            [ onClick (Push PrevStep)
                            , title "Previous turn (k)"
                            ]
                            [ mdSkipPrev ]
                        , btn
                            [ onClick (Push StopGame)
                            , title "Reset Game (q)"
                            ]
                            [ mdReplay ]
                        , playPause model
                        , btn
                            [ onClick (Push NextStep)
                            , title "Next turn (j)"
                            ]
                            [ mdSkipNext ]
                        ]
                    ]
                ]
            , sidebar model
            ]
        ]


board : Model -> Html msg
board { gameid } =
    container
        [ css
            [ position relative
            , margin ms0
            ]
        ]
        [ div [ id gameid ] []
        ]


sidebar : Model -> Html Msg
sidebar model =
    let
        sidebarLogo =
            div [ css [ marginBottom ms0 ] ]
                [ div []
                    [ img
                        [ src assets.logoLight
                        , css
                            [ Css.maxWidth (px 300)
                            , Css.display Css.block
                            , Css.marginLeft Css.auto
                            , Css.marginRight Css.auto
                            , Css.marginTop Css.zero
                            , Css.marginBottom Css.zero
                            ]
                        ]
                        []
                    , img
                        [ src assets.logoExpert
                        , css
                            [ Css.maxHeight (px 100)
                            , Css.display Css.block
                            , Css.marginLeft Css.auto
                            , Css.marginRight Css.auto
                            , Css.marginTop Css.zero
                            , Css.marginBottom ms2
                            ]
                        ]
                        []
                    ]
                ]

        content =
            case model.gameState of
                Nothing ->
                    text "loading..."

                Just { board } ->
                    container []
                        (List.concat
                            [ List.map (snake True) board.snakes
                            , List.map (snake False) board.deadSnakes
                            ]
                        )
    in
    column
        [ css
            [ padding ms1
            , Css.width theme.sidebarWidth
            , justifyContent spaceBetween
            , overflowWrap breakWord
            , sidebarTheme
            ]
        ]
        [ sidebarLogo
        , content
        , sidebarControls []
            [ a [ href <| editGamePath model.gameid ] [ text "Edit" ]
            , a [ href <| gamesPath ] [ text "Games" ]
            ]
        ]


snake : Bool -> Snake -> Html msg
snake alive snake =
    let
        -- _ = Debug.log "snake" snake
        healthbarWidth =
            if alive then
                toString snake.health ++ "%"
            else
                "0%"

        transition =
            Css.batch <|
                if alive then
                    []
                else
                    [ Css.property "transition-property" "width, background-color"
                    , Css.property "transition-duration" "1s"
                    , Css.property "transition-timing-function" "ease"
                    ]

        healthbarStyle =
            [ ( "background-color", snake.color )
            , ( "width", healthbarWidth )
            ]

        healthbar =
            div
                [ style healthbarStyle
                , css
                    [ Css.height (px 15)
                    , transition
                    ]
                ]
                []

        healthText =
            if alive then
                toString snake.health
            else
                "Dead"

        containerOpacity =
            if alive then
                1
            else
                0.5

        taunt =
            case snake.taunt of
                Nothing ->
                    ""

                Just val ->
                    val
    in
    div
        [ css
            [ marginBottom ms0
            , opacity (num containerOpacity)
            ]
        ]
        [ flag (avatar [ src snake.headUrl ] [])
            [ div
                [ css
                    [ displayFlex
                    , justifyContent spaceBetween
                    ]
                ]
                [ span [] [ text snake.name ]
                , span [] [ text healthText ]
                ]
            , healthbar
            ]
        , div
            [ css
                [ maxWidth theme.sidebarWidth
                , whiteSpace Css.noWrap
                , textOverflow ellipsis
                , overflow Css.hidden
                ]
            ]
            [ text taunt ]
        ]


playPause : Model -> Html Msg
playPause { gameState } =
    let
        gameEnded =
            btn [ title "Game ended", Attr.disabled True ] [ mdStop ]
    in
    case gameState of
        Nothing ->
            gameEnded

        Just { status } ->
            case status of
                Halted ->
                    gameEnded

                Suspended ->
                    btn
                        [ onClick (Push ResumeGame)
                        , title "Resume game (h)"
                        ]
                        [ mdPlayArrow ]

                Cont ->
                    btn
                        [ onClick (Push PauseGame)
                        , title "Pause game (l)"
                        ]
                        [ mdPause ]


column : List (Attribute msg) -> List (Html msg) -> Html msg
column =
    styled div
        [ displayFlex
        , flexDirection Css.column
        ]


row : List (Attribute msg) -> List (Html msg) -> Html msg
row =
    styled div
        [ displayFlex
        , flexDirection Css.row
        ]


viewPort : List (Attribute msg) -> List (Html msg) -> Html msg
viewPort =
    styled row [ Css.height (vh 100), Css.width (vw 100) ]


avControls : List (Attribute msg) -> List (Html msg) -> Html msg
avControls =
    styled div [ alignSelf center, flex Css.content, margin ms0 ]


sidebarControls : List (Attribute msg) -> List (Html msg) -> Html msg
sidebarControls =
    styled div
        [ displayFlex
        , justifyContent spaceAround
        ]


avatar : List (Attribute msg) -> List (Html msg) -> Html msg
avatar =
    styled img
        [ marginRight ms0
        , Css.width theme.sidebarPlayerHeight
        , Css.height theme.sidebarPlayerHeight
        ]


container : List (Attribute msg) -> List (Html msg) -> Html msg
container =
    styled div [ flex auto ]


btn : List (Attribute msg) -> List (Html msg) -> Html msg
btn =
    styled button
        [ border inherit
        , outline inherit
        , Css.property "-webkit-appearance" "none"
        , Css.property "-moz-appearance" "none"
        , backgroundColor inherit
        , color inherit
        , cursor pointer
        , Css.disabled
            [ backgroundColor inherit
            , color theme.buttonAccent
            ]
        , hover
            [ backgroundColor theme.buttonAccent ]
        ]


flag : Html msg -> List (Html msg) -> Html msg
flag img_ body =
    div
        [ css
            [ displayFlex
            , minHeight theme.sidebarPlayerHeight
            ]
        ]
        [ img_
        , container [] body
        ]


turn : Model -> String
turn { gameState } =
    case gameState of
        Just { board } ->
            toString board.turn

        Nothing ->
            ""

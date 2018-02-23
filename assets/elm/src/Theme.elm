module Theme exposing (..)

import Css exposing (..)

import Scale exposing (..)


assets : { logoExpert : String, logoLight : String }
assets =
    { logoExpert = "/images/bracket-expert.png"
    , logoLight = "/images/logo-light.png"
    }


pallet =
    { blue = hex "#99e1d9"
    , grey = hex "#5d576b"
    , lightgrey = hex "#e8e8e8"
    , pink = hex "#f7567c"
    , purple = hex "#5c2e8c"
    , yellow = hex "#fffae3"
    , white = hex "#fcfcfc"
    }


theme =
    { bgPrimary = pallet.purple
    , bgSecondary = pallet.white
    , buttonAccent = pallet.lightgrey
    , sidebarPlayerHeight = ms 3
    , sidebarWidth = (px 320)
    , tile = pallet.lightgrey
    , food = pallet.pink
    }


sidebarTheme : Style
sidebarTheme =
    batch
        [ backgroundColor theme.bgPrimary
        , color theme.bgSecondary
        ]

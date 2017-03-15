-- Copyright (c) 2016-present, Facebook, Inc.
-- All rights reserved.
--
-- This source code is licensed under the BSD-style license found in the
-- LICENSE file in the root directory of this source tree. An additional grant
-- of patent rights can be found in the PATENTS file in the same directory.


{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedStrings #-}

module Duckling.Duration.GA.Rules
  ( rules ) where

import Prelude
import Data.String

import Duckling.Dimensions.Types
import Duckling.Duration.Helpers
import Duckling.Number.Types (NumberData(..))
import qualified Duckling.Number.Types as TNumber
import qualified Duckling.TimeGrain.Types as TG
import Duckling.Types

ruleCoics :: Rule
ruleCoics = Rule
  { name = "coicís"
  , pattern =
    [ regex "coic(\x00ed|i)s(\x00ed|i|e)?"
    ]
  , prod = \_ -> Just . Token Duration $ duration TG.Day 14
  }

ruleLeathuair :: Rule
ruleLeathuair = Rule
  { name = "leathuair"
  , pattern =
    [ regex "leathuair(e|eanta)?"
    ]
  , prod = \_ -> Just . Token Duration $ duration TG.Minute 30
  }

ruleAonDurationAmhain :: Rule
ruleAonDurationAmhain = Rule
  { name = "aon X amhain"
  , pattern =
    [ isNumberWith TNumber.value (== 1)
    , dimension TimeGrain
    , isNumberWith TNumber.value (== 1)
    ]
  , prod = \tokens -> case tokens of
      (_:Token TimeGrain grain:_) -> Just . Token Duration $ duration grain 1
      _ -> Nothing
  }

ruleIntegerUnitofdurationInteger :: Rule
ruleIntegerUnitofdurationInteger = Rule
  { name = "<unit-integer> <unit-of-duration> <tens-integer>"
  , pattern =
    [ isNumberWith TNumber.value (< 10)
    , dimension TimeGrain
    , isNumberWith TNumber.value (`elem` [10, 20 .. 50])
    ]
  , prod = \tokens -> case tokens of
      (Token Numeral (NumberData {TNumber.value = v1}):
       Token TimeGrain grain:
       Token Numeral (NumberData {TNumber.value = v2}):
       _) -> Just . Token Duration . duration grain . floor $ v1 + v2
      _ -> Nothing
  }

rules :: [Rule]
rules =
  [ ruleCoics
  , ruleIntegerUnitofdurationInteger
  , ruleLeathuair
  , ruleAonDurationAmhain
  ]
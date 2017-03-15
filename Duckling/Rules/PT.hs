-- Copyright (c) 2016-present, Facebook, Inc.
-- All rights reserved.
--
-- This source code is licensed under the BSD-style license found in the
-- LICENSE file in the root directory of this source tree. An additional grant
-- of patent rights can be found in the PATENTS file in the same directory.


{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedStrings #-}

module Duckling.Rules.PT
  ( rules
  ) where

import Duckling.Dimensions.Types
import qualified Duckling.Distance.PT.Rules as Distance
import qualified Duckling.Finance.PT.Rules as Finance
import qualified Duckling.Number.PT.Rules as Number
import qualified Duckling.Ordinal.PT.Rules as Ordinal
import qualified Duckling.Quantity.PT.Rules as Quantity
import qualified Duckling.Temperature.PT.Rules as Temperature
import qualified Duckling.Time.PT.Rules as Time
import qualified Duckling.TimeGrain.PT.Rules as TimeGrain
import Duckling.Types
import qualified Duckling.Volume.PT.Rules as Volume

rules :: Some Dimension -> [Rule]
rules (This Distance) = Distance.rules
rules (This Duration) = []
rules (This Numeral) = Number.rules
rules (This Email) = []
rules (This Finance) = Finance.rules
rules (This Ordinal) = Ordinal.rules
rules (This PhoneNumber) = []
rules (This Quantity) = Quantity.rules
rules (This RegexMatch) = []
rules (This Temperature) = Temperature.rules
rules (This Time) = Time.rules
rules (This TimeGrain) = TimeGrain.rules
rules (This Url) = []
rules (This Volume) = Volume.rules
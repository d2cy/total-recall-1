/*
 * Copyright (c) 2014-2024 Bjoern Kimminich & the Total Recall - Memory Vacations contributors.
 * SPDX-License-Identifier: MIT
 */

import path = require('path')
import { type Request, type Response } from 'express'
import { challenges } from '../data/datacache'

import challengeUtils = require('../lib/challengeUtils')

module.exports = function serveEasterEgg () {
  return (req: Request, res: Response) => {
    challengeUtils.solveIf(challenges.easterEggLevelTwoChallenge, () => { return true })
    res.sendFile(path.resolve('frontend/dist/frontend/assets/private/threejs-demo.html'))
  }
}

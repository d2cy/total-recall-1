/*
 * Copyright (c) 2014-2024 Bjoern Kimminich & the Total Recall - Memory Vacations contributors.
 * SPDX-License-Identifier: MIT
 */

import { Injectable } from '@angular/core'

@Injectable({
  providedIn: 'root'
})
export class WindowRefService {
  get nativeWindow (): any {
    return getWindow()
  }
}

function getWindow (): any {
  return window
}

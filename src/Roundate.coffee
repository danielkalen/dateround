# **Roundate** provides rounding functions for JavaScript `Date` objects.
#
# Units
# -----
#
# `Roundate` methods accept the following strings for the `unit` parameter:
#
# * `millisecond`
# * `second`
# * `minute`
# * `hour`
# * `day`
# * `week`
# * `month`
# * `year`
#
# Week Calculations
# -----------------
#
# **Note - Monday is assumed to be the first day of the week.**

# Setup
# -----
Roundate = {}

# If CommonJS module, export Roundate.
if module? && module.exports
  module.exports = Roundate
# Otherwise attach Roundate to `this` (`window`).
else
  this['Roundate'] = Roundate

# Roundate.add
# ------------
#
# Add `value` `unit`s to `date`.
Roundate.add = (date, value, unit) ->
  date = new Date(date)
  switch unit
    when 'millisecond' then date.setUTCMilliseconds(date.getUTCMilliseconds() + value)
    when 'second'      then date.setUTCSeconds(     date.getUTCSeconds()      + value)
    when 'minute'      then date.setUTCMinutes(     date.getUTCMinutes()      + value)
    when 'hour'        then date.setUTCHours(       date.getUTCHours()        + value)
    when 'day'         then date.setUTCDate(        date.getUTCDate()         + value)
    when 'week'        then date.setUTCDate(        date.getUTCDate()         + (value*7))
    when 'month'       then date.setUTCMonth(       date.getUTCMonth()        + value)
    when 'year'        then date.setUTCFullYear(    date.getUTCFullYear()     + value)
    else throw "Invalid unit #{unit}"
  date

# Roundate.subtract
# -----------------
#
# Subtract `value` `unit`s from `date`.
Roundate.subtract = (date, value, unit) ->
  Roundate.add(date, value * -1, unit)

# Roundate.floor
# --------------
#
# Returns the floor of `date` for the given time `unit`.
Roundate.floor = (date, unit) ->
  date = new Date(date)
  return date if unit == 'millisecond'
  date.setUTCMilliseconds(0)
  if unit != 'second'
    date.setUTCSeconds(0)
    if unit != 'minute'
      date.setUTCMinutes(0)
      if unit != 'hour'
        date.setUTCHours(0)
        if unit == 'week'
          dow = (date.getUTCDay() + 6) % 7
          date.setUTCDate(date.getUTCDate() - dow)
        else if unit != 'day'
          date.setUTCDate(1)
          if unit == 'year'
            date.setUTCMonth(0)
          else if unit != 'month'
            throw "Invalid unit #{unit}"
  date

# Roundate.ceiling
# ----------------
#
# Returns the ceiling of `date` for the given time `unit`.
Roundate.ceiling = (date, unit) ->

  # Calculate the `floor` of `date`.
  date = new Date(date)
  floor = Roundate.floor(date, unit)

  # If the `floor` is equivalent to the `date`, return the `date`.
  if date.getTime() == floor.getTime()
    date

  # Otherwise, add 1 `unit` and return that.
  else
    Roundate.add(floor, 1, unit)

# Roundate.round
# --------------
#
# Returns `date` rounded for the given time `unit`.
Roundate.round = (date, unit) ->

  # Calculate `ceiling`, `floor`, and the distance between them and `date`.
  date        = new Date(date)
  ceiling     = Roundate.ceiling(date, unit)
  floor       = Roundate.floor(date, unit)
  ceilingDiff = ceiling.getTime() - date.getTime()
  floorDiff   = date.getTime() - floor.getTime()
  
  # If the distance to the `ceiling` is greater than the distance to the `floor`, return the `floor`.
  if ceilingDiff > floorDiff
    floor

  # Otherwise, return the `ceiling`.
  else
    ceiling

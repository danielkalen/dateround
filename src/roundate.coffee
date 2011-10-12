# **Roundate** provides rounding functions for JavaScript `Date` objects.
#
# Notes
# -----
#
# ### Units
#
# The following strings can be used for the `unit` parameter:
#
# * millisecond | milliseconds
# * second | seconds
# * minute | minutes
# * hour | hours
# * day | days
# * week | weeks
# * month | months
# * year | years
#
# ### Week Calculations
#
# _Monday is assumed to be the first day of the week._

# Setup
# -----

# Create the global object.
Roundate = {}

# Add a method to singularize plural units.
singularize = (str) ->
  str.replace /s$/, ''

# Create an exception object for invalid units.
class UnitError extends Error
  constructor: (unit) ->
    @name    = "Roundate.UnitError"
    @message = "Unknown unit #{unit}"
    @stack   = (new Error()).stack

Roundate.UnitError = UnitError

# Roundate.add
# ------------
#
# Add `value` `unit`s to `date`.
Roundate.add = (date, value, unit) ->
  date = new Date(date)
  switch singularize(unit)
    when 'millisecond' then date.setUTCMilliseconds(date.getUTCMilliseconds() + value)
    when 'second'      then date.setUTCSeconds(     date.getUTCSeconds()      + value)
    when 'minute'      then date.setUTCMinutes(     date.getUTCMinutes()      + value)
    when 'hour'        then date.setUTCHours(       date.getUTCHours()        + value)
    when 'day'         then date.setUTCDate(        date.getUTCDate()         + value)
    when 'week'        then date.setUTCDate(        date.getUTCDate()         + (value*7))
    when 'month'       then date.setUTCMonth(       date.getUTCMonth()        + value)
    when 'year'        then date.setUTCFullYear(    date.getUTCFullYear()     + value)
    else throw new UnitError(unit)
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
  snit = singularize unit
  if snit != 'millisecond'
    date.setUTCMilliseconds(0)
    if snit != 'second'
      date.setUTCSeconds(0)
      if snit != 'minute'
        date.setUTCMinutes(0)
        if snit != 'hour'
          date.setUTCHours(0)
          if snit == 'week'
            dow = (date.getUTCDay() + 6) % 7
            date.setUTCDate(date.getUTCDate() - dow)
          else if snit != 'day'
            date.setUTCDate(1)
            if snit == 'year'
              date.setUTCMonth(0)
            else if snit != 'month'
              throw new UnitError(unit)
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

# Time Methods
# ------------

# Create a time method generator that returns the UNIX time
# instead of a `Date` object for a given function `f`.
timeMethod = (f) ->
  () -> f.apply(this, arguments).getTime()

# For each method in `Roundate`, create a *Time method equivalent.
for name, method of Roundate
  Roundate["#{name}Time"] = timeMethod(method)

# Exports
# -------

# If this is a CommonJS module, export `Roundate`.
if module? && module.exports
  module.exports = Roundate

# Otherwise attach `Roundate` to `window`.
else
  this['Roundate'] = Roundate

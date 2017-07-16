# **DateRound** provides rounding functions for JavaScript `Date` objects.
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
DateRound = {}

# Add a method to singularize plural units.
singularize = (str) ->
	str.replace /s$/, ''

# Create an exception object for invalid units.
class UnitError extends Error
	constructor: (unit) ->
		@name    = "DateRound.UnitError"
		@message = "Unknown unit #{unit}"
		@stack   = (new Error()).stack

DateRound.UnitError = UnitError

# DateRound.add
# ------------
#
# Add `value` `unit`s to `date`.
DateRound.add = (date, value, unit) ->
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

# DateRound.subtract
# -----------------
#
# Subtract `value` `unit`s from `date`.
DateRound.subtract = (date, value, unit) ->
	DateRound.add(date, value * -1, unit)

# DateRound.floor
# --------------
#
# Returns the floor of `date` for the given time `unit`.
DateRound.floor = (date, precision, unit) ->
	if not unit?
		unit = precision
		precision = 0
	
	unit = precision
	date = new Date(date)
	snit = singularize unit
	
	if snit isnt 'millisecond'
		date.setUTCMilliseconds(0)
		
		if snit isnt 'second'
			date.setUTCSeconds(0)
		
			if snit isnt 'minute'
				date.setUTCMinutes(0)
		
				if snit isnt 'hour'
					date.setUTCHours(0)
		
					if snit == 'week'
						dow = (date.getUTCDay() + 6) % 7
						date.setUTCDate(date.getUTCDate() - dow)
		
					else if snit isnt 'day'
						date.setUTCDate(1)
						if snit == 'year'
							date.setUTCMonth(0)
						
						else if snit isnt 'month'
							throw new UnitError(unit)
	date

# DateRound.ceil
# ----------------
#
# Returns the ceil of `date` for the given time `unit`.
DateRound.ceil = (date, precision, unit) ->

	# Calculate the `floor` of `date`.
	date = new Date(date)
	floor = DateRound.floor(date, unit)

	# If the `floor` is equivalent to the `date`, return the `date`.
	if date.getTime() == floor.getTime()
		date

	# Otherwise, add 1 `unit` and return that.
	else
		DateRound.add(floor, 1, unit)


# DateRound.round
# --------------
#
# Returns `date` rounded for the given time `unit`.
DateRound.round = (date, precision, unit) ->

	# Calculate `ceil`, `floor`, and the distance between them and `date`.
	date        = new Date(date)
	ceil     = DateRound.ceil(date, unit)
	floor       = DateRound.floor(date, unit)
	ceilDiff = ceil.getTime() - date.getTime()
	floorDiff   = date.getTime() - floor.getTime()
	
	# If the distance to the `ceil` is greater than the distance to the `floor`, return the `floor`.
	if ceilDiff > floorDiff
		floor

	# Otherwise, return the `ceil`.
	else
		ceil

# Time Methods
# ------------

# Create a time method generator that returns the UNIX time
# instead of a `Date` object for a given function `f`.
timeMethod = (f) ->
	() -> f.apply(this, arguments).getTime()

# For each method in `DateRound`, create a *Time method equivalent.
for name, method of DateRound
	DateRound["#{name}Time"] = timeMethod(method)

# Exports
# -------

module.exports = DateRound
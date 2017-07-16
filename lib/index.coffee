KEYS = ['Month', 'Date', 'Hours', 'Minutes', 'Seconds', 'Milliseconds']
MAX = [12, 31, 24, 60, 60, 1000]

calc = (date, target, precision=1, direction)->
	date = normalizeDate(date)
	target = target.toLowerCase()
	target = 'Date' if target.indexOf('day') isnt -1
	target = target[0].toUpperCase() + target.slice(1)
	target += 's' unless target[target.length-1] is 's' or target is 'Month' or target is 'Day' or target is 'Date'

	value = 0
	rounded = false
	subRatio = 1
	maxValue = undefined

	for key,index in KEYS
		if key is target
			value = date["get#{key}"]()
			maxValue = rounded = MAX[index]
			rounded = true

		else if rounded
			subRatio *= MAX[index]
			value += date["get#{key}"]() / subRatio
			date["set#{key}"](0)


	value = Math[direction](value / precision) * precision
	value = Math.min(value, maxValue)
	date["set#{target}"](value)
	return date


normalizeDate = (target)->
	if target instanceof Date
		return target

	if typeof target is 'number' or typeof target is 'string'
		return new Date(target)

	return new Date()


round = (date, target, precision)-> calc date, target, precision, 'round'
floor = (date, target, precision)-> calc date, target, precision, 'floor'
ceil = (date, target, precision)-> calc date, target, precision, 'ceil'


























exports = module.exports = round
exports.round = round
exports.floor = floor
exports.ceil = ceil
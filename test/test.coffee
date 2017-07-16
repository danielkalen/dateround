dateround = require '../'
assert = require('chai').assert
timeunits = require 'timeunits'
moment = require 'moment'
base = null
original = moment('2011-03-05 12:13:23').valueOf()
# diff = ('0'+(12 - original.getHours())).slice(-2)
# str = ()-> diff

describe "dateround", ()->
	beforeEach ()-> base = new Date original
	
	it "exposes .round, .floor, .ceil methods", ()->
		assert.equal typeof dateround, 'function'
		assert.equal Object.keys(dateround).length, 3
		assert.equal typeof dateround.round, 'function'
		assert.equal typeof dateround.floor, 'function'
		assert.equal typeof dateround.ceil, 'function'

	it "rounds by default", ()->
		assert.equal dateround(base.valueOf(), 'month').valueOf(), dateround.round(base.valueOf(), 'month').valueOf()

	
	describe "floor", ()->
		it "can floor to the nearest month", ()->
			result = dateround.floor(base, 'month')
			assert.equal result.valueOf(), moment('2011-03-01 00:00:00').valueOf()
		
		it "can floor to the nearest day", ()->
			result = dateround.floor(base, 'day')
			assert.equal result.valueOf(), moment('2011-03-05 00:00:00').valueOf()
		
		it "can floor to the nearest hour", ()->
			result = dateround.floor(base, 'hour')
			assert.equal result.valueOf(), moment('2011-03-05 12:00:00').valueOf()
		
		it "can floor to the nearest minute", ()->
			result = dateround.floor(base, 'minute')
			assert.equal result.valueOf(), moment('2011-03-05 12:13:00').valueOf()
		
		it "can floor to the nearest second", ()->
			result = dateround.floor(base, 'second')
			assert.equal result.valueOf(), moment('2011-03-05 12:13:23').valueOf()
		
		it "can floor to the nearest millisecond", ()->
			result = dateround.floor(base, 'millisecond')
			assert.equal result.valueOf(), moment('2011-03-05 12:13:23').valueOf()













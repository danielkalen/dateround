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

	it "accepts strings", ()->
		assert.equal dateround(base.valueOf(), 'hour').valueOf(), moment('2011-03-05 12:00:00').valueOf()

	it "accepts strings", ()->
		assert.equal dateround(base.toUTCString(), 'hour').valueOf(), moment('2011-03-05 12:00:00').valueOf()

	it "accepts date objects", ()->
		assert.equal dateround(base, 'hour').valueOf(), moment('2011-03-05 12:00:00').valueOf()

	
	describe "floor", ()->
		it "can floor to the nearest month", ()->
			result = dateround.floor(base, 'month')
			assert.equal result.toISOString(), moment('2011-03-01 00:00:00').toISOString()
		
		it "can floor to the nearest day", ()->
			result = dateround.floor(base, 'day')
			assert.equal result.toISOString(), moment('2011-03-05 00:00:00').toISOString()
		
		it "can floor to the nearest hour", ()->
			result = dateround.floor(base, 'hour')
			assert.equal result.toISOString(), moment('2011-03-05 12:00:00').toISOString()
		
		it "can floor to the nearest minute", ()->
			result = dateround.floor(base, 'minute')
			assert.equal result.toISOString(), moment('2011-03-05 12:13:00').toISOString()
		
		it "can floor to the nearest second", ()->
			result = dateround.floor(base, 'second')
			assert.equal result.toISOString(), moment('2011-03-05 12:13:23').toISOString()
		
		it "can floor to the nearest millisecond", ()->
			result = dateround.floor(base, 'millisecond')
			assert.equal result.toISOString(), moment('2011-03-05 12:13:23').toISOString()

	
	describe "ceil", ()->
		it "can ceil to the nearest month", ()->
			result = dateround.ceil(base, 'month')
			assert.equal result.toISOString(), moment('2011-04-01 00:00:00').toISOString()
		
		it "can ceil to the nearest day", ()->
			result = dateround.ceil(base, 'day')
			assert.equal result.toISOString(), moment('2011-03-06 00:00:00').toISOString()
		
		it "can ceil to the nearest hour", ()->
			result = dateround.ceil(base, 'hour')
			assert.equal result.toISOString(), moment('2011-03-05 13:00:00').toISOString()
		
		it "can ceil to the nearest minute", ()->
			result = dateround.ceil(base, 'minute')
			assert.equal result.toISOString(), moment('2011-03-05 12:14:00').toISOString()
		
		it "can ceil to the nearest second", ()->
			result = dateround.ceil(base, 'second')
			assert.equal result.toISOString(), moment('2011-03-05 12:13:23').toISOString()
		
		it "can ceil to the nearest millisecond", ()->
			result = dateround.ceil(base, 'millisecond')
			assert.equal result.toISOString(), moment('2011-03-05 12:13:23').toISOString()

	
	describe "round", ()->
		it "can round to the nearest month", ()->
			result = dateround.round(base, 'month')
			assert.equal result.toISOString(), moment('2011-03-01 00:00:00').toISOString()
		
		it "can round to the nearest day", ()->
			result = dateround.round(base, 'day')
			assert.equal result.toISOString(), moment('2011-03-06 00:00:00').toISOString()
		
		it "can round to the nearest hour", ()->
			result = dateround.round(base, 'hour')
			assert.equal result.toISOString(), moment('2011-03-05 12:00:00').toISOString()
		
		it "can round to the nearest minute", ()->
			result = dateround.round(base, 'minute')
			assert.equal result.toISOString(), moment('2011-03-05 12:13:00').toISOString()
		
		it "can round to the nearest second", ()->
			result = dateround.round(base, 'second')
			assert.equal result.toISOString(), moment('2011-03-05 12:13:23').toISOString()
		
		it "can round to the nearest millisecond", ()->
			result = dateround.round(base, 'millisecond')
			assert.equal result.toISOString(), moment('2011-03-05 12:13:23').toISOString()

	
	describe "precision", ()->
		it "for month", ()->
			base = moment('2011-06-01 00:00:00')._d
			result = dateround.floor(base, 'month', 1)
			assert.equal result.toISOString(), moment('2011-06-01 00:00:00').toISOString()
			result = dateround.floor(base, 'month', 1)
			assert.equal result.toISOString(), moment('2011-06-01 00:00:00').toISOString()
			result = dateround.floor(base, 'month', 3)
			assert.equal result.toISOString(), moment('2011-04-01 00:00:00').toISOString()
			result = dateround.floor(base, 'month', 2)
			assert.equal result.toISOString(), moment('2011-03-01 00:00:00').toISOString()
		
		it "for day", ()->
			result = dateround.round(base, 'day')
			assert.equal result.toISOString(), moment('2011-03-06 00:00:00').toISOString()
		
		it "for hour", ()->
			result = dateround.round(base, 'hour')
			assert.equal result.toISOString(), moment('2011-03-05 12:00:00').toISOString()
		
		it "for minute", ()->
			result = dateround.round(base, 'minute')
			assert.equal result.toISOString(), moment('2011-03-05 12:13:00').toISOString()
		
		it "for second", ()->
			result = dateround.round(base, 'second')
			assert.equal result.toISOString(), moment('2011-03-05 12:13:23').toISOString()
		
		it "for millisecond", ()->
			result = dateround.round(base, 'millisecond')
			assert.equal result.toISOString(), moment('2011-03-05 12:13:23').toISOString()













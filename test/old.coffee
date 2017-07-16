DateRound = require "../"
expect = require('chai').expect

describe 'DateRound', ->

  sampleDate = new Date('Sat, 05 Mar 2011 12:13:23 GMT')
  
  describe 'add', ->
    
    add = (date, value, unit) -> DateRound.add(date, value, unit).toUTCString()
  
    it 'should add 1 to the sample date', ->
      expect( add(sampleDate, 1, 'millisecond') ).to.equal( 'Sat, 05 Mar 2011 12:13:23 GMT' )
      expect( add(sampleDate, 1, 'second')      ).to.equal( 'Sat, 05 Mar 2011 12:13:24 GMT' )
      expect( add(sampleDate, 1, 'minute')      ).to.equal( 'Sat, 05 Mar 2011 12:14:23 GMT' )
      expect( add(sampleDate, 1, 'hour')        ).to.equal( 'Sat, 05 Mar 2011 13:13:23 GMT' )
      expect( add(sampleDate, 1, 'day')         ).to.equal( 'Sun, 06 Mar 2011 12:13:23 GMT' )
      expect( add(sampleDate, 1, 'week')        ).to.equal( 'Sat, 12 Mar 2011 12:13:23 GMT' )
      expect( add(sampleDate, 1, 'month')       ).to.equal( 'Tue, 05 Apr 2011 12:13:23 GMT' )
      expect( add(sampleDate, 1, 'year')        ).to.equal( 'Mon, 05 Mar 2012 12:13:23 GMT' )
    
    it 'should throw an exception when given an invalid unit', ->
      expect( -> add(sampleDate, 1, 'xyz') ).to.throw( "Unknown unit xyz" );
  
  describe 'subtract', ->
    
    subtract = (date, value, unit) -> DateRound.subtract(date, value, unit).toUTCString()
  
    it 'should subtract 1 from the sample date', ->
      expect( subtract(sampleDate, 1, 'millisecond') ).to.equal( 'Sat, 05 Mar 2011 12:13:22 GMT' )
      expect( subtract(sampleDate, 1, 'second')      ).to.equal( 'Sat, 05 Mar 2011 12:13:22 GMT' )
      expect( subtract(sampleDate, 1, 'minute')      ).to.equal( 'Sat, 05 Mar 2011 12:12:23 GMT' )
      expect( subtract(sampleDate, 1, 'hour')        ).to.equal( 'Sat, 05 Mar 2011 11:13:23 GMT' )
      expect( subtract(sampleDate, 1, 'day')         ).to.equal( 'Fri, 04 Mar 2011 12:13:23 GMT' )
      expect( subtract(sampleDate, 1, 'week')        ).to.equal( 'Sat, 26 Feb 2011 12:13:23 GMT' )
      expect( subtract(sampleDate, 1, 'month')       ).to.equal( 'Sat, 05 Feb 2011 12:13:23 GMT' )
      expect( subtract(sampleDate, 1, 'year')        ).to.equal( 'Fri, 05 Mar 2010 12:13:23 GMT' )
  
  describe 'floor', ->
  
    floor = (date, unit) -> DateRound.floor(date, unit).toUTCString()
  
    it 'should floor the sample date', ->
      expect( floor(sampleDate, 'millisecond') ).to.equal( 'Sat, 05 Mar 2011 12:13:23 GMT' )
      expect( floor(sampleDate, 'second')      ).to.equal( 'Sat, 05 Mar 2011 12:13:23 GMT' )
      expect( floor(sampleDate, 'minute')      ).to.equal( 'Sat, 05 Mar 2011 12:13:00 GMT' )
      expect( floor(sampleDate, 'hour')        ).to.equal( 'Sat, 05 Mar 2011 12:00:00 GMT' )
      expect( floor(sampleDate, 'day')         ).to.equal( 'Sat, 05 Mar 2011 00:00:00 GMT' )
      expect( floor(sampleDate, 'week')        ).to.equal( 'Mon, 28 Feb 2011 00:00:00 GMT' )
      expect( floor(sampleDate, 'month')       ).to.equal( 'Tue, 01 Mar 2011 00:00:00 GMT' )
      expect( floor(sampleDate, 'year')        ).to.equal( 'Sat, 01 Jan 2011 00:00:00 GMT' )
  
    it 'should throw an exception when given an invalid unit', ->
      expect( -> floor(sampleDate, 'xyz') ).to.throw( "Unknown unit xyz" );

  describe 'ceil', ->
    
    ceil = (date, unit) -> DateRound.ceil(date, unit).toUTCString()
    
    it 'should ceil the sample date', ->
      expect( ceil(sampleDate, 'millisecond') ).to.equal( 'Sat, 05 Mar 2011 12:13:23 GMT' )
      expect( ceil(sampleDate, 'second')      ).to.equal( 'Sat, 05 Mar 2011 12:13:23 GMT' )
      expect( ceil(sampleDate, 'minute')      ).to.equal( 'Sat, 05 Mar 2011 12:14:00 GMT' )
      expect( ceil(sampleDate, 'hour')        ).to.equal( 'Sat, 05 Mar 2011 13:00:00 GMT' )
      expect( ceil(sampleDate, 'day')         ).to.equal( 'Sun, 06 Mar 2011 00:00:00 GMT' )
      expect( ceil(sampleDate, 'week')        ).to.equal( 'Mon, 07 Mar 2011 00:00:00 GMT' )
      expect( ceil(sampleDate, 'month')       ).to.equal( 'Fri, 01 Apr 2011 00:00:00 GMT' )
      expect( ceil(sampleDate, 'year')        ).to.equal( 'Sun, 01 Jan 2012 00:00:00 GMT' )
  
  describe 'round', ->
    
    round = (date, unit) -> DateRound.round(date, unit).toUTCString()

    it 'should round the sample date', ->
      expect( round(sampleDate, 'millisecond') ).to.equal( 'Sat, 05 Mar 2011 12:13:23 GMT' )
      expect( round(sampleDate, 'second')      ).to.equal( 'Sat, 05 Mar 2011 12:13:23 GMT' )
      expect( round(sampleDate, 'minute')      ).to.equal( 'Sat, 05 Mar 2011 12:13:00 GMT' )
      expect( round(sampleDate, 'hour')        ).to.equal( 'Sat, 05 Mar 2011 12:00:00 GMT' )
      expect( round(sampleDate, 'day')         ).to.equal( 'Sun, 06 Mar 2011 00:00:00 GMT' )
      expect( round(sampleDate, 'week')        ).to.equal( 'Mon, 07 Mar 2011 00:00:00 GMT' )
      expect( round(sampleDate, 'month')       ).to.equal( 'Tue, 01 Mar 2011 00:00:00 GMT' )
      expect( round(sampleDate, 'year')        ).to.equal( 'Sat, 01 Jan 2011 00:00:00 GMT' )

    it 'should accept plural units', ->
      expect( round(sampleDate, 'weeks')       ).to.equal( 'Mon, 07 Mar 2011 00:00:00 GMT' )
  
  describe '*time', ->
    
    sampleTime = sampleDate.getTime()
    
    it 'should be equivalent to the non-time methods', ->
      expect( DateRound.addTime(     sampleTime, 1, 'hour') ).to.equal( sampleTime + (3600*1000) )
      expect( DateRound.subtractTime(sampleTime, 1, 'hour') ).to.equal( sampleTime - (3600*1000) )
      expect( DateRound.floorTime(   sampleTime, 'hour')    ).to.equal( 1299326400000 )
      expect( DateRound.ceilTime( sampleTime, 'hour')    ).to.equal( 1299330000000 )
      expect( DateRound.roundTime(   sampleTime, 'hour')    ).to.equal( 1299326400000 )
      
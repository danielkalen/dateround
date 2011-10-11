Roundate = require '../lib/Roundate.js'

describe 'Roundate', ->

  sampleDate = 'Sat, 05 Mar 2011 12:13:23 GMT'
  
  describe 'add', ->
    
    add = (date, value, unit) -> Roundate.add(date, value, unit).toUTCString()
  
    it 'should add 1 to the sample date', ->
      expect( add(sampleDate, 1, 'millisecond') ).toEqual( 'Sat, 05 Mar 2011 12:13:23 GMT' )
      expect( add(sampleDate, 1, 'second')      ).toEqual( 'Sat, 05 Mar 2011 12:13:24 GMT' )
      expect( add(sampleDate, 1, 'minute')      ).toEqual( 'Sat, 05 Mar 2011 12:14:23 GMT' )
      expect( add(sampleDate, 1, 'hour')        ).toEqual( 'Sat, 05 Mar 2011 13:13:23 GMT' )
      expect( add(sampleDate, 1, 'day')         ).toEqual( 'Sun, 06 Mar 2011 12:13:23 GMT' )
      expect( add(sampleDate, 1, 'week')        ).toEqual( 'Sat, 12 Mar 2011 12:13:23 GMT' )
      expect( add(sampleDate, 1, 'month')       ).toEqual( 'Tue, 05 Apr 2011 12:13:23 GMT' )
      expect( add(sampleDate, 1, 'year')        ).toEqual( 'Mon, 05 Mar 2012 12:13:23 GMT' )
  
  describe 'subtract', ->
    
    subtract = (date, value, unit) -> Roundate.subtract(date, value, unit).toUTCString()
  
    it 'should subtract 1 from the sample date', ->
      expect( subtract(sampleDate, 1, 'millisecond') ).toEqual( 'Sat, 05 Mar 2011 12:13:22 GMT' )
      expect( subtract(sampleDate, 1, 'second')      ).toEqual( 'Sat, 05 Mar 2011 12:13:22 GMT' )
      expect( subtract(sampleDate, 1, 'minute')      ).toEqual( 'Sat, 05 Mar 2011 12:12:23 GMT' )
      expect( subtract(sampleDate, 1, 'hour')        ).toEqual( 'Sat, 05 Mar 2011 11:13:23 GMT' )
      expect( subtract(sampleDate, 1, 'day')         ).toEqual( 'Fri, 04 Mar 2011 12:13:23 GMT' )
      expect( subtract(sampleDate, 1, 'week')        ).toEqual( 'Sat, 26 Feb 2011 12:13:23 GMT' )
      expect( subtract(sampleDate, 1, 'month')       ).toEqual( 'Sat, 05 Feb 2011 12:13:23 GMT' )
      expect( subtract(sampleDate, 1, 'year')        ).toEqual( 'Fri, 05 Mar 2010 12:13:23 GMT' )
  
  describe 'floor', ->
  
    floor = (date, unit) -> Roundate.floor(date, unit).toUTCString()
  
    it 'should floor the sample date', ->
      expect( floor(sampleDate, 'millisecond') ).toEqual( 'Sat, 05 Mar 2011 12:13:23 GMT' )
      expect( floor(sampleDate, 'second')      ).toEqual( 'Sat, 05 Mar 2011 12:13:23 GMT' )
      expect( floor(sampleDate, 'minute')      ).toEqual( 'Sat, 05 Mar 2011 12:13:00 GMT' )
      expect( floor(sampleDate, 'hour')        ).toEqual( 'Sat, 05 Mar 2011 12:00:00 GMT' )
      expect( floor(sampleDate, 'day')         ).toEqual( 'Sat, 05 Mar 2011 00:00:00 GMT' )
      expect( floor(sampleDate, 'week')        ).toEqual( 'Mon, 28 Feb 2011 00:00:00 GMT' )
      expect( floor(sampleDate, 'month')       ).toEqual( 'Tue, 01 Mar 2011 00:00:00 GMT' )
      expect( floor(sampleDate, 'year')        ).toEqual( 'Sat, 01 Jan 2011 00:00:00 GMT' )
  
  describe 'ceiling', ->
    
    ceiling = (date, unit) -> Roundate.ceiling(date, unit).toUTCString()
    
    it 'should ceiling the sample date', ->
      expect( ceiling(sampleDate, 'millisecond') ).toEqual( 'Sat, 05 Mar 2011 12:13:23 GMT' )
      expect( ceiling(sampleDate, 'second')      ).toEqual( 'Sat, 05 Mar 2011 12:13:23 GMT' )
      expect( ceiling(sampleDate, 'minute')      ).toEqual( 'Sat, 05 Mar 2011 12:14:00 GMT' )
      expect( ceiling(sampleDate, 'hour')        ).toEqual( 'Sat, 05 Mar 2011 13:00:00 GMT' )
      expect( ceiling(sampleDate, 'day')         ).toEqual( 'Sun, 06 Mar 2011 00:00:00 GMT' )
      expect( ceiling(sampleDate, 'week')        ).toEqual( 'Mon, 07 Mar 2011 00:00:00 GMT' )
      expect( ceiling(sampleDate, 'month')       ).toEqual( 'Fri, 01 Apr 2011 00:00:00 GMT' )
      expect( ceiling(sampleDate, 'year')        ).toEqual( 'Sun, 01 Jan 2012 00:00:00 GMT' )
  
  describe 'round', ->
    
    round = (date, unit) -> Roundate.round(date, unit).toUTCString()

    it 'should round the sample date', ->
      expect( round(sampleDate, 'millisecond') ).toEqual( 'Sat, 05 Mar 2011 12:13:23 GMT' )
      expect( round(sampleDate, 'second')      ).toEqual( 'Sat, 05 Mar 2011 12:13:23 GMT' )
      expect( round(sampleDate, 'minute')      ).toEqual( 'Sat, 05 Mar 2011 12:13:00 GMT' )
      expect( round(sampleDate, 'hour')        ).toEqual( 'Sat, 05 Mar 2011 12:00:00 GMT' )
      expect( round(sampleDate, 'day')         ).toEqual( 'Sun, 06 Mar 2011 00:00:00 GMT' )
      expect( round(sampleDate, 'week')        ).toEqual( 'Mon, 07 Mar 2011 00:00:00 GMT' )
      expect( round(sampleDate, 'month')       ).toEqual( 'Tue, 01 Mar 2011 00:00:00 GMT' )
      expect( round(sampleDate, 'year')        ).toEqual( 'Sat, 01 Jan 2011 00:00:00 GMT' )

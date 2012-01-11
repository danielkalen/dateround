Roundate
========

**Roundate** provides rounding functions for JavaScript `Date` objects.

Example
-------

    Roundate = require('roundate');
    
    var date    = new Date('Sat, 05 Mar 2011 12:13:23 GMT'),
        rounded = Roundate.round(date, 'day');
    
    console.log( rounded.toUTCString() ); // "Sun, 06 Mar 2011 00:00:00 GMT"

Downloads and Documentation
---------------------------

- [roundate.js](http://patdeegan.github.com/roundate/roundate.js)
- [roundate.min.js](http://patdeegan.github.com/roundate/roundate.min.js)
- [Documentation](http://patdeegan.github.com/roundate/)

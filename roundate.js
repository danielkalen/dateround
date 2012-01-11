(function() {
  var Roundate, UnitError, method, name, singularize, timeMethod,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  Roundate = {};

  singularize = function(str) {
    return str.replace(/s$/, '');
  };

  UnitError = (function(_super) {

    __extends(UnitError, _super);

    function UnitError(unit) {
      this.name = "Roundate.UnitError";
      this.message = "Unknown unit " + unit;
      this.stack = (new Error()).stack;
    }

    return UnitError;

  })(Error);

  Roundate.UnitError = UnitError;

  Roundate.add = function(date, value, unit) {
    date = new Date(date);
    switch (singularize(unit)) {
      case 'millisecond':
        date.setUTCMilliseconds(date.getUTCMilliseconds() + value);
        break;
      case 'second':
        date.setUTCSeconds(date.getUTCSeconds() + value);
        break;
      case 'minute':
        date.setUTCMinutes(date.getUTCMinutes() + value);
        break;
      case 'hour':
        date.setUTCHours(date.getUTCHours() + value);
        break;
      case 'day':
        date.setUTCDate(date.getUTCDate() + value);
        break;
      case 'week':
        date.setUTCDate(date.getUTCDate() + (value * 7));
        break;
      case 'month':
        date.setUTCMonth(date.getUTCMonth() + value);
        break;
      case 'year':
        date.setUTCFullYear(date.getUTCFullYear() + value);
        break;
      default:
        throw new UnitError(unit);
    }
    return date;
  };

  Roundate.subtract = function(date, value, unit) {
    return Roundate.add(date, value * -1, unit);
  };

  Roundate.floor = function(date, unit) {
    var dow, snit;
    date = new Date(date);
    snit = singularize(unit);
    if (snit !== 'millisecond') {
      date.setUTCMilliseconds(0);
      if (snit !== 'second') {
        date.setUTCSeconds(0);
        if (snit !== 'minute') {
          date.setUTCMinutes(0);
          if (snit !== 'hour') {
            date.setUTCHours(0);
            if (snit === 'week') {
              dow = (date.getUTCDay() + 6) % 7;
              date.setUTCDate(date.getUTCDate() - dow);
            } else if (snit !== 'day') {
              date.setUTCDate(1);
              if (snit === 'year') {
                date.setUTCMonth(0);
              } else if (snit !== 'month') {
                throw new UnitError(unit);
              }
            }
          }
        }
      }
    }
    return date;
  };

  Roundate.ceiling = function(date, unit) {
    var floor;
    date = new Date(date);
    floor = Roundate.floor(date, unit);
    if (date.getTime() === floor.getTime()) {
      return date;
    } else {
      return Roundate.add(floor, 1, unit);
    }
  };

  Roundate.round = function(date, unit) {
    var ceiling, ceilingDiff, floor, floorDiff;
    date = new Date(date);
    ceiling = Roundate.ceiling(date, unit);
    floor = Roundate.floor(date, unit);
    ceilingDiff = ceiling.getTime() - date.getTime();
    floorDiff = date.getTime() - floor.getTime();
    if (ceilingDiff > floorDiff) {
      return floor;
    } else {
      return ceiling;
    }
  };

  timeMethod = function(f) {
    return function() {
      return f.apply(this, arguments).getTime();
    };
  };

  for (name in Roundate) {
    method = Roundate[name];
    Roundate["" + name + "Time"] = timeMethod(method);
  }

  if ((typeof module !== "undefined" && module !== null) && module.exports) {
    module.exports = Roundate;
  } else {
    this['Roundate'] = Roundate;
  }

}).call(this);

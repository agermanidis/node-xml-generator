(function() {
  var exports, tag, xml_to_string, _;
  var __slice = Array.prototype.slice, __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  _ = require('underscore');
  tag = __bind(function(name) {
    return function() {
      var args, body, env, nested, _i;
      args = 2 <= arguments.length ? __slice.call(arguments, 0, _i = arguments.length - 1) : (_i = 0, []), body = arguments[_i++];
      env = _.clone(this);
      env.result = [];
      if (_.isFunction(body)) {
        nested = true;
        body.apply(env, []);
      } else if (_.isString(body) || _.isNumber(body)) {
        nested = false;
        env.result = String(body);
      }
      return this.result.push({
        node_name: name,
        nested: nested,
        params: args[0] || [],
        body: env.result
      });
    };
  }, this);
  xml_to_string = function(children) {
    var body, child, children_xml, params;
    children_xml = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = children.length; _i < _len; _i++) {
        child = children[_i];
        params = _(child.params).map(function(value, name) {
          return "" + name + "=\"" + value + "\"";
        });
        params = params.length ? ' ' + params.join(' ') : '';
        if (child.nested) {
          body = xml_to_string(child.body);
        } else {
          body = child.body;
        }
        _results.push("<" + child.node_name + params + ">" + body + "</" + child.node_name + ">");
      }
      return _results;
    })();
    return children_xml.join('');
  };
  exports = function() {
    var args, env, params, tag_name, _i, _len, _ref, _ref2;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    params = args[0];
    env = {
      result: [],
      partial: function() {
        var args, f, result;
        f = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        return result = f.apply(this, args);
      }
    };
    if (params.tags != null) {
      _ref = params.tags;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        tag_name = _ref[_i];
        env[tag_name] = tag(tag_name);
      }
    }
    if ((_ref2 = params.prolog) == null) {
      params.prolog = '';
    }
    return __bind(function(body) {
      body.apply(env, []);
      return params.prolog + xml_to_string(env.result);
    }, this);
  };
}).call(this);

(function() {
  var tag, xml_to_string, _;
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
  exports.generator = function() {
    var args, env, params, partial, tag_name, _i, _j, _len, _len2, _ref, _ref2, _ref3;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    params = args[0];
    if ((_ref = params.prolog) == null) {
      params.prolog = '';
    }
    env = {};
    if (params.tags != null) {
      _ref2 = params.tags;
      for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
        tag_name = _ref2[_i];
        env[tag_name] = tag(tag_name);
      }
    }
    if (params.partials != null) {
      _ref3 = params.partials;
      for (_j = 0, _len2 = _ref3.length; _j < _len2; _j++) {
        partial = _ref3[_j];
        env[partial] = partial;
      }
    }
    _(env).extend({
      result: [],
      partial: function() {
        var args, f, result;
        f = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        return result = f.apply(this, args);
      }
    });
    return __bind(function(body) {
      body.apply(env, []);
      return params.prolog + xml_to_string(env.result);
    }, this);
  };
}).call(this);

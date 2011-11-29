_ = require('underscore')

tag = (name) =>
  (args..., body) ->
    env = _.clone @
    env.result = []
    if _.isFunction(body)
      nested = true
      body.apply env, []
    else if _.isString(body) or _.isNumber(body)
      nested = false
      env.result = String(body)
    @result.push
      node_name: name
      nested: nested
      params: args[0] or []
      body: env.result

xml_to_string = (children) ->
  children_xml = for child in children
    params = _(child.params).map (value, name) -> "#{name}=\"#{value}\""
    params = if params.length then ' '+params.join(' ') else ''
    if child.nested
      body = xml_to_string child.body
    else
      body = child.body
    "<#{child.node_name}#{params}>#{body}</#{child.node_name}>"
  children_xml.join ''

exports = (args...) ->
  params = args[0]
  params.prolog ?= ''
  env =
    result: []
    partial: (f, args...) ->
      result = f.apply @, args
  if params.tags?
    for tag_name in params.tags
        env[tag_name] = tag tag_name
  (body) =>
    body.apply env, []
    params.prolog + xml_to_string env.result


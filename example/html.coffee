xml_generator = require 'xml-generator'

html5_tags = ['a', 'abbr', 'address', 'area', 'article', 'audio', 'b', 'base', 'bdo', 'blockquote', 'body', 'br', 'button', 'canvas', 'cite', 'code', 'col', 'colgroup', 'command', 'datagrid', 'datalist', 'dd', 'del', 'details', 'dfn', 'dialog', 'div', 'dl', 'dt', 'em', 'embed', 'fieldset', 'figure', 'footer', 'form', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'head', 'header', 'hgroup', 'hr', 'html', 'i', 'iframe', 'img', 'input', 'ins', 'kbd', 'keygen', 'label', 'li', 'link', 'map', 'mark', 'menu', 'meta', 'noscript', 'object', 'ol', 'optgroup', 'option', 'output', 'p', 'param', 'pre', 'progress', 'q', 'rp', 'rt', 's', 'samp', 'script', 'section', 'select', 'small', 'source', 'span', 'strong', 'style', 'sub', 'summary', 'sup', 'table', 'tbody', 'td', 'textarea', 'tfoot', 'th', 'thead', 'title', 'ul', 'var', 'video']

html_generator = xml_generator
  prolog: "<!DOCTYPE html>"
  tags: html5_tags

template = (js_files, body) ->
   html_generator ->
    @html ->
      @head ->
        for js_file in js_files
          @script type: "text/javascript", src: js_file
      @body ->
        @div id: "wrapper", ->
          @partial body

console.log template ['jquery.js'], ->
  @h1 "Hello world!"

exports = html_generator

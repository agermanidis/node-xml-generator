generate_xml = require 'xml-generator'

final_cut_tags = ['xmeml', 'project', 'bin', 'children', 'sequence', 'media', 'track', 'locked', 'outputchannelindex', 'link', 'linkclipref', 'clipindex', 'groupindex', 'uuid', 'updatebehavior', 'clip', 'updatebehavior', 'file', 'pathurl', 'mediaSource', 'anamorphic', 'alphatype', 'alphareverse', 'compositemode', 'masterclipid', 'ismasterclip', 'logginginfo', 'takenote', 'description', 'scene', 'shottake', 'lognote', 'good', 'scenenote', 'shotnote', 'takenote', 'labels', 'label', 'label2', 'comments', 'mastercomment1', 'mastercomment2', 'mastercomment3', 'mastercomment4', 'sourcetrack', 'start', 'end', 'subclipinfo', 'startoffset', 'endoffset', 'stillframe', 'stilloffset', 'syncoffset', 'multiclip', 'angle', 'activevideoangle', 'activeaudioangle', 'collapsed', 'synctype', 'mediadelay', 'defaultangle', 'subframeoffset', 'gamma', 'video', 'layerindex', 'audio', 'channelcount', 'trackcount', 'channeldescription', 'layout', 'audiochannel', 'channellabel', 'sourcechannel', 'outputs', 'group', 'index', 'numchannels', 'downmix', 'channel', 'format', 'samplecharacteristics', 'width', 'height', 'pixelaspectratio', 'fielddominance', 'colordepth', 'codec', 'depth', 'samplerate', 'name', 'duration', 'enabled', 'marker', 'comment', 'in', 'out', 'mediatype', 'trackindex', 'rate', 'timebase', 'ntsc', 'timecode', 'string', 'frame', 'displayformat', 'field', 'reel', 'source', 'generatoritem', 'transitionitem', 'alignment', 'filter', 'effectid', 'effectcategory', 'effecttype', 'effectclass', 'wipecode', 'startratio', 'endratio', 'reverse', 'privatestate', 'parameter', 'parameterid', 'valuemin', 'valuemax', 'valuelist', 'valueentry', 'keyframe', 'when', 'inscale', 'inbez', 'outscale', 'outbez', 'interpolation', 'appspecificdata', 'appname', 'appmanufacturer', 'appversion', 'data', 'fcpimageprocessing', 'useyuv', 'usesuperwhite', 'rendermode', 'qtcodec', 'codecname', 'codectypename', 'codectypecode', 'codecvendorcode', 'spatialquality', 'temporalquality', 'keyframerate', 'datarate', 'qteffectid', 'UUID', 'filmdata', 'filmslate', 'scene', 'take', 'camerroll', 'labroll', 'dailyroll', 'keycode', 'prefix', 'feetframes', 'reversed', 'inknumber', 'filmstandard', 'telecinespeed', 'metadata', 'storage', 'key', 'size', 'type', 'value', 'importoptions', 'createnewproject', 'targetprojectname', 'defsequencepresetname', 'filterreconnectmediafiles', 'import.', 'filterincludemarkers', 'filterincludeeffects', 'filterincludesequencesettings', 'displaynonfatalerrors']

final_cut_xml = generate_xml
  prolog: "<?xml version=\"1.0\" encoding=\"UTF-8\"?><!DOCTYPE xmeml>"
  tags: final_cut_tags

clip = (name, duration) ->
  @clip ->
    @name name
    @duration duration
    @rate ->
      @ntsc "TRUE"
      @timebase 30

console.log final_cut_xml ->
  @xmeml version: 3, ->
    @partial clip, "Clip #1", 188


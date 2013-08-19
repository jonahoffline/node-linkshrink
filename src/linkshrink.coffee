###
 linkshrink - A node module for shrinking URLs
 https://www.github.com/jonahoffline/node-linkshrink
 Copyright (c) 2013 Jonah Ruiz
 MIT Licence
###

request = require 'request'

class LinkShrink
  constructor: (api_key) ->
    @defaults()
    @api_key = api_key ? process.env.GOOGLE_URL_KEY
    @configureApi() if @api_key

  defaults: ->
    @params ?= {}
    @params.headers = 'content-type': 'application/json'
    @params.url = "https://www.googleapis.com/urlshortener/v1/url/"

  shrinkUrl: (longUrl) ->
    @params.body = JSON.stringify('longUrl': longUrl)
    @call (res) ->
      console.log(res)

  configureApi: ->
    @params.url += "?key=#{@api_key}"

  call: (callback) ->
    request.post(@params, (err, res, body) ->
      callback(body) unless err
    )

module.exports = LinkShrink

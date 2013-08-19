{LinkShrink} = require '../index'
expect = require('chai').expect

describe 'LinkShrink', ->
  it '#new', ->
    linkshrink = new LinkShrink('something')
    expect(linkshrink).to.have.property('api_key').to.equal 'something'

  it '#defaults', ->
    linkshrink = new LinkShrink
    expect(linkshrink).to.have.property('params').to.be.a('Object')
    expect(linkshrink).to.have.property('api_key').to.be.a('String')
    expect(linkshrink).to.have.property('api_key').to.not.be.empty

  describe '#shrinkUrl', ->
    linkshrink = new LinkShrink
    long_url = 'http://www.google.com'
    body_params = '{"longUrl":"http://www.google.com"}'

    it 'adds longUrl to the body request', ->
      linkshrink.shrinkUrl(long_url)
      expect(linkshrink).to.have.property('params').property('body').
      to.equal body_params

  describe '#configureApi', ->
    linkshrink = new LinkShrink('blahblah')
    api_url = 'https://www.googleapis.com/urlshortener/v1/url/'

    it 'overrides default api url', ->
      expect(linkshrink).to.have.property('params').property('url').
      to.equal "#{api_url}?key=blahblah"

  describe '#call', ->
    linkshrink = new LinkShrink
    long_url = 'http://www.google.com'
    res = {
    "kind": "urlshortener#url",
    "id": "http://goo.gl/rjHP",
    "longUrl": "http://www.google.com/"
    }

    it 'sends post request to API', ->
      res = linkshrink.shrinkUrl(long_url)
      expect(res).to.equal res


import httplib
import urllib


class IRCPost(object):
    headers = {"Content-type": "application/x-www-form-urlencoded", 
               "Accept": "text/plain"}

    def __init__(self, host, port, path, channel):
        self.host = host
        self.port = port
        self.path = path
        self.channel = channel

    def say(self, msg):
        http = httplib.HTTPConnection(self.host + ":" + str(self.port))
        params = urllib.urlencode({'channel': self.channel, "msg": msg})
        http.request("POST", "/" + self.path, params, IRCPost.headers)




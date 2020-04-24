require 'http'
require 'json'

#Test 1 created the class
#Test 2 def self.getContent
#Test 3 Return 
module ElevatorMedia
    class Streamer
        def initialize
        end

        def self.getContent
            uselessfact=HTTP.get("https://uselessfacts.jsph.pl/random.json?language=en").to_s
            obj = JSON.parse(uselessfact)['text']
            html = "<html><body><blockquote class='blockquote text-center'><h1> Here's your useless fact of the day: <br> <p> #{obj} </p></h1></blockquote></body></html>"
            puts html
            return html
        end
    end
end


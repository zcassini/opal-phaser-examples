require 'bundler'
Bundler.require

opal = Opal::Server.new {|s|
  s.append_path '.'
  s.append_path '../../assets'
  s.main = 'main'
}

map '/assets' do
  run opal.sprockets
end

get '/' do
  <<-HTML
    <!doctype html>
    <html>
      <head>
          <title>Move An Image</title>
          <script src="//cdn.jsdelivr.net/phaser/2.2.2/phaser.js"></script>
          <script src="/assets/main.js"></script>
      </head>
      <style>
      body {
      	background-color: #993333;
      }
      #logo {
          height: 120px;
          width: 120px;
          float: right;
      }
      #title {
          font-family: 'HelveticaBd', Helvetica, Arial;
          font-size: 55px;
          color: #ffffff;
          text-shadow: 0 0 15px blue;
          text-transform: capitalize;
      }
      #example {
          width: 800px;
          height: 600px;
          border-style: solid;
          border-color: gray;
          border-radius: 5px;
      }
      </style>
      <body>
        <script>
          window.onload = function() {
            Opal.Game.$new()
          }
        </script>
        <a href="https://github.com/orbitalimpact/opal-phaser-examples">
            <img id="logo" src="https://raw.githubusercontent.com/orbitalimpact/opal-phaser/master/common/images/logo.png"/>
        </a>
        <center>
            <span id="title">move an image</span>
            <div id="example"></div>
        </center>
      </body>
    </html>
  HTML
end

run Sinatra::Application

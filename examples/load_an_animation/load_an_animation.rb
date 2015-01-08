require 'opal'
require 'opal-phaser'

class LoadAnAnimation
    def initialize
        state = Phaser::State.new
        state.preload do |game|
            game.load.atlasJSONArray("bot", "assets/sprites/running_bot.png", "assets/sprites/running_bot.json")
        end

        state.create do |game|
            bot = game.add.sprite(200, 200, "bot")

            bot.animations.add("run")

            bot.animations.play("run", 15, true)
        end

        @phaser = Phaser::Game.new(800, 600, Phaser::AUTO, '', state)
    end
end

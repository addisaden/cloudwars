# encoding: utf-8

require "rainbow"

module Cloudwars
  module Prototype
    class Spieler
      def initialize(name)
        @name = name
      end
    end

    class Spielfeld
      def initialize
        # Setup Spielfeldbreite
        loop do
          print "Spielfeldbreite: (8-32) "
          @spielfeldbreite = gets.strip.to_i
          break if (8..32).include? @spielfeldbreite
          puts "Ihre Angabe liegt nicht zwischen 8 und 32"
        end

        @spielfeld = Array.new(@spielfeldbreite, Array.new(@spielfeldbreite, 0))

        # setup spieler
        print "Spieler 1: "
        @spieler_1 = { color: :green, move: 1 }
        @spieler_1[:name] = gets.strip
        @spieler_1[:name] = "Spieler 1" if @spieler_1[:name].empty?
        
        print "Spieler 2: "
        @spieler_2 = { color: :red, :move: -1 }
        @spieler_2[:name] = gets.strip
        @spieler_2[:name] = "Spieler 2" if @spieler_2[:name].empty? or @spieler_2[:name] == @spieler_1[:name]
      end
    end
  end
end

spielfeld = Array.new(8, Array.new(8, 0))

puts ("Hallo " + "Welt".bright).color(:green) + (" dies ist ein " + "Test".bright).color(:red)

Cloudwars::Prototype::Spielfeld.new

# encoding: utf-8

require "rainbow"

module Cloudwars
  module Prototype
    class Spieler
      attr_reader :name, :color, :towers, :move, :last_move
      def initialize(name, color, move)
        @name = name
        @color = color
        @towers = 0
        @move = move

        @last_move = nil
      end

      # return the playerinput
      def go(spielfeld, gegner)
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
        @towers = ((@spielfeldbreite**2)/2 + 1).to_i

        # setup spieler
        print "Spieler 1: "
        @spieler_1 = gets.strip
        @spieler_1 = "Spieler 1" if @spieler_1.empty?
        @spieler_1 = Spieler.new @spieler_1, :green, 1
        
        print "Spieler 2: "
        @spieler_2 = gets.strip
        @spieler_2 = "Spieler 2" if @spieler_2.empty? or @spieler_2 == @spieler_1.name
        @spieler_2 = Spieler.new @spieler_2, :red, -1
      end
    end
  end
end

spielfeld = Array.new(8, Array.new(8, 0))

puts ("Hallo " + "Welt".bright).color(:green) + (" dies ist ein " + "Test".bright).color(:red)

spiel = Cloudwars::Prototype::Spielfeld.new

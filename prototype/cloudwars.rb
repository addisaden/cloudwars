# encoding: utf-8

require "rainbow"

module Cloudwars
  module Prototype
    Spielfeldwahl = Struct.new(:x, :y)

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
        Spielfeldwahl.new(0,0)
      end
    end

    class Spielfeld
      def initialize
        puts
        puts "Willkommen zu ".bright.color(:blue) + 'Cloud '.bright.color(:green) + 'Wars'.bright.color(:red)
        puts

        # Setup Spielfeldbreite
        loop do
          print "Spielfeldbreite:" + " (8-32) ".color(:blue)
          @spielfeldbreite = gets.strip.to_i
          break if (8..32).include? @spielfeldbreite
          puts "Ihre Angabe liegt nicht zwischen 8 und 32"
        end

        @spielfeld = Array.new(@spielfeldbreite, Array.new(@spielfeldbreite, 0))
        @towers = ((@spielfeldbreite**2)/2 + 1).to_i
        @runde = 1

        # setup spieler
        print "Spieler 1: "
        @spieler_1 = gets.strip
        @spieler_1 = "Spieler 1" if @spieler_1.empty?
        @spieler_1 = Spieler.new @spieler_1, :green, 1
        
        print "Spieler 2: "
        @spieler_2 = gets.strip
        @spieler_2 = "Spieler 2" if @spieler_2.empty? or @spieler_2 == @spieler_1.name
        @spieler_2 = Spieler.new @spieler_2, :red, -1

        start_game
      end

      private
      def start_game
        player = nil
        # Hauptspiel-Loop
        loop do
          if player == nil then
            player = @spieler_1
          else
            player = other(player)
          end

          # Spieler-Loop
          loop do
            puts "Runde: " + @runde.to_i.to_s.bright
            player_move = player.go(@spielfeld, other(player))
            case
              when ! player_move.is_a?(Spielfeldwahl) then
                puts "SYSTEM: Der Spieler muss eine Spielfeldwahl treffen".bright.color(:red)
                next
              when ! (@spielfeld[player_move.y] && @spielfeld[player_move.y][player_move.x]) then
                puts "SYSTEM: Das gewählte Spielfeld liegt ausserhalb der gültigen Felder, bitte wäheln Sie ein anderes".bright.color(:red)
                next
              when ! (-3..3).include?(@spielfeld[player_move.y][player_move.x]) then
                puts "SYSTEM: Das Feld kann nicht verändert werden, bitte wählen Sie ein anderes.".bright.color(:red)
                next              
            end
            # set the new field for player.
            break
          end

          # Testwinner and add half round
          @runde += 0.5
          break
        end
      end

      def other(this)
        if this == @spieler_1 then
          @spieler_2
        else
          @spieler_1
        end
      end
    end
  end
end

# Cloudwars::Prototype::Spielfeld.new

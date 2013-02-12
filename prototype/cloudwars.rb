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

      def add_tower
        @towers += 1
      end

      # return the playerinput
      def go(spielfeld, gegner)
        print_spielfeld(spielfeld, gegner)

        # puts "--- X : SPALTE --- Y : ZEILE ---"
        print "#{ name.capitalize } ist am Zug (x y): ".color(color)
        x, y = *gets.split.collect { |n| n.to_i }
        return Spielfeldwahl.new(x,y)
      end

      def print_spielfeld(spielfeld, gegner)
        puts "#{ name } : #{ towers }".bright.color( color )
        puts "#{ gegner.name } : #{ gegner.towers }".color( gegner.color )
        puts

        print "  "
        spielfeld.count.times do |i|
          print i%10 == 0 ? "#{ (i / 10).to_i } " : '  '
        end
        puts

        print "  "
        spielfeld.count.times do |i|
          print "#{ i%10 } "
        end
        print "_X_"
        puts

        spielfeld.each_with_index do |zeile, index_y|
          print "%2s" % (index_y.to_s)
          zeile.each do |feld|
            if move * feld > 0 then
              print (feld.abs == 4 ? 'X' : feld.abs).to_s.bright.color( color )
            elsif gegner.move * feld > 0 then
              print (feld.abs == 4 ? 'X' : feld.abs).to_s.color( gegner.color )
            else
              print ' '
            end
            print ' '
          end
          puts
        end
        puts "_Y_"
        puts
      end
    end

    class Spielfeld
      def initialize
        puts
        puts "Willkommen zu ".bright.color(:blue) + 'Cloud '.bright.color(:green) + 'Wars'.bright.color(:red)
        puts

        # Setup Spielfeldbreite
        loop do
          print "Spielfeldbreite:" + " (4-32) ".color(:blue)
          @spielfeldbreite = gets.strip.to_i
          break if (4..32).include? @spielfeldbreite
          puts "Ihre Angabe liegt nicht zwischen 4 und 32"
        end

        @spielfeld = []
        @spielfeldbreite.times do
          @spielfeld << Array.new(@spielfeldbreite, 0)
        end
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
            puts
            puts "Runde: " + @runde.to_i.to_s.bright
            puts "Towers: #{ @towers }".bright.color(:blue)
            player_move = player.go(@spielfeld, other(player))
            case              
              when ! player_move.is_a?(Spielfeldwahl) then
                puts "SYSTEM: Der Spieler muss eine Spielfeldwahl treffen".bright.color(:red)
                next
              when player_move.x.nil? || player_move.y.nil? then
                puts "SYSTEM: Es wurde nur eine Zahl eingegeben"
                next
              when ! (@spielfeld[player_move.y] && @spielfeld[player_move.y][player_move.x]) then
                puts "SYSTEM: Das gewählte Spielfeld liegt ausserhalb der gültigen Felder, bitte wäheln Sie ein anderes".bright.color(:red)
                next
              when ! (-3..3).include?(@spielfeld[player_move.y][player_move.x]) then
                puts "SYSTEM: Das Feld kann nicht verändert werden, bitte wählen Sie ein anderes.".bright.color(:red)
                next              
            end

            # aliases
            px = player_move.x
            py = player_move.y

            # set the move for player
            [-1, 0, 1].each do |y|
              next if @spielfeld[y + py].nil? or y+py < 0
              [-1, 0, 1].each do |x|
                next if @spielfeld[y + py][x + px].nil? or x+px < 0

                # if the middle filed of the move do twice
                2.times do
                  # add one (direction == player.move = 1 / -1)
                  next unless (-3..3).include?( @spielfeld[y + py][x + px] )
                  @spielfeld[y + py][x + px] += player.move

                  # add a tower to the player
                  if @spielfeld[y + py][x + px] == 4 * player.move && @towers > 0 then
                    player.add_tower
                    @towers -= 1
                    break
                  end
                  break if y != 0 or x != 0
                end
              end
            end
            break
          end
          3.times { puts }

          # Testwinner and add half round
          if @towers > 0 && (@spieler_1.towers - @spieler_2.towers).abs <= @towers then
            @runde += 0.5
            next
          else
            break
          end
        end
        if @spieler_1.towers == @spieler_2.towers then
          puts "Es ist unentschieden.".bright.color(:blue)
          puts
          @spieler_1.print_spielfeld(@spielfeld, @spieler_2)
        elsif @spieler_1.towers > @spieler_2.towers then
          puts "#{ @spieler_1.name.capitalize } hat gewonnen.".color( @spieler_1.color )
          puts
          @spieler_1.print_spielfeld(@spielfeld, @spieler_2)
        elsif @spieler_2.towers > @spieler_1.towers then
          puts "#{ @spieler_2.name.capitalize } hat gewonnen.".color( @spieler_2.color )
          puts
          @spieler_2.print_spielfeld(@spielfeld, @spieler_1)
        else
          puts "Das Spiel ist Zuende."
          puts
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

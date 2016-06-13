#! usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require "console"
require "main_menu"
require "menu"

begin
    empty_board = ["-", "-", "-",
                   "-", "-", "-",
                   "-", "-", "-"]

    app = Qt::Application.new (ARGV)
    gui = MainMenu.new
    gui.show
    app.exec

    console = Console.new(STDIN, Kernel)
    menu = Menu.new(console)
    menu.start
end



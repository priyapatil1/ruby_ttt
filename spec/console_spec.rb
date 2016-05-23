require 'console_game'

describe ConsoleGame do
    let(:output) {StringIO.new("")}
    let(:input) {StringIO.new("")}
    let(:console) {Console.new(input, output)}

    it "gets a number from user" do
        console = Console.new(StringIO.new("3\n"), output)
        (expect(console.get_valid_input(8)).to eq 3)
    end

    it "shows a greeting message" do
        console = Console.new(StringIO.new(""), output)
        console.greeting_message
        (expect(output.string.chomp).to include ("Hi please choose a board size"))
    end

    it "gets a valid number from user" do
        console = Console.new(StringIO.new("a\n3\n"), output)
        console.get_valid_input(8)
        (expect(output.string.chomp).to include"Please enter a valid number:")
    end
end

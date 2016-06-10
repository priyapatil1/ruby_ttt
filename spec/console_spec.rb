require 'console_game'

describe ConsoleGame do
    let(:output) {StringIO.new("")}
    let(:input) {StringIO.new("")}
    let(:console) {Console.new(input, output)}

    it "gets a number from user" do
        console = Console.new(StringIO.new("3\n"), output)
        (expect(console.get_valid_input).to eq 3)
    end

    it "shows a greeting message" do
        console = Console.new(StringIO.new(""), output)
        console.greeting_message
        (expect(output.string.chomp).to include ("Tic Tac Toe"))
    end
end

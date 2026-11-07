import ArgumentParser

@main
struct ErrBodyApp: ParsableCommand {

    @Option(help: "Quest")
    public var quest: Int?

    @Option(help: "Part")
    public var part: Int?

    @Argument(help: "Specify the input")
    public var input: String

    mutating func run() throws {
        ErrbodyCodes.run(quest: quest, part: part, input: input)
    }
}

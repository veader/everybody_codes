import ArgumentParser

@main
struct ErrBodyApp: ParsableCommand {

    @Option(help: "Day")
    public var day: Int?

    @Option(help: "Part")
    public var part: Int?

    @Argument(help: "Specify the input")
    public var input: String

    mutating func run() throws {
        ErrbodyCodes.run(day: day, part: part, input: input)
    }
}

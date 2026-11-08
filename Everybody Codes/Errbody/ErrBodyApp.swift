import ArgumentParser

@main
struct ErrBodyApp: ParsableCommand {

    @Option(name: .shortAndLong, help: "Which quest should we tackle?")
    public var quest: Int?

    @Option(name: .shortAndLong, help: "Which part of the quest should we run? (Defaults to 1)")
    public var part: Int?

    @Flag(name: .shortAndLong, help: "Use stored sample data. (Defaults to false)")
    public var sampleData: Bool = false

    @Argument(help: "Specify the input")
    public var input: String

    mutating func run() throws {
        ErrbodyCodes.run(quest: quest ?? 0, part: part ?? 1, useSampleData: sampleData, input: input)
    }
}

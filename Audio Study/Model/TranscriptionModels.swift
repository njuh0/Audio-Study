import Foundation

// MARK: - WhisperKit Configuration Models

enum WhisperTaskType: String, CaseIterable {
    case transcribe = "transcribe"
    case translate = "translate"
    
    var displayName: String {
        switch self {
        case .transcribe:
            return "Transcribe"
        case .translate:
            return "Translate to English"
        }
    }
}

// MARK: - Transcription Entry Model
struct TranscriptionEntry: Codable, Identifiable {
    let id: UUID
    let date: String
    let transcription: String

    // Initialize with a Date object, which will be formatted to a string
    init(id: UUID = UUID(), date: Date, transcription: String) {
        self.id = id
        self.date = DateUtil.iso8601Formatter.string(from: date)
        self.transcription = transcription
    }

    // If you need to initialize from a pre-formatted date string (e.g., when decoding)
    // Codable will use this automatically if keys match.
    // If not, you might need custom init(from decoder: Decoder)
}

// MARK: - Date Utility
enum DateUtil {
    static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds] // Standard ISO8601 format
        return formatter
    }()

    static func getCurrentFormattedDate() -> String {
        return iso8601Formatter.string(from: Date())
    }
}

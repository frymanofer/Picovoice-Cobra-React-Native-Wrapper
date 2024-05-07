import ios_voice_processor
import Cobra
import Combine
import ExpoModulesCore

class CobraModel {

    private let ACCESS_KEY = "CgDGZHMYBX4fQSEOwGAZEAQDBTd9Zvlf/EJOuFdbie6FF3cA50K1kg=="

    private let ALPHA: Float = 0.5

    private var frameCount: Int = 0

    private var cobra: Cobra!
    private var isListening = false
    private var lastChange: Date = Date() // Initialize with the current date

    private var timer: Timer?

    @Published var errorMessage = ""
    @Published var recordToggleButtonText: String = "Start"
    @Published var voiceProbability: Float = 0.0
    @Published var THRESHOLD: Float = 0.8
    @Published var secondsBetweenCollection: Int = 60
    //@Published var detectedText = ""

    init() {
        // Delete all left over if any
        do {
            try VoiceProcessor.instance.stop()
        } catch {
            errorMessage = "\(error)"
        }
        VoiceProcessor.instance.clearFrameListeners()

        let frameListener = VoiceProcessorFrameListener { frame in
        }
        VoiceProcessor.instance.addFrameListener(frameListener)

        VoiceProcessor.instance.addErrorListener(VoiceProcessorErrorListener(errorCallback))
        VoiceProcessor.instance.addFrameListener(VoiceProcessorFrameListener(audioCallback))
        do {
            try cobra = Cobra(accessKey: ACCESS_KEY)

        } catch let error as CobraInvalidArgumentError {
            errorMessage = error.localizedDescription
        } catch is CobraActivationError {
            errorMessage = "ACCESS_KEY activation error."
        } catch is CobraActivationRefusedError {
            errorMessage = "ACCESS_KEY activation refused."
        } catch is CobraActivationLimitError {
            errorMessage = "ACCESS_KEY reached its limit."
        } catch is CobraActivationThrottledError {
            errorMessage = "ACCESS_KEY is throttled."
        } catch {
            errorMessage = "\(error)"
        }
    }

    deinit {
        stop()
        cobra.delete()
    }
/*
    public func toggleRecording() {
        if isListening {
            stop()
            recordToggleButtonText = "Start"
        } else {
            start(self.secondsBetweenCollection)
            recordToggleButtonText = "Stop"
        }
    }
*/
    public func start(_ intervalCollection: String) {

        if let interval = Int(intervalCollection) {
            self.secondsBetweenCollection = interval
        } else {
            // Handle the case where the string cannot be converted to an integer
            // For example, you might want to log an error or set a default value.
            print("Error: Unable to convert \(intervalCollection) to an integer.")
            // You could set a default value or handle the error in some other way.
        }

        guard !isListening else {
            return
        }
/*
        guard VoiceProcessor.hasRecordAudioPermission else {
            VoiceProcessor.requestRecordAudioPermission { isGranted in
                guard isGranted else {
                    return
                }
                self.start()
            }
            return
        }
        */

        do {
            try VoiceProcessor.instance.start(
                frameLength: Cobra.frameLength,
                sampleRate: Cobra.sampleRate)
            isListening = true
        } catch {
            self.errorMessage = "\(error)"
        }

    }

    public func stop() {
        guard isListening else {
            return
        }

        do {
            try VoiceProcessor.instance.stop()
            isListening = false
            self.voiceProbability = 0
            self.timer?.invalidate()
        } catch {
            self.errorMessage = "\(error)"
        }
    }
    private func setProbability(value: Float32) {
        if value >= self.voiceProbability {
            lastChange = Date() // Mark the time of change
            self.voiceProbability = (self.ALPHA * value) + ((1 - self.ALPHA) * self.voiceProbability)
        } else {
            if lastChange.addingTimeInterval(Double(self.secondsBetweenCollection)) < Date() {
                // Only update the probability if more than 1 second has passed.
                self.voiceProbability = (self.ALPHA * value) + ((1 - self.ALPHA) * self.voiceProbability)
                lastChange = Date() // Reset the last change time
            }
        }
    }

    public func getViocePropability() -> String
    {
        var newStr = NSString(format: "%.2f", self.voiceProbability) as String
        if self.voiceProbability >= self.THRESHOLD {
            newStr += " - Voice Detected!"
        }
        return newStr
    }

    private func audioCallback(frame: [Int16]) {
        do {
            let result: Float32 = try self.cobra!.process(pcm: frame)
//            DispatchQueue.main.async {
                self.setProbability(value: result)
//            }
        } catch {
//            DispatchQueue.main.async {
                self.errorMessage = "Failed to process pcm frames."
                self.stop()
 //           }
        }
    }

    private func errorCallback(error: VoiceProcessorError) {
        //DispatchQueue.main.async {
            self.errorMessage = "AAaaaaaaaaaaa" + "\(error.localizedDescription)"
        //}
    }
}

public class ExpoCobraModule: Module {
  public func definition() -> ModuleDefinition {
    Name("ExpoCobra")

    Function("setCobra") { (cobra: String) -> Void in
        if (firsttime == true) {
            firsttime = false
            myCobraModel = CobraModel()
            // for some reason simply calling - myCobraModel.start() returns error
            if let cobraModel = myCobraModel as? CobraModel {
                cobraModel.start(cobra)
            } else {
                // Handle the case where `object` cannot be converted to CobraModel
            }
        }
    }

    Function("stopCobra") { () -> Void in
        if let cobraModel = myCobraModel as? CobraModel {
            cobraModel.stop()
        } else {
        }
    }

    Function("getCobra") { () -> String in
        var cobraRet: String = "N/A"
            if let cobraModel = myCobraModel as? CobraModel {
                cobraRet = cobraModel.getViocePropability()
            } else {
                // Handle the case where `object` cannot be converted to CobraModel
            }
        return cobraRet
    }
  }
  private var firsttime = true
  private var myCobraModel: CobraModel?
}

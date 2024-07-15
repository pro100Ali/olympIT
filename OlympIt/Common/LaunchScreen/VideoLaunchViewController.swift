import UIKit
import AVFoundation

class VideoLaunchViewController: UIViewController {

    var callback: () -> () = {}
    
    func setupAVPlayer() {

        let videoURL = Bundle.main.url(forResource: "IMG_9325", withExtension: "MP4") // Get video url
        let avAssets = AVAsset(url: videoURL!) // Create assets to get duration of video.
        let avPlayer = AVPlayer(url: videoURL!) // Create avPlayer instance
        let avPlayerLayer = AVPlayerLayer(player: avPlayer) // Create avPlayerLayer instance
        avPlayerLayer.frame = self.view.bounds // Set bounds of avPlayerLayer
        self.view.layer.addSublayer(avPlayerLayer) // Add avPlayerLayer to view's layer.
        avPlayer.play() // Play video

        // Add observer for every second to check video completed or not,
        // If video play is completed then redirect to desire view controller.
        avPlayer.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1) , queue: .main) { [weak self] time in
            
        }
    }

    //------------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //------------------------------------------------------------------------------

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupAVPlayer()  // Call method to setup AVPlayer & AVPlayerLayer to play video
    }
}

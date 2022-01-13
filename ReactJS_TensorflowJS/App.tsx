import React,{useRef} from 'react';
import * as bodyPix from "@tensorflow-models/body-pix";
import Webcam from "react-webcam";
import './App.css';
// import partyBackground from "./background_photos/party-background.jpg";
import partyBackground from "./background_photos/party-background";

function App() {
  const VIDEOWIDTH = 640;
  const VIDEOHEIGHT = 480;

  const webcamRef = useRef<any>(null);
  const canvasRef = useRef<any>(null);
  const offCanvas = new OffscreenCanvas(VIDEOWIDTH, VIDEOHEIGHT);
  const offCtx = offCanvas.getContext('2d');
  let background = new Image();
  background.src = partyBackground;
  const DoSegment = async()=>{
    const net = await bodyPix.load()
    setInterval(async ()=>{
      
      if (typeof webcamRef.current != "undefined" &&
      webcamRef.current !== null ){


        const ctx = canvasRef.current.getContext('2d');
        const video = webcamRef.current.video;
        const videoWidth = video.videoWidth; 
        const videoHeight = video.videoHeight;

        if (canvasRef.current.width !== VIDEOWIDTH && canvasRef.current.height !== VIDEOHEIGHT){
          canvasRef.current.width = VIDEOWIDTH
          canvasRef.current.height = VIDEOHEIGHT
        }

        const segmentation = await net.segmentPerson(video);
        const foregroundColor = {r: 0, g: 0, b: 0, a: 255};
        const backgroundColor = {r: 0, g: 0, b: 0, a: 0};
        const personMasked = bodyPix.toMask(
            segmentation, foregroundColor, backgroundColor);
        
        ctx.clearRect(0,0, videoWidth, videoHeight)
        
        ctx.drawImage(background, 0, 0, videoWidth, videoHeight);

        if (offCtx !== null){
          const oldGCO = offCtx.globalCompositeOperation
          // Prepare the mask, blend with webcam video
          offCtx.clearRect(0, 0, videoWidth, videoHeight);
          offCtx.putImageData(personMasked, 0, 0);
          offCtx.globalCompositeOperation = 'source-in';
          offCtx.drawImage(video, 0, 0, videoWidth, videoHeight);
          offCtx.globalCompositeOperation = oldGCO;
        }
        // Copy video with mask on top of background
        ctx.drawImage(offCanvas, 0, 0);
        // requestAnimationFrame(DoSegment)
      }
    },100)
  }
  DoSegment();
  const videoConstraints = {
    width:VIDEOWIDTH,
    height:VIDEOHEIGHT,
    facingMode: "user"
  };
  return (
    <div className="App">
      <header className="App-header">
        <Webcam ref={webcamRef}
          style={{
            "position":"absolute",
            "marginLeft":"auto",
            "marginRight":"auto",
            "left":0,
            "right":0,
            "textAlign":"center",
            "zIndex":9,
            "width":"0%",
            "height":"0%"
          }}
          mirrored
          videoConstraints={videoConstraints}
        />
        <canvas ref={canvasRef}
          className='render-canvas'
          style={{
            "position": "absolute",
            "marginLeft":"auto",
            "marginRight":"auto",
            "left":0,
            "right":0,
            "textAlign":"center",
            "zIndex":9,
          }}
        />
      </header>
    </div>
  );
}

export default App;

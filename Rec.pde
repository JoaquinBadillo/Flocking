final String sketchname = getClass().getName();

import com.hamoid.*;
VideoExport videoExport;

void rec() {
  if (frameCount == 1) {
    videoExport = new VideoExport(this, "./"+sketchname+".mp4");
    videoExport.setFrameRate(80);  
    videoExport.startMovie();
  }
  videoExport.saveFrame();
  
  if (frameCount/80 == 30) {
    videoExport.endMovie();
    exit();
  }
}

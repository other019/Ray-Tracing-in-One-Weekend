import nimPNG
import colors
import strformat
proc convertPixels(pixels: seq[seq[Color]]): seq[uint8] =  
  #for i in countdown(pixels.low,pixels.high): #height
  for i in countdown(pixels.high,pixels.low): #height
    for j in pixels[i].low..pixels[i].high: #width
      result &= uint8(255*pixels[i][j].x);
      result &= uint8(255*pixels[i][j].y);
      result &= uint8(255*pixels[i][j].z);
proc writeImage*(name: string, pixels: seq[seq[Color]]): void =
  echo "starting image"
  let width = pixels[0].len
  let height = pixels.len
  let px = convertPixels(pixels)
  echo fmt"converted {px.len/3} pixels"
  let status = savePNG24(name,px,width,height)
  echo status

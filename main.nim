import strformat
import colors
#import vec3

const IMG_WIDTH = 256
const IMG_HEIGHT = 256
const COLOR_DEPTH = 255

proc main =
  let f = open("image.ppm",fmWrite)
  defer: f.close()

  f.write("P3\n")
  f.write(fmt"{IMG_WIDTH} {IMG_HEIGHT}{'\n'}{COLOR_DEPTH}{'\n'}")
  for j in countdown(IMG_HEIGHT-1,0):
    echo fmt"Scanlines remaining {j}...{'\n'}"
    for i in 0..(IMG_WIDTH-1):
      f.write(fmt"{color(i/(IMG_WIDTH-1),j/(IMG_HEIGHT-1),0.25) }{'\n'}")


main()

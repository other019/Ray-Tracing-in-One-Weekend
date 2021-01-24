import strformat

const IMG_WIDTH = 256
const IMG_HEIGHT = 256
const COLOR_DEPTH = 255

proc main =
  let f = open("image.ppm",fmWrite)
  defer: f.close()

  f.write("P3\n")
  f.write(fmt"{IMG_WIDTH} {IMG_HEIGHT}{'\n'}{COLOR_DEPTH}{'\n'}")
  for j in countdown(IMG_HEIGHT-1,0):
    for i in 0..(IMG_WIDTH-1):
      echo fmt"Scanlines remaining {j}...{'\n'}"
      let r = i / (IMG_WIDTH-1)
      let g = j / (IMG_HEIGHT-1)
      let b = 0.25

      let ir = int(COLOR_DEPTH*r)
      let ig = int(COLOR_DEPTH*g)
      let ib = int(COLOR_DEPTH*b)

      f.write(fmt"{ir} {ig} {ib}{'\n'}")


main()

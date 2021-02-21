import strformat
import colors
import vec3s
import rays
import points
import math
import image
proc hit_sphere(center: Point, radius: float, r: Ray): float =
  let oc: Vec3 = r.origin - center
  let a = r.dir.length_squared()
  let half_b = oc *. r.dir
  let c = oc.length_squared() - radius * radius
  let discriminant = half_b * half_b - a * c
  if discriminant < 0:
    return -1.0
  else:
    return (-half_b - math.sqrt(discriminant))/(a)
  

proc ray_color(r: Ray): Color = 
  var t = hit_sphere(point(0.0,0.0,-1.0),0.5,r)
  if t > 0.0:
    let N:Vec3 = !(r.at(t) - point(0,0,-1))
    return 0.5*color(N.x+1,N.y+1,N.z+1)
  let unit_direction: Vec3 = !r.dir
  t = 0.5*(unit_direction.y + 1.0)
  return (1.0 - t) * color(1.0,1.0, 1.0) + t * color(0.5,0.7,1.0)

const ASPECT_RATIO = 16.0 / 9.0
const IMG_WIDTH = 400
const IMG_HEIGHT = int(IMG_WIDTH/ASPECT_RATIO)
const COLOR_DEPTH = 255

const VIEWPORT_HEIGHT = 2.0
const VIEWPORT_WIDTH = ASPECT_RATIO * VIEWPORT_HEIGHT
const FOCAL_LENGTH = 1.0


proc main =
  let origin = point(0.0,0.0,0.0)
  let horizontal = vec3(VIEWPORT_WIDTH,0.0,0.0)
  let vertical = vec3(0.0,VIEWPORT_HEIGHT,0.0)
  let lower_left_corner = origin - horizontal/2 - vertical/2 - vec3(0.0,0.0,FOCAL_LENGTH)

  let f = open("image.ppm",fmWrite)
  defer: f.close()

  var pixels = newSeq[seq[Color]](IMG_HEIGHT)
  f.write("P3\n")
  f.write(fmt"{IMG_WIDTH} {IMG_HEIGHT}{'\n'}{COLOR_DEPTH}{'\n'}")
  for j in countdown(IMG_HEIGHT-1,0):
    pixels[j].newSeq(IMG_WIDTH)
    echo fmt"Scanlines remaining {j}...{'\n'}"
    for i in 0..(IMG_WIDTH-1):
      let u = float(i) / (IMG_WIDTH - 1)
      let v = float(j) / (IMG_HEIGHT - 1)
      let r: Ray = ray(origin, lower_left_corner + (u*horizontal) + (v*vertical) - origin)
      let c: Color = ray_color(r)
      pixels[j][i] = c
      f.write(fmt"{c}{'\n'}")

  writeImage("image.png",pixels)

main()

import strformat
import colors
import vec3s
import rays
import points
proc hit_sphere(center: Point, radius: float, r: Ray): bool =
  let oc: Vec3 = r.origin - center
  let a= r.dir *. r.dir
  let b= 2.0 * oc *. r.dir
  let c= oc *. oc - radius * radius
  let discriminant= b*b - 4*a*c
  return discriminant>0

proc ray_color(r: Ray): Color = 
  if(hit_sphere(point(0.0,0.0,-1.0),0.5,r)):
    return color(1.0,0.0,0.0)
  let unit_direction: Vec3 = !r.dir
  let t = 0.5*(unit_direction.y + 1.0)
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

  f.write("P3\n")
  f.write(fmt"{IMG_WIDTH} {IMG_HEIGHT}{'\n'}{COLOR_DEPTH}{'\n'}")
  for j in countdown(IMG_HEIGHT-1,0):
    echo fmt"Scanlines remaining {j}...{'\n'}"
    for i in 0..(IMG_WIDTH-1):
      let u = float(i) / (IMG_WIDTH - 1)
      let v = float(j) / (IMG_HEIGHT - 1)
      let r: Ray = ray(origin, lower_left_corner + (u*horizontal) + (v*vertical) - origin)
      let c: Color = ray_color(r)
      f.write(fmt"{c}{'\n'}")


main()

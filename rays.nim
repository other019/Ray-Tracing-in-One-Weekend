import points
import vec3s
type 
  Ray* = tuple
  [origin: Point, dir: Vec3]

proc ray*(origin: Point, dir: Vec3):Ray =
  result.origin = origin
  result.dir = dir
proc at*(r: Ray, t: float): Point =
  return r.origin + t*r.dir

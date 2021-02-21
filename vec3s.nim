import math
import strformat
type
  Vec3* = tuple
    [x,y,z: float]

proc vec3*(x,y,z: float): Vec3 =
  return (x,y,z)
proc `$`*(a: Vec3) =
  echo fmt"x:{a.x} y:{a.y} z:{a.z}"

proc `+`*(a: Vec3, b: Vec3): Vec3 =
  return (a.x + b.x, a.y + b.y, a.z + b.z )

proc `-`*(a: Vec3, b: Vec3): Vec3 =
  return (a.x - b.x, a.y - b.y, a.z - b.z )

proc `*`*(a: Vec3, b: float): Vec3 =
  return (a.x * b, a.y * b, a.z * b)

proc `*`*(a: float, b: Vec3): Vec3 =
  return b*a

proc `/`*(a: Vec3, b: float): Vec3 =
  return (1/b) * a

proc `*.`*(a: Vec3, b: Vec3): float = #dot product
  return a.x*b.x + a.y*b.y + a.z*b.z

proc `*+`*(a: Vec3, b: Vec3): Vec3 = #cross product
  return (a.y*b.z - a.z*b.y,
          a.z*b.x - a.x*b.z,
          a.x*b.y - a.y*b.x)

proc `||`*(a: Vec3): float = #length
  return math.sqrt(a.x*a.x + a.y*a.y + a.z*a.z)

proc `!`*(a: Vec3): Vec3 = # unit
  return a/(||a) 

proc length_squared*(a: Vec3): float =
  return ||a * ||a

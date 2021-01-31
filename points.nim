import vec3s
type 
  Point* {.borrow: `.`.} = distinct Vec3
proc point*(x,y,z: float): Point =
  result.x = x
  result.y = y
  result.z = z

proc `$`*(a: Point) {.borrow.}

proc `+`*(a: Point, b: Vec3): Point = 
  return Point(Vec3(a)+b)

proc `-`*(a: Point, b: Vec3): Point =
  return Point(Vec3(a)-b)
proc `-`*(a: Point, b: Point): Vec3 {.borrow.}

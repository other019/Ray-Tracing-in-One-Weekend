import vec3s
type 
  Point* {.borrow: `.`.} = distinct Vec3
proc point(x,y,z): Point =
  result.x = x
  result.y = y
  result.z = z

proc `$`*(a: Point) {.borrow.}

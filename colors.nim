import vec3s
import strformat
type
  Color* {.borrow: `.`.} = distinct Vec3

proc color*(x,y,z:float): Color =
  result.x = x
  result.y = y
  result.z = z

proc `$`*(a:Color): string =
  return fmt"{int(255*a.x)} {int(255*a.y)} {int(255*a.z)}{'\n'}"

proc `+`*(a: Color, b: Color): Color {.borrow.}
proc `*`*(a: Color, b: float): Color {.borrow.}
proc `*`*(a: float, b: Color): Color {.borrow.}


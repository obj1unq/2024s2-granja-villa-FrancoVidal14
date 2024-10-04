import hector.*
import wollok.game.*

class Maiz {
	var property baby = true
	var property position = null
	
	method serPlantada(_posicion) {
		position = _posicion
		game.addVisual(self)
	}
	
	method image() = "corn_" + if (baby) "baby.png" else "adult.png"
	
	method regado() {
		baby = false
	}
	
	method listoParaCosechar() = not baby
	
	method cosechar() {
		hector.agregarCultivoCosechado(self)
		game.removeVisual(self)
	}
	
	method precio() = 150
}

class Trigo {
	var property evolucion = 0
	var property position = null
	
	method serPlantada(_posicion) {
		position = _posicion
		game.addVisual(self)
	}
	
	method image() = ("wheat_" + evolucion) + ".png"
	
	method regado() {
		if (evolucion < 3) {
			evolucion += 1
		} else {
			evolucion = 0
		}
	}
	
	method listoParaCosechar() = evolucion >= 2
	
	method cosechar() {
		hector.agregarCultivoCosechado(self)
		game.removeVisual(self)
	}
	
	method precio() = (evolucion - 1) * 100
}

class Tomaco {
	var property position = null
	
	method serPlantada(_posicion) {
		position = _posicion
		game.addVisual(self)
	}
	
	method image() = "tomaco.png"
	
	method regado() {
		if (position.y() == (game.height() - 1)) {
			position = game.at(position.x(), 0)
		} else {
			position = position.up(1)
		}
	}
	
	method listoParaCosechar() = true
	
	method cosechar() {
		hector.agregarCultivoCosechado(self)
		game.removeVisual(self)
	}
	
	method precio() = 80
}
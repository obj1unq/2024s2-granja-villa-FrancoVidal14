import cultivos.*
import wollok.game.*
import posiciones.*
import granja.*


object hector {
	var   property position           = game.origin()
	const property image              = "player.png"
	const property cultivosCosechados = [] 
	var   property guita              = 0 
	
	//MOVIMIENTO
	
	method desplazar(direccion) {
		self.validarMover(direccion)
		position = direccion.siguiente(self.position())
	}

	method mover(direccion) {
		self.validarMover(direccion)
		self.desplazar(direccion)
	}

	//ACCIONES

	method cultivar(semilla){
		semilla.serPlantada(self.position())
		granja.agregarCultivoALaGranja(semilla)
	}

	method regar() {
	  self.validarRiego()
	  granja.regarCultivosAca(position) 
	}

	method cosechar() {
	  self.validarCosecha()
	  granja.cultivosCosechablesAca().forEach({cultivo => cultivo.cosechar()})
	}

	method vender() {
	  self.validarVenta()
	  self.venderTodo()	}

	method venderTodo(){
		guita = cultivosCosechados.sum({cultivo => cultivo.precio()})
		cultivosCosechados.clear()
	}

	//FUNCIONES

	method cantidadDeCultivosCosechados() {
		return cultivosCosechados.size()
	}

	method agregarCultivoCosechado(cultivo) {
	  cultivosCosechados.add(cultivo) 
	}

	// VALIDACIONES

	method validarRiego() {
		if (not (granja.hayPlantaAca())){
			self.error("No hay ninguna planta para regar aquí")
		}
	}
	method validarCosecha() {
		if (granja.cultivosCosechablesAca().isEmpty()){
			self.error("no tengo nada para cosechar")
		} 
	}

	method validarVenta() {
	  if (cultivosCosechados.isEmpty()){
		self.error("No hay nada para vender")
	  }
	}

	method validarMover(direccion) {
		const siguiente = direccion.siguiente(self.position())
		tablero.validarDentro(siguiente)
	}

}
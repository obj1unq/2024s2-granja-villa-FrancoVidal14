import hector.*
import wollok.game.*
object granja{
    const cultivosEnLaGranja = []

    method agregarCultivoALaGranja(cultivo) {
      cultivosEnLaGranja.add(cultivo)
    }

    method regarCultivosAca(poiscion) {
        self.cultivosAca().forEach({cultivo => cultivo.regado()})
    }


    method cultivosAca() {
	  return cultivosEnLaGranja.filter({cultivo => cultivo.position() == hector.position()})
	}

	method hayPlantaAca() {
	  return (cultivosEnLaGranja.any({cultivo => cultivo.position() == hector.position()}))
	}

	method cultivosCosechablesAca(){
		return self.cultivosAca().filter({cultivo => cultivo.listoParaCosechar()})
	} 
}
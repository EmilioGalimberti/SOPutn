#!/bin/bash

#Colores 
GREEN='\033[0;32m'
RED='\033[0;31m'
RESET='\033[0m'

#punto 8)
echo "${GREEN}Usuario que ejecuto el script: " >> log
who >> log
echo "" >> log
DIA=`date  "%d/%m/%Y"`
HORA=`date  "%H:%M"`
echo "${GREEN}Dia que se ejecuto $DIA y Hora: $HORA" >> log
echo "${GREEN}opciones que selecciono: \n" >> log


#FUNCIONES
#1),2),3)
agregarGrupo(){
	echo "${GREEN}Eligio la opcion $n"
	verificacion=$(verificaruser)
	if test 1 -eq $verificacion
	then
		sudo usermod -G $grupo $user
		echo "${GREEN} SE AGREGO EXITOSAMENTE $user como grupo secundario a $grupo"
	else
		echo "${RED} EL USUARIO QUE INGRESO NO EXISTE"
	fi
	sleep 2
	clear
}

verificaruser(){
	listusers=$(cat /etc/passwd | cut -d: -f1)
	verificacion=0
	for i in $listusers
	do	 
		if test "$i" = "$user"
		then
			verificacion=1
		fi
	done
	echo "$verificacion"
}

#4)
modificaratributo(){ 
       echo "${GREEN}Eligio la opcion $n"
       case $atributo in 
		1) echo "Eligio modifiar el directorio HOME del usuario"
		echo "Ingrese el nuevo directorio: " 
		read directorio
		usermod -d $directorio $user
		;;
		
		2) echo "Eligio modificar el valor ID del usuario"
		echo "Ingrese nuevo valor ID: "
		read valor
		usermod -u $valor $user
		;;
		
		3) echo "Eligio modificar la contraseña del usuario"
		echo "Ingrese nueva contraseña: "
		read contraseña
		usermod -p $contraseña $user
		;;
		
		esac
}

#5)
eliminaruser(){
	echo "${GREEN}Eligio la opcion $n"
	verificacion=$(verificaruser)
	if test 1 -eq $verificacion
	then
		sudo userdel $user
		echo "${GREEN} SE ELIMINO EXITOSAMENTE $user"
	else
		echo "${RED} EL USUARIO QUE INGRESO NO EXISTE"
	fi
	sleep 2
	clear
}

#6)
attruser(){
	echo "${GREEN}Eligio la opcion $n"
	verificacion=$(verificaruser)
	if test 1 -eq $verificacion
	then
		echo `grep $user /etc/passwd`
	else
		echo "${RED} EL USUARIO QUE INGRESO NO EXISTE"
	fi
	sleep 4
	clear
}

#7)
generaresumen(){
echo "Resumen de informacion"
	echo "A) Memoria principal total y libre: "		
		cat /proc/meminfo | head -2 
		cat /proc/meminfo | head -2 >> log
	echo "B) Cantidad de Usuarios existentes en el sistema: "
		cat /etc/passwd | wc -l
		cat /etc/passwd | wc -l >> log
	echo "C) Conexion a internet"
	echo "D) Espacio disponible en el disco"
		df
		df >> log
	echo "E) Rendimiento del sistema"
		ps -aux
		ps -aux >> log

}

#Menu de opciones
n=0
while test $n -ne 8
do
	echo "${RESET}1) Agregar usuario al grupo Facilitadores"
	echo "${RESET}2) Agregar un usuario al grupo Expositories"
	echo "${RESET}3) Agregar un usuario al grupo Directivos"
	echo "${RESET}4) Modificar algún atributo del usuario independientemente de su grupo."
	echo "${RESET}5) Eliminar un usuario independientemente de su grupo."
	echo "${RESET}6) Mostrar los atributos de un usuario."
	echo "${RESET}7) Generar resumen de funcionamiento del sistema."
	echo "${RED}8) SALIR"
	echo "${RESET}Ingrese una opcion: \n"
	read n
	clear
	if test 1 -eq $n
	then
		echo "${GREEN}El usuario ingreso la opcion $n " >> log
		echo "${RESET}Ingrese el nombre del usuario que desea agregar al grupo Facilitadores: \n"
		read user
		grupo="facilitadores"
		agregarGrupo $n $user $grupo
		
	fi
	if test 2 -eq $n
	then
		echo "${GREEN}El usuario ingreso la opcion $n " >> log
		echo "${RESET} Ingrese el nombre del usuario que desea agregar al grupo Expositores: \n"
		read user
		grupo="expositores"
		agregarGrupo $n $user $grupo
		
	fi
	if test 3 -eq $n
	then
		echo "${GREEN}El usuario ingreso la opcion $n" >> log
		echo "${RESET} Ingrese el nombre del usuario que desea agregar al grupo Directivos: \n"
		read user
		grupo="directivos"
		agregarGrupo $n $user $grupo
		
	fi
	if test 4 -eq $n
	then
		echo "${GREEN}El usuario ingreso la opcion $n " >> log
		echo "${RESET} Ingrese el nombre del usuario que desea modificar: \n"
		read user
		echo "${RESET} Ingrese el atributo a modificar: 
		1 - Modificar el directorio HOME del usuario
		2 - Modificar el valor ID del usuario
		3 - Modificar contraseña del usuario"
		read atributo
		
		modificaratributo $n $user $atributo
		
		
		
		
	fi
	if test 5 -eq $n
	then
		echo "${GREEN}El usuario ingreso la opcion $n " >> log
		echo "${RESET} Ingrese el nombre del usuario que desea Eliminar: \n"
		read user
		eliminaruser $n $user 
		
	fi
	if test 6 -eq $n

	then

		echo "${GREEN}El usuario ingreso la opcion $n " >> log

		echo "${RESET} Ingrese el nombre del usuario que desea saber sus atributos: \n"

		read user

		attruser $n $user 
	fi
	if test 7 -eq $n
	then
		echo "${GREEN}El usuario ingreso la opcion $n " >> log
		generaresumen
	fi
done

	

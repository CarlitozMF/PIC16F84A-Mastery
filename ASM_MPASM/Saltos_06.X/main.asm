;*************************************************************************************************
; PROYECTO: Saltos_06 - Introduccion a las comparaciones
; AUTOR: Carlos Mamani Flores (UTN-FRT)
; DESCRIPCIÓN: Lee RA<2:0> (los bits mas bajos), que fijan la salida en RB<7:0> (valor max 8bits)
;por ejemplo, si lee el dato "---00101"(cinco) en los diodos LED conectados al Puerto B 
;se iluminará el código "00011111", encendiéndose cinco diodos LED (D4, D3, D2, D1 y D0).
;Se utilizará la instrucción de rotación rlf.
;*************************************************************************************************

	LIST	P=16F84A
	INCLUDE	<P16F84A.INC>
	
	__CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF

;--- CAPA 1: MAPEO DE HARDWARE Y CONSTANTES ---

;Reservo un bloque de memoria RAM	
	    CBLOCK  0x0C		;Me posiciono en la direccion 0x0C de la RAM
	    VALOR_LEIDO			;Registro auxiliar donde voy a almacenar el valor de PORTA
	    CONTADOR			;Registro Auxiliar donde voy a guardar el valor de la constante
	    ENDC

ENTRADAS    EQU	 b'00000111'		;Mascara para habilitar PORTA como entrada
MASCARASW   EQU  b'00000111'		;Mascara de filtrado

	
	ORG	0x00
	goto	CONFIG_PERIF
	
	ORG	0x04
	RETFIE

;--- CAPA 2: CONFIGURACION DE PERIFERICOS
CONFIG_PERIF
	BSF	STATUS,RP0	;cargo 1 en RP0 para acceder al banco 1
	MOVLW	ENTRADAS	;Cargo la constante que define los pines de entrada en W
	MOVWF	TRISA		;Configuro los pines que van a ser entradas en PORTA
	CLRF	TRISB	    	;Configuro en 0 todos los pines de TRISB para salidas
	BCF	STATUS,RP0	;Cargo 0 en RP0 para retornar al banco 0
	
	CLRF	PORTB		;Aseguro salidas en 0 para iniciar

;--- CAPA 3: LOGICA DE APLICACION
MAIN
	MOVF	PORTA,W		;Leo los valores de entrada
	ANDLW	MASCARASW	;Filtro las entradas RA<4:0>
	MOVWF	CONTADOR	;Guardo estos valores en un registro auxiliar
	CLRF	PORTB		;Empiezo con la barra vacia
	MOVF	CONTADOR,F	;Testeo si el valor leido es cero
	BTFSC	STATUS,Z	;¿Es cero?
	goto	MAIN		;Si Z=1 retorna el main y no muestra leds encendidos
BUCLE	
	BCF	STATUS,C	;Por seguridad limpio el Carry
	BSF	STATUS,C	;Cargo 1 en el carry para empezar a rotar
	RLF	PORTB,F		;Rotando a la izquierda, el bit de carry entra por bit 0
	DECFSZ	CONTADOR,F	;Decrementa el contador, ¿Contador = 0?
	goto	BUCLE		;Retorna a BUCLE mientras contador != 0
	
	goto	MAIN		;Retorna a main cuando contador = 0
	
	END

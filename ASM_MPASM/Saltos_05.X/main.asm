;*************************************************************************************************
; PROYECTO: Saltos_05 - Introduccion a las comparaciones
; AUTOR: Carlos Mamani Flores (UTN-FRT)
; DESCRIPCIÓN: Lee RA<4:0>, se compara con un numero y se muestra el resultado en RB<7:0>.
;Si PORTA = Numero se encienden los leds LED_ON_1 (todos encendidos)
;Si PORTA > Numero se encienden los leds LED_ON_2 (pares encendidos impares apagados)
;Si PORTA < Numero se encienden los leds LED_ON_3 (Nibble alto encendido)
;*************************************************************************************************

	LIST	P=16F84A
	INCLUDE	<P16F84A.INC>
	
	__CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF

;--- CAPA 1: MAPEO DE HARDWARE Y CONSTANTES ---

;Reservo un bloque de memoria RAM	
	    CBLOCK  0x0C		;Me posiciono en la direccion 0x0C de la RAM
	    VALOR_LEIDO			;Registro auxiliar donde voy a almacenar el valor de PORTA
	    AUXILIAR			;Registro Auxiliar donde voy a guardar el valor de la constante
	    ENDC

NUMERO	    EQU	 .16			;numero a comparar entre 0 y 32
ENTRADAS    EQU	 b'00011111'		;Mascara para habilitar PORTA como entrada
MASCARASW   EQU  b'00011111'		;Mascara de filtrado
LED_ON_1    EQU	 b'11111111'		;Mascara para encender todos los leds (igual)
LED_ON_2    EQU	 b'01010101'		;Mascara para encender solo los pares (mayor)
LED_ON_3    EQU	 b'11110000'		;Mascara para encender el nibble alto (menor)
	
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
	MOVWF	VALOR_LEIDO	;Guardo estos valores en un registro auxiliar
	
;Comienza la comparacion	
	MOVLW	NUMERO		;Cargo en W el numero a comparar
	SUBWF	VALOR_LEIDO,W	;Ejecuto (W)=(VALOR_LEIDO)- (W)
	
; Lógica del Carry (C) y Zero (Z):
; Si VALOR_LEIDO = 16	 =>  Z=1 AND C=1
; Si VALOR_LEIDO > 16	 =>  Z=0 AND C=1
; Si VALOR_LEIDO < 16	 =>  Z=0 AND C=0
;--- Aqui se evalua Z ---
	BTFSC	STATUS,Z	;¿Z = 0?    Si Z=0, salta y evalua C
	goto	MODO_ELSE	;Si Z = 1, no salto y goto manda a modo else
;--- Aqui se evalua C ---
	BTFSS	STATUS,C	;¿C = 1? Si C=1 es mayor y salta a modo if
	goto	MODO_ELSE_IF	;Si C = 0, es menor y goto manda a modo else
;--- Bifurcaciones ---
MODO_IF				;Se ejecuta si es mayor
	MOVLW	LED_ON_2
	MOVWF	PORTB
	goto	MAIN
MODO_ELSE_IF			;Se ejecuta cuando es menor	
	MOVLW	LED_ON_3
	MOVWF	PORTB
	goto	MAIN
MODO_ELSE			;Se ejecuta si es igual
	MOVLW	LED_ON_1
	MOVWF	PORTB
	goto	MAIN
	
	END
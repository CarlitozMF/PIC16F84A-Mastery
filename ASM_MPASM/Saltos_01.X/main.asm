;*************************************************************************************************
; PROYECTO: Saltos_01 - Introduccion a los Saltos Condicionales
; AUTOR: Carlos Mamani Flores (UTN-FRT)
; DESCRIPCIÓN: Lee RA0 y se muestra el resultado en RB<7:0>.
;Si RA0 = 1 se encienden los leds LED_ON_1
;Si RA0 = 0 se encienden los leds LED_ON_2
;*************************************************************************************************

	LIST	P=16F84A
	INCLUDE	<P16F84A.INC>
	
	__CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF

;--- CAPA 1: MAPEO DE HARDWARE Y CONSTANTES ---
#DEFINE SW_ENTRADA  PORTA,0     ; Definicion para el pin RA0 como entrada

ENTRADA	    EQU	 b'00000001'		;Mascara para habilitar RA0 cono entrada
LED_ON_1    EQU	 b'01010101'		;Mascara para encender los leds cuando RA0=1
LED_ON_2    EQU	 b'10101010'		;Mascara para encender los leds cuando RA0=0
	
	ORG	0x00
	goto	CONFIG_PERIF
	
	ORG	0x04
	RETFIE

;--- CAPA 2: CONFIGURACION DE PERIFERICOS
CONFIG_PERIF
	BSF	STATUS,RP0	;cargo 1 en RP0 para acceder al banco 1
	MOVLW	ENTRADA		;Cargo la constante que define los pines de entrada en W
	MOVWF	TRISA		;Configuro los pines que van a ser entradas en PORTA
	CLRF	TRISB	    	;Configuro en 0 todos los pines de TRISB para salidas
	BCF	STATUS,RP0	;Cargo 0 en RP0 para retornar al banco 0
	
	CLRF	PORTB		;Aseguro salidas en 0 para iniciar
	CLRF	PORTA		;Aseguro cero en las entradas

;--- CAPA 3: LOGICA DE APLICACION
MAIN
	BTFSS   SW_ENTRADA	; ¿El switch está en 1? (Skip if Set)
	goto    MODO_ELSE	; Si es 0: Salta a MODO_NIBBLE
MODO_IF				; Si es 1: Ejecuta esto
	MOVLW   LED_ON_1
	MOVWF   PORTB
	goto    MAIN		; Vuelve al inicio para seguir testeando
MODO_ELSE		      
	MOVLW   LED_ON_2
	MOVWF   PORTB
	goto    MAIN		; Vuelve al inicio

	END
	

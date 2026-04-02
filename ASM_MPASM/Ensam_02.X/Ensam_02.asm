;*************************************************************************************************
; PROYECTO: Ensam_02 - Configuracion de Salida
; AUTOR: Carlos Mamani Flores (UTN-FRT)
; DESCRIPCIÓN: Se muestra el valor de una constante en RB<7:0>, el nibble bajo del Puerto B se apagarán
;y los del nibble alto se encenderán.
;*************************************************************************************************

	LIST	    P=16F84A
	INCLUDE	    <P16F84A.INC>
	
	__CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF

;--- CAPA 1: MAPEO DE HARDWARE Y CONSTANTES ---
CONSTANTE   EQU	    b'11110000'	    ;El nibble alto esta en 1 y el bajo en 0

	ORG	    0		    ;El programa comienza en la posicion 0 de la memoria de programa
	GOTO	    INICIO	    ;Salta la posicion de memoria del vector de interrupcion
	
	ORG	    04h		    ;Direccion de memoria del vector de interrupcion
	retfie			    ;Retorno de seguridad

;--- CAPA 2: CONFIGURACIÓN DE PERIFÉRICOS ---
INICIO	bsf	    STATUS,RP0	    ;Pongo en 1 el bit RP0 para acceder al banco 1
	clrf	    TRISB	    ;Pongo en 0 todo el registro TRISB para configurar RB<7:0> como
				    ;salidas
	bcf	    STATUS,RP0	    ;Pongo en 0 el bit RP0 para retornar al banco 0
	
	movlw	    CONSTANTE	    ;Cargo al registro de trabajo W con la constante
;--- CAPA 3: LÓGICA DE APLICACIÓN ---
MAIN
	movwf	    PORTB	    ;Muevo el contenido de W al Puerto B
	goto	    MAIN	    ;Retorno MAIN para crear un bucle cerradi e infinito
	
	END			    ;Fin del Programa
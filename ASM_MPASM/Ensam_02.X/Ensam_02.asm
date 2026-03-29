;********************************************Ensam_02.ASM********************************************
;Los diodos LED conectados al nibble bajo del Puerto B se apagarán y los del nibble alto se encenderán.
;
;ZONA DE DATOS***************************************************************************************

; CONFIG
	__CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF
	LIST	    P=16F84A
	INCLUDE	    <P16F84A.INC>

CONSTANTE   EQU	    b'11110000'

;ZONA DE CODIGO****************************************************************************************
;   ----    Vector de Reset ----
	ORG	    0		    ;El programa comienza en la posicion 0 de la memoria de programa
	GOTO	    INICIO	    ;Salta la posicion de memoria del vector de interrupcion
;   ----    Vector de Interrupcion  ----
	ORG	    04h		    ;Direccion de memoria del vector de interrupcion
	retfie			    ;Retorno de seguridad

;   ----    Inicio del Programa	----
INICIO	bsf	    STATUS,RP0	    ;Pongo en 1 el bit RP0 para acceder al banco 1
	clrf	    TRISB	    ;Pongo en 0 todo el registro TRISB para configurar RB<7:0> como
				    ;salidas
	bcf	    STATUS,RP0	    ;Pongo en 0 el bit RP0 para retornar al banco 0
	
	movlw	    CONSTANTE	    ;Cargo al registro de trabajo W con la constante
MAIN
	movwf	    PORTB	    ;Muevo el contenido de W al Puerto B
	goto	    MAIN	    ;Retorno MAIN para crear un bucle cerradi e infinito
	
	END			    ;Fin del Programa
;*************************************************************************************************
; PROYECTO: Ensam_03 - Configuracion de Entradas y Salidas
; AUTOR: Carlos Mamani Flores (UTN-FRT)
; DESCRIPCIÓN: Lee RA<4:0> y se muestra el resultado en RB<7:0>
;*************************************************************************************************

	LIST	    P=16F84A
	INCLUDE	    <P16F84A.INC>
	
	__CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF
	
;--- CAPA 1: MAPEO DE HARDWARE Y CONSTANTES ---
ENTRADAS   EQU	    b'00011111'	    ;Define los pines RA<4:0> como entradas

	ORG	    0		    ;El programa comienza en la posicion 0 de la memoria de programa
	GOTO	    INICIO	    ;Salta la posicion de memoria del vector de interrupcion

	ORG	    04h		    ;Direccion de memoria del vector de interrupcion
	retfie			    ;Retorno de seguridad
;--- CAPA 2: CONFIGURACIÓN DE PERIFÉRICOS ---
INICIO	bsf	    STATUS,RP0	    ;Con el bit RP0 en 1, accedo al banco 1
	clrf	    TRISB	    ;El puerto B se configura como salida
	movlw	    ENTRADAS	    ;Cargo la constante que define a los pines como entrada
	movwf	    TRISA	    ;Determino que los bits RA<4:0> son entradas
	bcf	    STATUS,RP0	    ;Con el bit RP0 en C, retorno al banco 0
;--- CAPA 3: LÓGICA DE APLICACIÓN ---
MAIN	
	movf	    PORTA,W	    ;Todo lo que leo en el Puerto A lo muevo al registro de trabajo W
	movwf	    PORTB	    ;Lo cargado en el registro W lo vuelvo en el Puerto B
	goto	    MAIN	    ;Se crea un blucle cerrado e infinito
	
	END			    ;Fin del Programa
;*************************************************************************************************
; PROYECTO: Ensam_01 - Configuracion de Salida
; AUTOR: Carlos Mamani Flores (UTN-FRT)
; DESCRIPCIÓN: Se muestra el valor de una constante en RB<7:0>
;*************************************************************************************************
	LIST	    P=16F84A		;Procesador utilizado
	INCLUDE    <P16F84A.INC>	;Etiquetes del PIC16f84A
	
	__CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_ON & _CP_OFF

;--- CAPA 1: MAPEO DE HARDWARE Y CONSTANTES ---
CONSTANTE   EQU	    b'01010101'

	ORG	    0			;El ptograma comienza en la direccion 0 de la memoria de programa
	goto	    Inicio		;Salta la posicion de memoria del vector de interrupcion

	ORG	    04h			;Direcciion de memoria del vector interrupcion
	retfie				;Retorna por seguridad
;--- CAPA 2: CONFIGURACIÓN DE PERIFÉRICOS ---
Inicio	bsf	    STATUS,RP0		;Pone en 1 el bit 5 (RP0) de STATUS. Accede al banco 1
	clrf	    TRISB		;Las lineas del puerto B se configuran como salida
	bcf	    STATUS,RP0		;Pone en 0 el bit 5 (RP0) de STATUS, Retorna al banco 0
	
	movlw	    CONSTANTE		;Carga el registro de trabajo w con el valor de la cte
;--- CAPA 3: LÓGICA DE APLICACIÓN ---
Principal
	movwf	    PORTB		;El contenido de W se deposita en el puerto de salida
	goto	    Principal		;Se crea un blucle cerrado e infinito
	
	END				;Fin del Programa
;**********************Ensam_01.ASM**********************
;Por los diodos LED conectados al puerto B se visualiza   
;el valor de una constante, por ejemplo el numero
;binario b'01010101'.-
;ZONA DE DATOS*******************************************
    
; CONFIG
	__CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_ON & _CP_OFF
 
	LIST	    P=16F84A		;Procesador utilizado
	INCLUDE    <P16F84A.INC>	;Etiquetes del PIC16f84A
CONSTANTE   EQU	    b'11111111'

;ZONA DE CODIGOS*****************************************
;   ----    Vector de Reset ----
	ORG	    0			;El ptograma comienza en la direccion 0 de la memoria de programa
	goto	    Inicio		;Salta la posicion de memoria del vector de interrupcion
;   ----    Vector de Intrrupcion   ----
	ORG	    04h			;Direcciion de memoria del vector interrupcio
	retfie				;Retorna por seguridad
;   ----    Programa Principal	----
Inicio	bsf	    STATUS,RP0		;Pone en 1 el bit 5 (RP0) de STATUS. Accede al banco 1
	clrf	    TRISB		;Las lineas del puerto B se configuran como salida
	bcf	    STATUS,RP0		;Pone en 0 el bit 5 (RP0) de STATUS, Retorna al banco 0
	
	movlw	    CONSTANTE		;Carga el registro de trabajo w con el valor de la cte
Principal
	movwf	    PORTB		;El contenido de W se deposita en el puerto de salida
	goto	    Principal		;Se crea un blucle cerrado e infinito
	
	END				;Fin del Programa
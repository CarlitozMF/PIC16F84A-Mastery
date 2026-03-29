;********************************************Ensam_02.ASM********************************************
;Por el Puerto B se obtiene el dato de las cinco líneas del Puerto A,al que está conectado un array 
;de interruptores. Por ejemplo, si por el Puerto A se introduce ?---11001?, por el Puerto B 
;aparecerá ?xxx11001? (no importa el valor de los tres bits más altos del Puerto B)
;
;ZONA DE DATOS***************************************************************************************
; CONFIG
	__CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF
 
	LIST	    P=16F84A
	INCLUDE	    <P16F84A.INC>
ENTRADAS    EQU	    b'00011111'	    ;Esta constante definira a los pines RA<4:0> como entradas
;ZONA DE CODIGO****************************************************************************************
;   ----    Vector de Reset ----
	ORG	    0		    ;El programa comienza en la posicion 0 de la memoria de programa
	GOTO	    INICIO	    ;Salta la posicion de memoria del vector de interrupcion
;   ----    Vector de Interrupcion  ----
	ORG	    04h		    ;Direccion de memoria del vector de interrupcion
	retfie			    ;Retorno de seguridad

;   ----    Inicio del Programa	----
INICIO	bsf	    STATUS,RP0	    ;Con el bit RP0 en 1, accedo al banco 1
	clrf	    TRISB	    ;El puerto B se configura como salida
	movlw	    ENTRADAS	    ;Cargo la constante que define a los pines como entrada
	movwf	    TRISA	    ;Determino que los bits RA<4:0> son entradas
	bcf	    STATUS,RP0	    ;Con el bit RP0 en C, retorno al banco 0
MAIN	
	movf	    PORTA,W	    ;Todo lo que leo en el Puerto A lo muevo al registro de trabajo W
	movwf	    PORTB	    ;Lo cargado en el registro W lo vuelvo en el Puerto B
	goto	    MAIN	    ;Se crea un blucle cerrado e infinito
	
	END			    ;Fin del Programa
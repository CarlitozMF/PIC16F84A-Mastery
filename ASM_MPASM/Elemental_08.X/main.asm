;*************************************************************************************************
; PROYECTO: Elemental_08 - Bit Shifting
; AUTOR: Carlos Mamani Flores (UTN-FRT)
; DESCRIPCIÓN: Lee RA<4:0>, se desplaza un bit a la derecha, por la izquierda entrará un ?0?
;y se muestra el resultado en RB<7:0> 
;*************************************************************************************************

    LIST      P=16F84A
    INCLUDE   <P16F84A.INC>

    __CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF

;--- CAPA 1: MAPEO DE HARDWARE Y CONSTANTES ---
    ENTRADAS    EQU     b'00011111'	; RA0-RA4 como entradas
    MASCARASW	EQU	b'00011111'	; Mascara para asegurar el uso de los 5 bits de entrada
    Temp	EQU	0x0C		;Registro Temporal en la direccion 0x0C
    ORG     0x00
    GOTO    INICIO

    ORG     0x04
    RETFIE                          ; Resguardo de interrupciones
;--- CAPA 2: CONFIGURACIÓN DE PERIFÉRICOS ---
INICIO
    BSF     STATUS, RP0             ; Acceso al Banco 1
    MOVLW   ENTRADAS
    MOVWF   TRISA                   ; Configuro Puerto A
    CLRF    TRISB                   ; Puerto B como salida completa
    BCF     STATUS, RP0             ; Regreso al Banco 0
    
    CLRF    PORTB                   ; Aseguro salidas en 0 al iniciar

;--- CAPA 3: LÓGICA DE APLICACIÓN ---
MAIN
    MOVF    PORTA,  W		    ;Guardo en W los datos de las entradas PORTA
    ANDLW   MASCARASW		    ;Mascara de filtro para los 5 bits de entrada
    MOVWF   Temp		    ;Muevo los datos de W en el registro auxiliar
    BCF	    STATUS, C		    ;Aseguro de que el Carry siempre ingrese en 0
    RRF	    Temp,   W		    ;Desplazo un bit a la derecha y almaceno en W
    MOVWF   PORTB		    ;Muevo los datos en W al PORTB
    goto    MAIN		    ;Crea un bucle cerrado e infinito
    
    END




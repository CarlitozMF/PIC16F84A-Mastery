;*************************************************************************************************
; PROYECTO: Elemental_09 - Introduccion a la mascara de bits
; AUTOR: Carlos Mamani Flores (UTN-FRT)
; DESCRIPCIÓN: Lee RA<4:0>y se muestra el resultado en RB<7:0>invirtiendo los
;bits pares. Los impares se dejan como en la entrada. 
;*************************************************************************************************

    LIST      P=16F84A
    INCLUDE   <P16F84A.INC>

    __CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF

;--- CAPA 1: MAPEO DE HARDWARE Y CONSTANTES ---
    ENTRADAS    EQU     b'00011111'	; RA0-RA4 como entradas
    MASCARASW	EQU	b'00011111'	; Mascara para asegurar el uso de los 5 bits de entrada
    MASCARA_XOR	EQU	b'01010101'	; Mascara de bits XOR

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
    MOVF    PORTA,W		    ;Guardo en W los datos de entrada de PORTA
    ANDLW   MASCARASW		    ;Mascara de filtro para los 5 bits de entrada
    XORLW   MASCARA_XOR		    ;Aplico la mascara XOR
    MOVWF   PORTB		    ;Vuelco los valores de W con mascara en el PORTB
    goto    MAIN		    ;Creo un bucle cerrado e infinito
    
    END


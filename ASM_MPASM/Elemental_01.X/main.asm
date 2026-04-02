;**************************************************************************************
; PROYECTO: Elemental_01 - Sumador de Puerto A + Constante
; AUTOR: Carlos Mamani Flores (UTN-FRT)
; DESCRIPCIÓN: Lee RA<4:0>, suma 74d y muestra el resultado en RB<7:0>
;**************************************************************************************

    LIST      P=16F84A
    INCLUDE   <P16F84A.INC>

    __CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF

;--- CAPA 1: MAPEO DE HARDWARE Y CONSTANTES ---
CONSTANTE   EQU     .74             ; Uso formato decimal (.74)
ENTRADAS    EQU     b'00011111'     ; RA0-RA4 como entradas

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
    
    CLRF    PORTB                   ; ROBUSTEZ: Aseguro salidas en 0 al iniciar

;--- CAPA 3: LÓGICA DE APLICACIÓN ---
MAIN
    MOVF    PORTA, W                ; Guardo en W los valores de los interruptores
    ADDLW   CONSTANTE               ; Sumo el valor fijo en W
    MOVWF   PORTB                   ; Vuelco el resultado sobre PORTB
    goto    MAIN		    ; Creo un bucle cerrado e infinito

    END
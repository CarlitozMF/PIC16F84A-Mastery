# 📑 Guía de Laboratorios: Ciclo MPASM (Classic)

Este directorio contiene el desarrollo práctico basado en la metodología del libro *"Microcontrolador PIC16F84. Desarrollo de proyectos"*. El enfoque principal es dominar el **Assembly de 8 bits** antes de la migración a entornos industriales.

---

## ⚙️ Teoría de Operación: El Núcleo de la Fase 1 y 2

Para abordar estos laboratorios, es fundamental comprender el flujo de datos interno del PIC16F84A. En Assembly, el éxito depende de la gestión de estos dos pilares:

* **El Registro de Trabajo (W):** Es el "obrero" único. Ninguna operación aritmética o de movimiento entre puertos puede saltarse este registro.
* **El Registro STATUS:** Actúa como el centro de control. Aquí gestionamos el bit **RP0** para el cambio de bancos (Configuración vs. Operación) y monitoreamos los bits **Z** (Zero) y **C** (Carry) para la lógica de decisión.

---

## 🏗️ Arquitectura de los Proyectos

Cada laboratorio se organiza de forma modular para facilitar la lectura del código fuente:

| Archivo | Contenido |
| :--- | :--- |
| `*.asm` | Código fuente principal comentado. |
| `*.hex` | Archivo binario listo para grabar en el microcontrolador. |
| `README.md` | Detalle técnico, Teoría de Operación y Mapeo de Hardware del lab. |

---

## 📌 Roadmap de Aprendizaje: El Camino del Guerrero

### 🟦 Fase 1: Fundamentos de I/O y Registros (Cap. 4 y 5)
*Objetivo: Dominar el direccionamiento de memoria y la configuración de puertos.*
- [x] **[Lab 01 (Ensam_01)](./Ensam_01.X/):** Visualización de constantes binarias en el Puerto B.
- [x] **[Lab 02 (Ensam_02)](./Ensam_02.X/)** Manipulación de *nibbles* y bits individuales.
- [x] **[Lab 03 (Ensam_03)](./Ensam_03.X/)** Lectura del Puerto A y reflejo en Puerto B.
> **Instrucciones clave:** `MOVLW`, `MOVWF`, `BSF`, `BCF`.

### 🟩 Fase 2: Lógica y Aritmética Elemental (Cap. 8)
*Objetivo: Entrenamiento intensivo en la Unidad Aritmético Lógica (ALU).*
- [x] **[Lab 04 (Elemental_01)](./Elemental_01.X/):** Suma de `PORTA` + 74d (Instrucción `ADDLW`).
- [x] **[Lab 05 (Elemental_02)](./Elemental_02.X/):** Multiplicación por 2 mediante suma propia (`ADDWF`).
- [x] **[Lab 06 (Elemental_03)](./Elemental_03.X/):** Máscaras lógicas **OR** (Fijar bits pares a "1" - `IORLW`).
- [x] **[Lab 07 (Elemental_04)](./Elemental_04.X/):** Máscaras lógicas **AND** (Fijar bits impares a "0" - `ANDLW`).
- [x] **[Lab 08 (Elemental_05)](./Elemental_05.X/):** Inversión de datos (Instrucción `COMF`).
- [x] **[Lab 09 (Elemental_06)](./Elemental_06.X/):** Intercambio de *nibbles* (Instrucción `SWAPF`).
- [x] **[Lab 10 (Elemental_07)](./Elemental_07.X/):** Desplazamiento lateral (`RLF`).
- [x] **[Lab 11 (Elemental_08)](./Elemental_08.X/):** Desplazamiento lateral (`RRF`).
- [x] **[Lab 12 (Elemental_09)](./Elemental_09.X/):** Inversión selectiva mediante **XOR** (`XORLW`).
- [x] **[Lab 13 (Elemental_10)](./Elemental_10.X/):** Modo bajo consumo (`SLEEP`).

### 🟨 Fase 3: Control de Flujo y Subrutinas (Cap. 9 y 10)
*Objetivo: Abstracción de funciones y gestión de tiempos.*
- [x] **[Lab 14 (Saltos_01)](./Saltos_01.X/):** Control de flujo mediante saltos condicionales y lógica de bifurcación (BTFSS-BTFCS/GOTO).
- [x] **[Lab 15 (Saltos_02)](./Saltos_02.X/):** Procesamiento de magnitudes y comparación de registros mediante operaciones en la ALU.
- [x] **[Lab 16 (Saltos_03)](./Saltos_03.X/):** Implementación de comparadores de magnitud (≥ y <) mediante la gestión de la bandera Carry (Borrow).
- [x] **[Lab 17 (Saltos_04)](./Saltos_04.X/):** Implementación de comparador Mayor Estricto (>) mediante lógica de cascada y evaluación jerárquica de banderas (Z y C).
- [x] **[Lab 18 (Saltos_05)](./Saltos_05.X/):** Clasificador de triple estado (=,>,<) mediante lógica jerárquica de banderas (Z y C) y bifurcación por descarte sucesivo.
- [x] **[Lab 19 (Saltos_06)](./Saltos_06.X/):** Conversor de magnitud a barra de progreso mediante algoritmos iterativos y manipulación dinámica de bits con la instrucción **RLF**.
> **Instrucciones clave:** `BTFSS`,`BTFCS`,`CALL`, `RETURN`, `DECFSZ`, `PCLATH`.

### 🟧 Fase 4: Periféricos y Eventos de Hardware (Cap. 11 a 13)
*Objetivo: Uso de módulos internos y gestión de interrupciones.*
- [ ] **Lab 07:** Configuración del **Timer0** y Prescaler.
- [ ] **Lab 08:** Contador de eventos externos (Pin `RA4/T0CKI`).
- [ ] **Lab 09:** Gestión de Interrupciones (Externa e interna).
- [ ] **Lab 10:** Operaciones con la memoria **EEPROM**.

---

## 🛠️ Herramientas Utilizadas
* **Compilador:** MPASM (v5.87 o superior).
* **Simulador:** MPLAB X Simulator / Proteus (Verificación Visual).
* **Hardware:** Entrenador PIC16F84A / Protoboard + PICkit 3.

---
🛠️ *Estudiante de Ing. Electrónica @UTN_FRT | Documentando el camino hacia los sistemas embebidos profesionales.*
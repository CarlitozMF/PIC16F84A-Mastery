# 📑 Guía de Laboratorios: Ciclo MPASM (Classic)

Este directorio contiene el desarrollo práctico basado en la metodología del libro *"Microcontrolador PIC16F84. Desarrollo de proyectos"*. El enfoque principal es dominar el **Assembly de 8 bits** antes de la migración a entornos industriales.

---

## ⚙️ Teoría de Operación: El Núcleo de la Fase 1 y 2

Para abordar estos laboratorios, es fundamental comprender el flujo de datos interno del PIC16F84A. En Assembly, el éxito depende de la gestión de estos dos pilares:

* **El Registro de Trabajo (W):** Es el "obrero" único. Ninguna operación aritmética o de movimiento entre puertos puede saltarse este registro.
* **El Registro STATUS:** Actúa como el centro de control. Aquí gestionamos el bit **RP0** para el cambio de bancos (Configuración vs. Operación) y monitoreamos los bits **Z** (Zero) y **C** (Carry) para la lógica de decisión.

---

## 🏗️ Arquitectura de los Proyectos

Cada laboratorio sigue estrictamente el modelo de **3 Capas** definido en la raíz del repositorio:
1.  **Capa 1:** Configuración de Fuses y TRIS.
2.  **Capa 2:** Subrutinas de cálculo y manipulación de bits.
3.  **Capa 3:** Bucle principal de control (`MAIN`).

---

## 📌 Roadmap de Aprendizaje: El Camino del Guerrero

### 🟦 Fase 1: Fundamentos de I/O y Registros (Cap. 4 y 5)
*Objetivo: Dominar el direccionamiento de memoria y la configuración de puertos.*
- [x] **Lab 01 (Ensam_01):** Visualización de constantes binarias en el Puerto B.
- [x] **Lab 02 (Ensam_02):** Manipulación de *nibbles* y bits individuales.
- [x] **Lab 03 (Ensam_03):** Lectura del Puerto A y reflejo en Puerto B.

### 🟩 Fase 2: Lógica y Aritmética Elemental (Cap. 8)
*Objetivo: Entrenamiento intensivo en la Unidad Aritmético Lógica (ALU).*
- [ ] **Elemental 01:** Suma de `PORTA` + 74d (Instrucción `ADDLW`).
- [ ] **Elemental 02:** Multiplicación por 2 mediante suma propia (`ADDWF`).
- [ ] **Elemental 03:** Máscaras lógicas **OR** (Fijar bits pares a "1" - `IORLW`).
- [ ] **Elemental 04:** Máscaras lógicas **AND** (Fijar bits impares a "0" - `ANDLW`).
- [ ] **Elemental 05:** Inversión de datos (Instrucción `COMF`).
- [ ] **Elemental 06:** Intercambio de *nibbles* (Instrucción `SWAPF`).
- [ ] **Elemental 07/08:** Desplazamientos laterales (`RLF` y `RRF`).
- [ ] **Elemental 09:** Inversión selectiva mediante **XOR** (`XORLW`).
- [ ] **Elemental 10:** Modo bajo consumo (`SLEEP`).

### 🟨 Fase 3: Control de Flujo y Subrutinas (Cap. 9 y 10)
*Objetivo: Abstracción de funciones y gestión de tiempos.*
- [ ] **Lab 04:** Implementación de retardos por software (Bucles anidados).
- [ ] **Lab 05:** Manejo de tablas de datos con `RETLW` (Binario a 7-Seg).
- [ ] **Lab 06:** Control de un Display LED mediante multiplexación.

### 🟧 Fase 4: Periféricos y Eventos de Hardware (Cap. 11 a 13)
*Objetivo: Uso de módulos internos y gestión de interrupciones.*
- [ ] **Lab 07:** Configuración del **Timer0** y Prescaler.
- [ ] **Lab 08:** Contador de eventos externos (Pin `RA4/T0CKI`).
- [ ] **Lab 09:** Gestión de Interrupciones (Externa e interna).
- [ ] **Lab 10:** Operaciones con la memoria **EEPROM**.

---

## 🛠️ Herramientas Utilizadas
* **Compilador:** MPASM (v5.87 o superior).
* **Simulador:** MPLAB X Simulator.
* **Hardware de Verificación:** Entrenador PIC16F84A / Protoboard + PICkit 3.

---
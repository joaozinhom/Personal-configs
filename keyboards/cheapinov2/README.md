# Cheapino V2 — Keymap (`cheapinov2_v2.vil`)

Keymap Vial para o **Cheapino V2** (split 3×5 + 3 teclas de polegar por metade, 1 tecla central e 1 encoder rotativo).

O ponto central deste keymap: **as layers estão duplicadas em dois blocos de SO**.

| Bloco | Layers | Uso |
|---|---|---|
| **macOS** (principal) | `0` `1` `2` `3` | É o bloco padrão, onde a máquina liga |
| **Linux** | `4` `5` `6` `7` | Bloco espelhado, ativado por toggle |

As layers `8`–`13` estão todas em `KC_TRNS` (não usadas).

### Trocar de SO

A tecla **central** (a do meio, sozinha entre as duas metades) é o interruptor:

- Em **macOS**: `Layer 0` → ela é `Media Play`. Para chegar ao toggle: `MO(1)` + `MO(2)` (combo) → entra na `Layer 3`, e aí a central é **`TG(4)`**.
- Em **Linux**: `Layer 4` → a central já é **`TG(4)`** direto, então um toque volta para macOS.

> Ou seja: sair do macOS exige o combo + tecla central; voltar do Linux é só a tecla central.

---

## Mapa físico e legenda

```
   ┌───┬───┬───┬───┬───┐              ┌───┬───┬───┬───┬───┐
   │ 1 │ 2 │ 3 │ 4 │ 5 │   (encoder)  │ 1 │ 2 │ 3 │ 4 │ 5 │
   ├───┼───┼───┼───┼───┤   ( central) ├───┼───┼───┼───┼───┤
   │ 1 │ 2 │ 3 │ 4 │ 5 │              │ 1 │ 2 │ 3 │ 4 │ 5 │
   ├───┼───┼───┼───┼───┤              ├───┼───┼───┼───┼───┤
   │ 1 │ 2 │ 3 │ 4 │ 5 │              │ 1 │ 2 │ 3 │ 4 │ 5 │
   └───┴───┴───┴───┴───┘              └───┴───┴───┴───┴───┘
            └── polegar L: [ext] [mid] [int]   polegar R: [int] [mid] [ext] ──┘
```

- `___` = tecla vazia (`KC_NO`)
- `▽` = transparente (`KC_TRNS`, herda da layer de baixo)
- `TD(n)` = tap dance · `MO(n)` = momentary layer · `TG(n)` = toggle layer · `Mn` = macro

---

# Bloco macOS

## Layer 0 — Base (macOS)

![Layer 0](layer%20pictures/layer0.png)

```
  Q     W     E     R     T   │   Y     U     I     O     P
  A     S     D     F     G   │   H     J     K     L     ;
  Z     X     C     V     B   │   N     M     ,     .     /

polegar L:  TD(0)  TD(2)  MO(1)   │   MO(2)  TD(1)  Bksp
central: Media Play      encoder: Vol + / Vol −
```

Layout **QWERTY** puro nas 30 teclas alfanuméricas. Toda a modificação vive nos polegares:

| Tecla | Tap | Hold |
|---|---|---|
| `TD(0)` polegar L externo | `Cmd+Space` (Spotlight) | `Cmd` |
| `TD(2)` polegar L médio | `Space` | `Alt/Option` |
| `MO(1)` polegar L interno | — | Layer 1 (números/setas) |
| `MO(2)` polegar R interno | — | Layer 2 (símbolos/F) |
| `TD(1)` polegar R médio | `Enter` | `Shift` direito |
| `Bksp` polegar R externo | `Backspace` | — |

Não há home-row mods: `Shift`, `Cmd` e `Alt` são todos hold de polegar.

## Layer 1 — Números e navegação (macOS) · `MO(1)`

![Layer 1](layer%20pictures/layer1.png)

```
  1     2     3     4     5   │   6     7     8     9     0
 Esc   ___   ___   Tab   LAlt │  ___   ←     ↓     ↑     →
LShift ___    C    ___   ___  │  ___   ___   ___   ___   ___

polegar L:  ___    ___    (held)  │   LCtrl  Enter  LGui
central: M2 (Cmd+Shift+5)   encoder: Brightness + / −
```

- **Linha de cima**: fileira numérica inteira, `1`–`5` na esquerda, `6`–`0` na direita (com shift dá `! @ # $ % ^ & * ( )`).
- **Mão direita, home row**: setas em cruz horizontal `← ↓ ↑ →` — o cluster de navegação.
- **Mão esquerda**: `Esc`, `Tab`, `LAlt` e `LShift` acessíveis sem sair da layer.
- **Polegares direitos** viram modificadores puros: `LCtrl`, `Enter`, `LGui`.
- **Encoder** muda de volume para **brilho da tela**.
- **Central** dispara `M2` = `Cmd+Shift+5` (captura de tela / gravação do macOS).

## Layer 2 — Símbolos, F-keys e mídia (macOS) · `MO(2)`

![Layer 2](layer%20pictures/layer2.png)

```
  F1    F2    F3    F4    F5  │   F6    F7    F8    F9    F10
  F11   F12   ___   ___   ___ │   -     =     [     ]     \
 ___   ___   ___   ___   ___  │  Rewind Mute  Fwd    '     `

polegar L:  LGui   Space  ___    │   (held)  Enter  RAlt
central: ___              encoder: Scroll → / Scroll ←
```

- **F1–F12** ocupam a mão esquerda + linha de cima da direita.
- **Mão direita, home row**: os símbolos que faltam no base — `- = [ ] \`.
- **Mão direita, linha de baixo**: controles de mídia (`Rewind`, `Mute`, `Fast Fwd`) e `'` `` ` ``.
- **Encoder** vira **scroll horizontal** (`KC_WH_R` / `KC_WH_L`).

## Layer 3 — Mouse, RGB e toggle de SO (macOS) · combo `MO(1)`+`MO(2)`

![Layer 3](layer%20pictures/layer3.png)

```
 ___    ___    ___   ___  ___ │  ___  Btn1  Mouse↑ Btn2  Wheel↑
RGB_HUI RGB_SAI RGB_VAI ___ ___│  ___ Mouse← Mouse↓ Mouse→ Wheel↓
RGB_HUD RGB_SAD RGB_VAD ___ ___│  ___  ___   ___   ___   ___

polegar L:  LGui   Space   ▽     │    ▽    Enter  RAlt
central: TG(4)  ← troca para Linux      encoder: RGB mode − / +
```

Esta é a layer "adjust", alcançada **só por combo** (segurar os dois polegares internos ao mesmo tempo).

- **Mão direita**: mouse completo — movimento (`↑ ← ↓ →`), botões esquerdo/direito e scroll vertical.
- **Mão esquerda**: RGB — matiz (`Hue`), saturação (`Sat`) e brilho (`Bright`) nas colunas 1-2-3; a **home row aumenta** (`HUI`/`SAI`/`VAI`) e a **linha de baixo diminui** (`HUD`/`SAD`/`VAD`).
- **Central `TG(4)`**: é aqui que você **entra no modo Linux**.
- **Encoder** percorre os modos de RGB.

---

# Bloco Linux

Mesma estrutura de 4 layers, com `Ctrl` onde o macOS usa `Cmd`.

## Layer 4 — Base (Linux) · `TG(4)`

![Layer 4](layer%20pictures/layer4.png)

```
  Q     W     E     R     T   │   Y     U     I     O     P
  A     S     D     F     G   │   H     J     K     L     ;
  Z     X     C     V     B   │   N     M     ,     .     /

polegar L:  TD(3)  TD(2)  MO(5)   │   MO(6)  TD(1)  Bksp
central: TG(4)  ← volta para macOS      encoder: Vol + / Vol −
```

Alfanuméricos **idênticos** à Layer 0. As duas mudanças:

| | macOS (L0) | Linux (L4) |
|---|---|---|
| Polegar L externo | `TD(0)` = tap `Cmd+Space` / hold `Cmd` | `TD(3)` = tap `Super` / hold `Ctrl` |
| Layers de polegar | `MO(1)` / `MO(2)` | `MO(5)` / `MO(6)` |
| Tecla central | `Media Play` | `TG(4)` (sai do Linux) |

`TD(2)` (space/alt) e `TD(1)` (enter/shift) são compartilhados entre os dois SOs.

## Layer 5 — Números e navegação (Linux) · `MO(5)`

![Layer 5](layer%20pictures/layer5.png)

```
  1     2     3     4     5   │   6     7     8     9     0
 Esc   ___   ___   Tab  LCtrl │  ___   ←     ↓     ↑     →
LShift ___   ___   ___   ___  │  ___   ___   ___   ___   ___

polegar L:  ___    ___   (held)   │   LCtrl  Enter  LAlt
central: ___              encoder: (nada)
```

Gêmea da Layer 1, com três diferenças:

- Posição do `G` (mão esquerda, home row, coluna 5): **`LCtrl`** em vez de `LAlt`.
- Polegar direito externo: **`LAlt`** em vez de `LGui`.
- Sem macro de screenshot na central, e o encoder está **inativo** (`KC_NO`).

## Layer 6 — Símbolos, F-keys e mídia (Linux) · `MO(6)`

![Layer 6](layer%20pictures/layer6.png)

```
  F1    F2    F3    F4    F5  │   F6    F7    F8    F9    F10
  F11   F12   ___   ___   ___ │   -     =     [     ]     \
 ___   ___   ___   ___   ___  │  Prev  Mute  Next   '     `

polegar L:  LGui   Space  MO(3)   │   (held)  Enter  LAlt
central: ___              encoder: (nada)
```

Gêmea da Layer 2:

- Mídia usa `Prev Track` / `Next Track` em vez de `Rewind` / `Fast Forward` (o Linux responde melhor a `MPRV`/`MNXT`).
- Polegar direito externo: `LAlt` em vez de `RAlt`.
- Encoder **inativo**.

## Layer 7 — Mouse (Linux) · combo `MO(5)`+`MO(6)`

![Layer 7](layer%20pictures/layer7.png)

```
 ___   ___   ___   ___   ___  │  ___  Btn1  Mouse↑ Btn2  Wheel↑
 ___   ___   ___   ___   ___  │  ___ Mouse← Mouse↓ Mouse→ Wheel↓
 ___   ___   ___   ___   ___  │  ___  ___   ___   ___   ___

polegar L:  ___    ___    ___     │   ___    ___    ___
central: ___              encoder: (nada)
```

Versão enxuta da Layer 3: **só o cluster de mouse** na mão direita. Sem RGB, sem modificadores de polegar e sem tecla de toggle — para voltar ao macOS você solta o combo e usa a central da Layer 4.

---

## Tap dances

Todos com **tapping term de 230 ms**.

| | Tap | Hold | Onde |
|---|---|---|---|
| `TD(0)` | `Cmd+Space` (Spotlight) | `Cmd` | L0 — polegar L externo |
| `TD(1)` | `Enter` | `Shift` (direito) | L0 e L4 — polegar R médio |
| `TD(2)` | `Space` | `Alt` | L0 e L4 — polegar L médio |
| `TD(3)` | `Super` (`LGui`) | `Ctrl` | L4 — polegar L externo |

![TD(0)](tapdance%20pictures/td0.png)
![TD(1)](tapdance%20pictures/td1.png)
![TD(2)](tapdance%20pictures/td2.png)
![TD(3)](tapdance%20pictures/td3.png)

O padrão é sempre o mesmo: **o caractere no tap, o modificador no hold**. Isso é o que libera as 30 teclas alfanuméricas para serem só letras.

## Combos

| Combo | Resultado | Bloco |
|---|---|---|
| `MO(1)` + `MO(2)` | `MO(3)` | macOS — layer de mouse/RGB/toggle |
| `MO(5)` + `MO(6)` | `MO(7)` | Linux — layer de mouse |

![Combo 1](combo%20pictures%20/comb1.png)
![Combo 2](combo%20pictures%20/comb2.png)

Os dois polegares internos pressionados juntos abrem a layer "adjust" do bloco correspondente — o truque clássico de tri-layer, aqui feito por combo em vez de `LT`.

## Macros

| | Conteúdo | Usado em |
|---|---|---|
| `M0` | `Ctrl+Tab` | **não atribuído** |
| `M1` | `Ctrl+Shift+Tab` | **não atribuído** |
| `M2` | `Cmd+Shift+5` (captura/gravação macOS) | Layer 1 — tecla central |

![M0](Macro%20pictures/m0.png)
![M1](Macro%20pictures/m1.png)
![M2](Macro%20pictures/m2.png)

## Encoder

| Layer | Girar ↻ | Girar ↺ |
|---|---|---|
| 0 — Base macOS | Volume + | Volume − |
| 1 — Números macOS | Brilho + | Brilho − |
| 2 — Símbolos macOS | Scroll → | Scroll ← |
| 3 — Adjust macOS | RGB modo − (`RGB_RMOD`) | RGB modo + (`RGB_MOD`) |
| 4 — Base Linux | Volume + | Volume − |
| 5, 6, 7 — Linux | *(inativo)* | *(inativo)* |

---

## Resumo macOS × Linux

| | macOS | Linux |
|---|---|---|
| Base | Layer 0 | Layer 4 |
| Números/Nav | Layer 1 | Layer 5 |
| Símbolos/F | Layer 2 | Layer 6 |
| Mouse/Adjust | Layer 3 | Layer 7 |
| Polegar L externo | `Cmd+Space` / `Cmd` | `Super` / `Ctrl` |
| Mod extra na home row esquerda | `LAlt` | `LCtrl` |
| Polegar R externo (nav layer) | `LGui` | `LAlt` |
| Mídia (layer de símbolos) | `Rewind` / `Fast Fwd` | `Prev` / `Next` |
| Screenshot | `M2` na central da L1 | — |
| RGB | Layer 3 | — |
| Encoder nas layers secundárias | ativo | inativo |

---

## Pontos a revisar

Coisas que aparecem no `.vil` e provavelmente são resíduo de edições antigas:

1. **`MO(3)` no polegar L interno da Layer 6.** Estando no bloco Linux, isso te joga na layer de RGB/toggle **do macOS**. O combo `MO(5)`+`MO(6)` já cobre a layer adjust do Linux, então esta tecla parece sobra.
2. **Um `C` solto na Layer 1**, posição do `C` (mão esquerda, linha de baixo, coluna 3). Não existe equivalente na Layer 5.
3. **`M0` e `M1` definidos mas não atribuídos** a nenhuma tecla — `Ctrl+Tab` / `Ctrl+Shift+Tab` sobraram sem posição.
4. **Encoder morto nas layers 5–7** (`KC_NO`, não `KC_TRNS`), então girar não faz nada em vez de cair no volume da Layer 4.
5. **Layer 7 sem espelho completo da Layer 3**: falta RGB e faltam os mods de polegar (`LGui`, `Space`, `Enter`, `Alt`) que a Layer 3 tem.
6. A pasta `combo pictures ` tem **espaço no fim do nome** — vale renomear.

## Arquivos

- `cheapinov2_v2.vil` — keymap atual (este README)
- `cheapino_onev1.vil` — versão anterior
- `layer pictures/` — screenshots das layers 0–7
- `tapdance pictures/` — screenshots dos tap dances 0–3
- `combo pictures /` — screenshots dos combos
- `Macro pictures/` — screenshots das macros 0–2

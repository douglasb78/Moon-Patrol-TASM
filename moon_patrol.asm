.model small
.stack 200h
.data
LARGURA EQU 320                                 ; largura da tela em pixels
ALTURA EQU 200                                  ; altura da tela em pixels
CENARIO_Y EQU 100                               ; linha onde comeca o desenho das montanhas
CENARIO_W EQU 512                               ; largura total do cenario que se repete
TOPO EQU 15                                     ; limite superior da area de jogo
HUD_VIDAS_X EQU 151                             ; posicao horizontal dos icones de vida
HUD_NUMERO_COL EQU 0                            ; coluna dos numeros da pontuacao
PISTA EQU 185                                   ; linha onde comeca a pista
JIPE_Y EQU PISTA-10                             ; posicao vertical do jipe no chao
JIPE_MAX EQU 160-20                             ; maior posicao horizontal permitida pro jipe
VEL_JIPE EQU 4                                  ; pixels que o jipe anda por movimento
VEL_MUNDO EQU 2                                 ; pixels que o cenario anda por quadro
VEL_NAVE EQU 2                                  ; pixels que as naves andam por quadro
VEL_TIRO EQU 5                                  ; pixels que os tiros do jipe andam por quadro
VEL_BOMBA EQU 2                                 ; pixels que os tiros das naves descem por quadro
SALTO_ALT EQU 15                                ; altura maxima do pulo em pixels
PAREDE_Y EQU JIPE_Y-SALTO_ALT                   ; linha onde comeca a faixa verde abaixo das montanhas
COR_PAREDE EQU 0ah                              ; cor verde-claro da faixa abaixo das montanhas
SALTO_PASSO EQU 3                               ; pixels de subida ou descida do jipe por quadro
SALTO_PLATO_PIXELS EQU 45                       ; distancia sobre o terreno no topo do pulo; maior prolonga o pulo
DURACAO EQU 120                                 ; duracao da partida em segundos
VIDAS_INICIAIS EQU 3                            ; quantidade de vidas no inicio da partida
DELAY_FRAME EQU 20000                           ; pausa entre quadros em microssegundos
TIRO_W EQU 2                                    ; largura do tiro para cima em pixels
TIRO_H EQU 4                                    ; altura do tiro para cima em pixels
ALCANCE_FRONTAL EQU 50                          ; distancia maxima do tiro frontal em pixels
INTERVALO_BOMBA EQU 45                          ; quadros entre tentativas de disparo das naves
DIST_CRATERA EQU 180                            ; distancia minima entre novas crateras
VAR_CRATERA EQU 61                              ; quantidade de variacoes sorteadas pra distancia das crateras
PONTOS_NAVE EQU 100                             ; pontos ganhos ao destruir uma nave
PONTOS_OBST EQU 50                              ; pontos ganhos ao destruir uma rocha
MAX_OBJ EQU 24                                  ; quantidade maxima de objetos armazenados
MAX_NAVES EQU 3                                 ; quantidade maxima de naves ao mesmo tempo
TIPOS_NAVES EQU 3                               ; quantidade de modelos de nave
TIPOS_CRATERAS EQU 3                            ; quantidade de modelos de cratera
TIPOS_ROCHAS EQU 4                              ; quantidade de modelos de rocha
NAVE_W EQU 14                                   ; largura das naves em pixels
NAVE_H EQU 14                                   ; altura das naves em pixels
NAVE_DISTANCIA EQU 44                           ; distancia base entre as naves
NAVE_VAR_DIST EQU 17                            ; quantidade de variacoes sorteadas pra distancia entre naves
NAVE_VAR_ENTRADA EQU 21                         ; quantidade de variacoes na posicao de entrada das naves
NAVE_VAR_Y EQU CENARIO_Y-TOPO-NAVE_H+1          ; quantidade de alturas possiveis para as naves
JIPE_W EQU 20                                   ; largura do jipe em pixels
JIPE_H EQU 10                                   ; altura do jipe em pixels
JIPE_INICIO_X EQU 0                             ; posicao horizontal inicial do jipe
CENTESIMOS_SEGUNDO EQU 100                      ; quantidade de centesimos em um segundo
CENTESIMOS_MINUTO EQU 6000                      ; quantidade de centesimos em um minuto
FIM_NAVES EQU MAX_NAVES*2                       ; fim da area das naves nos arrays, em bytes
INI_OBST EQU 6                                  ; inicio da area dos obstaculos nos arrays, em bytes
FIM_OBST EQU 14                                 ; fim da area dos obstaculos nos arrays, em bytes
INI_TIROS EQU 14                                ; inicio da area dos tiros nos arrays, em bytes
FIM_OBJ EQU MAX_OBJ*2                           ; fim dos arrays de objetos, em bytes
INV_FRAMES EQU 30                               ; quadros de invulnerabilidade apos perder uma vida
MENU_Y EQU 82                                   ; posicao vertical das sprites animadas do menu
MENU_ALTURA EQU 14                              ; altura da faixa de animacao do menu
MENU_QUANTIDADE EQU 4                           ; quantidade de sprites animadas no menu
MENU_INTERVALO EQU 60                           ; espaco horizontal entre as sprites do menu
MENU_INICIO EQU 60                              ; posicao inicial da animacao do menu
MENU_CICLO EQU LARGURA+20                       ; distancia do ciclo antes de repetir a animacao do menu
; tipos: 1..3 naves; 4..6 crateras; 7..10 rochas;
; 11 tiro superior, 12 frontal, 13 alienigena. zero = livre.
tipo dw MAX_OBJ dup(0)
obj_x dw MAX_OBJ dup(0)
obj_y dw MAX_OBJ dup(0)
resist dw MAX_OBJ dup(0)
marcado dw MAX_OBJ dup(0)
percurso dw MAX_OBJ dup(0)
larguras dw 0,14,14,14,14,14,14,12,12,12,12,TIRO_W,4,2
alturas dw 0,14,14,14,7,7,7,10,10,10,10,TIRO_H,2,4
imagens dw 0,offset nave_alien1,offset nave_alien2,offset nave_alien3
        dw offset cratera1,offset cratera2,offset cratera3
        dw offset rocha1,offset rocha2,offset rocha3,offset rocha4
cores db 0,0,0,0,0,0,0,0,0,0,0,14,12,15
jx dw 0
jy dw JIPE_Y
salto dw 0
plato dw 0
invencivel dw 0
vidas dw VIDAS_INICIAIS
pontos dw 0
tempo dw DURACAO
relogio_anterior dw 0
centesimos dw 0
jx_anterior dw 0
seed dw 1
scroll_cenario dw 0
linhas_sujas db ALTURA dup(1)
distancia dw 0
proxima dw DIST_CRATERA
rocha_pendente dw 0
contador_bomba dw 0
sair db 0
selecao db 0
anim_x dw MENU_INICIO
menu_indice dw 0
menu_sprites dw offset jipe,offset nave_alien1,offset nave_alien2,offset nave_alien3
menu_larguras dw 20,14,14,14
menu_alturas dw 10,14,14,14
menu_deslocamentos dw 0,MENU_INTERVALO,2*MENU_INTERVALO,3*MENU_INTERVALO
tecla dw 0
cor_retangulo db 0
; uma linha temporaria;
linha_pixels db LARGURA dup(0)
linha_y dw 0
cache_pontos dw 0ffffh
cache_tempo dw 0ffffh
cache_vidas dw 0ffffh
hud_inicial db 1
col_x1 dw 0
col_y1 dw 0
col_l1 dw 0
col_a1 dw 0
col_x2 dw 0
col_y2 dw 0
col_l2 dw 0
col_a2 dw 0
buffer_numero db '00000$'
txt_score db 'SCORE:$'
txt_setor db 'Setor A$'
txt_voltar db 'QUALQUER TECLA: MENU$'
caixa_top db 218,7 dup(196),191,'$'
caixa_jogar db 179,' Jogar ',179,'$'
caixa_sair db 179,' Sair  ',179,'$'
caixa_base db 192,7 dup(196),217,'$'
; artes ascii; fonte compacta 5x8 + espaco.
ARTE_PASSO EQU 6                                ; espaco horizontal ocupado por cada caractere da arte
ARTE_ALTURA EQU 8                               ; altura dos caracteres da arte em pixels
TITULO_X EQU (LARGURA-46*ARTE_PASSO)/2          ; posicao horizontal para centralizar o titulo
FIM_X EQU (LARGURA-23*ARTE_PASSO)/2             ; posicao horizontal para centralizar game e over
arte_x dw 0
arte_inicio dw 0
arte_y dw 0
arte_cor db 14
arte_codigos db 32,95,124,92,47,39,96,44,40,45,41,86
ARTE_CARACTERES EQU $-arte_codigos              ; quantidade de caracteres disponiveis na fonte da arte
arte_fonte db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,248,0
 db 32,32,32,32,32,32,32,0,128,128,64,32,16,8,8,0
 db 8,8,16,32,64,128,128,0,32,32,64,0,0,0,0,0
 db 64,32,0,0,0,0,0,0,0,0,0,0,0,32,32,64
 db 16,32,64,64,64,32,16,0,0,0,0,248,0,0,0,0
 db 64,32,16,16,16,32,64,0,136,136,136,136,80,80,32,0
arte_titulo db "  __  __               ___      _           _ ",10
 db " |  \/  |___  ___ _ _ | _ \__ _| |_ _ _ ___| |",10
 db " | |\/| / _ \/ _ \ ' \|  _/ _` |  _| '_/ _ \ |",10
 db " |_|  |_\___/\___/_||_|_| \__,_|\__|_| \___/_|",0
arte_fim db "   ___                 ",10
 db "  / __|__ _ _ __  ___  ",10
 db " | (_ / _` | '  \/ -_) ",10
 db "  \___\__,_|_|_|_\___| ",10
 db "",10
 db "    ___                ",10
 db "   / _ \__ _____ _ _   ",10
 db "  | (_) \ V / -_) '_|  ",10
 db "   \___/ \_/\___|_|    ",0
; === bitmaps ===
; coracoes_1: 10x11 pixels, 110 bytes.
coracoes_1 label byte
 db 00h,00h,0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h
 db 00h,00h,0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h
 db 10 dup(0Ch)
 db 10 dup(0Ch)
 db 10 dup(0Ch)
 db 10 dup(0Ch)
 db 00h,00h,6 dup(0Ch),00h,00h
 db 00h,00h,6 dup(0Ch),00h,00h
 db 00h,00h,6 dup(0Ch),00h,00h
 db 4 dup(00h),0Ch,0Ch,4 dup(00h)
 db 4 dup(00h),0Ch,0Ch,4 dup(00h)
; coracoes_2: 14x11 pixels, 154 bytes.
coracoes_2 label byte
 db 00h,00h,0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h
 db 00h,00h,0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h
 db 0Ch,0Ch,00h,00h,10 dup(0Ch)
 db 0Ch,0Ch,00h,00h,10 dup(0Ch)
 db 0Ch,0Ch,00h,00h,10 dup(0Ch)
 db 0Ch,0Ch,00h,00h,10 dup(0Ch)
 db 00h,00h,0Ch,0Ch,00h,00h,6 dup(0Ch),00h,00h
 db 00h,00h,0Ch,0Ch,00h,00h,6 dup(0Ch),00h,00h
 db 00h,00h,0Ch,0Ch,00h,00h,6 dup(0Ch),00h,00h
 db 4 dup(00h),0Ch,0Ch,00h,00h,0Ch,0Ch,4 dup(00h)
 db 4 dup(00h),0Ch,0Ch,00h,00h,0Ch,0Ch,4 dup(00h)
; coracoes_3: 18x11 pixels, 198 bytes.
coracoes_3 label byte
 db 00h,00h,0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h
 db 00h,00h,0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h
 db 0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h,10 dup(0Ch)
 db 0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h,10 dup(0Ch)
 db 0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h,10 dup(0Ch)
 db 0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h,10 dup(0Ch)
 db 00h,00h,0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h,6 dup(0Ch),00h,00h
 db 00h,00h,0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h,6 dup(0Ch),00h,00h
 db 00h,00h,0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h,6 dup(0Ch),00h,00h
 db 4 dup(00h),0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h,0Ch,0Ch,4 dup(00h)
 db 4 dup(00h),0Ch,0Ch,00h,00h,0Ch,0Ch,00h,00h,0Ch,0Ch,4 dup(00h)
; cratera1: 14x7 pixels, 98 bytes.
cratera1 label byte
 db 08h,08h,10 dup(0Ah),08h,08h
 db 08h,08h,10 dup(0Ah),08h,06h
 db 06h,3 dup(08h),7 dup(0Ah),08h,08h,06h
 db 3 dup(06h),08h,08h,6 dup(0Ah),08h,06h,06h
 db 3 dup(06h),08h,08h,5 dup(0Ah),08h,3 dup(06h)
 db 06h,06h,08h,06h,06h,08h,3 dup(0Ah),08h,4 dup(06h)
 db 6 dup(06h),3 dup(08h),5 dup(06h)
; cratera2: 14x7 pixels, 98 bytes.
cratera2 label byte
 db 08h,10 dup(0Ah),3 dup(08h)
 db 06h,08h,9 dup(0Ah),08h,06h,06h
 db 06h,06h,08h,08h,6 dup(0Ah),08h,08h,06h,06h
 db 4 dup(06h),08h,08h,3 dup(0Ah),08h,08h,3 dup(06h)
 db 5 dup(06h),08h,08h,0Ah,0Ah,08h,4 dup(06h)
 db 5 dup(06h),08h,06h,3 dup(08h),4 dup(06h)
 db 8 dup(06h),08h,5 dup(06h)
; cratera3: 14x7 pixels, 98 bytes.
cratera3 label byte
 db 3 dup(08h),8 dup(0Ah),3 dup(08h)
 db 06h,06h,08h,7 dup(0Ah),08h,3 dup(06h)
 db 06h,06h,08h,6 dup(0Ah),08h,08h,3 dup(06h)
 db 3 dup(06h),5 dup(0Ah),08h,08h,4 dup(06h)
 db 3 dup(06h),08h,08h,3 dup(0Ah),08h,5 dup(06h)
 db 4 dup(06h),08h,0Ah,08h,08h,6 dup(06h)
 db 3 dup(06h),08h,06h,3 dup(08h),6 dup(06h)
; jipe: 20x10 pixels, 200 bytes.
jipe label byte
 db 11 dup(00h),5 dup(0Ch),4 dup(00h)
 db 6 dup(00h),01h,3 dup(00h),3 dup(0Ch),4 dup(09h),3 dup(00h)
 db 00h,00h,3 dup(0Ch),00h,04h,4 dup(0Ch),6 dup(09h),0Ch,00h,00h
 db 00h,19 dup(0Ch)
 db 00h,14 dup(0Ch),3 dup(04h),01h,01h
 db 00h,17 dup(0Ch),00h,00h
 db 00h,01h,09h,3 dup(0Ch),01h,09h,7 dup(0Ch),01h,09h,0Ch,00h,00h
 db 09h,3 dup(01h),00h,09h,3 dup(01h),5 dup(00h),09h,3 dup(01h),00h,00h
 db 3 dup(01h),09h,00h,3 dup(01h),09h,5 dup(00h),3 dup(01h),09h,00h,00h
 db 00h,09h,01h,3 dup(00h),09h,01h,7 dup(00h),09h,01h,3 dup(00h)
; cenario fixo 512x60: imagens fornecidas unidas, sem parallax.
; cenario: 512x60 pixels, 30720 bytes.
cenario label byte
 ; linha 0 do cenario
 db 17 dup(00h),01h,106 dup(00h),03h,03h,115 dup(00h),03h,03h,01h,24 dup(00h),01h,03h,03h,115 dup(00h),03h,03h
 db 106 dup(00h),01h,17 dup(00h)
 ; linha 1 do cenario
 db 17 dup(00h),01h,01h,105 dup(00h),03h,03h,115 dup(00h),03h,03h,01h,00h,01h,01h,18 dup(00h),01h,01h,00h,01h
 db 03h,03h,115 dup(00h),03h,03h,105 dup(00h),01h,01h,17 dup(00h)
 ; linha 2 do cenario
 db 17 dup(00h),01h,01h,104 dup(00h),4 dup(03h),113 dup(00h),3 dup(03h),5 dup(01h),16 dup(00h),5 dup(01h)
 db 3 dup(03h),113 dup(00h),4 dup(03h),104 dup(00h),01h,01h,17 dup(00h)
 ; linha 3 do cenario
 db 17 dup(00h),3 dup(01h),3 dup(00h),03h,99 dup(00h),4 dup(03h),113 dup(00h),4 dup(03h),4 dup(01h)
 db 16 dup(00h),4 dup(01h),4 dup(03h),113 dup(00h),4 dup(03h),99 dup(00h),03h,3 dup(00h),3 dup(01h)
 db 17 dup(00h)
 ; linha 4 do cenario
 db 17 dup(00h),3 dup(01h),00h,00h,3 dup(03h),98 dup(00h),01h,4 dup(03h),01h,110 dup(00h),03h,01h,3 dup(03h)
 db 3 dup(01h),03h,16 dup(00h),03h,3 dup(01h),3 dup(03h),01h,03h,110 dup(00h),01h,4 dup(03h),01h,98 dup(00h)
 db 3 dup(03h),00h,00h,3 dup(01h),17 dup(00h)
 ; linha 5 do cenario
 db 16 dup(00h),3 dup(01h),03h,00h,00h,4 dup(03h),97 dup(00h),01h,4 dup(03h),01h,3 dup(00h),03h,106 dup(00h)
 db 03h,01h,03h,03h,3 dup(01h),03h,03h,16 dup(00h),03h,03h,3 dup(01h),03h,03h,01h,03h,106 dup(00h),03h
 db 3 dup(00h),01h,4 dup(03h),01h,97 dup(00h),4 dup(03h),00h,00h,03h,3 dup(01h),16 dup(00h)
 ; linha 6 do cenario
 db 16 dup(00h),3 dup(01h),03h,00h,5 dup(03h),97 dup(00h),01h,01h,03h,03h,3 dup(01h),00h,00h,03h,106 dup(00h)
 db 5 dup(03h),01h,3 dup(03h),16 dup(00h),3 dup(03h),01h,5 dup(03h),106 dup(00h),03h,00h,00h,3 dup(01h),03h
 db 03h,01h,01h,97 dup(00h),5 dup(03h),00h,03h,3 dup(01h),16 dup(00h)
 ; linha 7 do cenario
 db 16 dup(00h),3 dup(01h),5 dup(03h),01h,03h,03h,96 dup(00h),01h,01h,3 dup(03h),01h,01h,00h,03h,03h
 db 106 dup(00h),9 dup(03h),16 dup(00h),9 dup(03h),106 dup(00h),03h,03h,00h,01h,01h,3 dup(03h),01h,01h
 db 96 dup(00h),03h,03h,01h,5 dup(03h),3 dup(01h),16 dup(00h)
 ; linha 8 do cenario
 db 15 dup(00h),4 dup(01h),8 dup(03h),96 dup(00h),01h,4 dup(03h),01h,01h,3 dup(03h),105 dup(00h),01h,01h
 db 7 dup(03h),01h,16 dup(00h),01h,7 dup(03h),01h,01h,105 dup(00h),3 dup(03h),01h,01h,4 dup(03h),01h
 db 96 dup(00h),8 dup(03h),4 dup(01h),15 dup(00h)
 ; linha 9 do cenario
 db 15 dup(00h),3 dup(01h),3 dup(03h),01h,5 dup(03h),96 dup(00h),01h,4 dup(03h),3 dup(01h),03h,03h
 db 105 dup(00h),01h,7 dup(03h),01h,01h,16 dup(00h),01h,01h,7 dup(03h),01h,105 dup(00h),03h,03h,3 dup(01h)
 db 4 dup(03h),01h,96 dup(00h),5 dup(03h),01h,3 dup(03h),3 dup(01h),15 dup(00h)
 ; linha 10 do cenario
 db 14 dup(00h),4 dup(01h),3 dup(03h),01h,01h,4 dup(03h),01h,19 dup(00h),03h,50 dup(00h),03h,03h,23 dup(00h)
 db 01h,3 dup(03h),3 dup(01h),4 dup(03h),103 dup(00h),3 dup(01h),5 dup(03h),3 dup(01h),16 dup(00h),3 dup(01h)
 db 5 dup(03h),3 dup(01h),103 dup(00h),4 dup(03h),3 dup(01h),3 dup(03h),01h,23 dup(00h),03h,03h,50 dup(00h)
 db 03h,19 dup(00h),01h,4 dup(03h),01h,01h,3 dup(03h),4 dup(01h),14 dup(00h)
 ; linha 11 do cenario
 db 12 dup(00h),6 dup(01h),4 dup(03h),01h,03h,03h,01h,03h,01h,19 dup(00h),03h,03h,00h,00h,01h,01h,45 dup(00h)
 db 03h,03h,22 dup(00h),01h,01h,3 dup(03h),01h,01h,5 dup(03h),98 dup(00h),03h,03h,3 dup(00h),01h,01h
 db 6 dup(03h),5 dup(01h),12 dup(00h),5 dup(01h),6 dup(03h),01h,01h,3 dup(00h),03h,03h,98 dup(00h),5 dup(03h)
 db 01h,01h,3 dup(03h),01h,01h,22 dup(00h),03h,03h,45 dup(00h),01h,01h,00h,00h,03h,03h,19 dup(00h),01h,03h,01h
 db 03h,03h,01h,4 dup(03h),6 dup(01h),12 dup(00h)
 ; linha 12 do cenario
 db 12 dup(00h),7 dup(01h),5 dup(03h),4 dup(01h),18 dup(00h),3 dup(03h),00h,3 dup(01h),45 dup(00h),3 dup(03h)
 db 21 dup(00h),01h,01h,4 dup(03h),01h,01h,4 dup(03h),98 dup(00h),03h,03h,00h,00h,03h,3 dup(01h),6 dup(03h)
 db 4 dup(01h),12 dup(00h),4 dup(01h),6 dup(03h),3 dup(01h),03h,00h,00h,03h,03h,98 dup(00h),4 dup(03h),01h,01h
 db 4 dup(03h),01h,01h,21 dup(00h),3 dup(03h),45 dup(00h),3 dup(01h),00h,3 dup(03h),18 dup(00h),4 dup(01h)
 db 5 dup(03h),7 dup(01h),12 dup(00h)
 ; linha 13 do cenario
 db 12 dup(00h),7 dup(01h),5 dup(03h),4 dup(01h),18 dup(00h),3 dup(03h),01h,01h,00h,01h,01h,44 dup(00h)
 db 3 dup(03h),00h,01h,19 dup(00h),01h,01h,4 dup(03h),01h,01h,4 dup(03h),39 dup(00h),3 dup(03h),56 dup(00h)
 db 5 dup(03h),3 dup(01h),7 dup(03h),3 dup(01h),12 dup(00h),3 dup(01h),7 dup(03h),3 dup(01h),5 dup(03h)
 db 56 dup(00h),3 dup(03h),39 dup(00h),4 dup(03h),01h,01h,4 dup(03h),01h,01h,19 dup(00h),01h,00h,3 dup(03h)
 db 44 dup(00h),01h,01h,00h,01h,01h,3 dup(03h),18 dup(00h),4 dup(01h),5 dup(03h),7 dup(01h),12 dup(00h)
 ; linha 14 do cenario
 db 11 dup(00h),7 dup(01h),6 dup(03h),4 dup(01h),17 dup(00h),4 dup(03h),5 dup(01h),43 dup(00h),03h,01h
 db 3 dup(03h),01h,18 dup(00h),01h,01h,6 dup(03h),01h,4 dup(03h),39 dup(00h),3 dup(03h),56 dup(00h),01h
 db 5 dup(03h),3 dup(01h),5 dup(03h),5 dup(01h),10 dup(00h),5 dup(01h),5 dup(03h),3 dup(01h),5 dup(03h),01h
 db 56 dup(00h),3 dup(03h),39 dup(00h),4 dup(03h),01h,6 dup(03h),01h,01h,18 dup(00h),01h,3 dup(03h),01h,03h
 db 43 dup(00h),5 dup(01h),4 dup(03h),17 dup(00h),4 dup(01h),6 dup(03h),7 dup(01h),11 dup(00h)
 ; linha 15 do cenario
 db 10 dup(00h),9 dup(01h),6 dup(03h),3 dup(01h),17 dup(00h),3 dup(03h),6 dup(01h),43 dup(00h),03h,01h
 db 3 dup(03h),01h,01h,17 dup(00h),01h,01h,6 dup(03h),01h,4 dup(03h),39 dup(00h),3 dup(03h),56 dup(00h),01h
 db 5 dup(03h),3 dup(01h),4 dup(03h),6 dup(01h),10 dup(00h),6 dup(01h),4 dup(03h),3 dup(01h),5 dup(03h),01h
 db 56 dup(00h),3 dup(03h),39 dup(00h),4 dup(03h),01h,6 dup(03h),01h,01h,17 dup(00h),01h,01h,3 dup(03h),01h
 db 03h,43 dup(00h),6 dup(01h),3 dup(03h),17 dup(00h),3 dup(01h),6 dup(03h),9 dup(01h),10 dup(00h)
 ; linha 16 do cenario
 db 7 dup(00h),01h,00h,00h,9 dup(01h),6 dup(03h),4 dup(01h),16 dup(00h),3 dup(03h),7 dup(01h),15 dup(00h),03h
 db 03h,25 dup(00h),5 dup(03h),3 dup(01h),16 dup(00h),3 dup(01h),3 dup(03h),01h,6 dup(03h),39 dup(00h)
 db 3 dup(03h),00h,03h,03h,53 dup(00h),01h,6 dup(03h),01h,5 dup(03h),6 dup(01h),10 dup(00h),6 dup(01h)
 db 5 dup(03h),01h,6 dup(03h),01h,53 dup(00h),03h,03h,00h,3 dup(03h),39 dup(00h),6 dup(03h),01h,3 dup(03h)
 db 3 dup(01h),16 dup(00h),3 dup(01h),5 dup(03h),25 dup(00h),03h,03h,15 dup(00h),7 dup(01h),3 dup(03h)
 db 16 dup(00h),4 dup(01h),6 dup(03h),9 dup(01h),00h,00h,01h,7 dup(00h)
 ; linha 17 do cenario
 db 6 dup(00h),3 dup(01h),00h,8 dup(01h),7 dup(03h),4 dup(01h),15 dup(00h),5 dup(03h),6 dup(01h),15 dup(00h)
 db 3 dup(03h),23 dup(00h),01h,4 dup(03h),4 dup(01h),16 dup(00h),3 dup(01h),3 dup(03h),01h,4 dup(03h),01h,03h
 db 39 dup(00h),6 dup(03h),53 dup(00h),01h,6 dup(03h),01h,6 dup(03h),5 dup(01h),10 dup(00h),5 dup(01h)
 db 6 dup(03h),01h,6 dup(03h),01h,53 dup(00h),6 dup(03h),39 dup(00h),03h,01h,4 dup(03h),01h,3 dup(03h)
 db 3 dup(01h),16 dup(00h),4 dup(01h),4 dup(03h),01h,23 dup(00h),3 dup(03h),15 dup(00h),6 dup(01h),5 dup(03h)
 db 15 dup(00h),4 dup(01h),7 dup(03h),8 dup(01h),00h,3 dup(01h),6 dup(00h)
 ; linha 18 do cenario
 db 6 dup(00h),6 dup(01h),03h,03h,01h,03h,03h,01h,8 dup(03h),3 dup(01h),15 dup(00h),5 dup(03h),6 dup(01h)
 db 5 dup(00h),02h,02h,8 dup(00h),03h,03h,3 dup(02h),21 dup(00h),01h,01h,3 dup(03h),4 dup(01h),16 dup(00h),01h
 db 01h,4 dup(03h),01h,01h,3 dup(03h),01h,03h,39 dup(00h),6 dup(03h),00h,03h,03h,50 dup(00h),01h,5 dup(03h)
 db 01h,01h,6 dup(03h),5 dup(01h),10 dup(00h),5 dup(01h),6 dup(03h),01h,01h,5 dup(03h),01h,50 dup(00h),03h,03h
 db 00h,6 dup(03h),39 dup(00h),03h,01h,3 dup(03h),01h,01h,4 dup(03h),01h,01h,16 dup(00h),4 dup(01h),3 dup(03h)
 db 01h,01h,21 dup(00h),3 dup(02h),03h,03h,8 dup(00h),02h,02h,5 dup(00h),6 dup(01h),5 dup(03h),15 dup(00h)
 db 3 dup(01h),8 dup(03h),01h,03h,03h,01h,03h,03h,6 dup(01h),6 dup(00h)
 ; linha 19 do cenario
 db 4 dup(00h),8 dup(01h),6 dup(03h),01h,7 dup(03h),3 dup(01h),03h,9 dup(00h),03h,3 dup(00h),6 dup(03h)
 db 6 dup(01h),4 dup(00h),3 dup(0Ah),02h,6 dup(00h),03h,6 dup(02h),20 dup(00h),01h,5 dup(03h),4 dup(01h),00h
 db 00h,01h,12 dup(00h),01h,01h,5 dup(03h),01h,03h,03h,01h,01h,03h,00h,03h,36 dup(00h),4 dup(03h),01h
 db 3 dup(03h),01h,03h,50 dup(00h),01h,01h,5 dup(03h),01h,5 dup(03h),6 dup(01h),10 dup(00h),6 dup(01h)
 db 5 dup(03h),01h,5 dup(03h),01h,01h,50 dup(00h),03h,01h,3 dup(03h),01h,4 dup(03h),36 dup(00h),03h,00h,03h
 db 01h,01h,03h,03h,01h,5 dup(03h),01h,01h,12 dup(00h),01h,00h,00h,4 dup(01h),5 dup(03h),01h,20 dup(00h)
 db 6 dup(02h),03h,6 dup(00h),02h,3 dup(0Ah),4 dup(00h),6 dup(01h),6 dup(03h),3 dup(00h),03h,9 dup(00h),03h
 db 3 dup(01h),7 dup(03h),01h,6 dup(03h),8 dup(01h),4 dup(00h)
 ; linha 20 do cenario
 db 4 dup(00h),9 dup(01h),6 dup(03h),01h,6 dup(03h),3 dup(01h),03h,8 dup(00h),3 dup(03h),00h,3 dup(03h),01h
 db 03h,03h,7 dup(01h),00h,00h,7 dup(0Ah),02h,02h,00h,00h,4 dup(02h),4 dup(0Ah),02h,02h,14 dup(00h),01h,01h
 db 00h,3 dup(01h),4 dup(03h),01h,03h,01h,01h,00h,01h,01h,12 dup(00h),3 dup(01h),4 dup(03h),01h,03h,03h,01h
 db 01h,03h,00h,03h,36 dup(00h),4 dup(03h),01h,3 dup(03h),01h,03h,50 dup(00h),01h,01h,10 dup(03h),7 dup(01h)
 db 10 dup(00h),7 dup(01h),10 dup(03h),01h,01h,50 dup(00h),03h,01h,3 dup(03h),01h,4 dup(03h),36 dup(00h),03h
 db 00h,03h,01h,01h,03h,03h,01h,4 dup(03h),3 dup(01h),12 dup(00h),01h,01h,00h,01h,01h,03h,01h,4 dup(03h)
 db 3 dup(01h),00h,01h,01h,14 dup(00h),02h,02h,4 dup(0Ah),4 dup(02h),00h,00h,02h,02h,7 dup(0Ah),00h,00h
 db 7 dup(01h),03h,03h,01h,3 dup(03h),00h,3 dup(03h),8 dup(00h),03h,3 dup(01h),6 dup(03h),01h,6 dup(03h)
 db 9 dup(01h),4 dup(00h)
 ; linha 21 do cenario
 db 00h,00h,10 dup(01h),03h,01h,14 dup(03h),3 dup(01h),7 dup(00h),6 dup(03h),01h,3 dup(03h),5 dup(01h),03h,01h
 db 01h,10 dup(0Ah),4 dup(02h),7 dup(0Ah),02h,13 dup(00h),7 dup(01h),4 dup(03h),01h,03h,03h,4 dup(01h)
 db 12 dup(00h),3 dup(01h),4 dup(03h),01h,03h,03h,01h,03h,03h,00h,3 dup(03h),34 dup(00h),10 dup(03h)
 db 48 dup(00h),03h,00h,01h,11 dup(03h),8 dup(01h),8 dup(00h),8 dup(01h),11 dup(03h),01h,00h,03h,48 dup(00h)
 db 10 dup(03h),34 dup(00h),3 dup(03h),00h,03h,03h,01h,03h,03h,01h,4 dup(03h),3 dup(01h),12 dup(00h)
 db 4 dup(01h),03h,03h,01h,4 dup(03h),7 dup(01h),13 dup(00h),02h,7 dup(0Ah),4 dup(02h),10 dup(0Ah),01h,01h,03h
 db 5 dup(01h),3 dup(03h),01h,6 dup(03h),7 dup(00h),3 dup(01h),14 dup(03h),01h,03h,10 dup(01h),00h,00h
 ; linha 22 do cenario
 db 00h,9 dup(01h),4 dup(03h),01h,14 dup(03h),01h,01h,6 dup(00h),12 dup(03h),3 dup(01h),03h,03h,12 dup(0Ah)
 db 4 dup(02h),7 dup(0Ah),3 dup(02h),11 dup(00h),01h,01h,03h,3 dup(01h),9 dup(03h),3 dup(01h),11 dup(00h)
 db 4 dup(01h),7 dup(03h),01h,6 dup(03h),34 dup(00h),5 dup(03h),01h,4 dup(03h),48 dup(00h),03h,03h,01h
 db 3 dup(03h),01h,6 dup(03h),10 dup(01h),6 dup(00h),10 dup(01h),6 dup(03h),01h,3 dup(03h),01h,03h,03h
 db 48 dup(00h),4 dup(03h),01h,5 dup(03h),34 dup(00h),6 dup(03h),01h,7 dup(03h),4 dup(01h),11 dup(00h)
 db 3 dup(01h),9 dup(03h),3 dup(01h),03h,01h,01h,11 dup(00h),3 dup(02h),7 dup(0Ah),4 dup(02h),12 dup(0Ah),03h
 db 03h,3 dup(01h),12 dup(03h),6 dup(00h),01h,01h,14 dup(03h),01h,4 dup(03h),9 dup(01h),00h
 ; linha 23 do cenario
 db 00h,01h,01h,03h,03h,4 dup(01h),19 dup(03h),4 dup(01h),00h,00h,12 dup(03h),01h,03h,4 dup(01h),12 dup(0Ah)
 db 4 dup(02h),8 dup(0Ah),4 dup(02h),11 dup(00h),01h,03h,03h,01h,01h,10 dup(03h),4 dup(01h),10 dup(00h),01h
 db 01h,5 dup(03h),01h,3 dup(03h),01h,7 dup(03h),33 dup(00h),5 dup(03h),01h,4 dup(03h),48 dup(00h),03h,03h,01h
 db 3 dup(03h),01h,6 dup(03h),12 dup(01h),00h,00h,12 dup(01h),6 dup(03h),01h,3 dup(03h),01h,03h,03h
 db 48 dup(00h),4 dup(03h),01h,5 dup(03h),33 dup(00h),7 dup(03h),01h,3 dup(03h),01h,5 dup(03h),01h,01h
 db 10 dup(00h),4 dup(01h),10 dup(03h),01h,01h,03h,03h,01h,11 dup(00h),4 dup(02h),8 dup(0Ah),4 dup(02h)
 db 12 dup(0Ah),4 dup(01h),03h,01h,12 dup(03h),00h,00h,4 dup(01h),19 dup(03h),4 dup(01h),03h,03h,01h,01h,00h
 ; linha 24 do cenario
 db 5 dup(03h),01h,03h,01h,01h,19 dup(03h),3 dup(01h),7 dup(03h),01h,7 dup(03h),4 dup(01h),12 dup(0Ah),02h,02h
 db 12 dup(0Ah),6 dup(02h),9 dup(00h),4 dup(03h),01h,10 dup(03h),01h,03h,01h,03h,10 dup(00h),01h,01h
 db 5 dup(03h),01h,11 dup(03h),14 dup(00h),03h,03h,15 dup(00h),12 dup(03h),48 dup(00h),03h,03h,01h,3 dup(03h)
 db 02h,02h,6 dup(03h),7 dup(01h),03h,3 dup(01h),03h,03h,3 dup(01h),03h,7 dup(01h),6 dup(03h),02h,02h
 db 3 dup(03h),01h,03h,03h,48 dup(00h),12 dup(03h),15 dup(00h),03h,03h,14 dup(00h),11 dup(03h),01h,5 dup(03h)
 db 01h,01h,10 dup(00h),03h,01h,03h,01h,10 dup(03h),01h,4 dup(03h),9 dup(00h),6 dup(02h),12 dup(0Ah),02h,02h
 db 12 dup(0Ah),4 dup(01h),7 dup(03h),01h,7 dup(03h),3 dup(01h),19 dup(03h),01h,01h,03h,01h,5 dup(03h)
 ; linha 25 do cenario
 db 4 dup(03h),01h,01h,03h,01h,19 dup(03h),3 dup(01h),6 dup(03h),4 dup(01h),7 dup(03h),01h,12 dup(0Ah),02h,02h
 db 14 dup(0Ah),8 dup(02h),6 dup(00h),6 dup(03h),01h,12 dup(03h),3 dup(01h),6 dup(00h),03h,03h,01h,01h
 db 5 dup(03h),01h,13 dup(03h),12 dup(00h),3 dup(03h),00h,03h,03h,11 dup(00h),12 dup(03h),46 dup(00h),03h,03h
 db 0Ah,0Ah,3 dup(03h),5 dup(02h),4 dup(03h),01h,01h,03h,03h,01h,01h,4 dup(03h),01h,03h,03h,01h,4 dup(03h),01h
 db 01h,03h,03h,01h,01h,4 dup(03h),5 dup(02h),3 dup(03h),0Ah,0Ah,03h,03h,46 dup(00h),12 dup(03h),11 dup(00h)
 db 03h,03h,00h,3 dup(03h),12 dup(00h),13 dup(03h),01h,5 dup(03h),01h,01h,03h,03h,6 dup(00h),3 dup(01h)
 db 12 dup(03h),01h,6 dup(03h),6 dup(00h),8 dup(02h),14 dup(0Ah),02h,02h,12 dup(0Ah),01h,7 dup(03h),4 dup(01h)
 db 6 dup(03h),3 dup(01h),19 dup(03h),01h,03h,01h,01h,4 dup(03h)
 ; linha 26 do cenario
 db 4 dup(03h),01h,01h,20 dup(03h),3 dup(01h),6 dup(03h),5 dup(01h),7 dup(03h),24 dup(0Ah),13 dup(02h)
 db 6 dup(00h),19 dup(03h),3 dup(01h),4 dup(00h),4 dup(03h),01h,20 dup(03h),12 dup(00h),5 dup(03h),01h
 db 11 dup(00h),12 dup(03h),17 dup(00h),3 dup(03h),25 dup(00h),3 dup(03h),3 dup(0Ah),03h,03h,02h,02h,0Ah
 db 3 dup(02h),03h,03h,01h,01h,3 dup(03h),01h,4 dup(03h),01h,4 dup(03h),01h,4 dup(03h),01h,3 dup(03h),01h,01h
 db 03h,03h,3 dup(02h),0Ah,02h,02h,03h,03h,3 dup(0Ah),3 dup(03h),25 dup(00h),3 dup(03h),17 dup(00h)
 db 12 dup(03h),11 dup(00h),01h,5 dup(03h),12 dup(00h),20 dup(03h),01h,4 dup(03h),4 dup(00h),3 dup(01h)
 db 19 dup(03h),6 dup(00h),13 dup(02h),24 dup(0Ah),7 dup(03h),5 dup(01h),6 dup(03h),3 dup(01h),20 dup(03h),01h
 db 01h,4 dup(03h)
 ; linha 27 do cenario
 db 3 dup(03h),01h,01h,25 dup(03h),01h,01h,03h,8 dup(01h),3 dup(03h),14 dup(0Ah),02h,02h,15 dup(0Ah)
 db 11 dup(02h),00h,00h,22 dup(03h),01h,01h,03h,3 dup(00h),4 dup(03h),01h,13 dup(03h),01h,01h,5 dup(03h)
 db 10 dup(00h),7 dup(03h),01h,11 dup(00h),8 dup(03h),01h,3 dup(03h),17 dup(00h),3 dup(03h),25 dup(00h),03h
 db 03h,5 dup(0Ah),02h,02h,3 dup(0Ah),3 dup(02h),01h,4 dup(03h),01h,4 dup(03h),01h,6 dup(03h),01h,4 dup(03h)
 db 01h,4 dup(03h),01h,3 dup(02h),3 dup(0Ah),02h,02h,5 dup(0Ah),03h,03h,25 dup(00h),3 dup(03h),17 dup(00h)
 db 3 dup(03h),01h,8 dup(03h),11 dup(00h),01h,7 dup(03h),10 dup(00h),5 dup(03h),01h,01h,13 dup(03h),01h
 db 4 dup(03h),3 dup(00h),03h,01h,01h,22 dup(03h),00h,00h,11 dup(02h),15 dup(0Ah),02h,02h,14 dup(0Ah)
 db 3 dup(03h),8 dup(01h),03h,01h,01h,25 dup(03h),01h,01h,3 dup(03h)
 ; linha 28 do cenario
 db 03h,03h,01h,26 dup(03h),01h,4 dup(03h),01h,01h,03h,3 dup(01h),03h,03h,14 dup(0Ah),02h,02h,20 dup(0Ah)
 db 10 dup(02h),10 dup(03h),01h,9 dup(03h),01h,01h,03h,01h,03h,3 dup(00h),4 dup(03h),01h,12 dup(03h)
 db 5 dup(01h),3 dup(03h),10 dup(00h),6 dup(03h),01h,03h,10 dup(00h),13 dup(03h),01h,16 dup(00h),4 dup(03h)
 db 01h,23 dup(00h),03h,12 dup(0Ah),02h,02h,28 dup(03h),02h,02h,12 dup(0Ah),03h,23 dup(00h),01h,4 dup(03h)
 db 16 dup(00h),01h,13 dup(03h),10 dup(00h),03h,01h,6 dup(03h),10 dup(00h),3 dup(03h),5 dup(01h),12 dup(03h)
 db 01h,4 dup(03h),3 dup(00h),03h,01h,03h,01h,01h,9 dup(03h),01h,10 dup(03h),10 dup(02h),20 dup(0Ah),02h,02h
 db 14 dup(0Ah),03h,03h,3 dup(01h),03h,01h,01h,4 dup(03h),01h,26 dup(03h),01h,03h,03h
 ; linha 29 do cenario
 db 03h,01h,22 dup(03h),01h,9 dup(03h),01h,03h,03h,01h,01h,03h,38 dup(0Ah),11 dup(02h),3 dup(03h),01h
 db 5 dup(03h),01h,8 dup(03h),01h,01h,03h,01h,03h,03h,00h,00h,6 dup(03h),01h,10 dup(03h),6 dup(01h),3 dup(03h)
 db 9 dup(00h),01h,01h,7 dup(03h),10 dup(00h),4 dup(03h),01h,7 dup(03h),01h,01h,16 dup(00h),4 dup(03h)
 db 3 dup(01h),21 dup(00h),03h,13 dup(0Ah),02h,02h,26 dup(03h),02h,02h,13 dup(0Ah),03h,21 dup(00h),3 dup(01h)
 db 4 dup(03h),16 dup(00h),01h,01h,7 dup(03h),01h,4 dup(03h),10 dup(00h),7 dup(03h),01h,01h,9 dup(00h)
 db 3 dup(03h),6 dup(01h),10 dup(03h),01h,6 dup(03h),00h,00h,03h,03h,01h,03h,01h,01h,8 dup(03h),01h,5 dup(03h)
 db 01h,3 dup(03h),11 dup(02h),38 dup(0Ah),03h,01h,01h,03h,03h,01h,9 dup(03h),01h,22 dup(03h),01h,03h
 ; linha 30 do cenario
 db 37 dup(03h),17 dup(0Ah),02h,02h,20 dup(0Ah),15 dup(02h),03h,3 dup(01h),6 dup(03h),3 dup(01h),3 dup(03h)
 db 01h,01h,03h,01h,03h,03h,00h,00h,16 dup(03h),9 dup(01h),3 dup(03h),7 dup(00h),01h,8 dup(03h),10 dup(00h)
 db 4 dup(03h),01h,7 dup(03h),01h,03h,16 dup(00h),4 dup(03h),3 dup(01h),21 dup(00h),3 dup(0Ah),02h,9 dup(0Ah)
 db 5 dup(02h),22 dup(03h),5 dup(02h),9 dup(0Ah),02h,3 dup(0Ah),21 dup(00h),3 dup(01h),4 dup(03h),16 dup(00h)
 db 03h,01h,7 dup(03h),01h,4 dup(03h),10 dup(00h),8 dup(03h),01h,7 dup(00h),3 dup(03h),9 dup(01h),16 dup(03h)
 db 00h,00h,03h,03h,01h,03h,01h,01h,3 dup(03h),3 dup(01h),6 dup(03h),3 dup(01h),03h,15 dup(02h),20 dup(0Ah)
 db 02h,02h,17 dup(0Ah),37 dup(03h)
 ; linha 31 do cenario
 db 14 dup(03h),01h,01h,19 dup(03h),40 dup(0Ah),18 dup(02h),5 dup(01h),9 dup(03h),01h,5 dup(03h),00h,00h
 db 17 dup(03h),3 dup(01h),03h,01h,03h,01h,4 dup(03h),7 dup(00h),01h,8 dup(03h),01h,8 dup(00h),7 dup(03h),01h
 db 01h,3 dup(03h),01h,03h,03h,12 dup(00h),3 dup(01h),4 dup(03h),01h,03h,4 dup(01h),18 dup(00h),3 dup(0Ah),02h
 db 02h,8 dup(0Ah),3 dup(02h),0Ah,02h,02h,22 dup(03h),02h,02h,0Ah,3 dup(02h),8 dup(0Ah),02h,02h,3 dup(0Ah)
 db 18 dup(00h),4 dup(01h),03h,01h,4 dup(03h),3 dup(01h),12 dup(00h),03h,03h,01h,3 dup(03h),01h,01h,7 dup(03h)
 db 8 dup(00h),01h,8 dup(03h),01h,7 dup(00h),4 dup(03h),01h,03h,01h,03h,3 dup(01h),17 dup(03h),00h,00h
 db 5 dup(03h),01h,9 dup(03h),5 dup(01h),18 dup(02h),40 dup(0Ah),19 dup(03h),01h,01h,14 dup(03h)
 ; linha 32 do cenario
 db 32 dup(03h),42 dup(0Ah),22 dup(02h),01h,01h,8 dup(03h),01h,01h,5 dup(03h),00h,8 dup(03h),01h,3 dup(02h)
 db 6 dup(03h),02h,02h,01h,8 dup(03h),5 dup(00h),3 dup(01h),7 dup(03h),01h,01h,8 dup(00h),7 dup(03h),01h
 db 8 dup(03h),11 dup(00h),3 dup(01h),3 dup(03h),01h,03h,03h,4 dup(01h),15 dup(00h),03h,03h,4 dup(0Ah),02h
 db 7 dup(0Ah),02h,02h,4 dup(0Ah),3 dup(02h),20 dup(03h),3 dup(02h),4 dup(0Ah),02h,02h,7 dup(0Ah),02h
 db 4 dup(0Ah),03h,03h,15 dup(00h),4 dup(01h),03h,03h,01h,3 dup(03h),3 dup(01h),11 dup(00h),8 dup(03h),01h
 db 7 dup(03h),8 dup(00h),01h,01h,7 dup(03h),3 dup(01h),5 dup(00h),8 dup(03h),01h,02h,02h,6 dup(03h)
 db 3 dup(02h),01h,8 dup(03h),00h,5 dup(03h),01h,01h,8 dup(03h),01h,01h,22 dup(02h),42 dup(0Ah),32 dup(03h)
 ; linha 33 do cenario
 db 29 dup(03h),43 dup(0Ah),25 dup(02h),01h,7 dup(03h),01h,7 dup(03h),00h,9 dup(03h),4 dup(02h),03h,03h
 db 6 dup(02h),10 dup(03h),3 dup(00h),01h,01h,8 dup(03h),01h,01h,7 dup(00h),01h,7 dup(03h),01h,8 dup(03h),01h
 db 01h,9 dup(00h),01h,01h,7 dup(03h),01h,03h,3 dup(01h),13 dup(00h),03h,01h,12 dup(0Ah),02h,7 dup(0Ah)
 db 4 dup(02h),16 dup(03h),4 dup(02h),7 dup(0Ah),02h,12 dup(0Ah),01h,03h,13 dup(00h),3 dup(01h),03h,01h
 db 7 dup(03h),01h,01h,9 dup(00h),01h,01h,8 dup(03h),01h,7 dup(03h),01h,7 dup(00h),01h,01h,8 dup(03h),01h,01h
 db 3 dup(00h),10 dup(03h),6 dup(02h),03h,03h,4 dup(02h),9 dup(03h),00h,7 dup(03h),01h,7 dup(03h),01h
 db 25 dup(02h),43 dup(0Ah),29 dup(03h)
 ; linha 34 do cenario
 db 26 dup(03h),44 dup(0Ah),15 dup(02h),3 dup(0Ah),12 dup(02h),22 dup(03h),3 dup(0Ah),7 dup(02h),0Ah
 db 3 dup(02h),9 dup(03h),00h,00h,01h,03h,03h,01h,5 dup(03h),4 dup(01h),6 dup(00h),01h,01h,7 dup(03h),01h,01h
 db 7 dup(03h),01h,01h,7 dup(00h),3 dup(01h),10 dup(03h),3 dup(01h),12 dup(00h),03h,01h,4 dup(0Ah),02h
 db 16 dup(0Ah),4 dup(02h),16 dup(03h),4 dup(02h),16 dup(0Ah),02h,4 dup(0Ah),01h,03h,12 dup(00h),3 dup(01h)
 db 10 dup(03h),3 dup(01h),7 dup(00h),01h,01h,7 dup(03h),01h,01h,7 dup(03h),01h,01h,6 dup(00h),4 dup(01h)
 db 5 dup(03h),01h,03h,03h,01h,00h,00h,9 dup(03h),3 dup(02h),0Ah,7 dup(02h),3 dup(0Ah),22 dup(03h),12 dup(02h)
 db 3 dup(0Ah),15 dup(02h),44 dup(0Ah),26 dup(03h)
 ; linha 35 do cenario
 db 22 dup(03h),47 dup(0Ah),14 dup(02h),7 dup(0Ah),12 dup(02h),18 dup(03h),7 dup(0Ah),4 dup(02h),3 dup(0Ah)
 db 4 dup(02h),7 dup(03h),3 dup(01h),3 dup(03h),01h,3 dup(03h),01h,03h,03h,5 dup(01h),3 dup(00h),01h,01h
 db 4 dup(03h),01h,11 dup(03h),01h,01h,7 dup(00h),3 dup(01h),4 dup(03h),01h,5 dup(03h),3 dup(01h),11 dup(00h)
 db 03h,01h,4 dup(0Ah),02h,16 dup(0Ah),6 dup(02h),14 dup(03h),6 dup(02h),16 dup(0Ah),02h,4 dup(0Ah),01h,03h
 db 11 dup(00h),3 dup(01h),5 dup(03h),01h,4 dup(03h),3 dup(01h),7 dup(00h),01h,01h,11 dup(03h),01h,4 dup(03h)
 db 01h,01h,3 dup(00h),5 dup(01h),03h,03h,01h,3 dup(03h),01h,3 dup(03h),3 dup(01h),7 dup(03h),4 dup(02h)
 db 3 dup(0Ah),4 dup(02h),7 dup(0Ah),18 dup(03h),12 dup(02h),7 dup(0Ah),14 dup(02h),47 dup(0Ah),22 dup(03h)
 ; linha 36 do cenario
 db 20 dup(03h),9 dup(0Ah),3 dup(02h),34 dup(0Ah),15 dup(02h),8 dup(0Ah),15 dup(02h),16 dup(03h),8 dup(0Ah)
 db 02h,02h,6 dup(0Ah),3 dup(02h),6 dup(03h),01h,01h,7 dup(03h),01h,4 dup(03h),4 dup(01h),3 dup(00h),01h,01h
 db 4 dup(03h),01h,10 dup(03h),01h,01h,03h,7 dup(00h),01h,01h,03h,01h,3 dup(03h),01h,5 dup(03h),01h,03h,01h
 db 6 dup(00h),01h,03h,03h,00h,00h,01h,4 dup(0Ah),02h,02h,15 dup(0Ah),8 dup(02h),12 dup(03h),8 dup(02h)
 db 15 dup(0Ah),02h,02h,4 dup(0Ah),01h,00h,00h,03h,03h,01h,6 dup(00h),01h,03h,01h,5 dup(03h),01h,3 dup(03h)
 db 01h,03h,01h,01h,7 dup(00h),03h,01h,01h,10 dup(03h),01h,4 dup(03h),01h,01h,3 dup(00h),4 dup(01h),4 dup(03h)
 db 01h,7 dup(03h),01h,01h,6 dup(03h),3 dup(02h),6 dup(0Ah),02h,02h,8 dup(0Ah),16 dup(03h),15 dup(02h)
 db 8 dup(0Ah),15 dup(02h),34 dup(0Ah),3 dup(02h),9 dup(0Ah),20 dup(03h)
 ; linha 37 do cenario
 db 16 dup(03h),8 dup(0Ah),3 dup(02h),37 dup(0Ah),15 dup(02h),9 dup(0Ah),18 dup(02h),12 dup(03h),10 dup(0Ah)
 db 02h,8 dup(0Ah),3 dup(02h),6 dup(03h),01h,13 dup(03h),4 dup(01h),00h,03h,01h,01h,4 dup(03h),01h,01h
 db 9 dup(03h),01h,01h,3 dup(03h),4 dup(00h),3 dup(01h),03h,01h,01h,3 dup(03h),01h,3 dup(03h),01h,03h,03h,01h
 db 6 dup(00h),01h,4 dup(03h),4 dup(0Ah),02h,02h,14 dup(0Ah),02h,02h,0Ah,0Ah,8 dup(02h),8 dup(03h),8 dup(02h)
 db 0Ah,0Ah,02h,02h,14 dup(0Ah),02h,02h,4 dup(0Ah),4 dup(03h),01h,6 dup(00h),01h,03h,03h,01h,3 dup(03h),01h
 db 3 dup(03h),01h,01h,03h,3 dup(01h),4 dup(00h),3 dup(03h),01h,01h,9 dup(03h),01h,01h,4 dup(03h),01h,01h,03h
 db 00h,4 dup(01h),13 dup(03h),01h,6 dup(03h),3 dup(02h),8 dup(0Ah),02h,10 dup(0Ah),12 dup(03h),18 dup(02h)
 db 9 dup(0Ah),15 dup(02h),37 dup(0Ah),3 dup(02h),8 dup(0Ah),16 dup(03h)
 ; linha 38 do cenario
 db 8 dup(03h),13 dup(0Ah),3 dup(02h),38 dup(0Ah),4 dup(02h),5 dup(0Ah),02h,02h,0Ah,0Ah,02h,02h,10 dup(0Ah)
 db 14 dup(02h),3 dup(0Ah),4 dup(02h),8 dup(03h),22 dup(0Ah),4 dup(02h),14 dup(03h),01h,03h,03h,5 dup(01h),03h
 db 3 dup(01h),4 dup(03h),01h,9 dup(03h),3 dup(01h),03h,0Ah,0Ah,03h,03h,00h,00h,3 dup(02h),03h,01h,8 dup(03h)
 db 01h,03h,03h,01h,01h,4 dup(00h),01h,01h,3 dup(03h),3 dup(0Ah),02h,02h,10 dup(0Ah),02h,02h,10 dup(0Ah)
 db 8 dup(02h),4 dup(03h),8 dup(02h),10 dup(0Ah),02h,02h,10 dup(0Ah),02h,02h,3 dup(0Ah),3 dup(03h),01h,01h
 db 4 dup(00h),01h,01h,03h,03h,01h,8 dup(03h),01h,03h,3 dup(02h),00h,00h,03h,03h,0Ah,0Ah,03h,3 dup(01h)
 db 9 dup(03h),01h,4 dup(03h),3 dup(01h),03h,5 dup(01h),03h,03h,01h,14 dup(03h),4 dup(02h),22 dup(0Ah)
 db 8 dup(03h),4 dup(02h),3 dup(0Ah),14 dup(02h),10 dup(0Ah),02h,02h,0Ah,0Ah,02h,02h,5 dup(0Ah),4 dup(02h)
 db 38 dup(0Ah),3 dup(02h),13 dup(0Ah),8 dup(03h)
 ; linha 39 do cenario
 db 4 dup(03h),14 dup(0Ah),5 dup(02h),37 dup(0Ah),02h,02h,23 dup(0Ah),5 dup(02h),0Ah,0Ah,02h,0Ah,0Ah
 db 4 dup(02h),4 dup(0Ah),8 dup(02h),3 dup(03h),23 dup(0Ah),7 dup(02h),11 dup(03h),01h,3 dup(03h),9 dup(01h)
 db 4 dup(03h),01h,8 dup(03h),01h,4 dup(03h),4 dup(0Ah),03h,03h,4 dup(02h),03h,01h,6 dup(03h),01h,4 dup(03h)
 db 01h,3 dup(03h),01h,01h,3 dup(03h),3 dup(0Ah),02h,02h,21 dup(0Ah),11 dup(02h),03h,03h,11 dup(02h)
 db 21 dup(0Ah),02h,02h,3 dup(0Ah),3 dup(03h),01h,01h,3 dup(03h),01h,4 dup(03h),01h,6 dup(03h),01h,03h
 db 4 dup(02h),03h,03h,4 dup(0Ah),4 dup(03h),01h,8 dup(03h),01h,4 dup(03h),9 dup(01h),3 dup(03h),01h
 db 11 dup(03h),7 dup(02h),23 dup(0Ah),3 dup(03h),8 dup(02h),4 dup(0Ah),4 dup(02h),0Ah,0Ah,02h,0Ah,0Ah
 db 5 dup(02h),23 dup(0Ah),02h,02h,37 dup(0Ah),5 dup(02h),14 dup(0Ah),4 dup(03h)
 ; linha 40 do cenario
 db 14 dup(0Ah),5 dup(02h),26 dup(0Ah),02h,02h,36 dup(0Ah),5 dup(02h),8 dup(0Ah),02h,5 dup(0Ah),10 dup(02h)
 db 16 dup(0Ah),02h,02h,6 dup(0Ah),9 dup(02h),13 dup(03h),10 dup(01h),03h,03h,4 dup(01h),10 dup(03h)
 db 7 dup(0Ah),02h,02h,0Ah,3 dup(02h),7 dup(03h),01h,11 dup(03h),27 dup(0Ah),9 dup(02h),8 dup(0Ah),9 dup(02h)
 db 27 dup(0Ah),11 dup(03h),01h,7 dup(03h),3 dup(02h),0Ah,02h,02h,7 dup(0Ah),10 dup(03h),4 dup(01h),03h,03h
 db 10 dup(01h),13 dup(03h),9 dup(02h),6 dup(0Ah),02h,02h,16 dup(0Ah),10 dup(02h),5 dup(0Ah),02h,8 dup(0Ah)
 db 5 dup(02h),36 dup(0Ah),02h,02h,26 dup(0Ah),5 dup(02h),14 dup(0Ah)
 ; linha 41 do cenario
 db 41 dup(0Ah),4 dup(02h),36 dup(0Ah),02h,02h,22 dup(0Ah),5 dup(02h),16 dup(0Ah),02h,02h,6 dup(0Ah)
 db 5 dup(02h),3 dup(0Ah),5 dup(02h),10 dup(03h),01h,01h,03h,01h,03h,3 dup(01h),03h,01h,3 dup(03h),3 dup(01h)
 db 11 dup(03h),11 dup(0Ah),4 dup(02h),13 dup(03h),01h,03h,28 dup(0Ah),3 dup(02h),0Ah,02h,18 dup(0Ah),02h,0Ah
 db 3 dup(02h),28 dup(0Ah),03h,01h,13 dup(03h),4 dup(02h),11 dup(0Ah),11 dup(03h),3 dup(01h),3 dup(03h),01h
 db 03h,3 dup(01h),03h,01h,03h,01h,01h,10 dup(03h),5 dup(02h),3 dup(0Ah),5 dup(02h),6 dup(0Ah),02h,02h
 db 16 dup(0Ah),5 dup(02h),22 dup(0Ah),02h,02h,36 dup(0Ah),4 dup(02h),41 dup(0Ah)
 ; linha 42 do cenario
 db 7 dup(0Ah),3 dup(02h),93 dup(0Ah),6 dup(02h),25 dup(0Ah),3 dup(02h),6 dup(0Ah),6 dup(02h),7 dup(03h),01h
 db 3 dup(03h),01h,03h,03h,01h,01h,5 dup(03h),01h,01h,11 dup(03h),11 dup(0Ah),7 dup(02h),11 dup(03h),01h
 db 27 dup(0Ah),4 dup(02h),24 dup(0Ah),4 dup(02h),27 dup(0Ah),01h,11 dup(03h),7 dup(02h),11 dup(0Ah)
 db 11 dup(03h),01h,01h,5 dup(03h),01h,01h,03h,03h,01h,3 dup(03h),01h,7 dup(03h),6 dup(02h),6 dup(0Ah)
 db 3 dup(02h),25 dup(0Ah),6 dup(02h),93 dup(0Ah),3 dup(02h),7 dup(0Ah)
 ; linha 43 do cenario
 db 103 dup(0Ah),3 dup(02h),26 dup(0Ah),4 dup(02h),6 dup(0Ah),9 dup(02h),12 dup(03h),01h,6 dup(03h),3 dup(01h)
 db 8 dup(03h),12 dup(0Ah),9 dup(02h),10 dup(03h),22 dup(0Ah),4 dup(02h),36 dup(0Ah),4 dup(02h),22 dup(0Ah)
 db 10 dup(03h),9 dup(02h),12 dup(0Ah),8 dup(03h),3 dup(01h),6 dup(03h),01h,12 dup(03h),9 dup(02h),6 dup(0Ah)
 db 4 dup(02h),26 dup(0Ah),3 dup(02h),103 dup(0Ah)
 ; linha 44 do cenario
 db 101 dup(0Ah),3 dup(02h),16 dup(0Ah),02h,02h,8 dup(0Ah),4 dup(02h),6 dup(0Ah),13 dup(02h),9 dup(03h),01h
 db 01h,5 dup(03h),4 dup(01h),7 dup(03h),12 dup(0Ah),6 dup(02h),0Ah,0Ah,4 dup(02h),6 dup(03h),4 dup(0Ah),02h
 db 02h,16 dup(0Ah),02h,02h,44 dup(0Ah),02h,02h,16 dup(0Ah),02h,02h,4 dup(0Ah),6 dup(03h),4 dup(02h),0Ah,0Ah
 db 6 dup(02h),12 dup(0Ah),7 dup(03h),4 dup(01h),5 dup(03h),01h,01h,9 dup(03h),13 dup(02h),6 dup(0Ah)
 db 4 dup(02h),8 dup(0Ah),02h,02h,16 dup(0Ah),3 dup(02h),101 dup(0Ah)
 ; linha 45 do cenario
 db 99 dup(0Ah),4 dup(02h),15 dup(0Ah),02h,02h,19 dup(0Ah),16 dup(02h),6 dup(03h),01h,7 dup(03h),4 dup(01h)
 db 5 dup(03h),14 dup(0Ah),3 dup(02h),0Ah,02h,6 dup(0Ah),3 dup(02h),3 dup(03h),3 dup(0Ah),02h,02h,84 dup(0Ah)
 db 02h,02h,3 dup(0Ah),3 dup(03h),3 dup(02h),6 dup(0Ah),02h,0Ah,3 dup(02h),14 dup(0Ah),5 dup(03h),4 dup(01h)
 db 7 dup(03h),01h,6 dup(03h),16 dup(02h),19 dup(0Ah),02h,02h,15 dup(0Ah),4 dup(02h),99 dup(0Ah)
 ; linha 46 do cenario
 db 96 dup(0Ah),3 dup(02h),39 dup(0Ah),18 dup(02h),13 dup(03h),6 dup(01h),3 dup(03h),10 dup(0Ah),6 dup(02h)
 db 8 dup(0Ah),4 dup(02h),100 dup(0Ah),4 dup(02h),8 dup(0Ah),6 dup(02h),10 dup(0Ah),3 dup(03h),6 dup(01h)
 db 13 dup(03h),18 dup(02h),39 dup(0Ah),3 dup(02h),96 dup(0Ah)
 ; linha 47 do cenario
 db 94 dup(0Ah),02h,02h,10 dup(0Ah),02h,02h,7 dup(0Ah),02h,02h,20 dup(0Ah),20 dup(02h),11 dup(03h),7 dup(01h)
 db 15 dup(0Ah),02h,02h,8 dup(0Ah),02h,02h,108 dup(0Ah),02h,02h,8 dup(0Ah),02h,02h,15 dup(0Ah),7 dup(01h)
 db 11 dup(03h),20 dup(02h),20 dup(0Ah),02h,02h,7 dup(0Ah),02h,02h,10 dup(0Ah),02h,02h,94 dup(0Ah)
 ; linha 48 do cenario
 db 104 dup(0Ah),6 dup(02h),26 dup(0Ah),23 dup(02h),9 dup(03h),3 dup(01h),27 dup(0Ah),02h,02h,112 dup(0Ah),02h
 db 02h,27 dup(0Ah),3 dup(01h),9 dup(03h),23 dup(02h),26 dup(0Ah),6 dup(02h),104 dup(0Ah)
 ; linha 49 do cenario
 db 105 dup(0Ah),4 dup(02h),25 dup(0Ah),28 dup(02h),6 dup(03h),176 dup(0Ah),6 dup(03h),28 dup(02h),25 dup(0Ah)
 db 4 dup(02h),105 dup(0Ah)
 ; linha 50 do cenario
 db 106 dup(0Ah),02h,02h,3 dup(0Ah),3 dup(02h),18 dup(0Ah),13 dup(02h),0Ah,0Ah,19 dup(02h),180 dup(0Ah)
 db 19 dup(02h),0Ah,0Ah,13 dup(02h),18 dup(0Ah),3 dup(02h),3 dup(0Ah),02h,02h,106 dup(0Ah)
 ; linha 51 do cenario
 db 104 dup(0Ah),02h,02h,24 dup(0Ah),10 dup(02h),0Ah,0Ah,02h,02h,5 dup(0Ah),02h,0Ah,0Ah,02h,02h,0Ah
 db 13 dup(02h),176 dup(0Ah),13 dup(02h),0Ah,02h,02h,0Ah,0Ah,02h,5 dup(0Ah),02h,02h,0Ah,0Ah,10 dup(02h)
 db 24 dup(0Ah),02h,02h,104 dup(0Ah)
 ; linha 52 do cenario
 db 129 dup(0Ah),10 dup(02h),18 dup(0Ah),13 dup(02h),172 dup(0Ah),13 dup(02h),18 dup(0Ah),10 dup(02h)
 db 129 dup(0Ah)
 ; linha 53 do cenario
 db 127 dup(0Ah),4 dup(02h),4 dup(0Ah),02h,02h,23 dup(0Ah),12 dup(02h),168 dup(0Ah),12 dup(02h),23 dup(0Ah)
 db 02h,02h,4 dup(0Ah),4 dup(02h),127 dup(0Ah)
 ; linha 54 do cenario
 db 125 dup(0Ah),3 dup(02h),34 dup(0Ah),4 dup(02h),0Ah,9 dup(02h),160 dup(0Ah),9 dup(02h),0Ah,4 dup(02h)
 db 34 dup(0Ah),3 dup(02h),125 dup(0Ah)
 ; linha 55 do cenario
 db 123 dup(0Ah),02h,02h,35 dup(0Ah),4 dup(02h),6 dup(0Ah),02h,02h,4 dup(0Ah),02h,02h,156 dup(0Ah),02h,02h
 db 4 dup(0Ah),02h,02h,6 dup(0Ah),4 dup(02h),35 dup(0Ah),02h,02h,123 dup(0Ah)
 ; linha 56 do cenario
 db 158 dup(0Ah),4 dup(02h),16 dup(0Ah),02h,02h,152 dup(0Ah),02h,02h,16 dup(0Ah),4 dup(02h),158 dup(0Ah)
 ; linha 57 do cenario
 db 155 dup(0Ah),4 dup(02h),194 dup(0Ah),4 dup(02h),155 dup(0Ah)
 ; linha 58 do cenario
 db 153 dup(0Ah),02h,02h,202 dup(0Ah),02h,02h,153 dup(0Ah)
 ; linha 59 do cenario
 db 512 dup(0Ah)
; nave_alien1: 14x14 pixels, 196 bytes.
nave_alien1 label byte
 db 14 dup(00h)
 db 14 dup(00h)
 db 14 dup(00h)
 db 6 dup(00h),09h,09h,6 dup(00h)
 db 4 dup(00h),6 dup(09h),4 dup(00h)
 db 3 dup(00h),09h,09h,04h,09h,09h,04h,09h,09h,3 dup(00h)
 db 3 dup(00h),8 dup(09h),3 dup(00h)
 db 00h,00h,3 dup(0Eh),4 dup(09h),3 dup(0Eh),00h,00h
 db 00h,12 dup(0Eh),00h
 db 5 dup(0Eh),4 dup(00h),5 dup(0Eh)
 db 00h,00h,04h,04h,6 dup(00h),04h,04h,00h,00h
 db 14 dup(00h)
 db 14 dup(00h)
 db 14 dup(00h)
; nave_alien2: 14x14 pixels, 196 bytes.
nave_alien2 label byte
 db 6 dup(00h),09h,09h,6 dup(00h)
 db 5 dup(00h),4 dup(09h),5 dup(00h)
 db 4 dup(00h),6 dup(09h),4 dup(00h)
 db 4 dup(00h),6 dup(09h),4 dup(00h)
 db 4 dup(00h),3 dup(09h),04h,09h,09h,4 dup(00h)
 db 5 dup(00h),4 dup(09h),5 dup(00h)
 db 4 dup(00h),04h,00h,09h,09h,00h,04h,4 dup(00h)
 db 00h,00h,09h,09h,6 dup(00h),09h,09h,00h,00h
 db 00h,4 dup(09h),4 dup(00h),4 dup(09h),00h
 db 09h,09h,04h,3 dup(09h),00h,00h,6 dup(09h)
 db 6 dup(09h),04h,04h,09h,04h,4 dup(09h)
 db 6 dup(09h),00h,00h,6 dup(09h)
 db 00h,4 dup(09h),4 dup(00h),4 dup(09h),00h
 db 00h,00h,09h,09h,6 dup(00h),09h,09h,00h,00h
; nave_alien3: 14x14 pixels, 196 bytes.
nave_alien3 label byte
 db 14 dup(00h)
 db 14 dup(00h)
 db 14 dup(00h)
 db 5 dup(00h),4 dup(0Eh),5 dup(00h)
 db 3 dup(00h),8 dup(0Eh),3 dup(00h)
 db 00h,12 dup(0Eh),00h
 db 14 dup(0Eh)
 db 0Eh,0Eh,3 dup(04h),9 dup(0Eh)
 db 00h,4 dup(0Eh),04h,04h,6 dup(0Eh),00h
 db 4 dup(00h),6 dup(0Eh),4 dup(00h)
 db 14 dup(00h)
 db 14 dup(00h)
 db 14 dup(00h)
 db 14 dup(00h)
; relogio: 7x8 pixels, 56 bytes.
relogio label byte
 db 00h,00h,3 dup(0Eh),00h,00h
 db 00h,0Eh,0Eh,00h,0Eh,0Eh,00h
 db 3 dup(0Eh),00h,3 dup(0Eh)
 db 3 dup(0Eh),00h,3 dup(0Eh)
 db 3 dup(0Eh),3 dup(00h),0Eh
 db 7 dup(0Eh)
 db 00h,5 dup(0Eh),00h
 db 00h,00h,3 dup(0Eh),00h,00h
; rocha1: 12x10 pixels, 120 bytes.
rocha1 label byte
 db 12 dup(00h)
 db 12 dup(00h)
 db 12 dup(00h)
 db 12 dup(00h)
 db 3 dup(00h),06h,08h,7 dup(00h)
 db 00h,00h,06h,06h,08h,7 dup(00h)
 db 00h,06h,06h,08h,08h,7 dup(00h)
 db 00h,06h,08h,06h,08h,7 dup(00h)
 db 00h,5 dup(06h),6 dup(00h)
 db 6 dup(06h),08h,5 dup(00h)
; rocha2: 12x10 pixels, 120 bytes.
rocha2 label byte
 db 12 dup(00h)
 db 12 dup(00h)
 db 3 dup(00h),06h,08h,7 dup(00h)
 db 00h,00h,4 dup(06h),00h,08h,08h,3 dup(00h)
 db 00h,00h,4 dup(06h),3 dup(08h),3 dup(00h)
 db 00h,00h,4 dup(06h),3 dup(08h),3 dup(00h)
 db 00h,4 dup(06h),4 dup(08h),3 dup(00h)
 db 00h,06h,06h,08h,08h,3 dup(06h),08h,08h,00h,00h
 db 06h,06h,08h,3 dup(06h),08h,08h,06h,08h,00h,00h
 db 06h,08h,3 dup(06h),08h,3 dup(06h),08h,08h,00h
; rocha3: 12x10 pixels, 120 bytes.
rocha3 label byte
 db 12 dup(00h)
 db 5 dup(00h),3 dup(08h),4 dup(00h)
 db 5 dup(00h),06h,3 dup(08h),3 dup(00h)
 db 4 dup(00h),3 dup(06h),08h,08h,3 dup(00h)
 db 3 dup(00h),08h,4 dup(06h),08h,3 dup(00h)
 db 00h,00h,5 dup(06h),08h,06h,08h,00h,00h
 db 00h,00h,7 dup(06h),08h,00h,00h
 db 00h,3 dup(06h),08h,3 dup(06h),08h,3 dup(00h)
 db 8 dup(06h),08h,08h,00h,00h
 db 08h,6 dup(06h),4 dup(08h),00h
; rocha4: 12x10 pixels, 120 bytes.
rocha4 label byte
 db 5 dup(00h),08h,08h,5 dup(00h)
 db 4 dup(00h),06h,06h,08h,08h,4 dup(00h)
 db 3 dup(00h),06h,06h,3 dup(08h),4 dup(00h)
 db 00h,00h,5 dup(06h),08h,4 dup(00h)
 db 00h,00h,4 dup(06h),4 dup(08h),00h,00h
 db 00h,00h,4 dup(06h),08h,06h,06h,08h,08h,00h
 db 00h,00h,3 dup(06h),08h,3 dup(06h),08h,08h,00h
 db 00h,9 dup(06h),08h,00h
 db 00h,3 dup(06h),08h,3 dup(06h),08h,06h,06h,08h
 db 12 dup(06h)

.code

; limpar a tela, altera ax,cx,di
LIMPA_TELA proc
 xor di,di
 xor ax,ax
 mov cx,32000
 rep stosw
 ret
LIMPA_TELA endp

; usa x em ax e y em bx pra achar a posicao na memoria de video.
; saida di=offset.
CALCULA_OFFSET proc
    push AX
    push DX
    push AX             ; guarda x
    mov AX, BX          ; ax = y
    mov DX, LARGURA
    mul DX              ; ax = y * 320 (maximo 63680)
    pop DI              ; di = x
    add DI, AX          ; di = y*320 + x
    pop DX
    pop AX
    ret
CALCULA_OFFSET endp

; escreve o texto de si, dh/dl dizem onde e bl escolhe a cor. o texto termina em $.
; mantem os registradores que usa.
ESCREVE_STRING proc
    push AX
    push BX
    push SI
    mov BH, 0               ; pagina de video 0
    mov AH, 02h             ; posiciona o cursor (dh, dl)
    int 10h
    LOOP_ESCREVE_STRING:
        lodsb               ; al = proximo caractere
        cmp AL, '$'
        je FIM_ESCREVE_STRING
        mov AH, 0Eh         ; escreve al na tela (bl = cor)
        int 10h
        jmp LOOP_ESCREVE_STRING
    FIM_ESCREVE_STRING:
    pop SI
    pop BX
    pop AX
    ret
ESCREVE_STRING endp

; escreve numero decimal. entrada ax=numero,cx=digitos,dh/dl=posicao,bl=cor.
; saida: tela; altera ax,si; preserva bx,cx,dx para os textos seguintes.
ESCREVE_NUMERO proc
 push bx
 push dx
 push cx
 mov si,offset buffer_numero+4
 mov cx,5
 mov bx,10
EN_DIGITO:
 xor dx,dx
 div bx
 add dl,'0'
 mov [si],dl
 dec si
 loop EN_DIGITO
 pop cx
 mov si,offset buffer_numero+5
 sub si,cx
 pop dx
 pop bx
 call ESCREVE_STRING
 ret
ESCREVE_NUMERO endp

; aqui eu dou uma pausa entre os quadros pra controlar a velocidade do jogo.
; mantem os registradores que usa.
ESPERA_FRAME proc
    push AX
    push CX
    push DX
    xor CX, CX              ; cx:dx = tempo em microssegundos
    mov DX, DELAY_FRAME
    mov AH, 86h
    int 15h
    pop DX
    pop CX
    pop AX
    ret
ESPERA_FRAME endp

; retirar as teclas acumuladas pra nao atrasar os comandos.
LIMPA_BUFFER_TECLADO proc
    push AX
    LOOP_LIMPA_BUFFER:
        mov AH, 01h         ; zf = 1 se nao ha tecla
        int 16h
        jz FIM_LIMPA_BUFFER
        xor AH, AH          ; le (e remove) a tecla
        int 16h
        jmp LOOP_LIMPA_BUFFER
    FIM_LIMPA_BUFFER:
    pop AX
    ret
LIMPA_BUFFER_TECLADO endp

; sortear um numero abaixo do limite que veio em cx, saida ax
SORTEIA proc
    push DX
    mov AX, [seed]
    mov DX, 25173           ; https://stackoverflow.com/questions/40698309
    mul DX                  ; dx:ax = seed * 25173
    add AX, 13849
    mov [seed], AX          ; nova semente
    xor DX, DX
    div CX                  ; dx = resto = ax mod cx
    mov AX, DX
    pop DX
    ret
SORTEIA endp

; testar colisao
TESTA_COLISAO proc
    mov AX, [col_x1]
    add AX, [col_l1]
    cmp AX, [col_x2]
    jle SEM_COLISAO 
    mov AX, [col_x2]
    add AX, [col_l2]
    cmp AX, [col_x1]
    jle SEM_COLISAO
    mov AX, [col_y1]
    add AX, [col_a1]
    cmp AX, [col_y2]
    jle SEM_COLISAO
    mov AX, [col_y2]
    add AX, [col_a2]
    cmp AX, [col_y1]
    jle SEM_COLISAO
    mov AL, 1
    ret
    SEM_COLISAO:
    mov AL, 0
    ret
TESTA_COLISAO endp

; copiar sprites para interface
; altera ax,bx,cx,dx,si,di
DESENHA_ICONE proc
 call CALCULA_OFFSET
 mov bx,cx
DI_LINHA:
 mov cx,bx
 rep movsb
 add di,LARGURA
 sub di,bx
 dec dx
 jnz DI_LINHA
 ret
DESENHA_ICONE endp

; copiar cenario para linha temporaria
FUNDO_LINHA proc
 mov ax,linha_y
 sub ax,CENARIO_Y
 mov bx,CENARIO_W
 mul bx
 mov bp,ax
 mov si,offset cenario
 add si,bp
 add si,scroll_cenario
 mov cx,CENARIO_W
 sub cx,scroll_cenario
 cmp cx,LARGURA
 jbe FL_TRECHO
 mov cx,LARGURA
FL_TRECHO:
 mov bx,LARGURA
 sub bx,cx
 push es
 push ds
 pop es
 mov di,offset linha_pixels
 rep movsb
 ; chegou no fim da faixa? copia o resto a partir do comeco.
 mov si,offset cenario
 add si,bp
 mov cx,bx
 rep movsb
 pop es
 ret
FUNDO_LINHA endp

; marcar linhas ocupadas altera ax,bx,dx
MARCA_RETANGULO proc
 cmp ax,LARGURA
 jge MR_FIM
 add ax,cx
 cmp ax,0
 jle MR_FIM
 add dx,bx
 cmp bx,TOPO
 jge MR_LIMITE
 mov bx,TOPO
MR_LIMITE:
 cmp dx,PISTA+7
 jle MR_LOOP
 mov dx,PISTA+7
MR_LOOP:
 cmp bx,dx
 jge MR_FIM
 mov linhas_sujas[bx],1
 inc bx
 jmp MR_LOOP
MR_FIM:
 ret
MARCA_RETANGULO endp

; posicoes antes e depois do movimento, e removidos.
MARCA_ENTIDADES proc
 xor si,si
ME_LOOP:
 mov bx,tipo[si]
 or bx,bx
 jz ME_PROX
 shl bx,1
 mov cx,larguras[bx]
 mov dx,alturas[bx]
 mov bx,obj_y[si]
 mov ax,obj_x[si]
 call MARCA_RETANGULO
ME_PROX:
 add si,2
 cmp si,FIM_OBJ
 jb ME_LOOP
 mov ax,jx
 mov bx,jy
 mov cx,20
 mov dx,10
 call MARCA_RETANGULO
 ret
MARCA_ENTIDADES endp


; parte do sprite que pertence a linha atual.
; altera ax,bx,cx,dx,si,di,bp.
SPRITE_LINHA proc
 mov di,ax
 mov ax,linha_y
 sub ax,bx
 js SL_FIM
 cmp ax,dx
 jae SL_FIM
 or si,si
 jz SL_SOLIDO
 mul cx
 add si,ax
SL_SOLIDO:
 mov bp,cx
SL_PIXEL:
 mov al,cor_retangulo
 or si,si
 jz SL_COR
 lodsb
 or al,al
 jz SL_PROX
SL_COR:
 cmp di,0
 jl SL_PROX
 cmp di,LARGURA
 jge SL_PROX
 mov linha_pixels[di],al
SL_PROX:
 inc di
 dec bp
 jnz SL_PIXEL
SL_FIM:
 ret
SPRITE_LINHA endp

; objetos e jipe sobre a linha de fundo pronta.
OBJETOS_LINHA proc
 xor di,di
OL_LOOP:
 mov bx,tipo[di]
 or bx,bx
 jz OL_PROX
 push di
 mov cor_retangulo,0
 mov si,bx
 mov al,cores[si]
 mov cor_retangulo,al
 shl bx,1
 mov cx,larguras[bx]
 mov dx,alturas[bx]
 xor si,si
 cmp bx,22
 jae OL_POSICAO
 mov si,imagens[bx]
OL_POSICAO:
 mov ax,obj_x[di]
 mov bx,obj_y[di]
 call SPRITE_LINHA
 pop di
OL_PROX:
 add di,2
 cmp di,FIM_OBJ
 jb OL_LOOP
 cmp invencivel,0
 je OL_JIPE
 test invencivel,2
 jnz OL_FIM
OL_JIPE:
 mov ax,jx
 mov bx,jy
 mov cx,20
 mov dx,10
 mov si,offset jipe
 call SPRITE_LINHA
OL_FIM:
 ret
OBJETOS_LINHA endp

; preencher a linha temporaria com dois pixels da cor em ax, altera cx,di
PREPARA_LINHA proc
 push es
 push ds
 pop es
 mov di,offset linha_pixels
 mov cx,LARGURA/2
 rep stosw
 pop es
 ret
PREPARA_LINHA endp

; a linha nao mudou? entao nem precisa copiar de novo pra tela.
; entradas linha_y,linha_pixels, altera ax,bx,cx,si,di.
ENVIA_LINHA proc
 xor ax,ax
 mov bx,linha_y
 call CALCULA_OFFSET
 push di
 mov si,offset linha_pixels
 mov cx,LARGURA/2
 repe cmpsw
 pop di
 je EL_FIM
 mov si,offset linha_pixels
 mov cx,LARGURA/2
 rep movsw
EL_FIM:
 ret
ENVIA_LINHA endp

; repor as linhas do cenario e linhas ocupadas
; montar uma linha de cada vez, sem apagar a imagem que ja esta na tela.
DESENHA_QUADRO proc
 mov linha_y,TOPO
DQ_LINHA:
 mov bx,linha_y
 cmp bx,CENARIO_Y
 jb DQ_ESTATICA
 cmp bx,PAREDE_Y
 jb DQ_MONTA
DQ_ESTATICA:
 cmp linhas_sujas[bx],0
 jne DQ_MONTA
 jmp DQ_PROX
DQ_MONTA:
 mov linhas_sujas[bx],0
 cmp bx,CENARIO_Y
 jb DQ_PRETO
 cmp bx,PAREDE_Y
 jb DQ_FUNDO
 mov ax,COR_PAREDE*101h
 cmp bx,PISTA
 jb DQ_PREENCHE
 mov ax,0e0eh
 jmp DQ_PREENCHE
DQ_PRETO:
 xor ax,ax
DQ_PREENCHE:
 call PREPARA_LINHA
 jmp DQ_OBJETOS
DQ_FUNDO:
 call FUNDO_LINHA
DQ_OBJETOS:
 call OBJETOS_LINHA
 call ENVIA_LINHA
DQ_PROX:
 inc linha_y
 cmp linha_y,PISTA+7
 jae DQ_FIM
 jmp DQ_LINHA
DQ_FIM:
 ret
DESENHA_QUADRO endp

; atualizar apenas os campos do hud que mudaram.
HUD proc
 cmp hud_inicial,0
 je HUD_PONTOS
 mov hud_inicial,0
 mov ax,280
 mov bx,1
 mov cx,7
 mov dx,8
 mov si,offset relogio
 call DESENHA_ICONE
HUD_PONTOS:
 mov ax,pontos
 cmp ax,cache_pontos
 je HUD_TEMPO
 mov cache_pontos,ax
 xor dh,dh
 mov dl,HUD_NUMERO_COL
 mov bl,15
 mov cx,5
 call ESCREVE_NUMERO
HUD_TEMPO:
 mov ax,tempo
 cmp ax,cache_tempo
 je HUD_VIDAS
 mov cache_tempo,ax
 mov dx,0024h
 mov bl,15
 mov cx,3
 call ESCREVE_NUMERO
HUD_VIDAS:
 mov ax,vidas
 cmp ax,cache_vidas
 jne HUD_MUDA_VIDAS
 ret
HUD_MUDA_VIDAS:
 mov cache_vidas,ax
 ; unico retangulo apagado: os 18x11 pixels reservados as vidas.
 mov di,LARGURA+HUD_VIDAS_X
 xor ax,ax
 mov dx,11
HUD_APAGA:
 mov cx,18
 rep stosb
 add di,LARGURA-18
 dec dx
 jnz HUD_APAGA
 cmp vidas,0
 je HUD_FIM
 mov ax,HUD_VIDAS_X
 mov cx,18
 mov si,offset coracoes_3
 cmp vidas,3
 je HUD_COR
 mov ax,HUD_VIDAS_X+2
 mov cx,14
 mov si,offset coracoes_2
 cmp vidas,2
 je HUD_COR
 mov ax,HUD_VIDAS_X+4
 mov cx,10
 mov si,offset coracoes_1
HUD_COR:
 mov bx,1
 mov dx,11
 call DESENHA_ICONE
HUD_FIM:
 ret
HUD endp

; ler tecla sem aguardar
LE_TECLA proc
 mov tecla,0
 mov ah,1
 int 16h
 jz LT_FIM
 xor ah,ah
 int 16h
 mov tecla,ax
 call LIMPA_BUFFER_TECLADO
LT_FIM:
 ret
LE_TECLA endp

VAGA_TIRO proc
 mov si,INI_TIROS
VT_LOOP:
 cmp tipo[si],0
 je VT_FIM
 add si,2
 cmp si,FIM_OBJ
 jb VT_LOOP
VT_FIM:
 ret
VAGA_TIRO endp

; criar um tiro para cima e outro pra direita.
; entrada jx,jy, altera ax,bx,dx,si
ATIRA proc
 ; primeiro conferir as duas vagas se nao couber o par, nao sai nenhum tiro.
 mov si,INI_TIROS
 xor cx,cx
AT_CONTA:
 cmp tipo[si],0
 jne AT_SEGUINTE
 inc cx
AT_SEGUINTE:
 add si,2
 cmp si,FIM_OBJ
 jb AT_CONTA
 cmp cx,2
 jae AT_PAR
 ret
AT_PAR:
 mov bx,11
AT_CANHAO:
 call VAGA_TIRO
 cmp si,FIM_OBJ
 je AT_FIM
 mov tipo[si],bx
 mov percurso[si],0
 mov ax,jx
 mov dx,jy
 cmp bx,11
 jne AT_FRENTE
 add ax,10
 sub dx,TIRO_H
 jmp AT_POSICAO
AT_FRENTE:
 add ax,20
 add dx,4
AT_POSICAO:
 mov obj_x[si],ax
 mov obj_y[si],dx
 inc bx
 cmp bx,12
 jbe AT_CANHAO
AT_FIM:
 ret
ATIRA endp

; mover o jipe e cuidar do do pulo: sobe, fica no topo e desce sozinho.
; entrada tecla,jx,jy,salto, saida estado altera ax,si.
MOVE_JIPE proc
 mov ax,jx
 mov jx_anterior,ax
 mov ax,tecla
 cmp ah,1
 jne MJ_ESQ
 mov sair,1
MJ_ESQ:
 cmp ah,4bh
 jne MJ_DIR
 sub jx,VEL_JIPE
 jns MJ_DIR
 mov jx,JIPE_INICIO_X
MJ_DIR:
 cmp ah,4dh
 jne MJ_CIMA
 add jx,VEL_JIPE
 cmp jx,JIPE_MAX
 jbe MJ_CIMA
 mov jx,JIPE_MAX
MJ_CIMA:
 cmp ah,48h
 jne MJ_TIRO
 cmp salto,0
 jne MJ_TIRO
 mov salto,1
MJ_TIRO:
 cmp ah,39h
 jne MJ_SALTO
 call ATIRA
MJ_SALTO:
 cmp salto,1
 jne MJ_PLATO
 sub jy,SALTO_PASSO
 cmp jy,JIPE_Y-SALTO_ALT
 ja MJ_FIM
 mov salto,2
 mov plato,0
 jmp MJ_FIM
MJ_PLATO:
 cmp salto,2
 jne MJ_DESCE
 ; distancia percorrida em relacao ao terreno, mesmo parado na tela.
 mov ax,jx
 sub ax,jx_anterior
 add ax,VEL_MUNDO
 jns MJ_DISTANCIA
 neg ax
MJ_DISTANCIA:
 add plato,ax
 cmp plato,SALTO_PLATO_PIXELS
 jb MJ_FIM
 mov salto,3
 jmp MJ_FIM
MJ_DESCE:
 cmp salto,3
 jne MJ_FIM
 add jy,SALTO_PASSO
 cmp jy,JIPE_Y
 jb MJ_FIM
 mov jy,JIPE_Y
 mov salto,0
MJ_FIM:
 ret
MOVE_JIPE endp

; so criar outro grupo de naves quando todas as anteriores ja sumiram.
; altera ax,bx,cx,dx,si,di.
GERA_GRUPO proc
 xor si,si
GG_CONFERE:
 cmp tipo[si],0
 jne GG_FIM
 add si,2
 cmp si,FIM_NAVES
 jb GG_CONFERE
 mov cx,MAX_NAVES
 call SORTEIA
 inc ax
 mov di,ax
 mov cx,TIPOS_NAVES
 call SORTEIA
 inc ax
 mov bx,ax
 mov cx,NAVE_VAR_ENTRADA
 call SORTEIA
 add ax,LARGURA
 mov dx,ax
 xor si,si
GG_CRIA:
 mov tipo[si],bx
 mov obj_x[si],dx
 mov cx,NAVE_VAR_Y
 call SORTEIA
 add ax,TOPO
 mov obj_y[si],ax
 mov cx,NAVE_VAR_DIST
 call SORTEIA
 add ax,NAVE_DISTANCIA
 add dx,ax
 add si,2
 dec di
 jnz GG_CRIA
GG_FIM:
 ret
GERA_GRUPO endp

; gerar uma cratera ou rocha num lugar livre altera si,bx, entrada ax tipo
CRIA_OBST proc
 mov si,INI_OBST
CO_BUSCA:
 cmp tipo[si],0
 je CO_CRIA
 add si,2
 cmp si,FIM_OBST
 jb CO_BUSCA
 ret
CO_CRIA:
 mov tipo[si],ax
 mov obj_x[si],LARGURA
 mov obj_y[si],PISTA
 cmp ax,7
 jb CO_PRONTO
 mov obj_y[si],JIPE_Y
CO_PRONTO:
 mov marcado[si],0
 mov resist[si],1
 cmp ax,10
 jne CO_FIM
 mov resist[si],2
CO_FIM:
 ret
CRIA_OBST endp

; alternar crateras e uma rocha no meio altera ax,cx,si,bx.
GERA_OBSTACULOS proc
 add distancia,VEL_MUNDO
 cmp rocha_pendente,0
 je GO_CRATERA
 mov ax,proxima
 shr ax,1
 cmp distancia,ax
 jb GO_CRATERA
 mov cx,TIPOS_ROCHAS
 call SORTEIA
 add ax,7
 call CRIA_OBST
 mov rocha_pendente,0
GO_CRATERA:
 mov ax,proxima
 cmp distancia,ax
 jb GO_FIM
 mov distancia,0
 mov cx,TIPOS_CRATERAS
 call SORTEIA
 add ax,4
 call CRIA_OBST
 mov cx,VAR_CRATERA
 call SORTEIA
 add ax,DIST_CRATERA
 mov proxima,ax
 mov rocha_pendente,1
GO_FIM:
 ret
GERA_OBSTACULOS endp

; soltar uma bomba de uma nave visivel a cada intervalo
; altera ax,bx,cx,dx,si,di.
BOMBARDEIA proc
 inc contador_bomba
 cmp contador_bomba,INTERVALO_BOMBA
 jb BO_FIM
 mov contador_bomba,0
 mov cx,MAX_NAVES
 call SORTEIA
 mov di,ax
 shl di,1
 cmp tipo[di],0
 je BO_FIM
 mov ax,obj_x[di]
 cmp ax,0
 jl BO_FIM
 cmp ax,LARGURA-14
 ja BO_FIM
 call VAGA_TIRO
 cmp si,FIM_OBJ
 je BO_FIM
 add ax,6
 mov obj_x[si],ax
 mov ax,obj_y[di]
 add ax,14
 mov obj_y[si],ax
 mov tipo[si],13
BO_FIM:
 ret
BOMBARDEIA endp

; mover todos os objetos e retirar os que sairam altera ax,si.
MOVE_OBJETOS proc
 xor si,si
MO_LOOP:
 mov ax,tipo[si]
 or ax,ax
 jz MO_PROX
 cmp ax,11
 jae MO_TIRO
 cmp ax,3
 ja MO_TERRENO
 sub obj_x[si],VEL_NAVE
 jmp MO_SAIU
MO_TERRENO:
 sub obj_x[si],VEL_MUNDO
MO_SAIU:
 cmp obj_x[si],-20
 jg MO_PROX
 jmp MO_REMOVE
MO_TIRO:
 cmp ax,13
 je MO_BOMBA
 cmp ax,11
 jne MO_FRENTE
 sub obj_y[si],VEL_TIRO
 jmp MO_LIMITE
MO_FRENTE:
 add obj_x[si],VEL_TIRO
 add percurso[si],VEL_TIRO
 cmp percurso[si],ALCANCE_FRONTAL
 jae MO_REMOVE
MO_LIMITE:
 cmp obj_y[si],TOPO
 jle MO_REMOVE
 cmp obj_x[si],LARGURA
 jl MO_PROX
 jmp MO_REMOVE
MO_BOMBA:
 add obj_y[si],VEL_BOMBA
 cmp obj_y[si],PISTA-4
 jb MO_PROX
MO_REMOVE:
 mov tipo[si],0
MO_PROX:
 add si,2
 cmp si,FIM_OBJ
 jb MO_LOOP
 ret
MOVE_OBJETOS endp

; carregar caixa de colisao de um objeto, di=indice, altera ax,bx.
CAIXA_OBJ proc
 mov ax,obj_x[di]
 mov col_x2,ax
 mov ax,obj_y[di]
 mov col_y2,ax
 mov bx,tipo[di]
 shl bx,1
 mov ax,larguras[bx]
 mov col_l2,ax
 mov ax,alturas[bx]
 mov col_a2,ax
 ret
CAIXA_OBJ endp

; bateu? tira uma vida, volta o jipe pra x=0 e deixa ele piscando um pouco
; entrada vidas. deixa invencivel, nao altera registrador
PERDE_VIDA proc
 cmp invencivel,0
 jne PV_FIM
 dec vidas
 mov jx,0
 mov jy,JIPE_Y
 mov salto,0
 mov invencivel,INV_FRAMES
PV_FIM:
 ret
PERDE_VIDA endp

; ver se o jipe bateu ou passou do obstaculo os pontos contam uma vez so.
; entradas array objeto,jx,jy, altera ax,bx,di.
COLISOES_JIPE proc
 mov di,INI_OBST
CJ_LOOP:
 cmp tipo[di],0
 je CJ_PROX
 cmp tipo[di],11
 je CJ_PROX
 cmp tipo[di],12
 je CJ_PROX
 call CAIXA_OBJ
 mov ax,jx
 mov col_x1,ax
 mov ax,jy
 mov col_y1,ax
 mov col_l1,20
 mov col_a1,10
 cmp tipo[di],7
 jae CJ_TESTA
 ; cratera toca os pneus na linha da pista; caixa virtual de 1 px acima
 dec col_y2
CJ_TESTA:
 call TESTA_COLISAO
 or al,al
 jz CJ_PASSOU
 mov marcado[di],1
 call PERDE_VIDA
 cmp tipo[di],13
 jne CJ_PROX
 mov tipo[di],0
 jmp CJ_PROX
CJ_PASSOU:
 cmp di,FIM_OBST
 jae CJ_PROX
 cmp marcado[di],0
 jne CJ_PROX
 mov ax,col_x2
 add ax,col_l2
 cmp ax,jx
 jg CJ_PROX
 mov marcado[di],1
 add pontos,PONTOS_OBST
CJ_PROX:
 add di,2
 cmp di,FIM_OBJ
 jae CJ_FIM
 jmp CJ_LOOP
CJ_FIM:
 ret
COLISOES_JIPE endp

; testar colisao, altera ax,bx,si,di.
COLISOES_TIROS proc
 mov si,INI_TIROS
CT_LOOP:
 mov ax,tipo[si]
 cmp ax,11
 je CT_INICIA
 cmp ax,12
 je CT_TIRO_VALIDO
 jmp CT_PROX
CT_TIRO_VALIDO:
CT_INICIA:
 mov ax,obj_x[si]
 mov col_x1,ax
 mov ax,obj_y[si]
 mov col_y1,ax
 mov bx,tipo[si]
 shl bx,1
 mov ax,larguras[bx]
 mov col_l1,ax
 mov ax,alturas[bx]
 mov col_a1,ax
 xor di,di
CT_ALVO:
 mov ax,tipo[di]
 or ax,ax
 jz CT_SEGUINTE
 cmp ax,3
 jbe CT_TESTA
 cmp ax,7
 jb CT_SEGUINTE
CT_TESTA:
 call CAIXA_OBJ
 call TESTA_COLISAO
 or al,al
 jz CT_SEGUINTE
 mov tipo[si],0
 cmp tipo[di],7
 je CT_PROX
 cmp tipo[di],3
 jbe CT_NAVE
 dec resist[di]
 jnz CT_PROX
 add pontos,PONTOS_OBST
 jmp CT_MATA
CT_NAVE:
 add pontos,PONTOS_NAVE
CT_MATA:
 mov tipo[di],0
 jmp CT_PROX
CT_SEGUINTE:
 add di,2
 cmp di,FIM_OBST
 jb CT_ALVO
CT_PROX:
 add si,2
 cmp si,FIM_OBJ
 jae CT_FIM
 jmp CT_LOOP
CT_FIM:
 ret
COLISOES_TIROS endp

; ler centesimos do relogio do computador, saida ax, altera bx,cx,dx.
LE_RELOGIO proc
 mov ah,2ch
 int 21h
 xor ax,ax
 mov al,dh
 xor bx,bx
 mov bl,dl
 mov cx,CENTESIMOS_SEGUNDO
 mul cx
 add ax,bx
 ret
LE_RELOGIO endp

; descontar segundos reais, saida tempo, altera ax,bx,cx,dx.
RELOGIO_JOGO proc
 call LE_RELOGIO
 mov bx,ax
 sub ax,relogio_anterior
 jnc RJ_DELTA
 add ax,CENTESIMOS_MINUTO
RJ_DELTA:
 mov relogio_anterior,bx
 add centesimos,ax
RJ_SEGUNDO:
 cmp tempo,0
 je RJ_FIM
 cmp centesimos,CENTESIMOS_SEGUNDO
 jb RJ_FIM
 sub centesimos,CENTESIMOS_SEGUNDO
 dec tempo
 jmp RJ_SEGUNDO
RJ_FIM:
 ret
RELOGIO_JOGO endp

; iniciar partida
INICIA_PARTIDA proc
 call LIMPA_TELA
 mov si,offset txt_setor
 mov dx,0a10h
 mov bl,14
 call ESCREVE_STRING
 mov cx,001eh
 mov dx,8480h
 mov ah,86h
 int 15h
 call LIMPA_BUFFER_TECLADO
 xor si,si
IP_ZERA:
 mov tipo[si],0
 add si,2
 cmp si,FIM_OBJ
 jb IP_ZERA
 mov vidas,VIDAS_INICIAIS
 mov pontos,0
 mov tempo,DURACAO
 mov jx,0
 mov jy,JIPE_Y
 mov salto,0
 mov invencivel,0
 mov sair,0
 mov distancia,DIST_CRATERA
 mov proxima,DIST_CRATERA
 mov rocha_pendente,0
 mov contador_bomba,0
 mov hud_inicial,1
 mov cache_pontos,0ffffh
 mov cache_tempo,0ffffh
 mov cache_vidas,0ffffh
 mov scroll_cenario,0
 xor bx,bx
IP_LINHAS:
 mov linhas_sujas[bx],1
 inc bx
 cmp bx,ALTURA
 jb IP_LINHAS
 call LE_RELOGIO
 mov relogio_anterior,ax
 mov centesimos,0
 call LIMPA_TELA
 ret
INICIA_PARTIDA endp

; loop geral do jogo, saida score final
PARTIDA proc
 call INICIA_PARTIDA
PA_QUADRO:
 call ESPERA_FRAME
 call MARCA_ENTIDADES
 call LE_TECLA
 call MOVE_JIPE
 cmp sair,0
 jne PA_FIM
 call MOVE_OBJETOS
 call GERA_GRUPO
 call GERA_OBSTACULOS
 call BOMBARDEIA
 call COLISOES_TIROS
 call COLISOES_JIPE
 call RELOGIO_JOGO
 add scroll_cenario,VEL_MUNDO
 and scroll_cenario,CENARIO_W-1
 cmp invencivel,0
 je PA_DESENHA
 dec invencivel
PA_DESENHA:
 call MARCA_ENTIDADES
 call DESENHA_QUADRO
 call HUD
 cmp vidas,0
 je PA_FIM
 cmp tempo,0
 je PA_TERMINOU
 jmp PA_QUADRO
PA_TERMINOU:
PA_FIM:
 ret
PARTIDA endp

; caixa de op??o do menu
; si=rotulo, dh=linha, bl=cor
CAIXA_MENU proc
 push si
 mov dl,15
 mov si,offset caixa_top
 call ESCREVE_STRING
 inc dh
 pop si
 call ESCREVE_STRING
 inc dh
 mov si,offset caixa_base
 call ESCREVE_STRING
 ret
CAIXA_MENU endp

; op??es do menu, altera si,dx,bx.
OPCOES_MENU proc
 mov bl,15
 cmp selecao,0
 jne OM_JOGAR
 mov bl,12
OM_JOGAR:
 mov si,offset caixa_jogar
 mov dh,15
 call CAIXA_MENU
 mov bl,15
 cmp selecao,1
 jne OM_SAIR
 mov bl,12
OM_SAIR:
 mov si,offset caixa_sair
 mov dh,19
 call CAIXA_MENU
 ret
OPCOES_MENU endp

; mover jipe e tres naves juntos, em ordem, pra direita.
ANIMA_MENU proc
 add anim_x,VEL_MUNDO
 cmp anim_x,MENU_CICLO
 jb AM_INICIA
 sub anim_x,MENU_CICLO
AM_INICIA:
 mov linha_y,MENU_Y
AM_LINHA:
 xor ax,ax
 call PREPARA_LINHA
 mov menu_indice,0
AM_SPRITE:
 mov bx,menu_indice
 mov ax,anim_x
 add ax,menu_deslocamentos[bx]
 cmp ax,LARGURA
 jl AM_POSICAO
 sub ax,MENU_CICLO
AM_POSICAO:
 mov si,menu_sprites[bx]
 mov cx,menu_larguras[bx]
 mov dx,menu_alturas[bx]
 mov bx,MENU_Y
 call SPRITE_LINHA
 add menu_indice,2
 cmp menu_indice,MENU_QUANTIDADE*2
 jb AM_SPRITE
 call ENVIA_LINHA
AM_PROXIMA:
 inc linha_y
 cmp linha_y,MENU_Y+MENU_ALTURA
 jb AM_LINHA
 ret
ANIMA_MENU endp

; si=texto terminado em zero, ax=x,bx=y,dl=cor.
; altera ax,bx,cx,dx,di,si; preserva es=a000h.
DESENHA_ARTE proc
 mov arte_x,ax
 mov arte_inicio,ax
 mov arte_y,bx
 mov arte_cor,dl
DA_LE:
 lodsb
 or al,al
 jz DA_FIM
 cmp al,10
 jne DA_SIMBOLO
 mov ax,arte_inicio
 mov arte_x,ax
 add arte_y,ARTE_ALTURA
 jmp DA_LE
DA_SIMBOLO:
 push si
 xor bx,bx
DA_BUSCA:
 cmp al,arte_codigos[bx]
 je DA_ACHOU
 inc bx
 cmp bx,ARTE_CARACTERES
 jb DA_BUSCA
 jmp DA_PROXIMO
DA_ACHOU:
 shl bx,1
 shl bx,1
 shl bx,1
 mov si,offset arte_fonte
 add si,bx
 mov ax,arte_x
 mov bx,arte_y
 call CALCULA_OFFSET
 mov dx,ARTE_ALTURA
DA_LINHA:
 lodsb
 mov ah,al
 mov cx,5
DA_PIXEL:
 test ah,80h
 jz DA_PULA
 mov al,arte_cor
 mov es:[di],al
DA_PULA:
 shl ah,1
 inc di
 loop DA_PIXEL
 add di,LARGURA-5
 dec dx
 jnz DA_LINHA
DA_PROXIMO:
 pop si
 add arte_x,ARTE_PASSO
 jmp DA_LE
DA_FIM:
 ret
DESENHA_ARTE endp

; Game over
GAME_OVER proc
 call LIMPA_TELA
 mov si,offset arte_fim
 mov ax,FIM_X
 mov bx,48
 mov dl,12
 call DESENHA_ARTE
 mov si,offset txt_score
 mov dx,100dh
 mov bl,15
 call ESCREVE_STRING
 mov ax,pontos
 mov cx,5
 mov dl,20
 call ESCREVE_NUMERO
 mov si,offset txt_voltar
 mov dx,140ah
 call ESCREVE_STRING
 call LIMPA_BUFFER_TECLADO
 xor ah,ah
 int 16h
 ret
GAME_OVER endp

; menu, partida e game over. esc no menu fecha o jogo.
JOGO proc
JG_MENU:
 mov anim_x,MENU_INICIO
 call LIMPA_TELA
 mov selecao,0
 mov si,offset arte_titulo
 mov ax,TITULO_X
 mov bx,16
 mov dl,0ah
 call DESENHA_ARTE
 call OPCOES_MENU
JG_ANIMA:
 call ANIMA_MENU
 call ESPERA_FRAME
 call LE_TECLA
 mov ax,tecla
 cmp ah,1
 je JG_FIM
 cmp ah,48h
 je JG_TROCA
 cmp ah,50h
 je JG_TROCA
 cmp ah,1ch
 jne JG_ANIMA
 cmp selecao,1
 je JG_FIM
 call PARTIDA
 cmp sair,0
 jne JG_MENU
 call GAME_OVER
 jmp JG_MENU
JG_TROCA:
 xor selecao,1
 call OPCOES_MENU
 jmp JG_ANIMA
JG_FIM:
 ret
JOGO endp

; video; restaurar texto ao sair.
MAIN proc
 mov ax,@data
 mov ds,ax
 cld
 mov ax,13h
 int 10h
 mov ax,0a000h
 mov es,ax
 xor ah,ah
 int 1ah
 mov seed,dx
 call JOGO
 mov ax,3
 int 10h
 mov ax,4c00h
 int 21h
MAIN endp
end MAIN

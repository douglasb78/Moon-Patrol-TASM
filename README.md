# Moon Patrol TASM 8086
Projeto desenvolvido como trabalho final para a disciplina de Arquitetura de Computadores, professor André Adami.<br/>
O jogo usa o modo gráfico VGA 13h, com resolução de 320 × 200 pixels e é uma versão simplificada do Moon Patrol.<br/>
No jogo controla um jipe, desviando dos obstáculos e atirando nas naves enquanto o cenário atrás movimenta.<br/>
A pontuação aumenta ao passar pelas crateras e destruir pedras e naves.<br/>

### Como rodar:

**GUI Turbo Assembler 8086 - Windows**

O mais simples, com o [programa](https://sourceforge.net/projects/guitasm8086/) instalado, só abrir o código e clicar para executar.

---

### Como compilar o jogo rápido

Dá para baixar o DOSBox e criar um atalho pra ir testando alterações rápido.

**DOSBox - Windows**

Criar um .bat para compilar a última versão e lançar o jogo:
```

@echo off
set DOSBOX="C:\Program Files (x86)\DOSBox-0.74-3\DOSBox.exe"
%DOSBOX% -c "mount c %~dp0" -c "c:" -c "tasm /zi nome_do_jogo.asm" -c "tlink /v nome_do_jogo.obj" -c "nome_do_jogo.exe" -exit
```

Criar um .bat só para abrir o jogo:
```
@echo off
set DOSBOX="C:\Program Files (x86)\DOSBox-0.74-3\DOSBox.exe"
%DOSBOX% "%~dp0nome_do_jogo.exe" -exit
```

Precisa copiar o tasm do GUI Turbo Assembler e pôr no PATH do Windows para funcionar.

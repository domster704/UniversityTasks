; ����� ������ ��� ������ ���������� .386 (����� ���� .486, .586 � ��)
.386

;.model flat ����������, � ����� ����� ����� �������� ���������. 
; ��� ��������� �������� ��� ����������� ������������ �������, ������� �� ��������� � ������������ 
; �������������� � ������� ������. ��������� .model ����� ������ ������ flat (������� ��� ��������)
; ��� ����� ���������.
; Stdcall - ��� "������" � ���, ��� ����� ������� ��������� (�������, ������� �������, ��� ��� ����������).
; Stdcall �������, ��� ������� ���� ����� ������� ���������
.model flat, stdcall
; ������� ����������, ��� ��� ����� �������
option casemap: none 

; ���������� � ���������������� ����� ��� ������ � WinApi
include windows.inc
include user32.inc
include kernel32.inc
include debug.inc

includelib user32.lib
includelib kernel32.lib
; ���������� ��� "������", � ������� �������, ����� ����� �������� �� ����� ��������
includelib debug.lib 

.const 
        ; �������� ����������, ������� ���������� � ��������� factorial ��� ���������� ����������
        mainVariable dword 19

.code
; ���������, ������� ������� ��������� ����� n. ��������� ��������� � �������� eax
; ��� ����� ��������� - https://prog-cpp.ru/asm-proc/
; ��� �������� ����� �����, ��� ����� ���� - https://assembler-code.com/stek-v-assemblere-push-i-pop/
; � �����, ��� ����� ��������� - 
; https://learn.microsoft.com/ru-ru/cpp/assembler/masm/proto?view=msvc-160&viewFallbackFrom=vs-2019
factorial proc n :dword
        ; ��������� ���������� (����� ������� ������ � ����������)
        local var: dword
        mov var, 1

        mov eax, 1
        ; ���� n = 0, �� ��������� ���� - ��� �������
        .if n == 0
                ret
        .endif
        
        ; ������� ECX (Extended Counter Register) - �������, ������� ����� ���������� ��� ������
        mov ecx, n
        ; ������ mainLoop - �� ���� ���������� �������� ������
        mainLoop:
                ; ��� mul (multiply - ���������) ����� ��������� ����� - 
                ; http://www.av-assembler.ru/instructions/mul.php
                mul var
                inc var
                dec ecx
                ; jne - �������� �������, ���� ���� zf != 0. ����� �������� ������ ���, ����� ����������
                ; �������������� �������� (� ������ ������ dec (��������� - � C++ ��� --)) 
                jne mainLoop
        ; �� ���� ��� �� ����� ����������
        ; for (int cx = n; cx > 0; cx--) {
        ;       ax *= var++;
        ; } 
        ; ��� ����� �� ������ � while (�� ������ ���� ���������� � masm32 (��� ����� ���� ����������
        ; ��������� .686, �� ��� ����, ��� ��� ������ �� ��������)
        ret                
factorial endp

; ������ start, � ������� ����������� �������� ��� ���
start:
        ; ��� ����� ��������� inovke - https://studfile.net/preview/1869264/page:57/
        invoke factorial, mainVariable
        ; ������ ��� ������ decimal �������� � ����
        ; ��� ����� ���������������� � ������� - https://prog-cpp.ru/asm-macro/
        PrintDec eax
end start
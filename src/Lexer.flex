import compilerTools.Token;

%%
%class Lexer
%type Token
%line
%column
%{
    private Token token(String lexeme, String lexicalComp, int line, int column){
        return new Token(lexeme, lexicalComp, line+1, column+1);
    }
%}
/* Variables básicas de comentarios y espacios */
TerminadorDeLinea = \r|\n|\r\n
EntradaDeCaracter = [^\r\n]
EspacioEnBlanco = {TerminadorDeLinea} | [ \t\f]
 
 
 
 

/* Comentario */
Comentario = {ComentarioTradicional} 

/* Identificador */
Letra = [A-Za-zÑñ_ÁÉÍÓÚáéíóúÜü]
Digito = [0-9]
Identificador = {Letra}({Letra}|{Digito})*

/* Número */
Numero = 0 | [1-9][0-9]*
%%

{EspacioEnBlanco} { /*Ignorar*/ }

 "<<" [^*] ~">>" | "/*" "*"+ "/" {return token(yytext(), "COMENTARIO", yyline, yycolumn); }

/* Numeros enteros */
{Numero} { return token(yytext(), "NUM_ENTERO", yyline, yycolumn); }

/* Numeros decimales */
{Numero}+(".")+(({Numero})*) { return token(yytext(), "NUM_DECIMAL", yyline, yycolumn); }

/* operadores logicos*/
">" { return token(yytext(), "MAYOR_QUE", yyline, yycolumn); }
"<" { return token(yytext(), "MENOR_QUE", yyline, yycolumn); }
">=" { return token(yytext(), "MAYOR_IGUAL_QUE", yyline, yycolumn); }
"<=" { return token(yytext(), "MENOR_IGUAL_QUE", yyline, yycolumn); }
"|" { return token(yytext(), "OR", yyline, yycolumn); }
"&" { return token(yytext(), "AND", yyline, yycolumn); }
"==" { return token(yytext(), "IGUAL", yyline, yycolumn); }
"!=" { return token(yytext(), "DIFERENTE_DE", yyline, yycolumn); }

/* Signos de Agrupacion */
"("  {return token(yytext(), "PARENTESIS_A", yyline, yycolumn); }
")"  {return token(yytext(), "PARENTESIS_C", yyline, yycolumn); }
"{"  {return token(yytext(), "CORCHETE_A", yyline, yycolumn); }
"}"  {return token(yytext(), "CORCHETE_c", yyline, yycolumn); }

/* Signos de asignacion */
"=" {return token(yytext(), "SIGNO_ASIGNACION", yyline, yycolumn); }


/* ESTRUCTURA IF*/
"si" {return token(yytext(), "SENTENCIA_LOGICA_SI", yyline, yycolumn); }
"no" {return token(yytext(), "SENTENCIA_LOGICA_NO", yyline, yycolumn); } 

/* ESTRUCTURA  CASE*/
"evaluar->" {return token(yytext(), "SENTENCIA_SWITCH_EVALUAR", yyline, yycolumn); }
"caso->" {return token(yytext(), "SENTENCIA_SWITCH_CASO", yyline, yycolumn); } 
"en ese caso->" {return token(yytext(), "SENTENCIA_LOGICA_DEFAULT", yyline, yycolumn); } 

/* ESTRUCTURA  FOR*/
"hasta" {return token(yytext(), "ESTRUCTURA_FOR", yyline, yycolumn); }

/* ESTRUCTURA  while*/
"mientras" {return token(yytext(), "ESTRUCTURA_WHILE", yyline, yycolumn); }

/* ESTRUCTURA  DO-while*/
"reptir" {return token(yytext(), "ESTRUCTURA_WHILE_DO", yyline, yycolumn); }

/* FINALIZAR CICLO*/
"romper" {return token(yytext(), "Break", yyline, yycolumn); }

/* OPERADORES  ARITMETICOS*/
"sumar" {return token(yytext(), "OPERADOR_ARITMETICO_SUMA", yyline, yycolumn); }
"restar" {return token(yytext(), "OPERADOR_ARITMETICO_RESTA", yyline, yycolumn); }
"multiplicar" {return token(yytext(), "OPERADOR_ARITMETICO_MULTIPLICAR", yyline, yycolumn); }
"dividir" {return token(yytext(), "OPERADOR_ARITMETICO_DIVIDIR", yyline, yycolumn); } 
"incrementar" {return token(yytext(), "OPERADOR_ARITMETICO_INCREMENTAR", yyline, yycolumn); }
"decrementar" {return token(yytext(), "OPERADOR_ARITMETICO_DECREMENTAR", yyline, yycolumn); }
"modulo" {return token(yytext(), "OPERADOR_ARITMETICO_MODULO", yyline, yycolumn); }

/* FUNCION*/
"ejecutar" {return token(yytext(), "LLAMADA_FUNCION", yyline, yycolumn); }
"hacer" {return token(yytext(), "INICIO_FUNCION", yyline, yycolumn); } 
"finalizar" {return token(yytext(), "FINAL_FUNCION", yyline, yycolumn); } 

/* CADENA*/
"$"+.+"$" {return token(yytext(), "CADENA", yyline, yycolumn); }

/* Matriz */
"[" {return token(yytext(), "MATRIZ_A", yyline, yycolumn); }
"]" {return token(yytext(), "MATRIZ_C", yyline, yycolumn); }

/* Caracter */
"°"{Letra}"°" {return token(yytext(), "CARACTER", yyline, yycolumn); }
/* Inicio de sentencia */
"porfavor" { return token(yytext(), "INICIAR_LINEA", yyline, yycolumn); }
/* Fin de sentencia */
"gracias" { return token(yytext(), "FIN_LINEA", yyline, yycolumn); }

"," {return token(yytext(), "COMA", yyline, yycolumn); }
/* Identificador */
{Identificador} { return token(yytext(), "IDENTIFICADOR", yyline, yycolumn); }















. { return token(yytext(), "ERROR", yyline, yycolumn); }
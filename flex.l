%{
#include "bison.tab.h"
#include <string.h>
#include <stdlib.h>

#define DEFAULT 0 
#define FFOR 1
#define FWHILE 2 

FILE *output;
extern int loopcounter;
extern int i;
extern int flag;
extern int startvalue;
extern int addvalue;
extern int endvalue;
extern char* Index;
extern char* printer;
extern int k;
extern int k2;
void copyPrint(const char s[],int choice);
%}

letter [a-zA-Z]
digit [0-9]
underscore _

%%
"extern" 	{fprintf(output,"extern ");			
			return EXTERN;}

"void" 		{fprintf(output,"void ");
			return VOID;}

"begin" 	{fprintf(output,"begin ");
			return BEG;}

"end" 		{fprintf(output,"end ");
			return END;}

"if" 		{if(flag == DEFAULT || flag == FWHILE)
				fprintf(output,"if ");
			else
				copyPrint(yytext,1);
			return IF;}

"else" 		{if(flag == DEFAULT || flag == FWHILE)
				fprintf(output,"else ");
			else
				copyPrint(yytext,1);
			return ELSE;}

"return" 	{fprintf(output,"return ");
			return RETURN;}

"integer" 	{fprintf(output,"integer ");
			return INT;}

"boolean" 	{fprintf(output,"boolean ");
			return BOOL;}

"string"	{fprintf(output,"string ");
			return STRING;}

"true" 		{if(flag==FFOR)
				copyPrint(yytext,1);
			else
				fprintf(output,"true ");
			return TRUE;}

"false" 	{if(flag==FFOR)
				 copyPrint(yytext,1);
			else 
				fprintf(output,"false ");
			return FALSE;}

"(" 		{if(flag==FFOR)
				copyPrint(yytext,1);				
			else if (k!=1)
				fprintf(output,"(");				
			return OPENBRACKET;}

")" 		{if(flag==FFOR)
				copyPrint(yytext,1);
			else if (k!=1)
				fprintf(output,")");
			return CLOSEBRACKET;}

"{" 		{if(flag==FFOR)
			 {
			 	if(k==1)
					k=0;
				else
					copyPrint(yytext,1);
			 }
			else if (k==1)
				k=0;
			else 
				fprintf(output,"{");	
			return OPENBRACE;}

"}" 		{if(flag == FFOR)
			 {
				if(k2==1)
					k2=0;
				else	
				 	copyPrint(yytext,1);
			 }
			else if (k!=1)
				fprintf(output,"}");
			return CLOSEBRACE;}

"&" 		{if(flag == FFOR)
				copyPrint(yytext,1);
			else
				fprintf(output,"&");
			return AMPERSAND;}

"&&" 		{if(flag == FFOR)
				copyPrint(yytext,1);
			else
				fprintf(output,"&&");
			return AND;}

"||" 		{if(flag == FFOR)
				copyPrint(yytext,1);
			else
				fprintf(output,"||");
			return OR;}

"!" 		{if(flag == FFOR)
				copyPrint(yytext,1);
			else
				fprintf(output,"!");
			return NOT;}

"=" 		{if(flag == FFOR)
				copyPrint(yytext,1);
			else if (k!=1)
				fprintf(output,"=");
			return ASSIGN;}

"==" 		{if(flag == FFOR)
				copyPrint(yytext,1);
			else
				fprintf(output,"==");
			return EQUAL;}

"!=" 		{if(flag == FFOR)
				copyPrint(yytext,1);
			else
				fprintf(output,"!=");
			return NON_EQUAL;}

"<" 		{if(flag == FFOR)
				copyPrint(yytext,1);
			else if (k!=1)
				fprintf(output,"<");
			 return LESS;}

">" 		{if(flag == FFOR)
				copyPrint(yytext,1);
			else
				fprintf(output,">");
			return GREATER;}

"<=" 		{if(flag == FFOR)
				copyPrint(yytext,1);
			else
				fprintf(output,"<=");
			return L_EQUAL;}

">=" 		{if(flag == FFOR)
				copyPrint(yytext,1);
			else
				fprintf(output,">=");
			return GR_EQUAL;}

"+" 		{if(flag == FFOR)
				copyPrint(yytext,1);
			else if (k!=1)
				fprintf(output,"+");
			return ADD;}

"-" 		{if(flag == FFOR)
				copyPrint(yytext,1);
			else
				fprintf(output,"-");
			return SUB;}

"*" 		{if(flag == FFOR)
				copyPrint(yytext,1);
			else
				fprintf(output,"*");
			return MUL;}

"/" 		{if(flag == FFOR)
				copyPrint(yytext,1);
			else
				fprintf(output,"/");
			return DIV;}

"%" 		{if(flag == FFOR)
				copyPrint(yytext,1);
			else
				fprintf(output,"%%");
			return MOD;}

";" 		{if(flag == FFOR)
				copyPrint(yytext,1);
			else if (k!=1)
				fprintf(output,";");
			return SEMICOLON;}

","			{if(flag == FFOR)
				copyPrint(yytext,1);
			else
				fprintf(output,",");
			return COMMA;}

"for" 		{flag==FFOR;
				k=1;			
			return FOR;}

"while"		{if(flag == FFOR)
				copyPrint(yytext,1);
			else
				fprintf(output,"while");
			return WHILE;}

[\n]+		{if(flag == FFOR)
				copyPrint(yytext,1);
			else 
				fprintf(output,"\n");
			yylineno++;}

[\t]+		{if(flag == FFOR)
				copyPrint(yytext,1);
			else
				fprintf(output,"\t");}

{digit}+	{if(flag == FFOR)
				copyPrint(yytext,1);
			else if (k!=1)
				fprintf(output,"%s", yytext);
			return STATHERAAKERAIOU;}

{letter}({letter}|{digit}|{underscore})*  {if(flag == FFOR)
											copyPrint(yytext,1);
										   else if (k!=1)
											fprintf(output,"%s", yytext);
										   return ID;}

({letter}|{digit}|{underscore})*  {if(flag == FFOR)
										copyPrint(yytext,1);
									else if (k!=1)
										fprintf(output,"%s", yytext);
									return STATHERASUMBOLOSEIRA;}

%%



%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define DEFAULT 0 
#define FFOR 1
#define FWHILE 2 

int flag = DEFAULT;
int i,j;
char c;
int k = 0 ;
int k2 = 0;
FILE *fp ;
int loopcounter=0;
int linesWithError[100];
int startvalue=0;
int addvalue=0;
int endvalue=0;
char *Index;
char *printer;
char *copier;
char* tmp = "tmp";
static char buffer[200];


int errors=0;
extern int lines;
extern char* yytext;
extern int yylineno;
extern int yylval;
extern FILE *yyin;
extern FILE *yyout;
void copyPrint(const char s[],int choice);
void yyerror(const char*  );
void copyFunc(char* );
int yylex(void);
extern FILE *output;

%}

%define parse.error verbose
%token EXTERN
%token VOID
%token BEG
%token END
%token IF
%token ELSE
%token RETURN

%token INT
%token BOOL
%token STRING

%token TRUE
%token FALSE

%token OPENBRACKET
%token CLOSEBRACKET
%token OPENBRACE
%token CLOSEBRACE

%token AMPERSAND 
%token AND
%token OR
%token NOT

%token EQUAL
%token NON_EQUAL
%token LESS
%token GREATER
%token L_EQUAL
%token GR_EQUAL

%token ADD
%token SUB
%token MUL
%token DIV
%token MOD

%token SEMICOLON
%token COMMA

%token ID

%token STATHERASUMBOLOSEIRA
%token STATHERAAKERAIOU

%token WHILE
%token FOR 

%left NOT
%left MUL DIV MOD
%left SUB ADD
%left EQUAL NON_EQUAL
%left GREATER GR_EQUAL LESS L_EQUAL
%left OR AND
%right ASSIGN

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%start programma

%%

programma: ekswterikesdilwseis kefalidaprogrammatos tmimaorismwn tmimaentolwn;

ekswterikesdilwseis: ekswterikoprwtotupo2;

ekswterikoprwtotupo2: %empty
					| ekswterikoprwtotupo ekswterikoprwtotupo2;


ekswterikoprwtotupo: EXTERN prwtotuposunartisis;

kefalidaprogrammatos: VOID ID OPENBRACKET CLOSEBRACKET
					| VOID ID OPENBRACKET error CLOSEBRACKET {yyclearin;  yyerrok;};
					
tmimaorismwn: orismos2;

orismos2: %empty
		| orismos orismos2;

orismos: orismosmetablitwn 
	   | orismossunartisis 
	   | prwtotuposunartisis;

orismosmetablitwn: tuposdedomenwn_metavlites SEMICOLON;

tuposdedomenwn_metavlites: INT ID
				 		 | BOOL ID
				 		 | STRING ID
				 		 | tuposdedomenwn_metavlites COMMA ID;

orismossunartisis: kefalidasunartisis tmimaorismwn tmimaentolwn;

prwtotuposunartisis: kefalidasunartisis SEMICOLON;

kefalidasunartisis: typos_synartisis_metavlites OPENBRACKET c CLOSEBRACKET
				  | typos_synartisis_metavlites OPENBRACKET error CLOSEBRACKET{yyclearin; yyerrok;};

typos_synartisis_metavlites:INT ID
						   | BOOL ID
						   | VOID ID;

c: %empty
 | listatupikwnparametrwn;


listatupikwnparametrwn: tupikesparametroi ntp;

ntp: %empty
   | ptp ntp;

ptp: COMMA tupikesparametroi;

tupikesparametroi: tuposdedomenwn ID
				 | tuposdedomenwn AMPERSAND ID;


tuposdedomenwn: INT
			  | BOOL
			  | STRING;

tmimaentolwn: BEG command END;

command: %empty
	   | entoli command;

entoli: aplientoli SEMICOLON 
	  | domimenientoli
	  | sunthetientoli 
	  | entolifor
	  | entoliwhile;

sunthetientoli: OPENBRACE command CLOSEBRACE;

domimenientoli: entoliif;

aplientoli: anathesi 
		  | klisisunartisis
		  | entolireturn 
		  | entolinull;

entoliif: IF OPENBRACKET genikiekfrasi CLOSEBRACKET entoli %prec LOWER_THAN_ELSE 
		| IF OPENBRACKET genikiekfrasi CLOSEBRACKET entoli ELSE entoli;

anathesi: ID ASSIGN genikiekfrasi
        | ID error genikiekfrasi
		| ID ASSIGN genikiekfrasi error ';' {yyclearin;  yyerrok; }; 

klisisunartisis: ID OPENBRACKET CLOSEBRACKET 
			   | ID OPENBRACKET listapragmatikwnparametrwn CLOSEBRACKET;

listapragmatikwnparametrwn: pragmatikiparametros npp
						  | pragmatikiparametros error {yyclearin;  yyerrok; }; 
npp: %empty
   | ppp npp;

ppp: COMMA pragmatikiparametros;

pragmatikiparametros: genikiekfrasi;

entolireturn: RETURN 
			| RETURN genikiekfrasi;

entolinull: " ";

genikiekfrasi: genikosoros ngo;

ngo: %empty
   | pgo ngo;

pgo: OR genikosoros;

genikosoros: genikosparagontas ngp;

ngp: %empty
   | pgp ngp;

pgp: AND genikosparagontas;

genikosparagontas: genikosprwtparag 
				 | NOT genikosprwtparag;

genikosprwtparag: apliekfrasi 
				| apliekfrasi tmimasugkrisis;

tmimasugkrisis: sugkritikostelestis apliekfrasi;

sugkritikostelestis: EQUAL 
				   | NON_EQUAL
				   | LESS 
				   | GREATER 
				   | L_EQUAL
				   | GR_EQUAL;

apliekfrasi: aplosoros nao1;

nao1: %empty
	| pao1 nao1;

pao1: addsub aplosoros;

addsub: ADD
	  | SUB;

aplosoros: aplosparagontas nao2;

nao2: %empty
	| pao2 nao2;

pao2: muldivmod aplosparagontas;

muldivmod: MUL 
		 | DIV
		 | MOD;

aplosparagontas: aplosprwtoros 
			   | addsub aplosprwtoros;

aplosprwtoros: ID
			 | stathera 
			 | klisisunartisis 
			 | OPENBRACKET genikiekfrasi CLOSEBRACKET;

stathera: STATHERAAKERAIOU 
		| STATHERASUMBOLOSEIRA 
		| TRUE 
		| FALSE;

entolifor: FOR OPENBRACKET
		   ID {Index = strdup(yytext);} ASSIGN STATHERAAKERAIOU {startvalue=atoi(yytext);} SEMICOLON 		   
		   ID LESS STATHERAAKERAIOU {endvalue=atoi(yytext);} SEMICOLON 
		   ID ASSIGN ID ADD STATHERAAKERAIOU {addvalue=atoi(yytext);}
		   CLOSEBRACKET 
		   {
			loopcounter =(endvalue-startvalue)/addvalue;
			if(loopcounter>3)
			{
				k = 1 ;
				flag = FWHILE;
				fprintf(output,"%s = %d ;\n",Index,startvalue);
				fprintf(output,"while (%s < %d) ",Index,endvalue);
				fprintf(output,"{ \n %s = %s + %d;",Index,Index,addvalue);
				flag=DEFAULT;
			}
			else 
			{
				k2=1;
				k=1;
				flag = FFOR;
			}
		   }
		   OPENBRACE 
		   command {k=1;}
		   CLOSEBRACE {
		   			   if (flag == FFOR) 
		   			   	   copyPrint(tmp,2);
		   			   flag=DEFAULT;
		              };

entoliwhile: WHILE OPENBRACKET ID sugkritikostelestis STATHERAAKERAIOU CLOSEBRACKET entoli;


%%
void yyerror(char const *s)
{
	fprintf (stderr, "%s\n", s);
	linesWithError[errors]=yylineno;	
	errors++;
	yyclearin;
}

int main(int argc, char *argv[])
{
	fp = fopen (argv[1],"r");
	output = fopen("output.txt", "w");
	if(!fp)
	{
		printf("Can't open file \n");
		return -1;
	}
	yyin = fp;
	do {
			yyparse();
		} 
	while (!feof(yyin));
	if(errors==0)
		printf("Program Parsed Successfully! \n");
	else
	{
		printf("There were %d parsing errors \n",errors);
		for(i=0;i<errors;i++)
			printf("Syntax Error on line %d \n",linesWithError[i]);
	}
	fclose(fp);
	fclose(output);
}

void copyPrint(const char s[],int choice)
{
	char *temp;
	char *tokenize[1000];
	int position=0;
	if(choice == 1)
	{	
		copier = strdup(s);
	    strcat(buffer,copier);  
	    strcat(buffer," ");   
	}
	else if(choice == 2)
	{
		int met = 0,j = 0;
		temp = strdup(buffer);
		printer= strtok(temp," ");
		while(printer!=NULL)
		{	tokenize[met] = printer;
			met++;
			printer = strtok(NULL," ");
		}
		for(i=startvalue;i<endvalue;i=i+addvalue)
	    {
	    	for (j=0;j<met;j++)
	    	{
	    		if (!strcmp(Index,tokenize[j]) && strcmp("=",tokenize[j+1]))
		    		fprintf(output,"%d ",i);
		    	else
		    		fprintf(output,"%s ",tokenize[j]);
	    	}
		}
	}
}
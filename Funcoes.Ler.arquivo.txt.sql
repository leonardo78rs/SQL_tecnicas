

 select grantor,grantee,table_name,privilege
    from
    all_tab_privs
    where table_name = 'ARQUIVO_DIR';



ALTER SYSTEM
    SET UTL_FILE_DIR = '*'

declare

-- A PASTA ONDE O ARQUIVO SE ENCONTRA DEVE SER UMA PASTA CONFIGURADA NO ORACLE PARA ACESSO DO PACOTE UTL_FILE
   
  arq utl_file.file_type ;
  TEMP UTL_FILE_DIR ;
  linha   varchar2(200)   ;
  eof     boolean := false; -- FLAG QUE INDICA FIM DO ARQUIVO.

begin
  TEMP  := 'C:\temp' ;
  arq := utl_file.fopen(TEMP,'ASDF.PRN','r') ;
  while not(eof) loop
      begin
         utl_file.get_line(arq,linha);
          
         dbms_output.put_line(linha) ;
          
      exception
         when no_data_found then
             eof := true;
         when others then
             Raise_Application_Error(-20000,'ERRO: ' || SQLERRM);
      end;
  end loop;
end;




/* outra forma - mas está dando erro 

DECLARE
    arquivo_ler                    UTL_File.File_Type;
    Linha                               Varchar2(100);
BEGIN
    arquivo_ler := UTL_File.Fopen('c:\temp\','asdf.prn', 'r');
    Loop
        UTL_File.Get_Line(arquivo_ler, Linha);
        DBMS_OUTPUT.PUT_LINE(LINHA);                 
    End Loop;

    UTL_File.Fclose(arquivo_ler);
    Dbms_Output.Put_Line('Arquivo processado com sucesso.');
EXCEPTION
    WHEN No_data_found THEN
               UTL_File.Fclose(arquivo_ler);
               Commit;
    WHEN UTL_FILE.INVALID_PATH THEN
               Dbms_Output.Put_Line('Diretório inválido.');
               UTL_File.Fclose(arquivo_ler);
    WHEN Others THEN
               Dbms_Output.Put_Line ('Problemas na leitura do arquivo.');
               UTL_File.Fclose(arquivo_ler);
END;

--Leia mais em: Leitura e Gravação em Arquivo Texto http://www.devmedia.com.br/leitura-e-gravacao-em-arquivo-texto/2720#ixzz36DTyMyjb
 */ 

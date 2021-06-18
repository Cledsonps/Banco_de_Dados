
use FIEB
CREATE TABLE [FIEB].[dbo].[responsavel]
(
	--Primary key,
	id int identity primary key,
	--código do departamento
    id_departamento int not null,
	--nome do responsável pelo departamento
    nome_resp_departamento varchar(50) not null,
	--login do responsável
    login_resp varchar(20) not null,
	--e-mail do responsável
    email_resp varchar(40) not null
)
GO

CREATE PROCEDURE sp_responsavel (@CODIGO_DEPARTAMENTO int, @NOME_RESPONSAVEL varchar(50), @LOGIN_RESPONSAVEL varchar(20), @EMAIL varchar(40))
as begin	
	--UPDADE EM CASO DE EXISTÊNCIA
	IF	
		(SELECT COUNT(*) FROM responsavel WHERE id_departamento = @CODIGO_DEPARTAMENTO 
										  AND login_resp = @LOGIN_RESPONSAVEL AND email_resp = @EMAIL) = 1
	BEGIN		
		UPDATE responsavel
		SET nome_resp_departamento = @NOME_RESPONSAVEL, login_resp = @LOGIN_RESPONSAVEL, email_resp = @EMAIL
		WHERE id_departamento = @CODIGO_DEPARTAMENTO AND login_resp = @LOGIN_RESPONSAVEL
		SELECT 'UPDATE! '+ @NOME_RESPONSAVEL + ', existe no departamento: ' + 
		CONVERT(varchar(10), @CODIGO_DEPARTAMENTO) + '.' AS Mensagem;
	END	
	--INSERT EM CASO DE INEXISTÊNCIA
	ELSE
	BEGIN
		INSERT INTO responsavel(id_departamento, nome_resp_departamento, login_resp, email_resp)
		VALUES(@CODIGO_DEPARTAMENTO, @NOME_RESPONSAVEL, @LOGIN_RESPONSAVEL, @EMAIL);
		SELECT 'REGISTRO INSERIDO COM SUCESSO!' AS Mensagem;
	END
end
GO

EXECUTE sp_responsavel 3, 'cledson santos', 'cledson','cledson.santos@email.com.br';
SELECT * FROM responsavel ORDER BY id DESC;
GO

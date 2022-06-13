CREATE TABLE medicos (
	crm VARCHAR(11) PRIMARY KEY,
    	nome VARCHAR(20) NOT NULL,
	sobrenome VARCHAR(20) NOT NULL
);

CREATE TABLE medico_clinico_geral(
	horas_trabalhadas INTEGER,
	salario DECIMAL(10,2),
	rg VARCHAR(10),
	crm_clinico_geral VARCHAR(11) PRIMARY KEY,

	FOREIGN KEY (crm_clinico_geral) REFERENCES medicos (crm) ON DELETE CASCADE
);

CREATE TABLE medico_cirurgiao(
	especialidade VARCHAR(20),
	numero_cirurgias INTEGER,
	HORAS_TRABALHADAS INTEGER,
	crm_medico_cirurgiao VARCHAR(11) PRIMARY KEY,

	FOREIGN KEY (crm_medico_cirurgiao) REFERENCES medicos (crm) ON DELETE CASCADE
);

CREATE TABLE pacientes(
	cpf VARCHAR(10) PRIMARY KEY,
    	nome VARCHAR(20) DEFAULT 'Não informado',
	idade INTEGER
);

CREATE TABLE medico_atende_paciente(
	crm_clinico VARCHAR(10) PRIMARY KEY,
    	cpf_paciente VARCHAR(10),
    
   	FOREIGN KEY (crm_clinico) REFERENCES medicos(crm),
    	FOREIGN KEY (cpf_paciente) REFERENCES pacientes(cpf)
);

CREATE TABLE paciente_reside_em(
	rua VARCHAR(100),
    	cpf VARCHAR(100),
    	numero INTEGER,
    	bairro VARCHAR(100),
	
    	PRIMARY KEY (rua,cpf),
    	FOREIGN KEY (cpf) REFERENCES pacientes (cpf) ON DELETE CASCADE
);

CREATE TABLE leitos(
	numero INTEGER PRIMARY KEY,
    	especialidade VARCHAR(20),
    	vagas INTEGER
);

CREATE TABLE paciente_ficam_em_leitos(
	paciente_cpf VARCHAR(11) PRIMARY KEY,
    	numero_leito INTEGER,
    	data_inicio DATE,
    
    	FOREIGN KEY (paciente_cpf) REFERENCES pacientes (cpf)
);

CREATE TABLE equipamentos(
	id_equip INTEGER PRIMARY KEY,
    	nome VARCHAR(30),
    	tipo VARCHAR(200)
);

CREATE TABLE leitos_necessitam_equipamentos(
		num_leito INTEGER,
    	id_equip INTEGER,
    
    	PRIMARY KEY (num_leito, id_equip),
    	FOREIGN KEY (num_leito) REFERENCES leitos(numero),
    	FOREIGN KEY (id_equip) REFERENCES equipamentos(id_equip)
);

CREATE TABLE cirurgias (
		id INTEGER PRIMARY KEY,
    	tempo VARCHAR(20),
        objetivo_cirurgia VARCHAR(300),
        grau_complexidade VARCHAR(40),
    	tipo_anestesia VARCHAR(10)
);

CREATE TABLE medicos_realizam_cirurgias (
	crm_cirurgiao VARCHAR(11),
    	id_cirurgia INTEGER,
	data_cirurgia DATE,
    
    	PRIMARY KEY (crm_cirurgiao, id_cirurgia),
    	FOREIGN KEY (crm_cirurgiao) REFERENCES medico_cirurgiao (crm_medico_cirurgiao),
    	FOREIGN KEY (id_cirurgia) REFERENCES cirurgias (id)
    
);

CREATE TABLE medicamentos(
	id_medicamento INTEGER PRIMARY KEY,
    	tipo_medicamento VARCHAR(20),
    	preco_medicamento DECIMAL(5,2)
    
);

CREATE TABLE medico_receita_medicamento(
	crm_clinico_geral VARCHAR(11),
    	id_medicamento INTEGER,
    
    	FOREIGN KEY (crm_clinico_geral) REFERENCES medico_clinico_geral(crm_clinico_geral),
    	FOREIGN KEY (id_medicamento) REFERENCES medicamentos(id_medicamento),
    
    	PRIMARY KEY (crm_clinico_geral, id_medicamento)
);

CREATE TABLE enfermeiros(
	coren VARCHAR(11) PRIMARY KEY,
    	nome VARCHAR(20),
    	idade INTEGER
);

CREATE TABLE enfermeiro_aplica_medicamento(
	coren_enfermeiro VARCHAR(11),
    	id_medicamento INTEGER,
    	quantidade_ml DECIMAL (5,4),
    
    	PRIMARY KEY (coren_enfermeiro, id_medicamento),
    	FOREIGN KEY (coren_enfermeiro) REFERENCES enfermeiros(coren),
    	FOREIGN KEY (id_medicamento) REFERENCES medicamentos(id_medicamento)
);

/*------------------------------MÉDICOS---------------------------*/

INSERT INTO medicos (CRM, nome, sobrenome)
VALUES  ('1254632025','Edson','Celulari'),
		('9315321211','Lucas','Souza'),
        ('9054398594','Ian','Mantovani'),
        ('2587413699','Paulo','Teruo'),
        ('6548921456','Carlos','Apate'),
        ('3154123311','Luiz','Albano'),
        ('3441233432','Amanda','Rodrigues'),
        ('6541225155','João','Silva'),
        ('7841223661','Pedro','Portinari'),
        ('1232435211','Felícia','Jones'),
        ('8539123832','Ana','Mantovani'),
		('1245856392','Brad','Jolie'),
        ('2540254940','Angelina','Pitt'),
        ('8493457322','Pietro','Oliveira'),
        ('1364729475','Calvin','Klein'),
        ('6314524196','Tereza','Souza'),
        ('9514367458','João','Paulo Neto'),
        ('4326175915','Ingrid','Kreinstopf'),
        ('0326154895','Mariana','Ulinstpor'),
        ('7485263198','Gabriela','Prielstein');
        
/*------------------------------CLINICO GERAL-------------------------*/

INSERT INTO medico_clinico_geral (horas_trabalhadas, salario, rg, crm_clinico_geral)
VALUES  (124,10214.32,'384182394',1254632025),
		(649,12254.32,'853712732',9315321211),
		(223,8008.32,'3656421020',9054398594),
        (642,15336.32,'987564825',2587413699),
        (200,12342.32,'645698765',6548921456),
        (154,7065.32,'102546989',3154123311),
        (395,9054.32,'214584545',3441233432),
        (678,16655.32,'874896583',6541225155),
        (765,21457.32,'986471814',7841223661),
        (345,5343.32,'356469595',1232435211);
        
/*------------------------------MÉDICO CIRURGIÃO-------------------------*/

INSERT INTO medico_cirurgiao (especialidade,numero_cirurgias, HORAS_TRABALHADAS, crm_medico_cirurgiao)
VALUES  ('Cardiovascular',8,80,'8539123832'),
		('Cirurgia Geral',12,140,'1245856392'),
		('Neurologia',4,58,'2540254940'),
        ('Plástica',13,175,'8493457322'),
        ('Urologia',5,198,'1364729475'),
        ('Oncologia',32,541,'6314524196'),
        ('Pediatria',13,412,'9514367458'),
        ('Coloproctológica',16,685,'4326175915'),
        ('Cirurgia Geral',21,785,'0326154895'),
        ('Plástica',31,488,'7485263198');
        
/*------------------------------PACIENTES-------------------------*/
        
INSERT INTO pacientes (cpf,nome,idade)
VALUES  ('3698777452','Ronaldo',13),
		('2146322231','Christopher',43),
		('3461542346','Renato', 26),
        ('9848721721','Wilfred', 64),
        ('9727857410','Beolwolf',84),
        ('8574515225','Cintia',21),
        ('5365452513','Obama', 47),
        ('4500524136','André', 28),
        ('5142321644','Ludmila', 64),
        ('5841873298','Fernanda',61);

/*------------------------------MEDICOS_ATENDEM_PACIENTES-------------------------*/

INSERT INTO medico_atende_paciente(crm_clinico, cpf_paciente)
VALUES 	('1254632025','3698777452'),
		('9315321211','2146322231'),
        ('9054398594','3461542346'),
        ('2587413699','9848721721'),
        ('6548921456','9727857410'),
        ('3154123311','8574515225'),
        ('3441233432','5365452513'),
        ('6541225155','4500524136'),
        ('7841223661','5142321644'),
        ('1232435211','5841873298');
        
/*------------------------------PACIENTE_RESIDE_EM-------------------------*/

INSERT INTO paciente_reside_em (rua,cpf,numero,bairro)
VALUES 	('Rua Cleber Matias','3698777452',1233,'Cleberlândia'),
		('Avenia Ribamar','2146322231',473,'Riba Oceano'),
        ('Rua das Lantejoulas','9848721721', 541, 'Grafite'),
        ('Rua Borboletas Psicodélicas','3461542346',508,'Insetolândia'),
        ('Rua do Banco','9727857410',231,'De Dados'),
        ('Rua avenida das ruas','8574515225',521,'Avenida de ruas'),
        ('Avenida Beira-mar','5365452513',1222,'Oceanos de avenidas'),
        ('Avenida Paulista','4500524136',4821,'Centro'),
        ('Rua Tapajós','5142321644',321,'Renato Maia'),
        ('Rua dos Índios', '5841873298',954,'Centro');
        
/*------------------------------LEITOS-------------------------*/

INSERT INTO leitos (numero,especialidade,vagas)
VALUES 	(101,'Pediatria', 2),
		(102,'Pediatria', 2),
        (201,'Enfermagem', 4),
        (202,'Enfermagem', 4),
        (301,'UTI', 6),
        (302,'UTI', 6),
        (303,'UTI Pediátrica', 6),
        (401,'Cirurgia', 1),
        (402,'Cirurgia', 1),
        (403,'Cirurgia', 1);
        
/*------------------------PACIENTES_FICAM_EM_LEITOS---------------*/

INSERT INTO paciente_ficam_em_leitos(paciente_cpf, numero_leito, data_inicio)
VALUES	('3698777452',101,'2020-04-11'),
		('2146322231',201,'2021-02-12'),
		('3461542346',201,'2021-04-18'),
        ('9848721721',202,'2021-01-18'),
        ('9727857410',401,'2021-04-11'),
        ('8574515225',402,'2021-01-26'),
        ('5365452513',302,'2021-04-01'),
        ('4500524136',102,'2021-06-07'),
        ('5142321644',303,'2021-03-13'),
        ('5841873298',201,'2020-12-20');
        
/*------------------------EQUIPAMENTOS---------------*/

INSERT INTO equipamentos (id_equip, nome, tipo)
VALUES 	(1011,'Desfibrilador','equipamento utilizado para socorrer pessoas vítimas de um ataque cardíaco e para reverter arritmias cardíacas'),
		(2541,'Cardioversor','emite descargas elétricas sincronizadas para restaurar o ritmo cardíaco'),
        (6554,'Eletrocardiógrafo','utilizado para diagnóstico e identificação de doenças cardíacas, pois avalia e registra os batimentos do coração. '),
        (1000,'Bomba de infusão','equipamento que leva alimentos, fluidos e medicamentos para pacientes que precisam de cuidados especiais'),
        (2133,'Ventilador','auxilia pacientes com o pulmão comprometido a respirarem, enviando ar e fazendo o movimento de expiração.'),
        (3442,'Oxímetro','É um pequeno aparelho usado para medir quanto oxigênio o sangue está transportando, sem precisar de agulha.'),
        (1331,'Monitor multiparamétrico','acompanhar os sinais vitais dos pacientes'),
        (1337,'Monitor multiparamétrico','acompanhar os sinais vitais dos pacientes'),
        (5421,'Desfibrilador','equipamento utilizado para socorrer pessoas vítimas de um ataque cardíaco e para reverter arritmias cardíacas'),
        (3444,'Desfibrilador','equipamento utilizado para socorrer pessoas vítimas de um ataque cardíaco e para reverter arritmias cardíacas');
	
/*------------------------LEITOS_NECESSITAM_EQUIPAMENTOS---------------*/

INSERT INTO leitos_necessitam_equipamentos (num_leito, id_equip)
VALUES	(101,1011),
		(102,2541),
        (201,6554),
        (202,1000),
        (301,2133),
        (302,3442),
        (303,1331),
        (401,1337),
        (402,5421),
        (403,3444);
        
INSERT INTO cirurgias (id, tempo, objetivo_cirurgia, grau_complexidade, tipo_anestesia)
VALUES 	(1, '3 horas e 2 minutos', 'Remoção do apêndice', 'baixo', 'Geral'),
		(2, '4 horas e 54 minutos', 'Amputação do dedo médio da mão esquerda', 'Médio', 'Geral'),
        (3, '20 minutos', 'Vasectomia', 'baixo', 'local'),
        (4, '2 horas e 32 minutos', 'Recuperação de membro quebrado', 'baixo', 'Geral'),
        (5, '7 horas e 8 minutos', 'Remoção de carcinoma pulmonar', 'Alto', 'Geral'),
        (6, '5 horas e 34 minutos', 'Reparação de problemas de cirurgia cardíaca anterior em criança', 'Alto', 'Geral'),
        (7, '2 horas e 00 minutos', 'Lipoaspiração e inserção de silicone nos seios', 'Baixo', 'Geral'),
        (8, '32 minutos', 'Lipoaspiração', 'baixo', 'Geral'),
        (9, '2 horas e 12 minutos', 'Cirurgia emergencial, remoção de projétil na região cerebral', 'Alto', 'Geral'),
        (10, '3 horas e 46 minutos', 'Remoção de um dos rins', 'Alto', 'Geral');
        
        
/*------------------------MEDICOS_REALIZAM_CIRURGIAS---------------*/

INSERT INTO medicos_realizam_cirurgias (crm_cirurgiao, id_cirurgia, data_cirurgia)
VALUES 	('1245856392',1,'2020-12-12'),
		('0326154895',2,'2021-05-01'),
        ('1364729475',3,'2020-06-02'),
        ('1245856392',4,'2021-02-12'),
        ('6314524196',5,'2021-01-23'),
        ('9514367458',6,'2021-01-27'),
        ('7485263198',7,'2021-02-15'),
        ('8493457322',8,'2021-05-04'),
        ('2540254940',9,'2021-05-09'),
        ('1364729475',10,'2021-04-23');
        
/*------------------------MEDICAMENTOS---------------*/

/*------------------------medico_receita_medicamento---------------*/

/*------------------------enfermeiros---------------*/

/*------------------------enfermeiro_aplica_medicamento---------------*/

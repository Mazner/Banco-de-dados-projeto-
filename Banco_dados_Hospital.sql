use banco_de_dados_hospital;

/* Declaração das tabelas*/ 

CREATE TABLE MEDICOS(
	CRM INTEGER NOT NULL PRIMARY KEY,
    NOME VARCHAR(100) NOT NULL,
    RG VARCHAR(30) NOT NULL,
    IDADE INTEGER NOT NULL
);

CREATE TABLE PACIENTES(
	CPF INTEGER NOT NULL PRIMARY KEY,
    NOME VARCHAR(100) NOT NULL,
    IDADE INTEGER NOT NULL,
    RG VARCHAR(30) NOT NULL,
    SEXO VARCHAR (20) NOT NULL
);

CREATE TABLE LEITOS(
	ID VARCHAR(100) NOT NULL PRIMARY KEY,
    ESPECIALIDADE VARCHAR(100) NOT NULL,
    NUMERO_CAMAS INTEGER NOT NULL
);

CREATE TABLE DOENCAS(
	NOME_CIENTIFICO VARCHAR(100) NOT NULL PRIMARY KEY,
    SINTOMAS VARCHAR (300) NOT NULL,
    FATOR_DE_RISCO VARCHAR (30) NOT NULL
);

CREATE TABLE EXAME_LABORATORIAL(
	ID_EXAME VARCHAR(100) NOT NULL PRIMARY KEY,
    DATA INTEGER NOT NULL,
    RESULTADO VARCHAR(100) NOT NULL
);

CREATE TABLE BIOMEDICOS(
	CRBM VARCHAR(100) NOT NULL PRIMARY KEY,
    NOME VARCHAR (100) NOT NULL,
    IDADE INTEGER NOT NULL
);

CREATE TABLE ENFERMEIROS (
	COREN VARCHAR(100) NOT NULL PRIMARY KEY, 
    NOME VARCHAR(100) NOT NULL,
	IDADE INTEGER NOT NULL
);

CREATE TABLE MEDICAMENTOS(
	ID_MEDICAMENTO INTEGER NOT NULL PRIMARY KEY,
    PRECO VARCHAR(100) NOT NULL,
	TIPO VARCHAR(100) NOT NULL,
    QUANTIDADE INTEGER NOT NULL
);

CREATE TABLE CIRURGIAS (
	TIPO VARCHAR(100) NOT NULL PRIMARY KEY,
    DATA INTEGER NOT NULL,
    HORA_INICIO INTEGER NOT NULL,
    RESULTADO ENUM('Sucesso', 'Fracasso', 'Adidada') NOT NULL
);

CREATE TABLE FUNCIONARIO_LOGISTICA (
	ID_FUNCIONARIO VARCHAR(100) NOT NULL PRIMARY KEY,
    NOME VARCHAR(100) NOT NULL,
    IDADE INTEGER NOT NULL
);

CREATE TABLE DEPARTAMENTOS (
	ID_DEPARTAMENTO VARCHAR(100) NOT NULL PRIMARY KEY,
    NOME VARCHAR(100) NOT NULL,
    ORCAMENTO VARCHAR(100) NOT NULL
);

/* Relações entre as tabelas*/

CREATE TABLE MEDICOS_TRATAM_DE_PACIENTES(
	CRM VARCHAR(100) NOT NULL,
    CPF INTEGER NOT NULL,
    
    FOREIGN KEY (CRM) REFERENCES MEDICOS(CRM),
    FOREIGN KEY (CPF) REFERENCES PACIENTES(CPF),
    
    PRIMARY KEY (CRM, CPF)
);

CREATE TABLE MEDICOS_REALIZAM_CIRURGIAS(
	CRM VARCHAR(100) NOT NULL,
    TIPO VARCHAR(100) NOT NULL,
    
    FOREIGN KEY (CRM) REFERENCES MEDICOS(CRM),
    FOREIGN KEY (TIPO) REFERENCES CIRURGIAS(TIPO),
    
    PRIMARY KEY (CRM,TIPO)
);

CREATE TABLE CIRURGIAS_NECESSITAM_MEDICAMENTOS(
	TIPO VARCHAR(100) NOT NULL,
    ID_MEDICAMENTO INTEGER NOT NULL,
    QUANTIDADE INTEGER NOT NULL,
    
    FOREIGN KEY (TIPO) REFERENCES CIRURGIAS(TIPO),
    FOREIGN KEY (ID_MEDICAMENTO) REFERENCES MEDICAMENTOS(ID_MEDICAMENTO),
    
    PRIMARY KEY (TIPO,ID_MEDICAMENTO)
);

CREATE TABLE ENFERMEIRO_AUXILIA_CIRURGIA(
	COREN VARCHAR(100) NOT NULL,
    TIPO VARCHAR(100) NOT NULL,
    
    FOREIGN KEY (COREN) REFERENCES ENFERMEIROS(COREN),
    FOREIGN KEY (TIPO) REFERENCES CIRURGIAS(TIPO),
    
    PRIMARY KEY (COREN, TIPO) 
);

CREATE TABLE ENFERMEIRO_AUXILIA_LEITO(
	COREN VARCHAR(100) NOT NULL,
    ID_LEITO VARCHAR(100) NOT NULL,
    
    FOREIGN KEY (COREN) REFERENCES ENFERMEIROS(COREN),
    FOREIGN KEY (ID_LEITO) REFERENCES LEITOS(ID_LEITO),
    
    PRIMARY KEY (COREN, ID_LEITO)
);

CREATE TABLE LEITO_REQUISITA (
	ID_LEITO VARCHAR(100) NOT NULL,
    ID_MEDICAMENTO INTEGER NOT NULL,
    
    FOREIGN KEY (ID_LEITO) REFERENCES LEITOS(ID_LEITO),
    FOREIGN KEY (ID_MEDICAMENTO) REFERENCES MEDICAMENTOS(ID_MEDICAMENTO),
    
    PRIMARY KEY (ID_LEITO,ID_MEDICAMENTO)
);

CREATE TABLE MEDICO_TRABALHA (
	CRM VARCHAR(100) NOT NULL,
    ID_DEPARTAMENTO VARCHAR(100) NOT NULL,
    
    FOREIGN KEY (CRM) REFERENCES MEDICOS(CRM),
    FOREIGN KEY (ID_DEPARTAMENTO) REFERENCES DEPARTAMENTOS (ID_DEPARTAMENTO),
    
    PRIMARY KEY (CRM, ID_DEPARTAMENTO)
);

CREATE TABLE DEPARTAMENTO_REQUISITA(
	ID_DEPARTAMENTO VARCHAR(100) NOT NULL,
    ID_FUNCIONARIO VARCHAR(100) NOT NULL,
    
    FOREIGN KEY (ID_DEPARTAMENTO) REFERENCES DEPARTAMENTOS(ID_DEPARTAMENTO),
    FOREIGN KEY (ID_FUNCIONARIO) REFERENCES FUNCIONARIO_LOGISTICA (ID_FUNCIONARIO),
    
    PRIMARY KEY (ID_DEPARTAMENTO, ID_FUNCIONARIO)
);

CREATE TABLE FUNCIONARIO_ENTREGA(
	ID_FUNCIONARIO VARCHAR(100) NOT NULL,
    ID_MEDICAMENTO INTEGER NOT NULL,
    DATA_ENTREGA INTEGER NOT NULL,
    QUANTIDADE_ENTREGUE INTEGER NOT NULL,
    
    FOREIGN KEY (ID_FUNCIONARIO) REFERENCES FUNCIONARIO_LOGISTICA(ID_FUNCIONARIO),
    
    PRIMARY KEY (ID_FUNCIONARIO)
);

CREATE TABLE FUNCIONARIO_LOGISITICA_TRABALHA(
	ID_FUNCIONARIO VARCHAR(100) NOT NULL,
    ID_DEPARTAMENTO VARCHAR(100) NOT NULL,
    
    FOREIGN KEY (ID_FUNCIONARIO) REFERENCES FUNCIONARIO_LOGISTICA(ID_FUNCIONARIO),
    FOREIGN KEY (ID_DEPARTAMENTO) REFERENCES DEPARTAMENTOS(ID_DEPARTAMENTO),
    
    PRIMARY KEY (ID_FUNCIONARIO, ID_DEPARTAMENTO)
);

CREATE TABLE ENFERMEIRO_TRABALHA(
	COREN VARCHAR(100) NOT NULL,
    ID_DEPARTAMENTO VARCHAR(100) NOT NULL,
    
    FOREIGN KEY (COREN) REFERENCES ENFERMEIROS(COREN),
    FOREIGN KEY (ID_DEPARTAMENTO) REFERENCES DEPARTAMENTOS(ID_DEPARTAMENTO),
    
    PRIMARY KEY (COREN, ID_DEPARTAMENTO)
);

CREATE TABLE PACIENTES_DIAGNOSTICO(
	CPF INTEGER NOT NULL,
    DOENCA VARCHAR(100) NOT NULL,
    
    FOREIGN KEY (CPF) REFERENCES PACIENTES(CPF),
    FOREIGN KEY (DOENCA) REFERENCES DOENCAS(NOME_CIENTIFICO),
    
    PRIMARY KEY (CPF, DOENCA)
);

CREATE TABLE BIOMEDICO_EXAME(
	CRBM VARCHAR(100) NOT NULL,
    ID_EXAME VARCHAR(100) NOT NULL,
    
    FOREIGN KEY (CRBM) REFERENCES BIOMEDICOS (CRBM),
    FOREIGN KEY (ID_EXAME) REFERENCES EXAME_LABORATORIAL(ID_EXAME),
    
    PRIMARY KEY (CRBM, ID_EXAME)
);

CREATE TABLE BIOMEDICO_DEPARTAMENTO(
	CRBM VARCHAR(100) NOT NULL,
    ID_DEPARTAMENTO VARCHAR(100) NOT NULL,
    
    FOREIGN KEY(CRBM) REFERENCES BIOMEDICOS(CRBM),
    FOREIGN KEY(ID_DEPARTAMENTO) REFERENCES DEPARTAMENTOS(ID_DEPARTAMENTO),
    
    PRIMARY KEY (CRBM, ID_DEPARTAMENTO)
);

CREATE TABLE PACIENTES_MEDICAMENTO(
	CPF INTEGER NOT NULL,
    ID_MEDICAMENTO INTEGER NOT NULL,
    QUANTIDADE_DIARIA INTEGER NOT NULL,
    NOME_MEDICAMENTO VARCHAR(100),
    
    FOREIGN KEY (CPF) REFERENCES PACIENTES (CPF),
    FOREIGN KEY (ID_MEDICAMENTO) REFERENCES MEDICAMENTOS(ID_MEDICAMENTO),
    
    PRIMARY KEY (CPF, ID_MEDICAMENTO)
);


CREATE TABLE medicos (
	crm VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(20) NOT NULL,
    sobrenome VARCHAR(20) NOT NULL
);

CREATE TABLE medico_clinico_geral(
	horas_trabalhadas INTEGER,
    idade INTEGER,
    rg VARCHAR(10),
    crm_clinico_geral VARCHAR(11) PRIMARY KEY,
    
    FOREIGN KEY (crm_clinico_geral) REFERENCES medicos (crm) ON DELETE CASCADE
);

CREATE TABLE medico_cirurgiao(
	especialidade VARCHAR(20),
    numero_cirurgias INTEGER,
    idade INTEGER,
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
	rua VARCHAR(10),
    cpf VARCHAR(10),
    numero INTEGER,
    bairro VARCHAR(10),
	
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
	id_equip INTEGER AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(20),
    tipo VARCHAR(100)
);

CREATE TABLE leitos_necessitam_equipamentos(
	num_leito INTEGER,
    id_equip INTEGER,
    
    PRIMARY KEY (num_leito, id_equip),
    FOREIGN KEY (num_leito) REFERENCES leitos (numero),
    FOREIGN KEY (id_equip) REFERENCES equipamentos (id_equip)
);

CREATE TABLE cirurgias (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    tempo VARCHAR(20),
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
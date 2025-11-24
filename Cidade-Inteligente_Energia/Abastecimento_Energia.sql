CREATE TABLE tipo_energia (
    id_tipo INTEGER PRIMARY KEY,
    nome_tipo VARCHAR(50) NOT NULL
);

CREATE TABLE categoria_energia (
    id_categoria INTEGER PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL,
    id_tipo INTEGER NOT NULL,
    CONSTRAINT fk_categoria_tipo FOREIGN KEY (id_tipo) 
        REFERENCES tipo_energia (id_tipo)
);

CREATE TABLE status_fonte (
    id_status INTEGER PRIMARY KEY,
    descricao VARCHAR(30) NOT NULL
);

CREATE TABLE fonte_energia (
    id_fonte INTEGER PRIMARY KEY,
    nome_fonte VARCHAR(100) NOT NULL,
    capacidade_mw DECIMAL(10, 2) NOT NULL,
    id_categoria INTEGER NOT NULL,
    id_status INTEGER NOT NULL,
    CONSTRAINT fk_fonte_categoria FOREIGN KEY (id_categoria) 
        REFERENCES categoria_energia (id_categoria),
    CONSTRAINT fk_fonte_status FOREIGN KEY (id_status) 
        REFERENCES status_fonte (id_status)
);

CREATE TABLE status_linha (
    id_status INTEGER PRIMARY KEY,
    descricao VARCHAR(30) NOT NULL
);

CREATE TABLE linha_transmissao (
    id_linha INTEGER PRIMARY KEY,
    tensao_kv DECIMAL(10, 2) NOT NULL,
    comprimento_km DECIMAL(10, 2) NOT NULL,
    capacidade_mw DECIMAL(10, 2) NOT NULL,
    id_status INTEGER NOT NULL,
    CONSTRAINT fk_linha_status FOREIGN KEY (id_status) 
        REFERENCES status_linha (id_status)
);

CREATE TABLE falha_linha (
    id_falha INTEGER PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);

CREATE TABLE linha_falha (
    id_linha INTEGER,
    id_falha INTEGER,
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_linha, id_falha, data_registro),
    CONSTRAINT fk_lf_linha FOREIGN KEY (id_linha) 
        REFERENCES linha_transmissao (id_linha),
    CONSTRAINT fk_lf_falha FOREIGN KEY (id_falha) 
        REFERENCES falha_linha (id_falha)
);

CREATE TABLE nivel_tensao (
    id_nivel INTEGER PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL
);

CREATE TABLE linha_nivel_tensao (
    id_linha INTEGER,
    id_nivel INTEGER,
    PRIMARY KEY (id_linha, id_nivel),
    CONSTRAINT fk_lnt_linha FOREIGN KEY (id_linha) 
        REFERENCES linha_transmissao (id_linha),
    CONSTRAINT fk_lnt_nivel FOREIGN KEY (id_nivel) 
        REFERENCES nivel_tensao (id_nivel)
);

INSERT INTO tipo_energia (id_tipo, nome_tipo) VALUES
(1, 'Renovável'),
(2, 'Não Renovável'),
(3, 'Alternativa')
ON CONFLICT (id_tipo) DO NOTHING;

INSERT INTO categoria_energia (id_categoria, nome_categoria, id_tipo) VALUES
(10, 'Solar Fotovoltaica', 1),
(11, 'Eólica', 1),
(12, 'Hidrelétrica', 1),
(13, 'Biomassa', 1),
(14, 'Termelétrica (Gás Natural)', 2),
(15, 'Nuclear', 3)
ON CONFLICT (id_categoria) DO NOTHING;

INSERT INTO status_fonte (id_status, descricao) VALUES
(1, 'Operacional'),
(2, 'Em Manutenção'),
(3, 'Desativada'),
(4, 'Em Standby')
ON CONFLICT (id_status) DO NOTHING;

INSERT INTO status_linha (id_status, descricao) VALUES
(1, 'Ativa'),
(2, 'Inativa (Manutenção)'),
(3, 'Falha Detectada'),
(4, 'Sobrecarga')
ON CONFLICT (id_status) DO NOTHING;

INSERT INTO falha_linha (id_falha, descricao) VALUES
(1, 'Curto-circuito'),
(2, 'Rompimento de Cabo'),
(3, 'Falha de Isolador'),
(4G, 'Queda de Torre'),
(5, 'Sobrecarga Não Gerenciada')
ON CONFLICT (id_falha) DO NOTHING;

INSERT INTO nivel_tensao (id_nivel, descricao) VALUES
(1, 'Extra Alta Tensão (EAT)'),
(2, 'Alta Tensão (AT)'),
(3, 'Média Tensão (MT)'),
(4, 'Baixa Tensão (BT)')
ON CONFLICT (id_nivel) DO NOTHING;

INSERT INTO fonte_energia (id_fonte, nome_fonte, capacidade_mw, id_categoria, id_status) VALUES
(1001, 'Usina Solar Central', 150.50, 10, 1),
(1002, 'Parque Eólico Vento Forte', 220.00, 11, 1),
(1003, 'Usina Hidrelétrica Rio Claro', 800.00, 12, 1),
(1004, 'Termelétrica Cidade Nova', 450.75, 14, 2),
(1005, 'Painéis Solares (Distribuído)', 50.00, 10, 4)
ON CONFLICT (id_fonte) DO NOTHING;

INSERT INTO linha_transmissao (id_linha, tensao_kv, comprimento_km, capacidade_mw, id_status) VALUES
(201, 500.00, 120.5, 1000.00, 1),
(202, 230.00, 45.0, 500.00, 1),
(203, 138.00, 15.2, 250.00, 3),
(204, 500.00, 90.0, 1000.00, 2)
ON CONFLICT (id_linha) DO NOTHING;

INSERT INTO linha_falha (id_linha, id_falha) VALUES
(203, 1),
(201, 3)
ON CONFLICT (id_linha, id_falha, data_registro) DO NOTHING;

INSERT INTO linha_nivel_tensao (id_linha, id_nivel) VALUES
(201, 1),
(202, 2),
(203, 2),
(204, 1)
ON CONFLICT (id_linha, id_nivel) DO NOTHING;
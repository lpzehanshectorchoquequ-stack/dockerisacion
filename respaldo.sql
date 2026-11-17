--
-- PostgreSQL database dump
--

\restrict mbJ6z4eljZcYlYsuuqRCtGRzKhN9uVhqE3pBaeECd8ZugmrDXMCWvZbYtUIstic

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-11-16 20:49:05

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 238 (class 1259 OID 49489)
-- Name: conclusiones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conclusiones (
    id_conclusion integer NOT NULL,
    id_evaluacion integer NOT NULL,
    trastorno character varying(30) NOT NULL,
    nivel character varying(30) NOT NULL,
    explicacion text,
    recomendacion text,
    usuario_creacion character varying(100) DEFAULT 'sistema'::character varying NOT NULL,
    usuario_modificacion character varying(100),
    fecha_creacion timestamp without time zone DEFAULT now() NOT NULL,
    fecha_modificacion timestamp without time zone,
    eliminado boolean DEFAULT false NOT NULL
);


ALTER TABLE public.conclusiones OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 49488)
-- Name: conclusiones_id_conclusion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conclusiones_id_conclusion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conclusiones_id_conclusion_seq OWNER TO postgres;

--
-- TOC entry 5162 (class 0 OID 0)
-- Dependencies: 237
-- Name: conclusiones_id_conclusion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conclusiones_id_conclusion_seq OWNED BY public.conclusiones.id_conclusion;


--
-- TOC entry 234 (class 1259 OID 49441)
-- Name: condiciones_regla; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.condiciones_regla (
    id_condicion integer NOT NULL,
    id_regla integer NOT NULL,
    hecho character varying(50) NOT NULL,
    operador character varying(2) NOT NULL,
    valor numeric NOT NULL,
    usuario_creacion character varying(100) DEFAULT 'sistema'::character varying NOT NULL,
    usuario_modificacion character varying(100),
    fecha_creacion timestamp without time zone DEFAULT now() NOT NULL,
    fecha_modificacion timestamp without time zone,
    eliminado boolean DEFAULT false NOT NULL,
    CONSTRAINT condiciones_regla_operador_check CHECK (((operador)::text = ANY ((ARRAY['>='::character varying, '>'::character varying, '<='::character varying, '<'::character varying, '=='::character varying])::text[])))
);


ALTER TABLE public.condiciones_regla OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 49440)
-- Name: condiciones_regla_id_condicion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.condiciones_regla_id_condicion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.condiciones_regla_id_condicion_seq OWNER TO postgres;

--
-- TOC entry 5163 (class 0 OID 0)
-- Dependencies: 233
-- Name: condiciones_regla_id_condicion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.condiciones_regla_id_condicion_seq OWNED BY public.condiciones_regla.id_condicion;


--
-- TOC entry 226 (class 1259 OID 33020)
-- Name: evaluaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evaluaciones (
    id_evaluacion integer NOT NULL,
    id_nino integer NOT NULL,
    id_psicologo integer CONSTRAINT evaluaciones_id_terapeuta_not_null NOT NULL,
    fecha_evaluacion date DEFAULT CURRENT_DATE,
    observaciones text,
    usuario_creacion character varying(100) DEFAULT 'sistema'::character varying NOT NULL,
    usuario_modificacion character varying(100),
    fecha_creacion timestamp without time zone DEFAULT now() NOT NULL,
    fecha_modificacion timestamp without time zone,
    eliminado boolean DEFAULT false NOT NULL,
    id_instrumento integer NOT NULL
);


ALTER TABLE public.evaluaciones OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 33019)
-- Name: evaluaciones_id_evaluacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.evaluaciones_id_evaluacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.evaluaciones_id_evaluacion_seq OWNER TO postgres;

--
-- TOC entry 5164 (class 0 OID 0)
-- Dependencies: 225
-- Name: evaluaciones_id_evaluacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evaluaciones_id_evaluacion_seq OWNED BY public.evaluaciones.id_evaluacion;


--
-- TOC entry 228 (class 1259 OID 49384)
-- Name: instrumentos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instrumentos (
    id_instrumento integer NOT NULL,
    codigo character varying(30) NOT NULL,
    nombre character varying(150) NOT NULL,
    descripcion text,
    trastorno character varying(30) NOT NULL,
    quien_responde character varying(50) NOT NULL,
    estado_validacion character varying(20) DEFAULT 'BORRADOR'::character varying NOT NULL,
    usuario_creacion character varying(100) DEFAULT 'sistema'::character varying NOT NULL,
    usuario_modificacion character varying(100),
    fecha_creacion timestamp without time zone DEFAULT now() NOT NULL,
    fecha_modificacion timestamp without time zone,
    eliminado boolean DEFAULT false NOT NULL
);


ALTER TABLE public.instrumentos OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 49383)
-- Name: instrumentos_id_instrumento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instrumentos_id_instrumento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.instrumentos_id_instrumento_seq OWNER TO postgres;

--
-- TOC entry 5165 (class 0 OID 0)
-- Dependencies: 227
-- Name: instrumentos_id_instrumento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instrumentos_id_instrumento_seq OWNED BY public.instrumentos.id_instrumento;


--
-- TOC entry 224 (class 1259 OID 32994)
-- Name: ninos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ninos (
    id_nino integer NOT NULL,
    id_tutor integer,
    nombre character varying(100) NOT NULL,
    fecha_nacimiento date NOT NULL,
    motivo_consulta text,
    activo boolean DEFAULT true NOT NULL,
    id_psicologo integer,
    usuario_creacion character varying(100) DEFAULT 'sistema'::character varying NOT NULL,
    usuario_modificacion character varying(100),
    fecha_creacion timestamp without time zone DEFAULT now() NOT NULL,
    fecha_modificacion timestamp without time zone,
    eliminado boolean DEFAULT false NOT NULL,
    genero character varying(10),
    fortalezas text,
    dificultades text,
    CONSTRAINT ninos_genero_check CHECK (((genero)::text = ANY ((ARRAY['NINO'::character varying, 'NINA'::character varying])::text[])))
);


ALTER TABLE public.ninos OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 32993)
-- Name: ninos_id_nino_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ninos_id_nino_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ninos_id_nino_seq OWNER TO postgres;

--
-- TOC entry 5166 (class 0 OID 0)
-- Dependencies: 223
-- Name: ninos_id_nino_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ninos_id_nino_seq OWNED BY public.ninos.id_nino;


--
-- TOC entry 230 (class 1259 OID 49402)
-- Name: preguntas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preguntas (
    id_pregunta integer NOT NULL,
    id_instrumento integer NOT NULL,
    orden integer NOT NULL,
    texto text NOT NULL,
    subescala character varying(30) NOT NULL,
    usuario_creacion character varying(100) DEFAULT 'sistema'::character varying NOT NULL,
    usuario_modificacion character varying(100),
    fecha_creacion timestamp without time zone DEFAULT now() NOT NULL,
    fecha_modificacion timestamp without time zone,
    eliminado boolean DEFAULT false NOT NULL
);


ALTER TABLE public.preguntas OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 49401)
-- Name: preguntas_id_pregunta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.preguntas_id_pregunta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.preguntas_id_pregunta_seq OWNER TO postgres;

--
-- TOC entry 5167 (class 0 OID 0)
-- Dependencies: 229
-- Name: preguntas_id_pregunta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.preguntas_id_pregunta_seq OWNED BY public.preguntas.id_pregunta;


--
-- TOC entry 232 (class 1259 OID 49421)
-- Name: reglas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reglas (
    id_regla integer NOT NULL,
    id_instrumento integer NOT NULL,
    codigo character varying(40) NOT NULL,
    descripcion text NOT NULL,
    nivel character varying(20),
    hecho_derivado character varying(40),
    recomendacion text,
    usuario_creacion character varying(100) DEFAULT 'sistema'::character varying NOT NULL,
    usuario_modificacion character varying(100),
    fecha_creacion timestamp without time zone DEFAULT now() NOT NULL,
    fecha_modificacion timestamp without time zone,
    eliminado boolean DEFAULT false NOT NULL
);


ALTER TABLE public.reglas OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 49420)
-- Name: reglas_id_regla_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reglas_id_regla_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reglas_id_regla_seq OWNER TO postgres;

--
-- TOC entry 5168 (class 0 OID 0)
-- Dependencies: 231
-- Name: reglas_id_regla_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reglas_id_regla_seq OWNED BY public.reglas.id_regla;


--
-- TOC entry 236 (class 1259 OID 49467)
-- Name: respuestas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.respuestas (
    id_respuesta integer NOT NULL,
    id_evaluacion integer NOT NULL,
    id_pregunta integer NOT NULL,
    valor integer NOT NULL,
    usuario_creacion character varying(100) DEFAULT 'sistema'::character varying NOT NULL,
    usuario_modificacion character varying(100),
    fecha_creacion timestamp without time zone DEFAULT now() NOT NULL,
    fecha_modificacion timestamp without time zone,
    eliminado boolean DEFAULT false NOT NULL,
    CONSTRAINT respuestas_valor_check CHECK (((valor >= 0) AND (valor <= 3)))
);


ALTER TABLE public.respuestas OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 49466)
-- Name: respuestas_id_respuesta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.respuestas_id_respuesta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.respuestas_id_respuesta_seq OWNER TO postgres;

--
-- TOC entry 5169 (class 0 OID 0)
-- Dependencies: 235
-- Name: respuestas_id_respuesta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.respuestas_id_respuesta_seq OWNED BY public.respuestas.id_respuesta;


--
-- TOC entry 220 (class 1259 OID 32963)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id_rol integer NOT NULL,
    nombre_rol character varying(50) NOT NULL,
    usuario_creacion character varying(100) DEFAULT 'sistema'::character varying NOT NULL,
    usuario_modificacion character varying(100),
    fecha_creacion timestamp without time zone DEFAULT now() NOT NULL,
    fecha_modificacion timestamp without time zone,
    eliminado boolean DEFAULT false NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 32962)
-- Name: roles_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_rol_seq OWNER TO postgres;

--
-- TOC entry 5170 (class 0 OID 0)
-- Dependencies: 219
-- Name: roles_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_rol_seq OWNED BY public.roles.id_rol;


--
-- TOC entry 222 (class 1259 OID 32974)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id_usuario integer NOT NULL,
    id_rol integer NOT NULL,
    nombre character varying(100) NOT NULL,
    correo character varying(100) NOT NULL,
    contrasena character varying(255) NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    usuario_creacion character varying(100) DEFAULT 'sistema'::character varying NOT NULL,
    usuario_modificacion character varying(100),
    fecha_creacion timestamp without time zone DEFAULT now() NOT NULL,
    fecha_modificacion timestamp without time zone,
    eliminado boolean DEFAULT false NOT NULL,
    debe_cambiar_contrasena boolean DEFAULT false NOT NULL,
    id_psicologo integer
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 32973)
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 5171 (class 0 OID 0)
-- Dependencies: 221
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_usuario_seq OWNED BY public.usuarios.id_usuario;


--
-- TOC entry 4942 (class 2604 OID 49492)
-- Name: conclusiones id_conclusion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conclusiones ALTER COLUMN id_conclusion SET DEFAULT nextval('public.conclusiones_id_conclusion_seq'::regclass);


--
-- TOC entry 4934 (class 2604 OID 49444)
-- Name: condiciones_regla id_condicion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.condiciones_regla ALTER COLUMN id_condicion SET DEFAULT nextval('public.condiciones_regla_id_condicion_seq'::regclass);


--
-- TOC entry 4916 (class 2604 OID 33023)
-- Name: evaluaciones id_evaluacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluaciones ALTER COLUMN id_evaluacion SET DEFAULT nextval('public.evaluaciones_id_evaluacion_seq'::regclass);


--
-- TOC entry 4921 (class 2604 OID 49387)
-- Name: instrumentos id_instrumento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instrumentos ALTER COLUMN id_instrumento SET DEFAULT nextval('public.instrumentos_id_instrumento_seq'::regclass);


--
-- TOC entry 4911 (class 2604 OID 32997)
-- Name: ninos id_nino; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ninos ALTER COLUMN id_nino SET DEFAULT nextval('public.ninos_id_nino_seq'::regclass);


--
-- TOC entry 4926 (class 2604 OID 49405)
-- Name: preguntas id_pregunta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas ALTER COLUMN id_pregunta SET DEFAULT nextval('public.preguntas_id_pregunta_seq'::regclass);


--
-- TOC entry 4930 (class 2604 OID 49424)
-- Name: reglas id_regla; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reglas ALTER COLUMN id_regla SET DEFAULT nextval('public.reglas_id_regla_seq'::regclass);


--
-- TOC entry 4938 (class 2604 OID 49470)
-- Name: respuestas id_respuesta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas ALTER COLUMN id_respuesta SET DEFAULT nextval('public.respuestas_id_respuesta_seq'::regclass);


--
-- TOC entry 4901 (class 2604 OID 32966)
-- Name: roles id_rol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id_rol SET DEFAULT nextval('public.roles_id_rol_seq'::regclass);


--
-- TOC entry 4905 (class 2604 OID 32977)
-- Name: usuarios id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuarios_id_usuario_seq'::regclass);


--
-- TOC entry 5156 (class 0 OID 49489)
-- Dependencies: 238
-- Data for Name: conclusiones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conclusiones (id_conclusion, id_evaluacion, trastorno, nivel, explicacion, recomendacion, usuario_creacion, usuario_modificacion, fecha_creacion, fecha_modificacion, eliminado) FROM stdin;
1	1	TDAH	ALTO	Hechos calculados: INATENCION.SINTOMAS = 9, INATENCION.PUNTAJE = 27, TOTAL.SINTOMAS = 9, TOTAL.PUNTAJE = 27, HIPERACTIVIDAD.SINTOMAS = 0, HIPERACTIVIDAD.PUNTAJE = 0, IND_INATENCION = 1\nHecho inferido IND_INATENCION por la regla R_INAT: Se observan 6 o más síntomas de inatención (se cumplió: INATENCION.SINTOMAS (9) >= 6)\nConclusión ALTO por la regla R_INATENTO: Indicadores altos de inatención con pocos de hiperactividad (predominio inatento) (se cumplió: IND_INATENCION (1) >= 1 y HIPERACTIVIDAD.SINTOMAS (0) < 6)	Se sugiere derivar a una evaluación clínica completa con la psicóloga. Este resultado es un indicador de riesgo y no constituye un diagnóstico.	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.186129	2026-10-25 22:30:34.186129	f
2	2	TDAH	ALTO	Hechos calculados: INATENCION.SINTOMAS = 9, INATENCION.PUNTAJE = 27, TOTAL.SINTOMAS = 9, TOTAL.PUNTAJE = 27, HIPERACTIVIDAD.SINTOMAS = 0, HIPERACTIVIDAD.PUNTAJE = 0, IND_INATENCION = 1\nHecho inferido IND_INATENCION por la regla R_INAT: Se observan 6 o más síntomas de inatención (se cumplió: INATENCION.SINTOMAS (9) >= 6)\nConclusión ALTO por la regla R_INATENTO: Indicadores altos de inatención con pocos de hiperactividad (predominio inatento) (se cumplió: IND_INATENCION (1) >= 1 y HIPERACTIVIDAD.SINTOMAS (0) < 6)	Se sugiere derivar a una evaluación clínica completa con la psicóloga. Este resultado es un indicador de riesgo y no constituye un diagnóstico.	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.335393	2026-10-25 22:57:38.335393	f
3	3	TDAH	MODERADO	Hechos calculados: INATENCION.SINTOMAS = 5, INATENCION.PUNTAJE = 15, TOTAL.SINTOMAS = 6, TOTAL.PUNTAJE = 20, HIPERACTIVIDAD.SINTOMAS = 1, HIPERACTIVIDAD.PUNTAJE = 5\nConclusión MODERADO por la regla R_MOD_INAT: Se observan entre 4 y 5 síntomas de inatención (se cumplió: INATENCION.SINTOMAS (5) >= 4 y INATENCION.SINTOMAS (5) < 6)	Se sugiere observar y dar seguimiento en distintos contextos, y repetir la evaluación. Valorar con la psicóloga si corresponde profundizar.	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.043693	2026-10-26 19:08:41.043693	f
4	4	TDAH	ALTO	Hechos calculados: INATENCION.SINTOMAS = 7, INATENCION.PUNTAJE = 16, TOTAL.SINTOMAS = 14, TOTAL.PUNTAJE = 33, HIPERACTIVIDAD.SINTOMAS = 7, HIPERACTIVIDAD.PUNTAJE = 17, IND_HIPERACTIVIDAD = 1, IND_INATENCION = 1\nHecho inferido IND_HIPERACTIVIDAD por la regla R_HIPER: Se observan 6 o más síntomas de hiperactividad/impulsividad (se cumplió: HIPERACTIVIDAD.SINTOMAS (7) >= 6)\nHecho inferido IND_INATENCION por la regla R_INAT: Se observan 6 o más síntomas de inatención (se cumplió: INATENCION.SINTOMAS (7) >= 6)\nConclusión ALTO por la regla R_COMBINADO: Indicadores altos de inatención e hiperactividad/impulsividad (presentación combinada) (se cumplió: IND_INATENCION (1) >= 1 y IND_HIPERACTIVIDAD (1) >= 1)	Se sugiere derivar a una evaluación clínica completa con la psicóloga. Este resultado es un indicador de riesgo y no constituye un diagnóstico.	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.054949	2026-11-09 20:07:08.054949	f
5	5	TDAH	ALTO	Hechos calculados: INATENCION.SINTOMAS = 8, INATENCION.PUNTAJE = 21, TOTAL.SINTOMAS = 16, TOTAL.PUNTAJE = 41, HIPERACTIVIDAD.SINTOMAS = 8, HIPERACTIVIDAD.PUNTAJE = 20, IND_HIPERACTIVIDAD = 1, IND_INATENCION = 1\nHecho inferido IND_HIPERACTIVIDAD por la regla R_HIPER: Se observan 6 o más síntomas de hiperactividad/impulsividad (se cumplió: HIPERACTIVIDAD.SINTOMAS (8) >= 6)\nHecho inferido IND_INATENCION por la regla R_INAT: Se observan 6 o más síntomas de inatención (se cumplió: INATENCION.SINTOMAS (8) >= 6)\nConclusión ALTO por la regla R_COMBINADO: Indicadores altos de inatención e hiperactividad/impulsividad (presentación combinada) (se cumplió: IND_INATENCION (1) >= 1 y IND_HIPERACTIVIDAD (1) >= 1)	Se sugiere derivar a una evaluación clínica completa con la psicóloga. Este resultado es un indicador de riesgo y no constituye un diagnóstico.	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.797016	2026-11-09 20:23:44.797016	f
6	6	TDAH	MODERADO	Hechos calculados: INATENCION.SINTOMAS = 3, INATENCION.PUNTAJE = 12, TOTAL.SINTOMAS = 7, TOTAL.PUNTAJE = 26, HIPERACTIVIDAD.SINTOMAS = 4, HIPERACTIVIDAD.PUNTAJE = 14\nConclusión MODERADO por la regla R_MOD_HIPER: Se observan entre 4 y 5 síntomas de hiperactividad/impulsividad (se cumplió: HIPERACTIVIDAD.SINTOMAS (4) >= 4 y HIPERACTIVIDAD.SINTOMAS (4) < 6)	Se sugiere observar y dar seguimiento en distintos contextos, y repetir la evaluación. Valorar con la psicóloga si corresponde profundizar.	psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.249292	2026-11-10 20:42:34.249292	f
7	7	TDAH	MODERADO	Hechos calculados: INATENCION.SINTOMAS = 5, INATENCION.PUNTAJE = 15, TOTAL.SINTOMAS = 10, TOTAL.PUNTAJE = 29, HIPERACTIVIDAD.SINTOMAS = 5, HIPERACTIVIDAD.PUNTAJE = 14\nConclusión MODERADO por la regla R_MOD_HIPER: Se observan entre 4 y 5 síntomas de hiperactividad/impulsividad (se cumplió: HIPERACTIVIDAD.SINTOMAS (5) >= 4 y HIPERACTIVIDAD.SINTOMAS (5) < 6)\nConclusión MODERADO por la regla R_MOD_INAT: Se observan entre 4 y 5 síntomas de inatención (se cumplió: INATENCION.SINTOMAS (5) >= 4 y INATENCION.SINTOMAS (5) < 6)	Se sugiere observar y dar seguimiento en distintos contextos, y repetir la evaluación. Valorar con la psicóloga si corresponde profundizar.	psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.453901	2026-11-15 13:28:47.453901	f
\.


--
-- TOC entry 5152 (class 0 OID 49441)
-- Dependencies: 234
-- Data for Name: condiciones_regla; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.condiciones_regla (id_condicion, id_regla, hecho, operador, valor, usuario_creacion, usuario_modificacion, fecha_creacion, fecha_modificacion, eliminado) FROM stdin;
1	1	HIPERACTIVIDAD.SINTOMAS	>=	4	sistema	\N	2026-10-25 21:49:44.931102	\N	f
2	1	HIPERACTIVIDAD.SINTOMAS	<	6	sistema	\N	2026-10-25 21:49:44.931102	\N	f
3	2	INATENCION.SINTOMAS	>=	4	sistema	\N	2026-10-25 21:49:44.931102	\N	f
4	2	INATENCION.SINTOMAS	<	6	sistema	\N	2026-10-25 21:49:44.931102	\N	f
5	3	IND_HIPERACTIVIDAD	>=	1	sistema	\N	2026-10-25 21:49:44.931102	\N	f
6	3	INATENCION.SINTOMAS	<	6	sistema	\N	2026-10-25 21:49:44.931102	\N	f
7	4	IND_INATENCION	>=	1	sistema	\N	2026-10-25 21:49:44.931102	\N	f
8	4	HIPERACTIVIDAD.SINTOMAS	<	6	sistema	\N	2026-10-25 21:49:44.931102	\N	f
9	5	IND_INATENCION	>=	1	sistema	\N	2026-10-25 21:49:44.931102	\N	f
10	5	IND_HIPERACTIVIDAD	>=	1	sistema	\N	2026-10-25 21:49:44.931102	\N	f
11	6	HIPERACTIVIDAD.SINTOMAS	>=	6	sistema	\N	2026-10-25 21:49:44.931102	\N	f
12	7	INATENCION.SINTOMAS	>=	6	sistema	\N	2026-10-25 21:49:44.931102	\N	f
13	8	SOCIAL.SINTOMAS	>=	2	sistema	\N	2026-10-25 21:49:44.931102	\N	f
14	8	REPETITIVO.SINTOMAS	>=	1	sistema	\N	2026-10-25 21:49:44.931102	\N	f
15	9	SOCIAL.SINTOMAS	>=	3	sistema	\N	2026-10-25 21:49:44.931102	\N	f
16	9	REPETITIVO.SINTOMAS	>=	2	sistema	\N	2026-10-25 21:49:44.931102	\N	f
17	10	IND_MATEMATICAS	>=	1	sistema	\N	2026-10-25 21:49:44.931102	\N	f
18	11	IND_ESCRITURA	>=	1	sistema	\N	2026-10-25 21:49:44.931102	\N	f
19	12	IND_LECTURA	>=	1	sistema	\N	2026-10-25 21:49:44.931102	\N	f
20	13	TOTAL.SINTOMAS	>=	6	sistema	\N	2026-10-25 21:49:44.931102	\N	f
21	14	MATEMATICAS.SINTOMAS	>=	2	sistema	\N	2026-10-25 21:49:44.931102	\N	f
22	15	ESCRITURA.SINTOMAS	>=	2	sistema	\N	2026-10-25 21:49:44.931102	\N	f
23	16	LECTURA.SINTOMAS	>=	2	sistema	\N	2026-10-25 21:49:44.931102	\N	f
\.


--
-- TOC entry 5144 (class 0 OID 33020)
-- Dependencies: 226
-- Data for Name: evaluaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evaluaciones (id_evaluacion, id_nino, id_psicologo, fecha_evaluacion, observaciones, usuario_creacion, usuario_modificacion, fecha_creacion, fecha_modificacion, eliminado, id_instrumento) FROM stdin;
1	1	2	2026-10-25	Prueba	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.162349	2026-10-25 22:30:34.162349	f	1
2	3	2	2026-10-25		psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.307412	2026-10-25 22:57:38.307412	f	1
3	4	2	2026-10-26	tiembla mucho 	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.024682	2026-10-26 19:08:41.024682	f	1
4	6	2	2026-11-09		psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.035438	2026-11-09 20:07:08.035438	f	1
5	7	2	2026-11-09	tiende a pegar a los niños 	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.793728	2026-11-09 20:23:44.793728	f	1
6	5	2	2026-11-10		psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.232799	2026-11-10 20:42:34.232799	f	1
7	5	2	2026-11-15		psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.392768	2026-11-15 13:28:47.392768	f	1
\.


--
-- TOC entry 5146 (class 0 OID 49384)
-- Dependencies: 228
-- Data for Name: instrumentos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instrumentos (id_instrumento, codigo, nombre, descripcion, trastorno, quien_responde, estado_validacion, usuario_creacion, usuario_modificacion, fecha_creacion, fecha_modificacion, eliminado) FROM stdin;
1	TDAH_BORRADOR	Indicadores de TDAH (borrador)	Borrador de ejemplo. Preguntas y umbrales pendientes de validación clínica. No constituye un diagnóstico.	TDAH	Tutor	BORRADOR	sistema	\N	2026-10-25 21:49:44.884203	\N	f
2	TEA_BORRADOR	Indicadores de TEA (borrador)	Borrador de ejemplo. Preguntas y umbrales pendientes de validación clínica. No constituye un diagnóstico.	TEA	Tutor	BORRADOR	sistema	\N	2026-10-25 21:49:44.884203	\N	f
3	APRENDIZAJE_BORRADOR	Indicadores de dificultades del aprendizaje (borrador)	Borrador de ejemplo. Preguntas y umbrales pendientes de validación clínica. No constituye un diagnóstico.	APRENDIZAJE	Docente	BORRADOR	sistema	\N	2026-10-25 21:49:44.884203	\N	f
\.


--
-- TOC entry 5142 (class 0 OID 32994)
-- Dependencies: 224
-- Data for Name: ninos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ninos (id_nino, id_tutor, nombre, fecha_nacimiento, motivo_consulta, activo, id_psicologo, usuario_creacion, usuario_modificacion, fecha_creacion, fecha_modificacion, eliminado, genero, fortalezas, dificultades) FROM stdin;
1	3	Juan Perez	2018-05-14	Dificultad para concentrarse en clase	t	2	psicologa@sistema.com	psicologa@sistema.com	2026-10-24 19:00:57.097484	2026-10-24 21:12:19.82737	f	\N	\N	\N
3	\N	hans choque 	2019-05-16	tiene discapacidad visual y en el entendimiento 	t	2	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 18:41:20.853086	2026-10-25 18:41:20.853086	f	\N	\N	\N
2	3	Juana chavez 	2020-06-22	tiene retraso	t	2	psicologa@sistema.com	psicologa@sistema.com	2026-10-24 21:13:22.367346	2026-10-26 13:53:09.339407	f	NINA	es muy comprensible	con la comunicacion
4	3	jugenn 	2018-04-11	creo que tiene dawnn	t	2	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:02:09.673544	2026-10-26 19:02:09.673544	f	NINO	es bueno en juegos 	tedencias suicidas
5	4	Angela Choque	2019-06-09		t	2	susana@gmail.com	psicologa@sistema.com	2026-11-09 17:57:21.604707	2026-11-09 17:58:17.086443	f	NINA		
6	6	Samuel	2019-06-11	quiero que se haga una revisión 	t	2	Ale@gmail.com	Ale@gmail.com	2026-11-09 20:03:51.087626	2026-11-09 20:03:51.087626	f	NINO	\N	\N
7	7	Laura	2026-11-09	quiero que la revisen 	t	2	gabo@gmail.com	gabo@gmail.com	2026-11-09 20:18:43.011255	2026-11-09 20:18:43.011255	f	NINA	\N	\N
8	8	Carlitos	2017-05-11	hgjgjhg	t	2	luis@gmail.com	luis@gmail.com	2026-11-10 20:33:35.312253	2026-11-10 20:33:35.312253	f	NINO	\N	\N
\.


--
-- TOC entry 5148 (class 0 OID 49402)
-- Dependencies: 230
-- Data for Name: preguntas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preguntas (id_pregunta, id_instrumento, orden, texto, subescala, usuario_creacion, usuario_modificacion, fecha_creacion, fecha_modificacion, eliminado) FROM stdin;
1	1	1	Comete errores por descuido en las tareas o no presta atención a los detalles.	INATENCION	sistema	\N	2026-10-25 21:49:44.904786	\N	f
2	1	2	Le cuesta mantener la atención en tareas o juegos.	INATENCION	sistema	\N	2026-10-25 21:49:44.904786	\N	f
3	1	3	Parece no escuchar cuando se le habla directamente.	INATENCION	sistema	\N	2026-10-25 21:49:44.904786	\N	f
4	1	4	No sigue las instrucciones hasta el final y no termina tareas o encargos.	INATENCION	sistema	\N	2026-10-25 21:49:44.904786	\N	f
5	1	5	Le cuesta organizar sus tareas y actividades.	INATENCION	sistema	\N	2026-10-25 21:49:44.904786	\N	f
6	1	6	Evita o se resiste a tareas que exigen esfuerzo mental sostenido.	INATENCION	sistema	\N	2026-10-25 21:49:44.904786	\N	f
7	1	7	Pierde con frecuencia objetos necesarios (útiles, cuadernos, juguetes).	INATENCION	sistema	\N	2026-10-25 21:49:44.904786	\N	f
8	1	8	Se distrae fácilmente con estímulos de su entorno.	INATENCION	sistema	\N	2026-10-25 21:49:44.904786	\N	f
9	1	9	Es olvidadizo en las actividades diarias.	INATENCION	sistema	\N	2026-10-25 21:49:44.904786	\N	f
10	1	10	Mueve las manos o los pies, o se retuerce en el asiento.	HIPERACTIVIDAD	sistema	\N	2026-10-25 21:49:44.904786	\N	f
11	1	11	Se levanta de su asiento cuando debería permanecer sentado.	HIPERACTIVIDAD	sistema	\N	2026-10-25 21:49:44.904786	\N	f
12	1	12	Corre o trepa en situaciones en las que no es apropiado.	HIPERACTIVIDAD	sistema	\N	2026-10-25 21:49:44.904786	\N	f
13	1	13	Le cuesta jugar o realizar actividades de forma tranquila.	HIPERACTIVIDAD	sistema	\N	2026-10-25 21:49:44.904786	\N	f
14	1	14	Está siempre en marcha, como si tuviera un motor.	HIPERACTIVIDAD	sistema	\N	2026-10-25 21:49:44.904786	\N	f
15	1	15	Habla en exceso.	HIPERACTIVIDAD	sistema	\N	2026-10-25 21:49:44.904786	\N	f
16	1	16	Responde antes de que se termine de formular la pregunta.	HIPERACTIVIDAD	sistema	\N	2026-10-25 21:49:44.904786	\N	f
17	1	17	Le cuesta esperar su turno.	HIPERACTIVIDAD	sistema	\N	2026-10-25 21:49:44.904786	\N	f
18	1	18	Interrumpe o se mete en las conversaciones o juegos de otros.	HIPERACTIVIDAD	sistema	\N	2026-10-25 21:49:44.904786	\N	f
19	2	1	Tiene dificultad para mantener una conversación de ida y vuelta.	SOCIAL	sistema	\N	2026-10-25 21:49:44.904786	\N	f
20	2	2	Evita el contacto visual o lo usa de forma poco habitual al comunicarse.	SOCIAL	sistema	\N	2026-10-25 21:49:44.904786	\N	f
21	2	3	Le cuesta entender o compartir las emociones de otras personas.	SOCIAL	sistema	\N	2026-10-25 21:49:44.904786	\N	f
22	2	4	Tiene dificultad para hacer amigos o mantener relaciones con niños de su edad.	SOCIAL	sistema	\N	2026-10-25 21:49:44.904786	\N	f
23	2	5	Repite movimientos, palabras o frases de forma estereotipada.	REPETITIVO	sistema	\N	2026-10-25 21:49:44.904786	\N	f
24	2	6	Insiste en las rutinas y se angustia mucho ante pequeños cambios.	REPETITIVO	sistema	\N	2026-10-25 21:49:44.904786	\N	f
25	2	7	Tiene intereses muy restringidos o intensos en temas u objetos particulares.	REPETITIVO	sistema	\N	2026-10-25 21:49:44.904786	\N	f
26	2	8	Reacciona de forma muy intensa o muy escasa a sonidos, texturas, luces u olores.	REPETITIVO	sistema	\N	2026-10-25 21:49:44.904786	\N	f
27	3	1	Lee con mucha lentitud o de forma entrecortada para su edad.	LECTURA	sistema	\N	2026-10-25 21:49:44.904786	\N	f
28	3	2	Confunde o invierte letras, sílabas o palabras al leer.	LECTURA	sistema	\N	2026-10-25 21:49:44.904786	\N	f
29	3	3	Comprende poco lo que lee, aunque lo lea en voz alta.	LECTURA	sistema	\N	2026-10-25 21:49:44.904786	\N	f
30	3	4	Comete muchos errores de ortografía o de omisión de letras para su edad.	ESCRITURA	sistema	\N	2026-10-25 21:49:44.904786	\N	f
31	3	5	Su letra es difícil de entender o escribe con mucho esfuerzo.	ESCRITURA	sistema	\N	2026-10-25 21:49:44.904786	\N	f
32	3	6	Le cuesta expresar sus ideas por escrito de forma organizada.	ESCRITURA	sistema	\N	2026-10-25 21:49:44.904786	\N	f
33	3	7	Le cuesta entender el concepto de número y las cantidades.	MATEMATICAS	sistema	\N	2026-10-25 21:49:44.904786	\N	f
34	3	8	Tiene dificultad para memorizar operaciones básicas (sumas, restas, tablas).	MATEMATICAS	sistema	\N	2026-10-25 21:49:44.904786	\N	f
35	3	9	Se equivoca al resolver problemas matemáticos sencillos para su edad.	MATEMATICAS	sistema	\N	2026-10-25 21:49:44.904786	\N	f
\.


--
-- TOC entry 5150 (class 0 OID 49421)
-- Dependencies: 232
-- Data for Name: reglas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reglas (id_regla, id_instrumento, codigo, descripcion, nivel, hecho_derivado, recomendacion, usuario_creacion, usuario_modificacion, fecha_creacion, fecha_modificacion, eliminado) FROM stdin;
1	1	R_MOD_HIPER	Se observan entre 4 y 5 síntomas de hiperactividad/impulsividad	MODERADO	\N	Se sugiere observar y dar seguimiento en distintos contextos, y repetir la evaluación. Valorar con la psicóloga si corresponde profundizar.	sistema	\N	2026-10-25 21:49:44.916893	\N	f
2	1	R_MOD_INAT	Se observan entre 4 y 5 síntomas de inatención	MODERADO	\N	Se sugiere observar y dar seguimiento en distintos contextos, y repetir la evaluación. Valorar con la psicóloga si corresponde profundizar.	sistema	\N	2026-10-25 21:49:44.916893	\N	f
3	1	R_HIPERACTIVO	Indicadores altos de hiperactividad/impulsividad con pocos de inatención (predominio hiperactivo)	ALTO	\N	Se sugiere derivar a una evaluación clínica completa con la psicóloga. Este resultado es un indicador de riesgo y no constituye un diagnóstico.	sistema	\N	2026-10-25 21:49:44.916893	\N	f
4	1	R_INATENTO	Indicadores altos de inatención con pocos de hiperactividad (predominio inatento)	ALTO	\N	Se sugiere derivar a una evaluación clínica completa con la psicóloga. Este resultado es un indicador de riesgo y no constituye un diagnóstico.	sistema	\N	2026-10-25 21:49:44.916893	\N	f
5	1	R_COMBINADO	Indicadores altos de inatención e hiperactividad/impulsividad (presentación combinada)	ALTO	\N	Se sugiere derivar a una evaluación clínica completa con la psicóloga. Este resultado es un indicador de riesgo y no constituye un diagnóstico.	sistema	\N	2026-10-25 21:49:44.916893	\N	f
6	1	R_HIPER	Se observan 6 o más síntomas de hiperactividad/impulsividad	\N	IND_HIPERACTIVIDAD	\N	sistema	\N	2026-10-25 21:49:44.916893	\N	f
7	1	R_INAT	Se observan 6 o más síntomas de inatención	\N	IND_INATENCION	\N	sistema	\N	2026-10-25 21:49:44.916893	\N	f
8	2	R_MODERADO	Indicadores presentes en comunicación social y en conductas repetitivas	MODERADO	\N	Se sugiere observar y dar seguimiento en distintos contextos, y repetir la evaluación. Valorar con la psicóloga si corresponde profundizar.	sistema	\N	2026-10-25 21:49:44.916893	\N	f
9	2	R_ALTO	Indicadores marcados en comunicación social y en conductas repetitivas	ALTO	\N	Se sugiere derivar a una evaluación clínica completa con la psicóloga. Este resultado es un indicador de riesgo y no constituye un diagnóstico.	sistema	\N	2026-10-25 21:49:44.916893	\N	f
10	3	R_MOD_MATEMATICAS	Indicadores de dificultad en el área de matemáticas	MODERADO	\N	Se sugiere reforzar y observar el área de matemáticas, y repetir la evaluación. Valorar con la psicóloga si corresponde profundizar.	sistema	\N	2026-10-25 21:49:44.916893	\N	f
11	3	R_MOD_ESCRITURA	Indicadores de dificultad en el área de escritura	MODERADO	\N	Se sugiere reforzar y observar el área de escritura, y repetir la evaluación. Valorar con la psicóloga si corresponde profundizar.	sistema	\N	2026-10-25 21:49:44.916893	\N	f
12	3	R_MOD_LECTURA	Indicadores de dificultad en el área de lectura	MODERADO	\N	Se sugiere reforzar y observar el área de lectura, y repetir la evaluación. Valorar con la psicóloga si corresponde profundizar.	sistema	\N	2026-10-25 21:49:44.916893	\N	f
13	3	R_ALTO	Dificultades numerosas en varias áreas del aprendizaje	ALTO	\N	Se sugiere derivar a una evaluación psicopedagógica completa. Este resultado es un indicador de riesgo y no constituye un diagnóstico.	sistema	\N	2026-10-25 21:49:44.916893	\N	f
14	3	R_IND_MATEMATICAS	Se observan 2 o más dificultades en matemáticas	\N	IND_MATEMATICAS	\N	sistema	\N	2026-10-25 21:49:44.916893	\N	f
15	3	R_IND_ESCRITURA	Se observan 2 o más dificultades en escritura	\N	IND_ESCRITURA	\N	sistema	\N	2026-10-25 21:49:44.916893	\N	f
16	3	R_IND_LECTURA	Se observan 2 o más dificultades en lectura	\N	IND_LECTURA	\N	sistema	\N	2026-10-25 21:49:44.916893	\N	f
\.


--
-- TOC entry 5154 (class 0 OID 49467)
-- Dependencies: 236
-- Data for Name: respuestas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.respuestas (id_respuesta, id_evaluacion, id_pregunta, valor, usuario_creacion, usuario_modificacion, fecha_creacion, fecha_modificacion, eliminado) FROM stdin;
1	1	1	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.192381	2026-10-25 22:30:34.192381	f
2	1	2	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.196556	2026-10-25 22:30:34.196556	f
3	1	3	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.197559	2026-10-25 22:30:34.197559	f
4	1	4	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.197559	2026-10-25 22:30:34.197559	f
5	1	5	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.198554	2026-10-25 22:30:34.198554	f
6	1	6	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.200753	2026-10-25 22:30:34.200753	f
7	1	7	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.200753	2026-10-25 22:30:34.200753	f
8	1	8	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.201754	2026-10-25 22:30:34.201754	f
9	1	9	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.202751	2026-10-25 22:30:34.202751	f
10	1	10	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.202751	2026-10-25 22:30:34.202751	f
11	1	11	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.203763	2026-10-25 22:30:34.203763	f
12	1	12	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.204769	2026-10-25 22:30:34.204769	f
13	1	13	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.20577	2026-10-25 22:30:34.20577	f
14	1	14	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.20577	2026-10-25 22:30:34.20577	f
15	1	15	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.206769	2026-10-25 22:30:34.206769	f
16	1	16	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.207772	2026-10-25 22:30:34.207772	f
17	1	17	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.208773	2026-10-25 22:30:34.208773	f
18	1	18	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:30:34.208773	2026-10-25 22:30:34.208773	f
19	2	1	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.335393	2026-10-25 22:57:38.335393	f
20	2	2	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.350421	2026-10-25 22:57:38.350421	f
21	2	3	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.353771	2026-10-25 22:57:38.353771	f
22	2	4	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.353771	2026-10-25 22:57:38.353771	f
23	2	5	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.353771	2026-10-25 22:57:38.353771	f
24	2	6	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.353771	2026-10-25 22:57:38.353771	f
25	2	7	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.359407	2026-10-25 22:57:38.359407	f
26	2	8	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.359407	2026-10-25 22:57:38.359407	f
27	2	9	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.359407	2026-10-25 22:57:38.359407	f
28	2	10	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.359407	2026-10-25 22:57:38.359407	f
29	2	11	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.363904	2026-10-25 22:57:38.363904	f
30	2	12	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.365865	2026-10-25 22:57:38.365865	f
31	2	13	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.365865	2026-10-25 22:57:38.365865	f
32	2	14	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.365865	2026-10-25 22:57:38.365865	f
33	2	15	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.370747	2026-10-25 22:57:38.370747	f
34	2	16	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.370747	2026-10-25 22:57:38.370747	f
35	2	17	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.370747	2026-10-25 22:57:38.370747	f
36	2	18	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-25 22:57:38.370747	2026-10-25 22:57:38.370747	f
37	3	1	1	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.061705	2026-10-26 19:08:41.061705	f
38	3	2	1	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.072514	2026-10-26 19:08:41.072514	f
39	3	3	2	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.074266	2026-10-26 19:08:41.074266	f
40	3	4	2	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.081791	2026-10-26 19:08:41.081791	f
41	3	5	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.083765	2026-10-26 19:08:41.083765	f
42	3	6	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.083765	2026-10-26 19:08:41.083765	f
43	3	7	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.083765	2026-10-26 19:08:41.083765	f
44	3	8	2	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.083765	2026-10-26 19:08:41.083765	f
45	3	9	1	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.083765	2026-10-26 19:08:41.083765	f
46	3	10	3	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.083765	2026-10-26 19:08:41.083765	f
47	3	11	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.098004	2026-10-26 19:08:41.098004	f
48	3	12	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.09903	2026-10-26 19:08:41.09903	f
49	3	13	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.09903	2026-10-26 19:08:41.09903	f
50	3	14	1	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.09903	2026-10-26 19:08:41.09903	f
51	3	15	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.09903	2026-10-26 19:08:41.09903	f
52	3	16	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.09903	2026-10-26 19:08:41.09903	f
53	3	17	0	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.09903	2026-10-26 19:08:41.09903	f
54	3	18	1	psicologa@sistema.com	psicologa@sistema.com	2026-10-26 19:08:41.109469	2026-10-26 19:08:41.109469	f
55	4	1	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.074529	2026-11-09 20:07:08.074529	f
56	4	2	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.089882	2026-11-09 20:07:08.089882	f
57	4	3	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.089882	2026-11-09 20:07:08.089882	f
58	4	4	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.089882	2026-11-09 20:07:08.089882	f
59	4	5	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.089882	2026-11-09 20:07:08.089882	f
60	4	6	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.099449	2026-11-09 20:07:08.099449	f
61	4	7	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.103164	2026-11-09 20:07:08.103164	f
62	4	8	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.105359	2026-11-09 20:07:08.105359	f
63	4	9	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.106138	2026-11-09 20:07:08.106138	f
64	4	10	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.106138	2026-11-09 20:07:08.106138	f
65	4	11	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.106138	2026-11-09 20:07:08.106138	f
66	4	12	3	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.111331	2026-11-09 20:07:08.111331	f
67	4	13	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.111331	2026-11-09 20:07:08.111331	f
68	4	14	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.115217	2026-11-09 20:07:08.115217	f
69	4	15	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.11805	2026-11-09 20:07:08.11805	f
70	4	16	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.121232	2026-11-09 20:07:08.121232	f
71	4	17	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.121232	2026-11-09 20:07:08.121232	f
72	4	18	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:07:08.121232	2026-11-09 20:07:08.121232	f
73	5	1	3	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.799208	2026-11-09 20:23:44.799208	f
74	5	2	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.802203	2026-11-09 20:23:44.802203	f
75	5	3	3	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.805214	2026-11-09 20:23:44.805214	f
76	5	4	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.808213	2026-11-09 20:23:44.808213	f
77	5	5	3	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.810681	2026-11-09 20:23:44.810681	f
78	5	6	0	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.817407	2026-11-09 20:23:44.817407	f
79	5	7	3	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.823241	2026-11-09 20:23:44.823241	f
80	5	8	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.82535	2026-11-09 20:23:44.82535	f
81	5	9	3	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.82636	2026-11-09 20:23:44.82636	f
82	5	10	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.82736	2026-11-09 20:23:44.82736	f
83	5	11	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.828359	2026-11-09 20:23:44.828359	f
84	5	12	3	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.829359	2026-11-09 20:23:44.829359	f
85	5	13	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.83036	2026-11-09 20:23:44.83036	f
86	5	14	3	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.834597	2026-11-09 20:23:44.834597	f
87	5	15	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.836602	2026-11-09 20:23:44.836602	f
88	5	16	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.838596	2026-11-09 20:23:44.838596	f
89	5	17	3	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.839594	2026-11-09 20:23:44.839594	f
90	5	18	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-09 20:23:44.840595	2026-11-09 20:23:44.840595	f
91	6	1	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.262298	2026-11-10 20:42:34.262298	f
92	6	2	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.26874	2026-11-10 20:42:34.26874	f
93	6	3	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.270895	2026-11-10 20:42:34.270895	f
94	6	4	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.272907	2026-11-10 20:42:34.272907	f
95	6	5	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.273912	2026-11-10 20:42:34.273912	f
96	6	6	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.28016	2026-11-10 20:42:34.28016	f
97	6	7	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.283154	2026-11-10 20:42:34.283154	f
98	6	8	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.284149	2026-11-10 20:42:34.284149	f
99	6	9	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.286157	2026-11-10 20:42:34.286157	f
100	6	10	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.28715	2026-11-10 20:42:34.28715	f
101	6	11	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.28815	2026-11-10 20:42:34.28815	f
102	6	12	3	psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.290151	2026-11-10 20:42:34.290151	f
103	6	13	0	psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.293158	2026-11-10 20:42:34.293158	f
104	6	14	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.298155	2026-11-10 20:42:34.298155	f
105	6	15	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.300154	2026-11-10 20:42:34.300154	f
106	6	16	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.302155	2026-11-10 20:42:34.302155	f
107	6	17	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.303155	2026-11-10 20:42:34.303155	f
108	6	18	3	psicologa@sistema.com	psicologa@sistema.com	2026-11-10 20:42:34.305151	2026-11-10 20:42:34.305151	f
109	7	1	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.460595	2026-11-15 13:28:47.460595	f
110	7	2	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.48146	2026-11-15 13:28:47.48146	f
111	7	3	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.48146	2026-11-15 13:28:47.48146	f
112	7	4	3	psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.48146	2026-11-15 13:28:47.48146	f
113	7	5	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.48146	2026-11-15 13:28:47.48146	f
114	7	6	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.48146	2026-11-15 13:28:47.48146	f
115	7	7	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.48146	2026-11-15 13:28:47.48146	f
116	7	8	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.49191	2026-11-15 13:28:47.49191	f
117	7	9	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.494358	2026-11-15 13:28:47.494358	f
118	7	10	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.494358	2026-11-15 13:28:47.494358	f
119	7	11	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.494358	2026-11-15 13:28:47.494358	f
120	7	12	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.494358	2026-11-15 13:28:47.494358	f
121	7	13	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.494358	2026-11-15 13:28:47.494358	f
122	7	14	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.494358	2026-11-15 13:28:47.494358	f
123	7	15	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.494358	2026-11-15 13:28:47.494358	f
124	7	16	1	psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.494358	2026-11-15 13:28:47.494358	f
125	7	17	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.504344	2026-11-15 13:28:47.504344	f
126	7	18	2	psicologa@sistema.com	psicologa@sistema.com	2026-11-15 13:28:47.504344	2026-11-15 13:28:47.504344	f
\.


--
-- TOC entry 5138 (class 0 OID 32963)
-- Dependencies: 220
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id_rol, nombre_rol, usuario_creacion, usuario_modificacion, fecha_creacion, fecha_modificacion, eliminado) FROM stdin;
1	Admin	sistema	\N	2026-10-11 21:05:33.423872	\N	f
3	Tutor	sistema	\N	2026-10-11 21:05:33.423872	\N	f
2	Psicologo	sistema	\N	2026-10-11 21:05:33.423872	\N	f
\.


--
-- TOC entry 5140 (class 0 OID 32974)
-- Dependencies: 222
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id_usuario, id_rol, nombre, correo, contrasena, activo, usuario_creacion, usuario_modificacion, fecha_creacion, fecha_modificacion, eliminado, debe_cambiar_contrasena, id_psicologo) FROM stdin;
1	1	Administrador	admin@sistema.com	$2a$10$iDPXFWIbRvghYKr4RyK3uuUGEtjQSBd5IacBcd3WV41NgdgkgBmRm	t	sistema	sistema	2026-10-11 21:53:56.118903	2026-10-11 21:53:56.118903	f	f	\N
2	2	Psicologa Prueba	psicologa@sistema.com	$2a$10$DNfx7XxWQyMsNAo2w6lqw.1O1/q5RYxbBOU2.IPPE6x.VE0durwzG	t	admin@sistema.com	admin@sistema.com	2026-10-11 22:02:03.280086	2026-10-11 22:02:03.280086	f	f	\N
3	3	Tutor Prueba	tutor@sistema.com	$2a$10$re5ad6KkSz2PgipYLTwVPeARKxpuhtNQGuksxS2nByH1qPtTAvJHS	t	admin@sistema.com	admin@sistema.com	2026-10-24 18:59:30.322825	2026-10-24 18:59:30.322825	f	f	2
4	3	susana	susana@gmail.com	$2a$10$vjtsy.DdJYRZ.TUhyByBgO5QARmg8CgwiKm1oZCpTcIrtIJz4UWly	t	psicologa@sistema.com	susana@gmail.com	2026-11-09 17:54:16.480751	2026-11-09 17:56:16.825149	f	f	2
5	2	Luz Camila	Luz@gmail.com	$2a$10$DF3cfLpHbnPMWnGTwc5nGO/.UzcqOaHF15oF1VlyyZHki8zlBEiDu	t	admin@sistema.com	admin@sistema.com	2026-11-09 19:51:01.731868	2026-11-09 19:51:01.731868	f	t	\N
6	3	Alejandro	Ale@gmail.com	$2a$10$454GvsmlDxsW5ZQ8SxJty.DQUKvDTeLdj1vnV9ITkPWL8Bz.gNMFy	t	psicologa@sistema.com	Ale@gmail.com	2026-11-09 20:00:33.78487	2026-11-09 20:02:32.88581	f	f	2
7	3	Gabriel	gabo@gmail.com	$2a$10$XZCMgAzJzPjIQC1KNKZsBu0NZbJkKH7uC3udYaEAAKZ.zgjDWBKRe	t	psicologa@sistema.com	gabo@gmail.com	2026-11-09 20:16:27.56278	2026-11-09 20:17:44.553077	f	f	2
8	3	luis adolfo alvarez guerra	luis@gmail.com	$2a$10$hExwr.wZfUgU6ok5WDgGsuGF3WzfFCGgbf.SULz88kmKUaIukMzXu	t	psicologa@sistema.com	luis@gmail.com	2026-11-10 20:29:54.139582	2026-11-10 20:31:31.540133	f	f	2
\.


--
-- TOC entry 5172 (class 0 OID 0)
-- Dependencies: 237
-- Name: conclusiones_id_conclusion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conclusiones_id_conclusion_seq', 7, true);


--
-- TOC entry 5173 (class 0 OID 0)
-- Dependencies: 233
-- Name: condiciones_regla_id_condicion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.condiciones_regla_id_condicion_seq', 23, true);


--
-- TOC entry 5174 (class 0 OID 0)
-- Dependencies: 225
-- Name: evaluaciones_id_evaluacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.evaluaciones_id_evaluacion_seq', 7, true);


--
-- TOC entry 5175 (class 0 OID 0)
-- Dependencies: 227
-- Name: instrumentos_id_instrumento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instrumentos_id_instrumento_seq', 3, true);


--
-- TOC entry 5176 (class 0 OID 0)
-- Dependencies: 223
-- Name: ninos_id_nino_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ninos_id_nino_seq', 8, true);


--
-- TOC entry 5177 (class 0 OID 0)
-- Dependencies: 229
-- Name: preguntas_id_pregunta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.preguntas_id_pregunta_seq', 35, true);


--
-- TOC entry 5178 (class 0 OID 0)
-- Dependencies: 231
-- Name: reglas_id_regla_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reglas_id_regla_seq', 16, true);


--
-- TOC entry 5179 (class 0 OID 0)
-- Dependencies: 235
-- Name: respuestas_id_respuesta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.respuestas_id_respuesta_seq', 126, true);


--
-- TOC entry 5180 (class 0 OID 0)
-- Dependencies: 219
-- Name: roles_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_rol_seq', 6, true);


--
-- TOC entry 5181 (class 0 OID 0)
-- Dependencies: 221
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_usuario_seq', 8, true);


--
-- TOC entry 4976 (class 2606 OID 49500)
-- Name: conclusiones conclusiones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conclusiones
    ADD CONSTRAINT conclusiones_pkey PRIMARY KEY (id_conclusion);


--
-- TOC entry 4972 (class 2606 OID 49454)
-- Name: condiciones_regla condiciones_regla_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.condiciones_regla
    ADD CONSTRAINT condiciones_regla_pkey PRIMARY KEY (id_condicion);


--
-- TOC entry 4960 (class 2606 OID 33031)
-- Name: evaluaciones evaluaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluaciones
    ADD CONSTRAINT evaluaciones_pkey PRIMARY KEY (id_evaluacion);


--
-- TOC entry 4962 (class 2606 OID 49400)
-- Name: instrumentos instrumentos_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instrumentos
    ADD CONSTRAINT instrumentos_codigo_key UNIQUE (codigo);


--
-- TOC entry 4964 (class 2606 OID 49398)
-- Name: instrumentos instrumentos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instrumentos
    ADD CONSTRAINT instrumentos_pkey PRIMARY KEY (id_instrumento);


--
-- TOC entry 4958 (class 2606 OID 33002)
-- Name: ninos ninos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ninos
    ADD CONSTRAINT ninos_pkey PRIMARY KEY (id_nino);


--
-- TOC entry 4966 (class 2606 OID 49414)
-- Name: preguntas preguntas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas
    ADD CONSTRAINT preguntas_pkey PRIMARY KEY (id_pregunta);


--
-- TOC entry 4968 (class 2606 OID 49434)
-- Name: reglas reglas_id_instrumento_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reglas
    ADD CONSTRAINT reglas_id_instrumento_codigo_key UNIQUE (id_instrumento, codigo);


--
-- TOC entry 4970 (class 2606 OID 49432)
-- Name: reglas reglas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reglas
    ADD CONSTRAINT reglas_pkey PRIMARY KEY (id_regla);


--
-- TOC entry 4974 (class 2606 OID 49477)
-- Name: respuestas respuestas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_pkey PRIMARY KEY (id_respuesta);


--
-- TOC entry 4950 (class 2606 OID 32972)
-- Name: roles roles_nombre_rol_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_nombre_rol_key UNIQUE (nombre_rol);


--
-- TOC entry 4952 (class 2606 OID 32970)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id_rol);


--
-- TOC entry 4954 (class 2606 OID 32987)
-- Name: usuarios usuarios_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_correo_key UNIQUE (correo);


--
-- TOC entry 4956 (class 2606 OID 32985)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4989 (class 2606 OID 49501)
-- Name: conclusiones conclusiones_id_evaluacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conclusiones
    ADD CONSTRAINT conclusiones_id_evaluacion_fkey FOREIGN KEY (id_evaluacion) REFERENCES public.evaluaciones(id_evaluacion);


--
-- TOC entry 4986 (class 2606 OID 49455)
-- Name: condiciones_regla condiciones_regla_id_regla_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.condiciones_regla
    ADD CONSTRAINT condiciones_regla_id_regla_fkey FOREIGN KEY (id_regla) REFERENCES public.reglas(id_regla);


--
-- TOC entry 4981 (class 2606 OID 49461)
-- Name: evaluaciones evaluaciones_id_instrumento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluaciones
    ADD CONSTRAINT evaluaciones_id_instrumento_fkey FOREIGN KEY (id_instrumento) REFERENCES public.instrumentos(id_instrumento);


--
-- TOC entry 4982 (class 2606 OID 33032)
-- Name: evaluaciones evaluaciones_id_nino_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluaciones
    ADD CONSTRAINT evaluaciones_id_nino_fkey FOREIGN KEY (id_nino) REFERENCES public.ninos(id_nino);


--
-- TOC entry 4983 (class 2606 OID 33037)
-- Name: evaluaciones evaluaciones_id_terapeuta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluaciones
    ADD CONSTRAINT evaluaciones_id_terapeuta_fkey FOREIGN KEY (id_psicologo) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 4979 (class 2606 OID 41159)
-- Name: ninos ninos_id_psicologo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ninos
    ADD CONSTRAINT ninos_id_psicologo_fkey FOREIGN KEY (id_psicologo) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 4980 (class 2606 OID 33003)
-- Name: ninos ninos_id_tutor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ninos
    ADD CONSTRAINT ninos_id_tutor_fkey FOREIGN KEY (id_tutor) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 4984 (class 2606 OID 49415)
-- Name: preguntas preguntas_id_instrumento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas
    ADD CONSTRAINT preguntas_id_instrumento_fkey FOREIGN KEY (id_instrumento) REFERENCES public.instrumentos(id_instrumento);


--
-- TOC entry 4985 (class 2606 OID 49435)
-- Name: reglas reglas_id_instrumento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reglas
    ADD CONSTRAINT reglas_id_instrumento_fkey FOREIGN KEY (id_instrumento) REFERENCES public.instrumentos(id_instrumento);


--
-- TOC entry 4987 (class 2606 OID 49478)
-- Name: respuestas respuestas_id_evaluacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_id_evaluacion_fkey FOREIGN KEY (id_evaluacion) REFERENCES public.evaluaciones(id_evaluacion);


--
-- TOC entry 4988 (class 2606 OID 49483)
-- Name: respuestas respuestas_id_pregunta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_id_pregunta_fkey FOREIGN KEY (id_pregunta) REFERENCES public.preguntas(id_pregunta);


--
-- TOC entry 4977 (class 2606 OID 57577)
-- Name: usuarios usuarios_id_psicologo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_id_psicologo_fkey FOREIGN KEY (id_psicologo) REFERENCES public.usuarios(id_usuario);


--
-- TOC entry 4978 (class 2606 OID 32988)
-- Name: usuarios usuarios_id_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_id_rol_fkey FOREIGN KEY (id_rol) REFERENCES public.roles(id_rol);


-- Completed on 2026-11-16 20:49:05

--
-- PostgreSQL database dump complete
--

\unrestrict mbJ6z4eljZcYlYsuuqRCtGRzKhN9uVhqE3pBaeECd8ZugmrDXMCWvZbYtUIstic


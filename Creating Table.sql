-- Create Salesman Table

CREATE TABLE public.salesman
(
    salesman_id integer,
    s_name character varying(50),
    city character varying(50),
    commission double precision,
    PRIMARY KEY (salesman_id)
);

ALTER TABLE IF EXISTS public.salesman
    OWNER to postgres;

-- Create Customer Table

CREATE TABLE public.customer
(
    customer_id integer,
    customer_name character varying(50),
    city character varying(50),
    grade integer,
    salesman_id integer,
    PRIMARY KEY (customer_id),
    CONSTRAINT salesman_id FOREIGN KEY (salesman_id)
        REFERENCES public.salesman (salesman_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public.customer
    OWNER to postgres;

-- Create Order Table

CREATE TABLE public.orders
(
    order_no integer,
    purch_amt double precision,
    order_date date,
    customer_id integer,
    salesman_id integer,
		PRIMARY KEY (order_no),
    CONSTRAINT customer_id FOREIGN KEY (customer_id)
        REFERENCES public.customer (customer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT salesman_id FOREIGN KEY (salesman_id)
        REFERENCES public.salesman (salesman_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public."orders"
    OWNER to postgres;

-- Exercícios:

-- Qual a média salarial na empresa?
select avg(salario) AS Media_Salarial from empregado;

-- Quantos empregados do departamento 5 trabalham mais de 10h por semana no projeto chamado "ProductX"?
select pnome, unome, te.horas, pj.pjnome from empregado emp 
inner join trabalha_em te on te.essn = emp.ssn
inner join projeto pj on pj.pnumero = te.pno
where emp.dno = 5 and pj.pjnome = 'ProductX' and te.horas > 10;

-- Quantos empregados possuem um dependente com o mesmo primeiro nome que o deles?
select count(*) from empregado emp
inner join dependente dep on dep.essn = emp.ssn
where dep.nome_dependente like emp.pnome || '%';

-- Quais os nomes de todos os empregados que são diretamente supervisionados por Franklin Wong
select emp.pnome, emp.unome from empregado emp
inner join empregado emp2 ON emp2.ssn = emp.superssn
where emp2.pnome = 'Franklin';

-- Quem é a pessoa que possui mais tempo de alocação no projeto 'Newbenefits'?
select pnome, te.horas, pj.pjnome from empregado emp
inner join trabalha_em te on te.essn = emp.ssn
inner join projeto pj on pj.pnumero = te.pno
where pj.pjnome = 'Newbenefits'
order by te.horas desc;

-- Qual é a soma dos salários de todos os empregados do departamento chamado 'Research'?
select sum(emp.salario) from empregado emp
inner join departamento dep on dep.dnumero = emp.dno
where dep.dnome = 'Research';

-- Qual seria o custo do projeto com folha salarial (soma de todos os salários) caso a empresa desse 10% de aumento para todos os empregados que trabalham no projeto 'ProductX'?
select sum(emp.salario*1.1) from empregado emp 
inner join trabalha_em te on te.essn = emp.ssn
inner join projeto pj on pj.pnumero = te.pno
where pj.pjnome = 'ProductX';

-- Qual o nome do departamento com a menor média de salário entre seus funcionários?
select dep.dnome, avg(emp.salario) from empregado emp
inner join departamento dep on dep.dnumero = emp.dno
group by dep.dnome
order by avg(emp.salario);
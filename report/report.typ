#import "lncc_report_template.typ": template
#import "@preview/subpar:0.1.1"

#show: doc => template(
  title: "Variáveis Aleatória - LGN & TCL",
  author: "João Pedro dos S. Rocha",
  discipline: "GA030 - Estatística",
  professor: "Márcio Borges",
  bibliography_file: "references.bib",
  doc
)


= Descrição

Neste documento estão descritos os resultados obtidos para os exercícios do
arquivo `trabGA030_2024.pdf` disponibilizados em @mrborges a serem feitos
utilizando os dados também disponibilizados em @mrborges. Serão apresentados os
resultados item a item na mesma sequência do documento com as questões. Para a
construção deste documento foi assumido que o leitor estará com uma cópia do
documento que contém as questões (uma cópia do mesmo pode ser encontrada neste
repositório na pasta
`docs`.

= Questões

Para referência, temos as seguintes variáveis: $Q ~ NN(0, 2)$, $X ~ UU(-1, 1)$,
$Y ~ EE(lambda = 0.05)$, $T ~ BB(15, 0.4)$. As questões que necessitam de apresentação
de resultados para cada variável serão colocadas em sub-sessões separadas.


== (a) Expectância e Variâncias Teóricas

Para cada variável temos as expectâncias e variâncias teóricas especificadas abaixo, 
començando por $Q$.

=== $Q$

Para a distribuição $Q ~ NN(0, 2)$ temos que as expectâncias e variância
teóricas são exatamente os parâmetros da distribuição pois a mesma é uma
distribuição normal, ou seja, são respectivamente $mu_Q = 0$ e $sigma_Q^2 = 2$.

=== $X$

Para a variável $X ~ U(-1, 1)$, temos a expectância e variância teórica dados
por:


$
  mu_X = (b + a)/2 = (1 + (-1))/2 = 0
$

$
  sigma^2_X = (b - a)^2/12 = (1 - (-1))^2/12 = 4/12 = 1/3
$

Onde $a$ é o limite inferior e $b$ é o limite superior.

=== $Y$

A variável $Y ~ EE(lambda = 0.05)$ é de uma distribuição exponencial, logo
temos os valores teóricos:


$
  mu_Y = 1/lambda = 1/0.05 = 1/(1/20) = 20
$

$
  sigma^2_Y = 1/lambda^2 = 1/(1/20)^2 = 1/(1/400) = 400
$



=== $T$

A variável $T ~ BB(15, 0.40)$ é de uma distribuição binomial, logo temos os
valores teóricos:

$
  mu_T = n p = 15 times 0.40 = 15 times 2/5 = 6
$

$
  sigma^2_T = n p (1 - p) = 6 (1 - 2/5) = 6 times 3/5 = 18/5 = 3.6
$

== (b) Médias e variâncias amostrais

Para este item os resultados foram calculados carregando os dados via a
biblioteca numpy no Python e usando as funções embutidas para obter a média e
variância amostral. Os resultados com 5 casas decimais foram colocados na
@tab-sample-x-theory.

#figure(
 table(
  stroke: none,
  columns: 7,
  table.hline(),
  table.header[][$accent(mu, macron)$][$accent(sigma, macron)$][$mu$][$sigma$][$Delta mu$][$Delta sigma$],
  table.hline(),
  [Q], [  -0.00009], [   1.99961], [   0.00000], [   2.00000], [   0.00009], [   0.00039],
  [X], [  -0.00023], [   0.33325], [   0.00000], [   0.33333], [   0.00023], [   0.00008],
  [Y], [  20.00756], [ 400.36956], [  20.00000], [ 400.00000], [   0.00756], [   0.36956],
  [T], [   5.99979], [   3.60221], [   6.00000], [   3.60000], [   0.00021], [   0.00221],
  table.hline(),
  ),
  caption: "Resultado amostral contra teórico"
)<tab-sample-x-theory>

Podemos observar que as estimativas amostrais ficaram bastante próximas como
esperado, com diferenças apenas a partir da terceira casa decimal com exceção
da variável $Y$, que apresentou uma estimativa com diferença na primeira casa,
no entanto esta é uma variável exponencial cuja variância é de $400$,
comparando via a diferença relativa percentual temos apenas $0.092%$.

== (c) Histogramas

Montando os histogramas das variáveis aleatórias (com 50 bins nas distribuições
contínuas), que podem ser vistos na @fig-histograms-rvs-1 e
@fig-histograms-rvs-2, podemos ver uma excelente concordância com as
distribuições analíticas de origem.

#subpar.grid(
  figure(
    image("figures/Q_histogram.svg"),
    caption: "Histograma da variável Q"
  ), <fig-q-hist>,
  figure(
    image("figures/X_histogram.svg"),
    caption: "Histograma da variável X"
  ), <fig-q-hist>,
  columns: (1fr, 1fr),
  caption: "Histogramas das variáveis Q e X",
  label: <fig-histograms-rvs-1>
)

#subpar.grid(
  figure(
    image("figures/Y_histogram.svg"),
    caption: "Histograma da variável Y"
  ), <fig-q-hist>,
  figure(
    image("figures/T_histogram.svg"),
    caption: "Histograma da variável T"
  ), <fig-q-hist>,
  columns: (1fr, 1fr),
  caption: "Histogramas das variáveis Y e T",
  label: <fig-histograms-rvs-2>
)


== (d) Construindo variáveis amostrais

Para construir as variáveis média amostral e variância amostral foram usados os
seguintes códigos em Python usando a biblioteca numpy. Para a média amostral:

```python
sizes = [5, 10, 50]
N = 10_000

for var, rv in data.items():

    for s, ax in zip(sizes, axes):
        sample_var_rv = (
            np.random.choice(rv, size=(N, s), replace=True) 
            .mean(axis=1)
        )

# Continuação com plotagem #
```
E para a variância amostral:

```python
for var, rv in data.items():

    for s, ax in zip(sizes, axes):
        sample_var_rv = (
            np.random.choice(rv, size=(N, s), replace=True) 
            .var(axis=1, ddof=1)
        )

# Continuação com plotagem #
```

Onde a variável `data` é um dicionário (tabela hash) contendo os dados
relativos à cada variável relacionados ao nome da variável. O código roda o
núcleo que sorteia 10 mil amostras (`np.choice`) e tira a estatística (`.{mean, var}(axis=1)`)
para cada variável no dicionário `data` e para cada tamanho de amostra na lista
`sizes` com reposição. Depois segue com o código de plotagem, que pode ser
achado por completo no caderno jupyter que acompanha o relatório.

== (e) + (f) Visualizando as distribuições construídas + Comparações

As variáveis foram construídas 3 a 3 para cada variável aleatória de origem. Vamos
começar listando as médias amostrais.

=== Médias Amostrais

Começando com a variável $Q$ podemos ver que para a mesma as médias amostrais
aparecem naturalmente como uma normal com variância $sigma^2/n$ como esperado
por conta da lei dos grandes números e teorema central do limite.

#figure(
  image("figures/sample_mean_Q.svg"),
  caption: [Média amostral de $Q$]
)

Para a variável $X$ também temos uma aderência rápida a uma normal, com apenas
um pouco mais de ruído perceptível à olho.

#figure(
  image("figures/sample_mean_X.svg"),
  caption: [Média amostral de $X$]
)

Para a variável $Y$ podemos ver uma aderência menor no início, porém com o
aumento do tamanho da amostra é possível ver a convergência para uma normal.

#figure(
  image("figures/sample_mean_Y.svg"),
  caption: [Média amostral de $Y$]
)

Na variável $T$ podemos ver artefatos na variável média amostral, isso acontece
por conta da variável de origem ser uma binomial, ou seja, uma variável
discreta. No entanto, da mesma forma podemos ver a variável aderindo a uma
normal com o aumento do tamanho da amostra.

#figure(
  image("figures/sample_mean_T.svg"),
  caption: [Média amostral de $T$]
)

Assim podemos ver a aderência de todas as variáveis a uma normal $N(mu,
sigma/n)$ em todos os casos. Vejamos agora as variâncias.

=== Variâncias Amostrais

Com a variável variância amostral podemos ver o comportamento específico das
amostras de $Q$ aderindo a uma variável $chi^2$ com o aumento da amostra quando
multiplicado pelo fator $(n-1)/sigma$ dado que $Q$ é uma normal. Como podemos
ver na @fig-var-q.

#figure(
  image("figures/sample_variance_Q.svg"),
  caption: [Variância amostral da variável $Q$. Com $chi^2$ sobreposta.]
) <fig-var-q>

Já no caso das outras variáveis não temos garantias teóricas sobre a
distribuição da variância amostral. Portanto não podemos sobrepor uma 
distribuição usando apenas informações teóricas.

#figure(
  image("figures/sample_variance_X.svg"),
  caption: [Variância amostral da variável $X$.]
)

#figure(
  image("figures/sample_variance_Y.svg"),
  caption: [Variância amostral da variável $Y$.]
)

#figure(
  image("figures/sample_variance_T.svg"),
  caption: [Variância amostral da variável $T$.]
)

Apesar da falta de garantias teóricas podemos observar uma tendência geral das
variáveis a ficar com uma aparência de distribuição normal, mesmo para a
variável discreta, o que indica uma ação do teorema central do limite.

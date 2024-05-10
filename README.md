# Introdução

## Problema

**Objetivo principal**: apresentar o *'Kluster'* para realizar agrupamentos considerando a geolocalização das regiões. As variáveis e dados utilizados neste projeto, embora sejam dados reais, correspondem a um recorte para ilustrar a técnica. Na aplicação real, foram utilizados outros dados que correspondiam ao objetivo da empresa.

### Contexto

Uma empresa precisa realizar uma campanha de marketing de um curso/treinamento para órgãos públicos do estado de Minas Gerais. O produto possui características que podem ser adaptadas ao perfil dos municípios. Por exemplo, parte do curso é personalizada de acordo com características econômicas e sociais. Além da personalização, uma das etapas do treinamento envolve a troca de experiências e interação entre os participantes de forma presencial, fator potencializado quando os públicos possuem similaridades.

### Proposta

Considerando as seguintes características:
- Personalização dos cursos;
- Interações presenciais;
- Similaridade entre os participantes.

A proposta é agrupar os municípios do estado de Minas Gerais conforme as características de cada município, levando em consideração também a geolocalização ao agrupar.

## SKATER

SKATER (Assunção et al., 2006) é um algoritmo de clusterização espacial que consiste na criação de um grafo conectando os pontos (municípios) aos seus vizinhos, construindo uma relação entre as vizinhanças. Cada município/área corresponde a um nó, e as conexões são denominadas arestas.

Para cada aresta, é atribuído um custo que calcula a similaridade entre os dois objetos, geralmente utilizando a distância euclidiana no espaço do vetor de atributos. Em seguida, os "custos" são avaliados em cada nó, eliminando as arestas com menor "custo" associado. Ao final da "poda", obtêm-se *n* nós e *n-1* arestas.

Usando a árvore gerada, aplica-se uma nova remoção de arestas até que se obtenha a quantidade de clusters definida pelo pesquisador. Nessa etapa, a atribuição dos custos é alterada, sendo o novo custo de definir as arestas determinado como a diferença entre a soma dos quadrados dos desvios da árvore e a soma das duas parcelas obtidas dos quadrados dos desvios.

# Base de Dados

Foram considerados os seguintes dados:

## Base 1: Características Municipais
Dados extraídos do Censo (IBGE) e do Atlas do Desenvolvimento Humano.

| Variável  | Descrição                                                                                                                     |
|:----------|:----------------------------------------------------------------------------------------------------------------------------|
| VAR_001   | código IBGE                                                                                                                  |
| VAR_003   | população                                                                                                                   |
| VAR_004   | taxa de crescimento geográfico (%)                                                                                          |
| VAR_005   | percentual da população em áreas urbanas                                                                                    |
| VAR_006   | percentual de domicílios classificados como "casa"                                                                          |
| VAR_007   | percentual de domicílios com abastecimento pela rede geral d'água                                                           |
| VAR_008   | percentual de domicílios conectados à rede geral de esgoto                                                                  |
| VAR_009   | percentual de domicílios com banheiro de uso exclusivo                                                                      |
| VAR_010   | percentual de domicílios com coleta de lixo                                                                                 |
| VAR_011   | renda média da população                                                                                                    |
| VAR_012   | expectativa de anos de estudo: média de anos de estudos concluídos com aprovação das pessoas com 25 anos ou mais de idade  |
| VAR_017   | percentual de pobres no município no ano de 2010                                                                            |
| VAR_018   | prop_ocupados_medio: percentual dos ocupados com ensino médio completo                                                      |
| VAR_019   | prop_ocupados_superior: percentual dos ocupados com ensino superior completo                                               |
| VAR_020   | PEA: população economicamente ativa                                                                                         |
| VAR_021   | mortalidade infantil até 5 anos                                                                                             |
| VAR_022   | índice de Gini em 2010                                                                                                      |
| VAR_023   | probabilidade de sobrevivência até os 60 anos                                                                              |
| VAR_031   | produto interno bruto per capita                                                                                           |
| VAR_055   | densidade demográfica                                                                                                      |

## Base 2: Quantidades de Empresas por Seção

Os dados foram extraídos da Base dos Dados.

| Variável              | Descrição                |
|:----------------------|:-------------------------|
| secao                 | seção do CNAE - letra    |
| descricao             | descrição do CNAE        |
| id_municipio          | código IBGE - 7 dígitos  |
| total_empresas_secao  | quantidade de empresas   |

## Base 3: Informação sobre o PIB Municipal em 2021

Os dados foram extraídos da Base dos Dados.

| Variável          | Descrição                                                                                                                              |
|:------------------|:-------------------------------------------------------------------------------------------------------------------------------------|
| id_municipio      | código IBGE - 7 dígitos                                                                                                               |
| pib               | produto interno bruto a preços correntes                                                                                             |
| impostos          | impostos, líquidos de subsídios, sobre produtos a preços correntes                                                                   |
| va_agropecuaria   | valor adicionado bruto a preços correntes da agropecuária                                                                            |
| va_industria      | valor adicionado bruto a preços correntes da indústria                                                                               |
| va_servicos       | valor adicionado bruto a preços correntes dos serviços, exceto administração, defesa, educação e saúde públicas e seguridade social |
| va_adespss        | valor adicionado bruto a preços correntes da administração, defesa, educação e saúde públicas e seguridade social                    |

## Malhas dos Municípios Brasileiros
Para os gráficos, foi utilizada a malha dos municípios brasileiros disponibilizada pelo IBGE.

# Análise Exploratória

O estado possui **853** municípios, com uma população superior a 20 milhões e uma densidade demográfica de 35,02 km². Como o objetivo principal é a aplicação da técnica e já havia um conhecimento prévio dos dados e de suas características, parte da análise exploratória foi omitida.

## 1. Base PIB:
- Todas as cidades apresentam valores para todos os grupos do PIB.
- O estado apresenta um PIB médio de R$ 1 milhão (SD = R$ 4,7 milhões), sendo o maior valor apresentado por um município de R$ 105 milhões e o menor, R$ 22 mil. Além disso, 50% dos municípios apresentam um PIB de até R$ 169 mil.
- O PIB de Serviços apresenta o maior valor para uma cidade: R$ 63 milhões, enquanto o PIB Agropecuário apresenta o menor valor, com R$ 57 reais.
- Considerando a proposta do projeto de entender o comportamento dos municípios em relação aos produtos e serviços ofertados, optou-se por utilizar a proporção/representatividade de cada grupo do PIB na economia da cidade, reduzindo o efeito do "valor absoluto do PIB" nos agrupamentos.
![Grafico de dispersao do PIB](https://github.com/mateusengq/CLUSTER_MINAS_GERAIS/blob/main/GRAFICOS/EXPLORATORIA_PIB_PROPORCAO_DISPERSAO.png)


## 2. Base Empresas:
- Para a base de empresas, foram considerados apenas os números iniciais do CNPJ. Ou seja, caso a empresa possua matriz na mesma cidade, será contabilizada apenas uma unidade. Para empresas com unidades em várias cidades, será contabilizada a quantidade em cada cidade.
- A cidade com maior quantidade de CNPJ básicos únicos possui 88 mil registros, enquanto a cidade com menor, apenas 1 registro.
- A média é de 152 registros por cidade (SD = 1.342) e a mediana foi de 19 registros.
- O grupo da Seção B (Extração Mineral) apresenta 123 registros e o grupo Q (Órgãos Governamentais...) possui 70 registros. Os CNAEs D (Eletricidade e Gás) e K (Atividades Financeiras, de Seguros e de Serviços) são os que apresentam o maior número de ocorrências.
![Quantidade de empresas por secao](https://github.com/mateusengq/CLUSTER_MINAS_GERAIS/blob/main/GRAFICOS/EXPLORATORIA_QUANTIDADE_EMPRESAS_SECAO.png)

## 3. Base com as Características da Região:
- A população das cidades de Minas Gerais (VAR_003) varia de 833 moradores (Serra da Saudade) até 11,2 milhões (Belo Horizonte). A cidade de Serra da Saudade é considerada a menor cidade do país.
- O estado é o segundo mais populoso do Brasil, com 20,5 milhões de habitantes, ficando atrás apenas de São Paulo.
- Metade dos municípios possuem até 98,6% dos domicílios classificados como casa; 75,7% são abastecidos pela rede geral d'água e 99,9% possuem banheiro de uso exclusivo.
- 50% dos municípios possuem renda média de R$ 413; o município com maior renda média apresenta um valor de R$ 8.897, enquanto o menor, R$ 27.
- Com relação à expectativa de anos de estudo concluídos com aprovação das pessoas com 25 anos ou mais, o menor valor identificado foi um município com 1 ano, enquanto o maior possui aproximadamente 13 anos.

Resumo das variaveis da base Caracteristicas:
![Resumo das variaveis - Base Caracteristicas](https://github.com/mateusengq/CLUSTER_MINAS_GERAIS/blob/main/GRAFICOS/EXPLORATORIA_VARIAVEIS_CARACTERISTICAS.png)

Grafico da renda media por municipio
![Renda media por municipio](https://github.com/mateusengq/CLUSTER_MINAS_GERAIS/blob/main/GRAFICOS/RENDA_MEDIA_VAR_001.png).
# Implementação

## Parâmetros

Utilizando a técnica SKATER, os 853 municípios podem ser agrupados em *k* regiões. Os dados foram padronizados considerando a escala de 0 a 1.

```python
from sklearn.preprocessing import MinMaxScaler

scaler = MinMaxScaler()
dados_tmp[attrs_name] = scaler.fit_transform(dados_tmp[attrs_name])

```
1.1. Definição das variáveis
A primeira etapa é definir as variáveis que serão consideradas para medir a homogeneidade dos municípios. Neste caso, serão utilizadas todas as variáveis citadas na seção "Base de Dados".

``` python
attr_name = attrs_name = dados_tmp.iloc[:, 2:45].columns
attrs_name = attrs_name.drop(['id_municipio_x', 'id_municipio_y'])
```


1.2. Descrição do relacionamento espacial dos municípios
Para a conectividade dos municípios, foi adotada a contiguidade Queen, que segue os mesmos movimentos da peça do xadrez. As conexões geradas aqui consideram apenas as áreas divisas de cada cidade, desconsiderando qualquer critério de distância entre elas.

```
import libpysal

w = libpysal.weights.Queen.from_dataframe(dados_tmp, use_index=False)
```

1.3. Definição do número de clusters
```
n_clusters = 5
```

1.4. Número mínimo de municípios em cada região
```
floor = 2
```

1.5. Outros parâmetros que podem ser especificados:
- trace: indica se os rótulos devem ser armazenados à medida que a árvore é podada. trace = False
- islands: define as ações a serem tomadas no caso de ilhas. Não se aplica ao caso dos municípios na análise.
- dissimilarity: métrica de distância utilizada para comparar as regiões.
- affinity: métrica entre 0 e 1, que corresponde ao inverso da dissimilarity (Apenas uma das medidas é utilizada).
- center: método utilizado para definir o centro de cada região no espaço das variáveis. Default: numpy.mean().
- verbose: argumento utilizado para definir se as saídas serão exibidas na tela. O argumento 1 representa uma saída mínima, enquanto 2 corresponde à saída completa. Por default, o argumento é False, não exibindo nenhuma saída.

## Modelo 1
```
import spopt.region

model = spopt.region.Skater(
    dados_tmp,
    w,
    attrs_name,
    n_clusters=n_clusters,
    floor=floor,
    trace=False,
    islands='ignore',
    spanning_forest_kwds=spanning_forest_kwds
)
model.solve()
```

Adicionar os rótulos à base principal e visualizar os agrupamentos gerados.

```
import matplotlib.pyplot as plt

dados_tmp['regioes'] = model.labels_

dados_tmp.plot(
    figsize=(7, 14), column="regioes", categorical=True, edgecolor='w'
).axis("off")
plt.show()

```

## Testando diferentes valores para k
Definindo valores para k:

```
n_clusters_range = [2, 4, 6, 8, 10, 15, 20, 25, 30]
n_clusters_range

```

Para cada simulação, os outros valores foram definidos como constantes:

```
floor, trace, islands = 2, False, "ignore"

spannning_forest_kwds = dict(
    dissimilarity = skm.euclidean_distances,
    affinity = None,
    reduction = np.sum,
    center = np.mean,
    verbose = 2
)

```
Executando os testes:

```
for ncluster in n_clusters_range:
    model = spopt.region.Skater(
        dados_tmp,
        w,
        attrs_name,
        n_clusters=ncluster,
        floor=floor,
        trace=trace,
        islands=islands,
        spanning_forest_kwds=spannning_forest_kwds
    )

    model.solve()
    dados_tmp[f"cluster_{ncluster}"] = model.labels_
```

# Resultados

Avaliando o primeiro modelo considerando a divisão em 5 clusters, aqueles que conhecem o estado conseguem confirmar uma frase recorrente: "Minas Gerais é a síntese do Brasil". Na parte superior (cluster cinza), há fortes influências da Região Nordeste. A região de Juiz de Fora é conhecida como a "terra dos cariocas". Ao sul, temos a proximidade com o estado de São Paulo, enquanto a região Centro-Oeste é representada pelo cluster azul. Ao centro, há o cluster azul-claro, composto pela capital e região metropolitana.

![Resultados iniciais - k = 5](https://github.com/mateusengq/CLUSTER_MINAS_GERAIS/blob/main/GRAFICOS/RESULTADOS_TESTE_5_CLUSTERS.png)

A partir das regiões definidas, é possível adaptar o produto conforme as necessidades e características de cada região, além de criar campanhas de marketing específicas.

Para o Modelo 2, foram gerados mais alguns agrupamentos, considerando os valores de *k* = [2, 4, 6, 8, 10, 15, 20, 25, 30].

![Clusters gerados variando o valor de k](https://github.com/mateusengq/CLUSTER_MINAS_GERAIS/blob/main/GRAFICOS/simulacoes_quantidade_clusters_floor_2.png)


## Resumo dos Clusters

Para resumir as características de cada estado, utilizamos *k* = 10. Abaixo, a visualização gráfica da mediana dos indicadores para os clusters 3 e 8. Os demais podem ser acessados [AQUI](https://github.com/mateusengq/CLUSTER_MINAS_GERAIS/tree/main/GRAFICOS).

Cluster 3 - Norte do Estado
![Cluster 3 = Norte de Minas Gerais](https://github.com/mateusengq/CLUSTER_MINAS_GERAIS/blob/main/GRAFICOS/RESULTADOS_CLUSTER_3.jpeg)

Cluster 8 - Capital
![Cluster 8 - Regiao Central](https://github.com/mateusengq/CLUSTER_MINAS_GERAIS/blob/main/GRAFICOS/RESULTADOS_CLUSTER_8.jpeg)

# Considerações Finais

A técnica SKATER mostrou-se eficaz para identificar agrupamentos espaciais de municípios no estado de Minas Gerais, levando em consideração suas características socioeconômicas e geográficas. 

Atraves dos agrupamentos criados, e possivel adaptar os produtos e estratégias de marketing de forma mais precisa e segmentada, levando em conta as necessidades e características de cada cluster.




Referência:
- Assunção, R. M., Neves, M. C., Câmara, G., & da Costa Freitas, C. (2006). Efficient regionalization techniques for socio‐economic geographical units using minimum spanning trees. *International Journal of Geographical Information Science*, 20(7), 797-811.
- Shkolnik, Dmitry. Spatially constrained clustering and regionalization: https://www.dshkol.com/post/spatially-constrained-clustering-and-regionalization/
- Feng, X; Gaboardi, J. Spatial ‘K’luster Analysis by Tree Edge Removal: Clustering Airbnb Spots in Chicago. https://pysal.org/spopt/notebooks/skater.html

pacotes <- c('geobr', 'sf', 'janitor', 'hrbrthemes', 'ggthemes', 
             'officer', 'tidyverse', 'gridExtra', 'patchwork')


### Carregando/ Instalando os pacotes
if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)){
    install.packages(instalador, dependencies = TRUE)
    break()}
  sapply(pacotes, require, character = TRUE)
}else{
  sapply(pacotes, require, character = TRUE)
}


## Mapa Brasil

munic <- geobr::read_municipality(year = 2022)

head(munic, 3)

## Dados

df_tmp <- merge(resultados_skater_10[,2:45], munic, by.x = 'VAR_001', by.y = 'code_muni')

cluster_profile <- df_tmp %>%
  st_drop_geometry() %>%
  mutate(clus = cluster_10) %>%
  select(-c(id_municipio_x, id_municipio_y)) %>%
  group_by(clus) %>%
  summarise(across(.cols = 2:41, median)) %>%
  pivot_longer(cols = 2:41, 
               names_to = "occupation", values_to = "share")

# Cores dos clusters

cores <- cores_custom <- c(
  "#e41a1c",  # Red
  "#377eb8",  # Blue
  "#4daf4a",  # Green
  "#984ea3",  # Purple
  "#ff7f00",  # Orange
  "#ffff33",  # Yellow
  "#a65628",  # Brown
  "#f781bf",  # Pink
  "#999999",  # Gray
  "#66c2a5"   # Turquoise
)


cores <- data.frame(cluster = seq(0,9,1), cores = cores)


#### Atribuindo as cores aos grupos

df_tmp <- left_join(df_tmp,cores, by = c('cluster_10' = 'cluster'))
cluster_profile <- left_join(cluster_profile, cores, by = c('clus' = 'cluster'))

# Funcao para a criacao dos mapas

cluster_plot <- function(cluster){

  df_tmp$cores_g1 <- ifelse(df_tmp$cluster_10 == cluster, df_tmp$cores, NA)
  
  # Plot
  (df_tmp %>%
      ggplot() +
      geom_sf(aes(geometry = geom, fill = cores_g1)) +
      scale_fill_identity() +
      theme_void()
    |
      cluster_profile %>%
      filter(clus == cluster) %>%
      ggplot() +
      geom_col(aes(x = factor(occupation), y = share, fill = cores), col = 'white')+
      scale_fill_identity() +
      coord_flip() +
      theme_minimal() +
      # ylim(-2.75, 2.75) +
      labs(y = "Relatively less < | > Relatively more", x = "", title = paste0('Cluster: ', cluster)) +
      theme(panel.grid = element_blank(),
            #axis.text.x = element_blank(),
            axis.title.x = element_text(hjust = 0),
            axis.line.x = element_line(arrow = grid::arrow(length = unit(0.3, "cm"), ends = "both")),
            plot.margin = grid::unit(c(0, 0, 0, 0), "mm"))
  )
}


cluster_plot('8')



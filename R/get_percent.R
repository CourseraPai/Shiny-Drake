#' @get_percent
#' @param data
#' @param country
get_percent <- function(data, country) {

  percent_growth <- data %>% 
    select(birth_country,year) %>% 
    mutate(decade=floor(year/10)*10) %>% 
    group_by(decade,birth_country) %>% 
    summarise(count=n()) %>% 
    mutate(percent = prop.table(count)) %>% 
    filter(birth_country==country)
  
  pct_plot <- percent_growth %>% 
    ggplot(aes(x=decade,y=percent))+
    geom_line(colour="blue")+
    scale_y_continuous(labels = scales::percent)+
    scale_x_continuous(limits=c(1910,2010),breaks=seq(1910,2010,by=10))
  
  return(pct_plot)
  
}

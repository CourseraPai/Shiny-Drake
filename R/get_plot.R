#' @get_percent
#' @param data
#' @param country
get_plot <- function(type,data, country,incategory) {
  
if(type=="percent"){

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
  
}else if(type=="age"){
  
  if(!incategory=="All"){
    filter_phrase = "filter(category==incategory)"
  } else if(incategory=="All"){
    filter_phrase = "select(birth_date,year,category)"
  }
  
  age_analysis <- eval(parse(text=(paste("data %>%",filter_phrase,"%>% select(birth_date,year,category) %>% mutate(age= year-year(birth_date))"))))
  
  age_analysis_plot <- age_analysis %>% 
    ggplot(aes(x=year,y=age))+
    geom_point(colour="blue")+
    geom_smooth(colour="black")+
    scale_y_continuous(limits=c(20,90),breaks=seq(20,90,by=10))+
    scale_x_continuous(limits=c(1900,2010),breaks=seq(1900,2010,by=20))
  
      return(age_analysis_plot)
    
}
  
  
}

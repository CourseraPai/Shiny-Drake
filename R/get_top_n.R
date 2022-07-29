#' @get_top_n
#' @param data
#' @param n
#' @param cat
get_top_n <- function(data, n,cat,gender) {
  
  data <- data %>% 
    filter(!birth_country=="NA")
  
  if(!cat=="All" & !gender=="Both"){
    filter_phrase = "filter(category==cat & sex==gender)"
  } else if(cat=="All" & !gender=="Both"){
    filter_phrase = "filter(sex==gender)"
  } else if(!cat=="All"& gender=="Both"){
    filter_phrase = "filter(category==cat )"
  } else if(cat=="All"&gender=="Both"){
    filter_phrase="select(birth_country)"
  }
  
  nobel <- eval(parse(text=paste("data %>%", 
      filter_phrase," %>% 
      select(birth_country) %>% 
      group_by(birth_country) %>% 
      summarise(count=n()) %>% 
      arrange(desc(count)) %>% 
      slice(1:n)")))
  
  return(nobel)
  

}

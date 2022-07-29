url = "https://raw.githubusercontent.com/VolodymyrGavrysh/DataCamp_projects/master/A%20Visual%20History%20of%20Nobel%20Prize%20Winners/datasets/nobel.csv"
nobel <- readr::read_csv(url,col_names=TRUE)

get_top_n(nobel,10,"All")


nobel %>% 
  select(category) %>% 
  unique()

nobel %>% 
  filter(!birth_country=="NA" & category==cat) %>% 
  select(birth_country) %>% 
  group_by(birth_country) %>% 
  summarise(count=n()) %>% 
  arrange(desc(count)) %>% 
  slice(1:n)

nobel %>% 
  select(birth_country,year) %>% 
  mutate(decade=floor(year/10)*10) %>% 
  group_by(decade,birth_country) %>% 
  summarise(count=n()) %>% 
  mutate(percent = prop.table(count)) %>% 
  filter(birth_country=="United States of America")

get_percent(data,country)

percent_growth %>% 
  ggplot(aes(x=decade,y=percent))+
  geom_line(colour="blue")+
  scale_y_continuous(labels = scales::percent)+
  scale_x_continuous(limits=c(1900,2010),breaks=seq(1900,2010,by=20))


cat="All"
gender="Male"

if(!cat=="All" & !gender=="All"){
  filter_phrase = "filter(category==cat & sex==gender)"
} else if(cat=="All" & !gender=="All"){
  filter_phrase = "filter(nobel$sex==gender)"
} else if(!cat=="All"& gender=="All"){
  filter_phrase = "filter(category==cat )"
}

noquote(paste("nobel %>% ",noquote(filter_phrase)))


rsconnect::setAccountInfo(name='courserapai',
token='762384BB477FC0E6567C37F803F5D5C5',
secret='2IhQzjYs2CWFz5tzFRo1kqmGVHDh1MYiFRHwa9ng')


age_analysis <- nobel %>% 
  select(age,year) %>% 
  mutate(decade=floor(year/10)*10)

d.in <- data.frame(
  dob = c("01-30-1978", "02-10-1960", "03-04-1990"),
  hosp_admission = c("12-20-2015", "06-15-2000", "07-06-2017"))

d.in %>%
  mutate(
    dob = mdy(dob),
    hosp_admission = mdy(hosp_admission),
    age = year(hosp_admission) - year(dob))



eval(parse(text=(paste("nobel %>%",filter_phrase,"%>% select(birth_date,year) %>% mutate(age= year-year(birth_date))"))))

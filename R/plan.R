nobel_plan <-
  drake_plan(

   url = "https://raw.githubusercontent.com/VolodymyrGavrysh/DataCamp_projects/master/A%20Visual%20History%20of%20Nobel%20Prize%20Winners/datasets/nobel.csv",
   nobel = get_data(url),
   save_file = saveRDS(nobel, file_out("nobel.RDS")),
   deployment = rsconnect::deployApp(
     appDir = "NobelApp",
     appFiles = file_in(
       "nobel.RDS",
       "app.R",
       "R/get_data.R",
       "R/get_top_n.R",
       "R/get_plot.R"
     ),
     appName = "NobelApp",
     account="courserapai",
     forceUpdate = TRUE)

)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~ SARS-X Emergence Odin.Dust Model ~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ------------------------------------------------------------------------------
# ----- 0. Initialisation ------------------------------------------------------
# ------------------------------------------------------------------------------

# ----- 0.1. Description -------------------------------------------------------

# The following script reproduces the model run from Figure 2 of the Odin
# Epidemiological model from Imrie & Bissett et al., (2025) "Post-pandemic
# changes in population immunity have reduced the likelihood of emergence of
# zoonotic coronaviruses"

# ----- 0.2. Dependencies ------------------------------------------------------

library(odin.dust); library(tidyverse); library(socialmixr);library(abind)

# ----- 0.3 Convenience Functions ----------------------------------------------

add <- function(list, name, object){
  list[[name]] <- object
  list[order(names(list))]
}

# ----- 0.4. Load Odin Model ---------------------------------------------------

setwd("~/") # Set to your directory containing the models and data subdirectories

model <- odin_dust("models/Odin_Model.R")

# ------------------------------------------------------------------------------
# ----- 1. Model Parameterisation ----------------------------------------------
# ------------------------------------------------------------------------------

# ----- 1.1. Iterations and Duration -------------------------------------------

parameters <- list()

parameters <- add(parameters, "model_iterations", 2500)

parameters <- add(parameters, "model_duration", 3650)

parameters <- add(parameters, "model_times", seq(1, parameters$model_duration, by = 1))

# ----- 1.2. Scotland Population Structure -------------------------------------

scotland <- list()

with(scotland, {
  groups <- read_csv("data/pop_structure.csv")$age_group
  values <- read_csv("data/pop_structure.csv")[,2:6]
  for (i in c(1:ncol(values))){
    new <- values[[i]]
    names(new) <- groups
    scotland <<- add(scotland, colnames(values)[i], new)
  }
  
  ages <- read_csv("data/pop_individual_ages.csv")$age
  n <- read_csv("data/pop_individual_ages.csv")$n_by_indiv_years
  names(n) <- ages
  
  scotland <<- add(scotland, "n_by_year", n)
  
})

scotland <<- add(scotland, "groups", list(
  "0-5" = c(1:5),
  "5-10" = c(6:10),
  "10-15" = c(11:15),
  "15-20" = c(16:20),
  "20-25" = c(21:25),
  "25-30" = c(26:30),
  "30-35" = c(31:35),
  "35-40" = c(36:40),
  "40-45" = c(41:45),
  "45-50" = c(46:50),
  "50-55" = c(51:55),
  "55-60" = c(56:60),
  "60-65" = c(61:65),
  "65-70" = c(66:70),
  "70-75" = c(71:75),
  "75+" = c(76:86)))

scotland <<- add(scotland, "n_by_year_cutoff", c(scotland$n_by_year[1:85], "85+" = sum(scotland$n_by_year[86:91])))

# ----- 1.3. Scotland Vacination Rates -----------------------------------------

scotland <- add(scotland, "vaccination_dose1", as.matrix(read_csv("data/vaccination_dose1.csv")[,2:17])[1:parameters$model_duration, ])
scotland <- add(scotland, "vaccination_dose2",
                as.matrix(read_csv("data/vaccination_dose2.csv")[,2:17])[1:parameters$model_duration, ])

# ----- 1.4. Scotland Social Structure -----------------------------------------

scotland <- add(scotland, "contact_matrices", readRDS("data/contact_matrices.rds")[,,1:parameters$model_duration])

# ----- 1.5 SARS-CoV-2 Variant Prevalences -------------------------------------

viruses <- list()

viruses <- add(viruses, "prevalence_wuhan", read_csv("data/SARS2_variant_prevalences.csv")$wuhan[1:parameters$model_duration])
viruses <- add(viruses, "prevalence_alpha", read_csv("data/SARS2_variant_prevalences.csv")$alpha[1:parameters$model_duration])
viruses <- add(viruses, "prevalence_delta", read_csv("data/SARS2_variant_prevalences.csv")$delta[1:parameters$model_duration])
viruses <- add(viruses, "prevalence_omicron", read_csv("data/SARS2_variant_prevalences.csv")$omicron[1:parameters$model_duration])

# ----- 1.6 SARS-CoV-2 Variant Phenotypes --------------------------------------

with(viruses, {
  phenotypes <- read_csv("data/SARS2_infection_phenotypes_by_age.csv")
  
  for (v in unique(phenotypes$virus)){
    current <- filter(phenotypes, virus == v)
    viruses <<- add(viruses, sprintf("u_death_%s", v), current$u_death)
    viruses <<- add(viruses, sprintf("u_transmission_%s", v), current$u_transmission)
    viruses <<- add(viruses, sprintf("u_incubation_%s", v), current$u_incubation)
    viruses <<- add(viruses, sprintf("u_recovery_%s", v), current$u_recovery)
    viruses <<- add(viruses, sprintf("disability_weighting_%s", v), current$disability_weighting)
    
  }

})

# ----- 1.7 SARS-CoV-2 Immunity Phenotypes -------------------------------------

immunity <- list()

with(immunity, {
  
  reinfection <- read_csv("data/SARS2_immunity_reinfection_by_age.csv")
  for(v in reinfection$virus){
    immunity <<- add(immunity, sprintf("immunity_reinfection_%s", v), filter(reinfection, virus == v)[,3:21] %>% as.matrix())
  }
  
  virulence <- read_csv("data/SARS2_immunity_virulence_by_age.csv")
  for(v in virulence$virus){
    immunity <<- add(immunity, sprintf("immunity_virulence_%s", v), filter(virulence, virus == v)[,3:21] %>% as.matrix())
  }
  
  waning <- read_csv("data/SARS2_waning_rates.csv")
  
  for (i in c(1:nrow(waning))){
    immunity <<- add(immunity, sprintf("u_waning_%s", waning$immunity[[i]]), rep(waning$u_waning[[i]], 16))
  }
  
})

# ----- 1.8 Population Information for Wrangling -------------------------------

pop <- c(
  "0" = 52310, "1" = 53852, "2" = 56084, "3" = 57065, "4" = 57551,
  "5" = 58712, "6" = 60252, "7" = 62094, "8" = 59207, "9" = 60824,
  "10" = 60578, "11" = 58240, "12" = 57028, "13" = 56549, "14" = 55395,
  "15" = 53761, "16" = 53470, "17" = 55826, "18" = 57923, "19" = 63584,
  "20" = 66553, "21" = 69638, "22" = 70320, "23" = 71115, "24" = 72998,
  "25" = 74452, "26" = 78687, "27" = 78594, "28" = 75598, "29" = 75009,
  "30" = 75210, "31" = 72799, "32" = 72184, "33" = 71623, "34" = 69442,
  "35" = 70265, "36" = 71110, "37" = 70470, "38" = 69208, "39" = 66944,
  "40" = 62120, "41" = 60952, "42" = 64225, "43" = 64595, "44" = 65630,
  "45" = 69643, "46" = 73805, "47" = 76696, "48" = 75548, "49" = 78595,
  "50" = 79961, "51" = 80572, "52" = 79878, "53" = 82671, "54" = 81605,
  "55" = 81321, "56" = 79351, "57" = 77374, "58" = 74742, "59" = 73872,
  "60" = 71830, "61" = 69664, "62" = 67359, "63" = 64232, "64" = 63221,
  "65" = 61710, "66" = 59315, "67" = 59478, "68" = 59481, "69" = 60429,
  "70" = 61782, "71" = 66483, "72" = 49554, "73" = 46406, "74" = 46740,
  "75" = 44032, "76" = 39818, "77" = 36270, "78" = 36307, "79" = 196873,
  "80" = 32934, "81" = 32935, "82" = 32936, "83" = 32937, "84" = 32938,
  "85" = 197649)

groups <- list(
  "0-5" = c(1:5),
  "5-10" = c(6:10),
  "10-15" = c(11:15),
  "15-20" = c(16:20),
  "20-25" = c(21:25),
  "25-30" = c(26:30),
  "30-35" = c(31:35),
  "35-40" = c(36:40),
  "40-45" = c(41:45),
  "45-50" = c(46:50),
  "50-55" = c(51:55),
  "55-60" = c(56:60),
  "60-65" = c(61:65),
  "65-70" = c(66:70),
  "70-75" = c(71:75),
  "75+" = c(76:86))

# ----- 1.9 Immunity by Age Functions ------------------------------------------

immune_effectiveness <- function(z) {
  function(x){
    y <- 58.100686 / (1 + exp(-(0.031678) * (x - 7.635491))) - 
      48.95726 / (1 + exp(-0.11386 * (x - 83.1))) + 
      -42.46706 + 1.05007 * z
    pmax(pmin(y, 100), 0)
  }
}

find_z_immune_effectiveness <- function(target){
  if (target == 1){target <- target - 1e-8}
  effectiveness_auc <- function(z) {
    (integrate(immune_effectiveness(z), lower = 0, upper = 80)$value / 80) / 100
  }
  effectiveness_delta <- function(z) {
    current_auc <- effectiveness_auc(z)
    current_auc - target
  }
  effectiveness_z <- uniroot(effectiveness_delta, interval = c(-25, 125), tol = 0.0001)$root
  return(effectiveness_z)
}

# ----- 1.10 Infection-related Mortality Rate Function -------------------------

virus_death_rate <- function(x, z) {
  
  z <- z * 100
  
  rate <- 0.0224086 / (1 + exp(-0.0975006 * (x - (95.0328598 - 3.4256239 * z))))
  rate <- pmax(pmin(rate, 1), 0)
  return(rate)
}

# ----- 1.11 Transmission Rate Function ----------------------------------------

transmission_rate <- function(R0, incubation_rate, recovery_rate, mortality_natural, mortality_infection) {
  rate <-
    (R0 * (incubation_rate + mortality_natural) *
       (recovery_rate + mortality_natural + mortality_infection)) / incubation_rate
  return(rate)
}

# ----- 1.12 Prevenative Vaccine Program Function ------------------------------

find_preventative_vaccine_amplitude <- function(target_coverage, pop_size = 5698993, 
                                                time_points = 0:60, mean_time = 30, sd_time = 10) {
  
  if(target_coverage == 100){
    target_coverage <- 99.5
  }
  
  get_coverage <- function(amp) {
    rates <- amp * exp(-((time_points - mean_time)^2) / (2 * sd_time^2))
    pop <- pop_size
    
    for (i in rates) {
      if (pop > 0) {
        pop <- pop - rbinom(1, pop, i)
      } else {
        break
      }
    }
    
    return(((pop_size - pop) / pop_size) * 100)
  }
  
  find_amp <- function(target) {
    opt <- uniroot(function(amp) get_coverage(amp) - target, 
                   interval = c(0, 1), tol = 0.001)
    return(opt$root)
  }
  
  return(find_amp(target_coverage))
}

# ------------------------------------------------------------------------------
# ----- 2. Model Run -----------------------------------------------------------
# ------------------------------------------------------------------------------

# ----- 2.1 Scenarios ----------------------------------------------------------

scenarios <- expand.grid(virus = c(1:4),
                         vaccine_timing = seq(-360, 360, 30),
                         vaccine_coverage = seq(0, 1, length.out = 25))


# ----- 2.2 Model Execution ----------------------------------------------------

for (s in (1:nrow(scenarios))){
  
  virus <- scenarios[s,]
  
  target <- ifelse(scenarios$vaccine_coverage[s] == 1, 99.5, scenarios$vaccine_coverage[s]*100)
  
  vaccination <- find_preventative_vaccine_amplitude(target) * exp(-((c(1:60) - 30)^2) / (2 * 10^2))
  
  vaccination <- as.data.frame(matrix(rep(vaccination, 16), ncol = 16))
  
  delay <- round(virus$vaccine_timing + 4*365)
  
  zero_rows <- as.data.frame(matrix(0, nrow = delay, ncol = ncol(vaccination)))
  colnames(zero_rows) <- colnames(vaccination)
  
  vaccination <- rbind(zero_rows, vaccination)
  
  rows_to_add <- max(0, 10*365 - nrow(vaccination))
  
  zero_rows_end <- as.data.frame(matrix(0, nrow = rows_to_add, ncol = ncol(vaccination)))
  colnames(zero_rows_end) <- colnames(vaccination)
  
  vaccination <- as.matrix(rbind(vaccination, zero_rows_end))
  
  vaccination <- pmax(vaccination, scotland$vaccination_dose2)
  
  sarsx <- list()
  
  with(sarsx, {
    
    sarsx_ID <- virus$virus #1 = RaTG13, 2 = Rs4084, 3 = GX/P1E, 4 = SARS-1, 6... = Sobol samples
    
    phenos <- colnames(read.csv("Viruses/SARSX_infection_phenotypes_by_age.csv"))
    
    phenotypes <- read.csv("Viruses/SARSX_infection_phenotypes_by_age.csv", skip = (sarsx_ID-1)*16, nrows = 16, header = T)
    
    for(i in c(3:ncol(phenotypes))){
      sarsx <<- add(sarsx, phenos[i], phenotypes[[i]])
    }
    
    reinfection <- read.csv("Viruses/SARSX_immunity_reinfection_by_age.csv", skip = (sarsx_ID-1)*16, nrows = 16, header = T)
    sarsx <<- add(sarsx, "immunity_reinfection", reinfection[,3:21] %>% as.matrix())
    
    virulence <- read.csv("Viruses/SARSX_immunity_virulence_by_age.csv", skip = (sarsx_ID-1)*16, nrows = 16, header = T)
    sarsx <<- add(sarsx, "immunity_virulence", virulence[,3:21] %>% as.matrix())
    
    waning <- read.csv("Viruses/SARSX_waning_rates.csv")[1,]
    sarsx <<- add(sarsx, "u_waning", rep(waning$u_waning[[1]], 16))
    
  })
  
  emerged <- 0
  
  cat("\n")
  print(sprintf("Scenario: %s", s))
  
  pb <- txtProgressBar(min = 0, max = parameters$model_iterations, style = 3)
  
  for (trial in c(1:parameters$model_iterations)){
    
    model_run <- model$new(pars = list(blank = rep(0, 16),
                                       duration = parameters$model_duration,
                                       N_age = 16,
                                       contact_matrices = scotland$contact_matrices,
                                       S_ini = scotland$n,
                                       u_birth = scotland$u_birth,
                                       u_death = scotland$u_death,
                                       u_aging = 1/(365*5),
                                       n_migration = scotland$n_migration,
                                       
                                       u_V1 = scotland$vaccination_dose1,
                                       u_V2 = vaccination,
                                       
                                       u_waning_V1 = immunity$u_waning_V1,
                                       u_waning_V2 = immunity$u_waning_V2,
                                       
                                       prevalence_W = viruses$prevalence_wuhan,
                                       prevalence_A = viruses$prevalence_alpha,
                                       prevalence_D = viruses$prevalence_delta,
                                       prevalence_O = viruses$prevalence_omicron,
                                       
                                       u_trans_W = viruses$u_transmission_wuhan,
                                       u_trans_A = viruses$u_transmission_alpha,
                                       u_trans_D = viruses$u_transmission_delta,
                                       u_trans_O = viruses$u_transmission_omicron,
                                       u_trans_X = sarsx$u_transmission,
                                       
                                       immunity_inf_W = immunity$immunity_reinfection_wuhan,
                                       immunity_inf_A = immunity$immunity_reinfection_alpha,
                                       immunity_inf_D = immunity$immunity_reinfection_delta,
                                       immunity_inf_O = immunity$immunity_reinfection_omicron,
                                       immunity_inf_X = sarsx$immunity_reinfection,
                                       
                                       u_death_W = viruses$u_death_wuhan,
                                       u_death_A = viruses$u_death_alpha,
                                       u_death_D = viruses$u_death_delta,
                                       u_death_O = viruses$u_death_omicron,
                                       u_death_X = sarsx$u_death,
                                       
                                       immunity_vir_W = immunity$immunity_virulence_wuhan,
                                       immunity_vir_A = immunity$immunity_virulence_alpha,
                                       immunity_vir_D = immunity$immunity_virulence_delta,
                                       immunity_vir_O = immunity$immunity_virulence_omicron,
                                       immunity_vir_X = sarsx$immunity_virulence,
                                       
                                       u_incub_W = viruses$u_incubation_wuhan,
                                       u_incub_A = viruses$u_incubation_alpha,
                                       u_incub_D = viruses$u_incubation_delta,
                                       u_incub_O = viruses$u_incubation_omicron,
                                       u_incub_X = sarsx$u_incubation,
                                       
                                       u_recov_W = viruses$u_recovery_wuhan,
                                       u_recov_A = viruses$u_recovery_alpha,
                                       u_recov_D = viruses$u_recovery_delta,
                                       u_recov_O = viruses$u_recovery_omicron,
                                       u_recov_X = sarsx$u_recovery,
                                       
                                       u_waning_W = immunity$u_waning_wuhan,
                                       u_waning_A = immunity$u_waning_alpha,
                                       u_waning_D = immunity$u_waning_delta,
                                       u_waning_O = rep(0.013, 16),
                                       u_waning_X = sarsx$u_waning,
                                       time_intro_W = 1,
                                       amount_intro_W = c(0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,0),
                                       time_intro_X = 4*365,
                                       amount_intro_X = c(0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0)),
                           time = 1L,
                           n_particles = 1,
                           n_threads = 1L)
      
      output <- array(NA, dim = c(model_run$info()$len, 1, parameters$model_duration))
      
      for (i in c(1:(parameters$model_duration))){
        output[ , , i] <- model_run$run(i)
      }
      
      if (output[1,,parameters$model_duration] > 0){
        emerged <- emerged + 1
      }
      
      setTxtProgressBar(pb, trial)
      
    }
  
  virus$emergences <- emerged
  virus$trials <- parameters$model_iterations

  cat("\n")
  print(virus)
  
  if(!exists("outdata")){
    outdata <- virus
  } else {
    outdata <- rbind(outdata, virus)
  }
  
}


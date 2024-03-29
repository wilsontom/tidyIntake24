#' show-Intake24
#' @rdname show
#' @param object an `Intake24` object
#' @export

setMethod('show', signature = 'Intake24',
         function(object) {
           cat(cli::rule(
             left = crayon::bold('Intake24 Object'),
             right = paste0('tidyIntake24 v', utils::packageVersion('tidyIntake24'))
           ), '\n')

           cat(crayon::red('Object Size:', format(utils::object.size(object), units = 'Mb'), '\n', '\n'))

           cat(crayon::green('# of Participants:', length(unique(object@meta$User$UserID)), '\n', '\n'))
           cat(crayon::green('# of Surveys:', length(unique(object@food$SurveyID)), '\n', '\n'))

           cat('Start Date:', as.character(min(object@food$StartDate)), '\n')
           cat('End Date:', as.character(max(object@food$StartDate)), '\n', '\n')


           mostFreq <- object@food %>% dplyr::select(DescriptionEN) %>%
             dplyr::group_by(DescriptionEN) %>% dplyr::count() %>%
             dplyr::ungroup() %>%
             dplyr::filter(DescriptionEN != 'N/A') %>%
             dplyr::arrange(-n)

           cat(cli::rule(left = crayon::bold('Top 10 items recorded')), '\n')
           for (i in 1:10) {
             cat(paste0(mostFreq$DescriptionEN[i], ' (', crayon::yellow(mostFreq$n[i]), ')', '\n'))
           }



         })

##' @importFrom R6 R6Class
data.frame_iterator_generator <- R6::R6Class(
    "data.frame_iterator",
    public = list(
        data = NULL,
        counter = NULL,

        initialize = function(data, ...) {
            self$data <- data
            self$counter <- 1L
        },

        yield = function(j) {
            if (self$is_complete) {
                stop("already done")
            }

            ret <- self$data[self$counter, j]

            self$counter <- self$counter +  1L
            ret
        }),

    active = list(
        is_complete = function(value) {
            self$counter >  self$length
        },

        length = function(value) {
            if (!missing(value)) {
                stop("read only function")
            }
            nrow(self$data)
        }
        )
)
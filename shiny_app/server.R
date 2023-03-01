library(shiny)

# Define server logic required to draw a histogram
server <- function(input, output) {
    # Load linear model previously fitted in R
    model <- readRDS("model.rda")
    data <- readRDS("data.rda")
    # Predict based on user input
    output$prediction_table <- renderTable({
        # Get user input
        year <- input$year
        budget <- input$budget * 1000000
        runtime <- input$runtime
        score <- input$score
        votes <- input$votes
        company <- input$company
        genre <- input$genre
        star <- input$star
        rating <- input$rating
        pred_table <- data.frame(year = year, budget = budget, runtime = runtime, score = score, votes = votes, company = company, genre = genre, star = star, rating = rating) # nolint
        # Predict gross
        prediction <- predict(model, pred_table)
        # Add row with prediction
        data <- rbind(data, c(budget, year, score, votes, runtime, prediction, rating, company, genre, star)) # nolint
        # Transform data$gross as numeric
        data$gross <- as.numeric(data$gross)
        # Sort data by gross
        data <- data[order(data$gross, decreasing = TRUE), ]
        # Add column rank
        data$rank <- 1:nrow(data) # nolint
        # Get rank of prediction
        rank <- data[data$budget == budget & data$year == year & data$score == score & data$votes == votes & data$runtime == runtime & data$rating == rating & data$company == company & data$genre == genre & data$star == star, ]$rank # nolint
        # Reorginize columns
        data <- data[, c("rank", "budget", "year", "score", "votes", "runtime", "gross", "rating", "company", "genre", "star")] # nolint
        # get row of prediction
        data <- data[data$budget == budget & data$year == year & data$score == score & data$votes == votes & data$runtime == runtime & data$rating == rating & data$company == company & data$genre == genre & data$star == star, ] # nolint
        # Return prediction
        return(data)
    })
    # Plot prediction
    output$prediction_plot <- renderPlot({
        # Get user input
        year <- input$year
        budget <- input$budget * 1000000
        runtime <- input$runtime
        score <- input$score
        votes <- input$votes
        company <- input$company
        genre <- input$genre
        star <- input$star
        rating <- input$rating
        pred_table <- data.frame(year = year, budget = budget, runtime = runtime, score = score, votes = votes, company = company, genre = genre, star = star, rating = rating) # nolint
        # Predict gross
        prediction <- predict(model, pred_table)
        # Add row with prediction
        data <- rbind(data, c(budget, year, score, votes, runtime, prediction, rating, company, genre, star)) # nolint
        # Transform data$gross as numeric
        data$gross <- as.numeric(data$gross)
        # Sort data by gross
        data <- data[order(data$gross, decreasing = TRUE), ]
        # Add column rank
        data$rank <- 1:nrow(data) # nolint
        # Get rank of prediction
        rank <- data[data$budget == budget & data$year == year & data$score == score & data$votes == votes & data$runtime == runtime & data$rating == rating & data$company == company & data$genre == genre & data$star == star, ]$rank # nolint
        # Reorginize columns
        data <- data[, c("rank", "budget", "year", "score", "votes", "runtime", "gross", "rating", "company", "genre", "star")] # nolint
        # Transform data$gross as numeric
        data$gross <- as.numeric(data$gross)
        # Hist prediction with x numeric
        hist(data$gross, xlab = "Gross", ylab = "Frequency", main = "Histogram of Gross", col = "lightblue", border = "black", breaks = 100) # nolint
        # Add dashed vertical line for prediction
        abline(v = prediction, col = "red", lwd = 2, lty = 2)
        # Add text next to the line top right
        text(prediction, 1000, paste("Your movie predicted gross: ", prediction), col = "red", pos = 4) # nolint
    })
    # Show prediction
    output$prediction_text <- renderText({
        # Get user input
        year <- input$year
        budget <- input$budget * 1000000
        runtime <- input$runtime
        score <- input$score
        votes <- input$votes
        company <- input$company
        genre <- input$genre
        star <- input$star
        rating <- input$rating
        pred_table <- data.frame(year = year, budget = budget, runtime = runtime, score = score, votes = votes, company = company, genre = genre, star = star, rating = rating) # nolint
        # Predict gross
        prediction <- predict(model, pred_table)
        # Add row with prediction
        data <- rbind(data, c(budget, year, score, votes, runtime, prediction, rating, company, genre, star)) # nolint
        # Transform data$gross as numeric
        data$gross <- as.numeric(data$gross)
        # Sort data by gross
        data <- data[order(data$gross, decreasing = TRUE), ]
        # Add column rank
        data$rank <- 1:nrow(data) # nolint
        # Get rank of prediction
        rank <- data[data$budget == budget & data$year == year & data$score == score & data$votes == votes & data$runtime == runtime & data$rating == rating & data$company == company & data$genre == genre & data$star == star, ]$rank # nolint
        # Reorginize columns
        data <- data[, c("rank", "budget", "year", "score", "votes", "runtime", "gross", "rating", "company", "genre", "star")] # nolint
        # Show prediction
        return(paste("Your movie would gross", format(round(prediction, 0), big.mark=",",scientific=FALSE), " dollars and would be ranked", rank, "in the top 5000 movies of all time! 🎉")) # nolint
    })
}
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Predict the success of your own movie 🍿"),
    # Add subtitle in black and bold
    h3("This app will help you predict the success of your own movie 🎥", style = "color: #000000; font-weight: bold;", fontsize = 40), # nolint
    # Add subtitle in blue
    h3("Could you be the next Steven Spielberg? 🎬", style = "color: #0000FF;", fontsize = 40), # nolint
    # Sidebar with slider inputs for year, budget, runtime, score and votes
    sidebarLayout(
        sidebarPanel(
            sliderInput("year", "Year", min = 1980, max = 2023, value = 2023),
            sliderInput("budget", "Budget (in millions):", min = 0, max = 300, value = 100), # nolint
            sliderInput("runtime", "Runtime (in minutes):", min = 60, max = 300, value = 120), # nolint
            sliderInput("score", "Score of IMDB votes:", min = 0, max = 10, value = 5), # nolint
            sliderInput("votes", "Number of votes:", min = 0, max = 1000000, value = 100000), # nolint
            selectInput("star", "Star:", choices = c('Sam Worthington', 'Robert Downey Jr.', 'Leonardo DiCaprio', 'Daisy Ridley', 'Donald Glover', 'Chris Pratt', 'Vin Diesel', 'Kristen Bell', 'Chadwick Boseman', 'Daniel Radcliffe', 'Emma Watson', 'Craig T. Nelson', 'Sandra Bullock', 'Chris Evans', 'Jason Momoa', 'Elijah Wood', 'Tom Holland', 'Brie Larson', 'Shia LaBeouf', 'Daniel Craig', 'Mark Wahlberg', 'Matthew Broderick', 'Christian Bale', 'Joaquin Phoenix', 'Tom Hanks', 'Johnny Depp', 'Felicity Jones', 'Will Smith', 'Steve Carell', 'Sam Neill', 'Ellen DeGeneres', 'Ewan McGregor', 'Mia Wasikowska', 'Ginnifer Goodwin', 'Martin Freeman', 'Neel Sethi', 'Dwayne Johnson', 'Ian McKellen', 'Albert Brooks', 'Mike Myers', 'Rami Malek', 'Tobey Maguire', 'Ray Romano', 'Louis C.K.', 'Ben Affleck', 'Hayden Christensen', 'Jennifer Lawrence', 'Amy Poehler', 'Tom Hardy', 'Chris Hemsworth', 'Kristen Stewart', 'Gal Gadot', 'Eddie Redmayne', 'Anthony Gonzalez', 'Henry Thomas', 'Tom Cruise', 'John Cusack', 'Harrison Ford', 'Ryan Reynolds', 'Angelina Jolie', 'Andrew Garfield', 'Ben Stiller', 'Patrick Stewart', 'Tilda Swinton', 'Billy Crystal', 'Keanu Reeves', 'Edward Asner', 'Gary Oldman', 'Bill Skarsgård', 'Matthew McConaughey', 'Jing Wu', 'Benedict Cumberbatch', 'Bruce Willis', 'Henry Cavill', 'Jack Black', 'Ryan Potter', "Auli'i Cravalho", 'Matt Damon', 'Brad Garrett', 'Paul Rudd', 'Jay Baruchel', 'Hugh Jackman', 'Jeff Goldblum', 'Jim Caviezel', 'Meryl Streep', 'Suraj Sharma', 'Mandy Moore', 'Tommy Lee Jones', 'Nicolas Cage', 'Bradley Cooper', 'Tye Sheridan', 'Dakota Johnson', 'Tom Hiddleston', 'Hank Azaria', 'Naomi Watts', 'Owen Wilson', 'Antonio Banderas', 'Dennis Quaid', 'James McAvoy', 'Lily James', 'Chris Rock', 'Brad Pitt', 'Kelly Macdonald', 'Mark Hamill', 'Dan Castellaneta', 'Jason Statham', 'John C. Reilly', 'Adam Sandler', 'Alec Baldwin', 'Fionn Whitehead', 'Aaron Taylor-Johnson', 'Ben Burtt', 'Arnold Schwarzenegger', 'Patrick Swayze', 'Scott Weinger', 'Jesse Eisenberg', 'Helen Hunt', 'James Franco', 'Andy Serkis', 'Megan Fox', 'Jim Carrey', 'Macaulay Culkin', 'Jessica Chastain', 'Zach Galifianakis', 'Hailee Steinfeld', 'Chris Pine', 'Russell Crowe', 'Richard Gere', 'Zhi-zhong Huang', 'Scarlett Johansson', 'Gerard Butler', 'George Clooney', 'Ryan Gosling', 'Tony Goldwyn', 'Brendan Fraser', 'Jason Lee', 'Robin Williams', 'Travis Fimmel', 'Lady Gaga', 'Pierce Brosnan', 'Patton Oswalt', 'Colin Firth', 'Jamie Foxx', "Paige O'Hara", 'Kevin Costner', 'Ben Barnes', 'Sarah Jessica Parker', 'Michael Keaton', 'Idris Elba', 'Taron Egerton', 'Mel Gibson', 'Rosa Salazar', 'Noomi Rapace', 'Jeff Bridges', 'Alden Ehrenreich', 'Brandon Routh', 'Liam Hemsworth', 'Kyle Chandler', 'Jim Parsons', 'Dean-Charles Chapman', 'Denis Leary', 'Michael J. Fox', 'Reese Witherspoon', 'Dev Patel', 'Liam Neeson', 'Shameik Moore', 'Jamie Bell', 'Tom McGrath', 'Nicole Kidman', 'Cameron Diaz', 'Nia Vardalos', 'Zachary Levi', 'Demián Bichir', 'Hugh Grant', 'John David Washington', 'Kevin Spacey', 'Jackie Chan', 'Alexander Skarsgård', 'Daveigh Chase', 'Dustin Hoffman', 'Colin Farrell', 'Michael Douglas', 'Kenneth Branagh', 'Jason Sudeikis', 'Anthony Hopkins', 'James Corden', 'Emily Blunt', 'D.B. Sweeney', 'Robert Duvall', 'Zac Efron', "Dylan O'Brien", 'Neil Patrick Harris', 'Anna Kendrick', 'Justin Long', 'John Goodman', 'Amy Adams', 'Sullivan Stapleton', 'Val Kilmer', 'Jake Gyllenhaal', 'Josh Hutcherson', 'Sean Connery', 'Ioan Gruffudd', 'Jeffrey Wright', 'Channing Tatum', 'Bob Hoskins', 'Natalie Portman', 'Paul Hogan', 'Morgan Freeman', 'Anne Hathaway', 'Demi Moore', 'Tom Kenny', 'Will Ferrell', 'Vera Farmiga', 'Viggo Mortensen', 'Katherine Heigl', 'Glenn Close', 'Patrick Wilson', 'Ben Schwartz', 'Noah Ringer', 'Eddie Murphy', 'Sylvester Stallone', 'Zach Braff', 'Jack Nicholson', 'Milla Jovovich', 'Will Arnett', 'John Travolta', 'Julia Roberts', 'Quinton Aaron', 'Shailene Woodley', 'Renée Zellweger', 'Anthony LaPaglia', 'Jacob Tremblay', 'Ming-Na Wen', 'Eva Green', 'Bill Murray', 'John Cena', 'Jerry Seinfeld', 'John Boyega', 'Gwyneth Paltrow', 'Kristen Wiig', 'Bill Pullman', 'Jason Biggs', 'Taylor Kitsch', 'Hugh Bonneville', 'Anna Faris', 'Jeremy Renner', 'Ty Burrell', 'Matthew Lillard', 'Daniel Day-Lewis', 'Alicia Vikander', 'Bill Hader', 'Jodie Foster', 'Seth Rogen', 'Clint Eastwood', 'Camilla Belle', 'Denzel Washington', 'Amanda Seyfried', 'Anika Noni Rose', 'Robert Redford', 'Edward Norton', 'Sacha Baron Cohen', 'Linda Hamilton', 'Elle Fanning', 'Drew Barrymore', 'Kang-ho Song', 'Robert Carlyle', 'Ward Horton', 'Sigourney Weaver', 'Jamie Lee Curtis', 'Daniel Kaluuya', "Lupita Nyong'o", 'James Cromwell', 'Tate Donovan', 'Rowan Atkinson', 'Ed Speleers', 'Heather Donahue', 'Noah Schnapp', 'Eric Bana', 'Jaden Smith', 'Eminem', 'Joel Kinnaman', 'Michael Fassbender', 'Carlos Alazraqui', 'Constance Wu', 'Stephen Campbell Moore', 'Paul Walker', 'Taraji P. Henson', 'Chieko Baishô', 'Haley Joel Osment', 'Melissa McCarthy', 'Elliot Page', 'Ralph Fiennes', 'Whoopi Goldberg', 'Michael Jordan')), # nolint
            selectInput("company", "Company:", choices = c('Twentieth Century Fox', 'Marvel Studios', 'Lucasfilm', 'Walt Disney Pictures', 'Universal Pictures', 'Walt Disney Animation Studios', 'Warner Bros.', 'Mandeville Films', 'Illumination Entertainment', 'New Line Cinema', 'Columbia Pictures', 'Paramount Pictures', 'Metro-Goldwyn-Mayer (MGM)', 'Pixar Animation Studios', 'Fairview Entertainment', 'Dreamworks Pictures', 'Twentieth Century Fox Animation', 'B24', 'Blue Sky Studios', 'Color Force', 'Avi Arad Productions', 'Summit Entertainment', 'Heyday Films', 'DreamWorks', 'Chris Morgan Productions', 'Jolie Pas', 'Lionsgate', 'DreamWorks Animation', 'Atlas Entertainment', 'Marvel Entertainment', 'Temple Hill Entertainment', 'Chernin Entertainment', 'Marvel Enterprises', 'Beijing Dengfeng International Culture Communications Company', 'Hollywood Pictures', 'FortyFour Studios', 'Hurwitz Creative', 'Dentsu', 'Icon Productions', 'Fox 2000 Pictures', 'Focus Features', 'Touchstone Pictures', 'Allison Shearmur Productions', 'New Regency Productions', 'Di Bonaventura Pictures', 'Sony Pictures Animation', 'Syncopy', 'China Film Group Corporation (CFGC)', 'Carolco Pictures', 'Gary Sanchez Productions', 'Spyglass Entertainment', 'Hughes Entertainment', 'Hasbro', 'Beijing Diqi Yinxiang Entertainment', 'EuropaCorp', 'Legendary Entertainment', 'Bona Film Group', 'Warner Bros. Pictures', 'C-2 Pictures', 'Eon Productions', 'The Weinstein Company', 'Tig Productions', 'Kasdan Pictures', 'Roth Films', 'Red Granite Pictures', 'Centropolis Film Productions', 'Celador Films', 'Sony Pictures Entertainment (SPE)', 'Perfect World Pictures', 'The Halcyon Company', 'Gold Circle Films', 'Cinergi Pictures Entertainment', 'Atomic Monster', 'Polygram Filmed Entertainment', 'Green Hat Films', 'Danjaq', 'Village Roadshow Pictures', 'Tokuma Shoten', 'United Artists', 'The Mark Gordon Company', 'Lucamar Productions', 'Legendary East', 'Fox Searchlight Pictures', 'Rimfire Films', 'Cecchi Gori Pictures', 'Paramount Animation', 'Participant', 'Castle Rock Entertainment', 'TriStar Pictures', 'Gotham Group', 'Screen Gems', 'Animal Logic', 'Alcon Entertainment', 'Miramax', 'Amblin Entertainment', 'Estudios Churubusco Azteca S.A.', 'Jerry Bruckheimer Films', 'LivePlanet', 'Brownstone Productions (II)', 'StudioCanal', 'GK Films', 'Dimension Films', 'Revolution Studios', 'Bullwinkle Studios', 'Millennium Films', 'Imagine Entertainment', 'Strong Heart/Demme Production', 'Good Universe', 'Davis Entertainment', 'Matten Productions', 'Everyman Pictures', 'Barunson E&A', 'Redwave Films', 'Blumhouse Productions', 'Monkeypaw Productions', 'Haxan Films', 'Buena Vista International', 'PolyGram Filmed Entertainment', 'Permut Presentations', 'Kopelson Entertainment', 'Flashlight Films', 'Constantin Film International', 'Prana Studios', 'Carnival Film & Television', 'Buena Vista Home Entertainment', 'Jack Giarraputo Productions', 'Black Bear Pictures', 'Warner Bros. Family Entertainment', 'Melampo Cinematografica', 'Mirage Enterprises', 'Relativity Media', 'Aardman Animations', 'Geffen Pictures', 'Peters Entertainment', 'Scott Rudin Productions', 'Mace Neufeld Productions', 'American Zoetrope', 'Great American Films Limited Partnership', 'Warner Animation Group', 'Forward Pass', 'Asia Union Film & Entertainment Ltd.', 'Icon Entertainment International', 'BBL Motion Picture Studios', 'Morgan Creek Entertainment', 'Beacon Communications', 'Cruise/Wagner Productions', 'Compulsion Inc.', 'Studio Ghibli', 'Working Title Films', 'Lava Bear Films', '888 Productions', 'Clubhouse Pictures (II)', 'Total Recall', 'Mediaset España', '2DUX²', 'Canal+', 'Double Dare You (DDY)', 'Waverly Films', '"Weathering With You" Film Partners', 'Solana Films', 'Orion Pictures', 'Disney Television Animation', 'Robert Simonds Productions', 'Brownstone Entertainment (II)', 'STX Entertainment', 'Cruella Productions', 'RatPac-Dune Entertainment', 'Donner/Shuler-Donner Productions', 'Angry Films', 'Lynda Obst Productions', 'Edko Films', 'Follow Through Productions', 'Golden Harvest Company', 'Claudie Ossard Productions', 'Aggregate Films', 'Skydance Media', 'Paramount Vantage', 'Iron Horse Entertainment (II)', 'Astoria Films', 'Twisted Pictures', 'Caravan Pictures', 'Blue Tulip Productions', 'Oriental Light and Magic (OLM)', 'FilmDistrict', 'Broken Road Productions', '3 Arts Entertainment', 'Brandywine Productions', 'Ixtlan', 'Casual Friday Productions', 'Blueprint Pictures', 'Kramer & Sigman Films', 'Don Simpson/Jerry Bruckheimer Films', 'Annapurna Pictures', 'Overbrook Entertainment', 'Visiona Romantica', "It's a Laugh Productions", 'Film 44', 'Decibel Films')), # nolint
            selectInput("genre", "Genre:", choices = c('Drama', 'Adventure', 'Action', 'Comedy', 'Horror', 'Biography', 'Crime', 'Fantasy', 'Animation', 'Family', 'Western', 'Sci-Fi', 'Romance', 'Thriller', 'Mystery')), # nolint
            selectInput("rating", "Rating:", choices = c('R', 'PG', 'G', 'NC-17', 'Approved', 'Not Rated', 'PG-13', 'Unrated', 'X', 'TV-MA'))# nolint
        ),
        # Show prediction for gross in main panel based on user input
        mainPanel(
            tableOutput("prediction_table"),
            plotOutput("prediction_plot"),
            textOutput("prediction_text"),
            # Change fonsize to 40 and color to red
            tags$head(tags$style(HTML("h3 {font-size: 30px; color: red;}"))), # nolint
            h3("Can you beat the top 5 movies? 🏆", style = "color: #000000; font-weight: bold;", fontsize = 40),# nolint
        ),
    ),
)

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
        return(paste("Your movie will gross", format(round(prediction, 0), big.mark=",",scientific=FALSE), " dollars and will be ranked", rank, "in the top 5000 movies of all time! 🎉")) # nolint
    })
}

# Run the application
shinyApp(ui = ui, server = server)

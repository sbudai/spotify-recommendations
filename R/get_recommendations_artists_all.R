#' @title Get Recommendations For All Artists
#'
#' @param artist_ids Spotify Artist IDs
#' @param authorization Authorization token
#' @importFrom purrr map_df
#' @importFrom spotifyr get_recommendations
#' @export

get_recommendations_artists_all <- function (
        artist_ids,
        authorization = NULL ) {

  if (is.null(token)) token <- get_spotify_access_token()

  get_recs <- function(i, ids, vec_length ) {
    start <- i
    end <- ifelse(i + 4 > vec_length, vec_length, i + 4)
    seeds <- ids[c(start:end)]
    recs <- get_recommendations(limit = end + 1 - start,
                                seed_artists = seeds,
                                authorization = token )
    recs
  }

  artist_length <- length(artist_ids)
  artist_seq <- seq(from = 1, to = artist_length, by = 5)
  all_recs <- purrr::map_df(artist_seq, ~get_recs(.x, artist_ids,
                                           artist_length))
  all_recs
}

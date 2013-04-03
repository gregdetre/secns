function [uxi movies_md] = import_secns()

% Analyse the 100k movielens dataset.


[dat, cols, users, movies, ratings, timestamps nUsers nMovies] = load_data();

[movies_md] = load_movies_md();

% try generating the USERS x MOVIES matrix 2 different ways
% and confirm they produce the same thing
uxi = generate_uxi(nUsers, nMovies, users, movies, ratings);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [dat, cols, users, movies, ratings, timestamps nUsers nMovies] = load_data()

% DAT = nPoints x 4
dat = load('sample/ml-100k/u.data');

cols.user = 1;
cols.movie = 2;
cols.rating = 3;
cols.timestamp = 4;

users = dat(:, cols.user);
movies = dat(:, cols.movie);
ratings = dat(:, cols.rating);
timestamps = dat(:, cols.timestamp);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [uxi] = generate_uxi(nUsers, nMovies, users, movies, ratings)

nPoints = count(ratings);

uxi = nan(nUsers, nMovies);
for r=1:nPoints
  user = users(r);
  movie = movies(r);
  rating = ratings(r);
  uxi(user, movie) = rating;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [] = plot_uxi2(ratings)

mean_rating = mean(ratings);

fig = figure(gcf);
hold on
hist(ratings, 5);
title('Histogram of ratings');
plot(mean_rating, 1:35000, 'r-');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [movies_md] = load_movies_md()

% metadata about each MOVIE, e.g.
%   1|Toy Story (1995)|01-Jan-1995||http://us.imdb.com/M/title-exact?Toy%20Story%20(1995)|0|0|0|1|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0
%   ->
%   - movies_md.textdata(1,:) = unstructured metadata
%     '1'    'Toy Story (1995)'    '01-Jan-1995'    ''    [1x53 char]
%   - movies_md.data(1,:) = genre booleans
%     0     0     0     1     1     1     0     0     0     0     0     0     0     0     0     0     0     0     0
movies_md = importdata('sample/ml-100k/u.item', '|');

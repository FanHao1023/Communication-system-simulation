color_areas = [0.2, 0.15, 0.2, 0.15, 0.2, 0.1];

colors = {'orange', 'red', 'purple', 'blue', 'green', 'yellow'};


num_darts = 1e5;  
dart_hits = rand(num_darts, 1);  

color_counts = histcounts(dart_hits, [0, cumsum(color_areas)]);

color_probabilities = color_counts / num_darts;

figure;
bar(color_probabilities, 'FaceColor', 'flat');
xticklabels(colors);
title('Probability of Dart Landing in Each Color Block');
xlabel('Color');
ylabel('Probability');
function [] = prepare(problem)
  
  cd '/media/SSD/Dokumenty/Skola/CMP/Minimal-Problem-Solver-Generator/sources/graphs';
  
  res = [];
  edges = [];
  TeX{1, 1} = '\\textbf{minimal}';
  TeX{2, 1} = '\\textbf{median}';
  TeX{3, 1} = '\\textbf{maximal}';
  TeX{1, 2} = @min;
  TeX{2, 2} = @median;
  TeX{3, 2} = @max;

  eval(['load ', problem]);
  
  time = cell(1, length(res));
  fid = fopen([problem, '_time.tex'], 'w');
  
  for i = 1:length(res)
    
    % errors
    tmp = reshape(res{i}.err, size(res{i}.err, 1)*size(res{i}.err, 2), 1);
    tmp = tmp(~isnan(tmp));
    tmp = tmp(tmp ~= 0);
    tmp = log10(abs(tmp));
    if size(edges, 1) == 0
      h = histogram(tmp, 100);
      s = [(h.BinLimits(1)+h.BinWidth/2:h.BinWidth:h.BinLimits(2))', h.Values'];
      edges = h.BinEdges;
    else
      h = histogram(tmp, edges);
      s = [s, h.Values'];
    end
    % time
    time{i} = res{i}.time(~isnan(res{i}.time));
    
  end
  
  save([problem, '.dat'], 's', '-ascii');
  
  % time
  
  for i = 1:length(TeX)
    fprintf(fid, TeX{i, 1});
    for j = 1:length(res)
     fprintf(fid, ' & %5.3f', TeX{i, 2}(time{j}));
    end
    fprintf(fid, '\\\\\n');
  end
  
  fclose(fid);
  quit;
end

function [] = prepare(problem)
  
  cd '/media/SSD/Dokumenty/Skola/CMP/Minimal-Problem-Solver-Generator/sources/graphs';
  
  res = [];
  edges = -15:0.25:10;
  TeX{1, 1} = '\\textbf{minimal time}';
  TeX{2, 1} = '\\textbf{median of times}';
  TeX{3, 1} = '\\textbf{maximal time}';
  TeX{1, 2} = @min;
  TeX{2, 2} = @median;
  TeX{3, 2} = @max;

  if strcmp(problem, 'elim')
    r1 = load('sys_gj0');
    r2 = load('sys_gj1');
    r3 = load('sys_gj2');
  elseif strcmp(problem, 'part')
    r1 = load('sys_gj1');
    r2 = load('sys_last');
    r3 = load('sys_all');
  elseif strcmp(problem, 'gen')
    r1 = load('sys_gj0');
    r2 = load('F4_none');
    r3 = load('F4_last');
  end
  
  res{1} = r1.res{1};
  res{2} = r2.res{1};
  res{3} = r3.res{1};
  
  time = cell(1, length(res));
  fid = fopen([problem, '_time.tex'], 'w');
  
  s = [-15+0.25/2:0.25:10-0.25/2]';
  
  for i = 1:length(res)
    
    % errors
    tmp = reshape(res{i}.err, size(res{i}.err, 1)*size(res{i}.err, 2), 1);
    tmp = tmp(~isnan(tmp));
    tmp = tmp(tmp ~= 0);
    tmp = log10(abs(tmp));
    %if size(edges, 1) == 0
    %  h = histogram(tmp, 100);
    %  s = [(h.BinLimits(1)+h.BinWidth/2:h.BinWidth:h.BinLimits(2))', h.Values'];
    %  edges = h.BinEdges;
    %else
      h = histogram(tmp, edges);
      s = [s, h.Values'];
    %end
    % time
    time{i} = res{i}.time(~isnan(res{i}.time));
    
  end
  
  save([problem, '.dat'], 's', '-ascii');
  
  % time
  
  for i = 1:length(TeX)
    fprintf(fid, TeX{i, 1});
    for j = 1:length(res)
     fprintf(fid, ' & %5.3f s', TeX{i, 2}(time{j}));
    end
    fprintf(fid, '\\\\\n');
  end
  
  fclose(fid);
  quit;
end

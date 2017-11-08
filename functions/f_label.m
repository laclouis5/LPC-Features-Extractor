function [label, nb_label] = f_label(f_logic)

len_sig  = length(f_logic);
label    = zeros(len_sig, 1);
nb_label = 0;

i = 1;

while (i  <= len_sig)
    
    if (f_logic(i) == 1)
        
        nb_label = nb_label + 1;
        label(i) = nb_label;
        
        i = i + 1;
        
    end
        
        while (f_logic(i) == 1)
            
            label(i) = nb_label;
            i = i + 1;         
        end  
        
       i = i + 1;
end
end


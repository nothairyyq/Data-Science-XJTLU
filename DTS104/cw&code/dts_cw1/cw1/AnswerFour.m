function AnswerFour
%Main Program
t0=0;      %initial t value
y0=2555;   %initial y value
st=10;     %step size = 10
it=5;      %number of iterations
y1=[2555 3040 3710 4455 5275 6080]; %Actual y values
Euler(t0,y0,st,it,y1);          %using Euler Method simulate
Runge_Kutta(t0,y0,st,it,y1);    %using 4th-Order Runge-Kutta Method simulate
    
    function Euler(t,y,h,n,y_actual)
 
       
            function z=f(t,y)
             %Needed to solve the growth of y over time(t)
            z=0.0259*(1-y/(12000))*y;
            end
 
    %Euler Method simulation
    %Input:       t:Initial condition time t;
    %             y:Initial condition y   e.g:y_0(t=0)=2555
    %             h:Step size  e.g. 0.1,10,20
    %             n:Number of iterations
    %             y_actual: actual y values
 
 
    %Euler Method
    t_array1=[t];  %initial time t array to store t
    y_array1=[y];  %initial y array to store y
    e_array1=[0];
    fprintf('Euler Method: t=%d, y=%4.0f\n',t,y);
        
        for i=1:n
        t=(i-1)*h;
        K=f(t,y);
        y=y+h*K;        %using Euler Method to simulate y
        e1=abs(y-y_actual(i+1))/y_actual(i+1); %Compute relative error
        e_array1=[e_array1;e1];
        fprintf('Euler Method: t=%d, y=%4.0f,   t=%5.2f%%\n ',t+h,y,e1*100);
       
        t_array1=[t_array1;t+h];             %store each t
        y_array1=[y_array1;y];               %store each y
 
        end
        
    %Plot y actual value and using euler method y
    figure;
    plot(t_array1,y_array1,t_array1,y_actual);       %Plot y actual value and using euler method y
    title('Euler Method Plot');
    xlabel('t');
    ylabel('y');
    legend('Euler Simulate y','y-actual');
    figure;
    plot(t_array1,e_array1);
    title('Euler Method Relative Error Plot');      %Plot relative error 
    xlabel('t');
    ylabel('Error');
    end
 
 
 
    function Runge_Kutta(t,y,h,n,y_actual)
 
            %Needed to solve the growth of y over time(t)
            function z=f(t,y)
            z=0.0259*(1-y/(12000))*y;
            end
 
    %4th-Order Runge-Kutta simulation
    %Input:       t:Initial condition time t;
    %             y:Initial condition y   e.g:y_0(t=0)=2555
    %             h:Step size  e.g. 0.1,10,20
    %             n:Number of iterations
    %             y_actual: actual y values
 
 
    t_array2=[t];   %initial time t array to store t
    y_array2=[y];   %initial y array to store y
    e_array2=[0];   %initial e array to store error
    
    fprintf('4th-Order Runge-Kutta Method: t=%d, y=%4.0f\n',0,2555);
    for i=1:n
        t=(i-1)*h;
        K1=f(t,y);
        K2=f(t+h/2,y+(h/2)*K1);
        K3=f(t+h/2,y+(h/2)*K2);
        K4=f(t+h,y+h*K3);
        y=y+(h/6)*(K1+2*K2+2*K3+K4);    %using 4th-Order Runge-Kutta method to simulate y
        e2=abs(y-y_actual(i+1))/y_actual(i+1);  %compute relative error
        fprintf('4th-Order Runge-Kutta Method: t=%d, y=%4.0f,error=%5.2f%%\n',t+h,y,e2*100);
        e_array2=[e_array2;e2];
        t_array2=[t_array2;t+h];
        y_array2=[y_array2;y];
    end
 
    
    %Plot y actual value and using 4th-Order Runge-Kutta method y
    figure;
    plot(t_array2,y_array2,t_array2,y_actual);       
    title('4th-Order Runge-Kutta Method Plot');
    xlabel('t');
    ylabel('y');
    legend('4th-Order Runge-Kutta Simulate y','y-actual');
    figure;
    plot(t_array2,e_array2);    %Plot relative error 
    title('4th-Order Runge-Kutta Method Relative Error Plot');
    xlabel('t');
    ylabel('Error');
     
  
    end
end

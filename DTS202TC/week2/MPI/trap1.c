/*
 * Trapezoidal method 1
 * Algorithm:
 * 1.Each process calculates its interval of integration
 * 2.Each process estimates the integral of f(x)
 *   over its interval using the trapezoidal rule
 * 3.Each process != 0 sends its integral to 0 process
 * 3.b process 0 sums the calculations received from the
 *   individual processes and prints the result
 * */

#include <stdio.h>
#include <mpi.h>

/*calculate local integral*/
double Trap(double left_endpt,double right_endpt,
            int trap_count,double base_len);

/*Function we're integrating*/
double f(double x);

int main(void){

    int n = 1024;   /*将x轴可以分为n个等长区间*/
    int local_n;    /*将n个等长区间聚合为local_n个*/
    int my_rank;    /*My process rank*/
    int comm_sz;    /*Number of processes*/

    double a = 0.0, b = 3.0;    /* 区间的左右端点 */
    double h;                   /* 每个子区间的宽度 */
    double local_a, local_b;     /*每个进程的左右端点*/

    double local_int,total_int;
    int source;

    /*Set up MPI*/
    MPI_Init(NULL,NULL);

    /*Get my rank among all the processes*/
    MPI_Comm_rank(MPI_COMM_WORLD,&my_rank);
    /*Find out how many processes are being used*/
    MPI_Comm_size(MPI_COMM_WORLD,&comm_sz);

    h = (b-a)/n;
    local_n = n/comm_sz;

    /*Length of each process' interval of
     * integration = local_n*h
     * */
    local_a = a + my_rank*local_n*h;
    local_b = local_a+local_n*h;
    local_int = Trap(local_a,local_b,local_n,h);

    /*Add up the integrals calculated by each process*/
    if (my_rank != 0){
        MPI_Send(&local_int,1,MPI_DOUBLE,0,0,MPI_COMM_WORLD);
    } else{
        total_int = local_int;
        for (source = 1; source < comm_sz; source++) {
            MPI_Recv(&local_int,1,MPI_DOUBLE,source,0,
                     MPI_COMM_WORLD,MPI_STATUS_IGNORE);
            total_int += local_int;
        }
    }

    /*Print the result*/
    if(my_rank == 0){
        printf("With n =%d trapezoids, our estimate\n",n);
        printf("of the integral from %f to %f = %.15e\n",
               a,b,total_int);
    }

    MPI_Finalize();
    /*shut down mpi*/
    return 0;
}

/*
 * Function: f
 * Purpose: compute value of function to be integrated
 * Input args: x
*/
double f(double x){
    return x*x;
}

/*
 * Function: Trap
 * Purpose: Serial function for estimating a definite integral
 *          using the trapezoidal rule
 *
 * Return val:  Trapezoidal rule estimate of integral from left_endpt
 *              to right_endpt using trap_count trapezoids
 * */
double Trap(double left_endpt,double right_endpt,
            int trap_count,double base_len){
    double estimate,x;
    int i;
    estimate = (f(left_endpt)+ f(right_endpt))/2.0;
    for ( i = 0; i <trap_count ; i++) {
        x = left_endpt+i*base_len;
        estimate+=f(x);
    }
    estimate = estimate*base_len;

    return estimate;
}
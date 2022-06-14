#include <stdio.h>
#include <mpi.h>

/* Calculate local integral  */
double Trap(double left_endpt, double right_endpt, int trap_count,
            double base_len);

/* Function we're integrating */
double f(double x);
void Get_input(int my_rank, int comm_sz, double* a_p, double* b_p,
               int* n_p);

int main(void) {
    int my_rank, comm_sz, n = 1024, local_n;
    double a = 0.0, b = 3.0, h, local_a, local_b;
    double local_int, total_int;
    int source;

    MPI_Init(NULL, NULL);
    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
    MPI_Comm_size(MPI_COMM_WORLD, &comm_sz);


    Get_input(my_rank, comm_sz, &a, &b, &n);

    h = (b - a) / n;          /* h is the same for all processes */
    local_n = n / comm_sz;  /* So is the number of trapezoids  */

    /* Length of each process' interval of
     * integration = local_n*h.  So my interval
     * starts at: */
    local_a = a + my_rank * local_n * h;
    local_b = local_a + local_n * h;
    local_int = Trap(local_a, local_b, local_n, h);

    //进行全局累加函数，并将输出给每一个进程
    MPI_Allreduce(&local_int,&total_int,1,MPI_DOUBLE,MPI_SUM,MPI_COMM_WORLD);

    /* Print the result */
    if (my_rank == 0) {
        printf("With n = %d trapezoids, our estimate\n", n);
        printf("of the integral from %f to %f = %.15e\n",
               a, b, total_int);
    }

    /* Shut down MPI */
    MPI_Finalize();

    return 0;
}

double Trap(
        double left_endpt  /* in */,
        double right_endpt /* in */,
        int    trap_count  /* in */,
        double base_len    /* in */) {
    double estimate, x;
    int i;

    estimate = (f(left_endpt) + f(right_endpt))/2.0;
    for (i = 1; i <= trap_count-1; i++) {
        x = left_endpt + i*base_len;
        estimate += f(x);
    }
    estimate = estimate*base_len;

    return estimate;
}

double f(double x) {
    return x*x;
} /* f */


void Get_input(int my_rank, int comm_sz, double* a_p, double* b_p,
               int* n_p) {
    if (my_rank == 0) {
        printf("Enter a, b, and n\n");
        scanf("%lf %lf %d", a_p, b_p, n_p);
        MPI_Bcast(&a_p,1,MPI_DOUBLE,0,MPI_COMM_WORLD);
        MPI_Bcast(&b_p,1,MPI_DOUBLE,0,MPI_COMM_WORLD);
        MPI_Bcast(&n_p,1,MPI_DOUBLE,0,MPI_COMM_WORLD);
    }
}

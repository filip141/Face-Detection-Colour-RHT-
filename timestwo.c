#include "mex.h"
 
void timestwo(double y[], double x[])
{
 y[0] = 2.0*x[0];
}
void mexFunction(int nlhs, mxArray *plhs[], int nrhs,
 const mxArray *prhs[])
{
 double *x, *y;
 int mrows, ncols;
 
 /* SPrawdzenie poprawnej iloœci parametrow. */
 if (nrhs != 1) {
 mexErrMsgTxt("Wymagany jest jeden parametr wejsciowy.");
 } else if (nlhs > 1) {
 mexErrMsgTxt("Podano za duzo parametrow wyjsciowych");
 }
 
 /* The input must be a noncomplex scalar double. */
 mrows = mxGetM(prhs[0]);
 ncols = mxGetN(prhs[0]);
 if (!mxIsDouble(prhs[0]) || mxIsComplex(prhs[0]) ||
 !(mrows == 1 && ncols == 1)) {
 mexErrMsgTxt("Input must be a noncomplex scalar double.");
 }
 /* Create matrix for the return argument. */
 plhs[0] = mxCreateDoubleMatrix(mrows,ncols, mxREAL);
 
 /* Assign pointers to each input and output. */
 x = mxGetPr(prhs[0]);
 y = mxGetPr(plhs[0]);
 
 /* Call the timestwo subroutine. */
 timestwo(y,x);
} 
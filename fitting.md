# Mantid fitting code


`IFittingAlgorithm.h`

Base class for main fitting algorithms
Takes care of workspace and function then creates domain handles.

Domains:
Fitting algorithm creates `Domain creators` which create the domain once they have all the information.

The domain requires the workspace and function types to be known. This means we create the domain once we are about run a fit.

The most common domain is `FitMW.h`, which is used for matrix workspaces and most standard functions.

4 methods in domain needs an override:

1) `declareDatasetProperties` 
2) `createDomain` sets up domain values and also weights (which are typically 1/error)
3) `createOutputWorkspace` workspace created after the fit, containing the fit curves and errors.
4) `initFunction` Initializes the function and sets its workspace


Minimizer then does the main fitting, we have:

1) Levenberg martuqardt. THis is the main fitting minimizer. Its a mix of gradient descent and newtons method. We have the GSL versiona and our version with MD appended on the end.

Other than that we have lots of other GSL minimizers, e.g simplex (non gradient method) and various other gradient methods (conjugate gradient).

To interact with the GSL minimizers we have GSLFunction.h


Minimizer only knows about costFunction and not the function.

Cost function:
- function of the parameters

There are a few cost functions, but we usually use 
least squares (chi squared when we have Gaussian errors).

But we also have:

- Unweighted least squares
- RWP for exponential data
- Poisson

The cost functions have a base class in costFunction.h

Cost function class should be implemented such that we can find the cost function value, derivatives and hessian.

In cost functions we also handle constraints by adding a penalty factor to the cost function if a constraint is broken.

A few issues with this:

- Gradient algorithm searches in regions that should be impossible according to the constraint. Can lead to difficulty converging.
- Constraint is approximate as its controlled by a penalty factor. If the penalty factor is too large the problem won't coverage.


My opinion: Don't use constraints too much. LMFit says the same thing it its manual.

Alternatively, we can use lagrange constraints, but it leads to a saddle point problem, meaning we may not converge. 


A brief on the minimizers:

- Levenberg - Probably the most reliable - quadratic converge if we are close to a minimum. Forming Hessian is costly for large problems
- Simplex non gradient method, pretty robust but pretty slow as it just moves the solution about using geometric argument.
- Others probably not as tested, so read the GSL manual if you need to know about them.
- FABADA (no idea its some bayesian minimizer. I think this a Indirect specific thing. 






IFunction is the interface for all functions. This is a really big interface (far too big). Its aim is to give you function values if you supply it a domain. It has:

Attributes - non fitting parameters, this is stored as variant as the value stored can be boolean, string, double ect. An example is `n` in a polynomial.

- function() returns values
- functionDeriv() optionally calculate the derivative. Usually people just use the numerical derivative. Neither are very "modern" as most other fitting libraries use the concept of dual numbers to calculate exact derivatives. See ceres-solver jets.


- Activate parameters lets us use different parameters in the cost function. This is used with the sigma parameter in the Gaussian function.

-Outside of that you can look in the IFunction header for function declarations and descriptions.

There are no parameters in IFunction. These are stored in ParamFunction.

CompositeFunctions give us a way to add multiple IFunctions together.

Jacobian is the derivative of the function with respect to its parameters.

Convolution:
Allows you to convolute functions together, this is used in Indirect to convolve peaks with a resolution function.

Convolution uses GSL FFT but also has a direct calculation approach if non-regular.


Resolution function is a tabulate function of the resolution.
You just need to set X and Y.

MultiDomainFunction is a type of composite, where at each index (I) we have a function and an associated domain. This is how we do sequential and simultaneous fitting.



IFunctionWithLocation - splits background and peak functions.





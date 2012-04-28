#include <cstdio>
#include <sstream>
#include <iostream>
#include <string>
#include <vector>

using namespace std;

int
main(int argc, char **argv)
{
        int T;

        string lineT;
        getline(cin, lineT);
        stringstream ssT(lineT);
        ssT >> T;

        for (int i = 0; i < T; i++) {

                int A, B;
                string line1, line2;
                getline(cin, line1);
                getline(cin, line2);
                stringstream ss1(line1), ss2(line2);
                ss1 >> A; ss1 >> B;

                double p[A];
                for (int j = 0; j < A; j++)
                        ss2 >> p[j];

                double a[A+2];
                for (int j = 0; j < A; j++) {
                        double prob = 1.0;
                        for (int k = 0; k < A-j; k++)
                                prob *= p[k];
                        a[j] = prob*(B+1+2*j) + (1.0-prob)*(2*B+2+2*j);
                }
                a[A] = B+2*A+1;
                a[A+1] = A+B+2;

                double answer = 3.0*B;
                for (int j = 0; j < A+2; j++)
                        if (a[j] < answer)
                                answer = a[j];

                // oops
                // cout << "Case #" << i+1 << ": " << answer-A << endl;
                printf("Case #%d: %lf\n", i+1, answer-A);

        }

        return 0;
}

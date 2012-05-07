#include <cstdio>
#include <sstream>
#include <iostream>
#include <string>
#include <vector>
#include <cmath>

using namespace std;

int
main(int argc, char **argv)
{
        int T;

        cout.precision(16);

        string lineT;
        getline(cin, lineT);
        stringstream ssT(lineT);
        ssT >> T;

        for (int i = 0; i < T; i++) {

                string lineD;
                getline(cin, lineD);
                stringstream ssD(lineD);

                double D;
                int N, A;
                ssD >> D >> N >> A;

                vector<double> ts, xs;
                for (int j = 0; j < N; j++) {
                        string line;
                        getline(cin, line);
                        stringstream ss(line);
                        double t, x;
                        ss >> t >> x;
                        ts.push_back(t);
                        xs.push_back(x);
                }

                for (int j = 0; j < N; j++) {
                        if (xs[j] > D) {
                                N = j+1;
                                break;
                        }
                }

#if 1
                cerr << "Case " << i+1 << endl;
                cerr << D << " " << N << " " << A << endl;
                for (int j = 0; j < N; j++) {
                        cerr << ts[j] << " " << xs[j] << endl;
                }
#endif

                if (N > 1) {
                        double ul = (xs[N-1]-xs[N-2])/(ts[N-1]-ts[N-2]);
                        double vl = xs[N-1] - ul * ts[N-1];
                        ts[N-1] = (D-vl)/ul;
                        xs[N-1] = D;
                }
                cerr << ts[N-1] << " " << xs[N-1] << endl;

                string lineA;
                getline(cin, lineA);
                stringstream ssA(lineA);

                cout << "Case #" << i+1 << ":" << endl;

                vector<double> as;
                for (int j = 0; j < A; j++) {
                        double a;
                        ssA >> a;
                        double ta;
                        if (N > 1) {
                                double td = ts[N-1] - sqrt(2*D/a);
                                if (td < 0.0)
                                        td = 0.0;
                                for (int k = N-2; k >= 0; k--) {
                                        double t = ts[k] - td;
                                        if (t < 0.0)
                                                continue;
                                        double x = 0.5*a*t*t;
                                        if (x > xs[k])
                                                td = ts[k]-sqrt(2*xs[k]/a);
                                }
                                ta = sqrt(2*D/a)+td;
                        }
                        else {
                                ta = sqrt(2*D/a);
                        }
                        cout << ta << endl;
                }

        }

        return 0;
}

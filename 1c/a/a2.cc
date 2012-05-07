#include <cstdio>
#include <sstream>
#include <iostream>
#include <string>
#include <vector>

using namespace std;

int
rec(vector< vector<int> > &v, vector< vector<int> > &dic, int j, int k)
{
        if (dic[j][k] >= 0)
                return dic[j][k];
        int result = 0;
        for (size_t i = 0; i < v[j].size(); i++)
                result += rec(v, dic, v[j][i], k);
        dic[j][k] = result;
        return result;
}


int
main(int argc, char **argv)
{
        int T;

        string lineT;
        getline(cin, lineT);
        stringstream ssT(lineT);
        ssT >> T;

        for (int i = 0; i < T; i++) {

                string lineN;
                getline(cin, lineN);
                stringstream ssN(lineN);
                int N;
                ssN >> N;

                vector< vector<int> > cs(N);

                for (int j = 0; j < N; j++) {

                        string line;
                        getline(cin, line);
                        stringstream ss(line);

                        int dd;
                        ss >> dd;
                        vector<int> ds(dd);
                        for (int k = 0; k < dd; k++) {
                                int d;
                                ss >> d;
                                ds[k] = d-1;
                        }
                        cs[j] = ds;
                }

                for (int j = 0; j < N; j++) {
                        vector<int> &ds = cs[j];
                        for (size_t k = 0; k < ds.size(); k++)
                                cerr << " " << ds[k];
                        cerr << endl;
                }

                vector< vector<int> > dic(N, vector<int>(N, -1));
                for (int j = 0; j < N; j++)
                        dic[j][j] = 1;

                bool dia = false;
                for (int j = 0; j < N; j++) {
                        for (int k = 0; k < N; k++) {
                                if (rec(cs, dic, j, k) > 1) {
                                        dia = true;
                                        goto out;
                                }
                        }
                }

out:
                cout << "Case #" << i+1 << ": " << (dia ? "Yes" : "No") << endl;

        }

        return 0;
}

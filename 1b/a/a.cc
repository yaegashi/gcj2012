#include <cstdio>
#include <sstream>
#include <iostream>
#include <iomanip>
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

                string line;
                getline(cin, line);
                stringstream ss(line);

                int N;
                vector<int> scores;

                ss >> N;
                int total = 0, min1 = INT_MAX, min2 = INT_MAX;
                for (int j = 0; j < N; j++) {
                        int score;
                        ss >> score;
                        total += score;
                        if (score <= min1) {
                                min2 = min2 < min1 ? min2 : min1;
                                min1 = score;
                        }
                        else {
                                min2 = min2 < score ? min2 : score;
                        }
                        scores.push_back(score);
                }

                cout.precision(10);
                cout << "Case #" << i+1 << ":";
                for (int j = 0; j < N; j++) {
                        int s = scores[j];
                        double p = (total-s+total-N*s)/(N+1.0)/total;
                        cout << " " << showpoint << 100.0*p;
                }
                cout << endl;
                cout << " " << min1 << " " << min2 << " " << total << endl;


        }

        return 0;
}

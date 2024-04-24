#include<bits/stdc++.h>
using namespace std;


// #include <ext/pb_ds/assoc_container.hpp>
// #include <ext/pb_ds/tree_policy.hpp>

// using namespace __gnu_pbds;
// #define ordered_set tree<int, null_type,less<int>, rb_tree_tag,tree_order_statistics_node_update>
// // order_of_key(k) : no. of elements < k
// // *find_by_order(i) : value at index i (0-based)

typedef long long ll;
typedef pair<int,int> ii;
typedef vector<int> vi;
typedef vector<ii> vii;
typedef vector<vi> vvi;
typedef vector<char> vc;
typedef map<int,int> mi;
typedef map<string,int> ms;
typedef map<char,int> mc;
#define py cout<<"YES\n";
#define pn cout<<"NO\n";
#define endl "\n";
#define all int i=0;i<n;i++
#define allj int j=0;j<n;j++
#define all1 int i=1;i<=n;i++
#define all1j int j=1;j<=n;j++
#define allm int i=0;i<m;i++
#define sorti(v) sort(v.begin(),v.end());
#define take int n;cin>>n;int a[n]; for(all){cin>>a[i];}
#define show(v) for(auto x:v){cout<<x<<" ";}cout<<endl;
#define mnv(v) *min_element(v.begin(), v.end());
#define mxv(v) *max_element(v.begin(), v.end());
#define rev(v) reverse(v.begin(), v.end());
const ll N=1e9+7; //largeprime
//ll N=998244353;
const ll NN=1e5+10;
const ll sis=2e5+7;

void solve(){
    int n; cin>>n;
    int a[n];
    for(all){
        cin>>a[i];
    }

    int shift[n]={0};
    int ans[n];
    for(int i=n-1;i>=1;i--){
        int ind=-1;
        for(int j=0;j<n;j++){
            if(a[j]==i){
                ind=j; break;
            }
        }
        ans[i]=(ind-shift[ind]+i)%i;
        for(int j=0;j<n;j++){
            shift[j]+=shift[ind]%i;
            shift[j]%=i;
        }

    }

    for(all){
        cout<<ans[i]<<" ";
    }
    cout<<endl;
}

int main(){
    ios::sync_with_stdio(0);
    cin.tie(0);
    int t; cin>>t;
    while(t--){
        solve();
    }
}


#include<iostream>

using namespace std;

int main()
{
	int ncol, nrow;
	cin>>ncol>>nrow;
	float mean[ncol];
	for(int i=0;i<ncol;i++)
		mean[i]=1000.0;
	int seen = 0;
	int good = 0;
	while(seen<nrow)
	{
		int row[ncol];
		int count = 0;
		for(int i=0;i<ncol;i++)
		{
			cin>>row[i];
			if(row[i]>10*mean[i])
				count++;			
		}
		if(count<ncol/3)
		{
			good++;
			for(int i=0;i<ncol;i++)
			{
				mean[i]=((mean[i]*(good-1))+row[i])/good;
				cout<<row[i]<<" ";
			}
			cout<<endl;
		}
		seen++;
	}
	return 0;
}

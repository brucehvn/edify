#### Passwords, etc.
The sensitive information about the AWS account, etc. is in a text file which is located in the encrypted zip called edify-info.zip.  The password for this zip will be sent to you via email.

#### Notes
Unfortunately, I was unable to satisfy all of the requirements for this test.

I do have the three peered VPCs working and have video to show pinging servers from all three AWS regions to the t2.micro servers in the other regions.  That entire part of the challenge was done via Terraform and the files are here in the terraform folder.

I was unable to get the EKS cluster to be publically available without being logged into AWS.  I thought it was working, but when I tried from a private browser window, I could no longer bring up the nginx deployment.

This means that I was also unable to contact the EKS cluster from the Ohio region.

The kubernetes dashboard is installed, but I was also unable to get that publically facing and working even after using a load balance to expose it.  I'm pretty sure it's related to my overall failure to get the EKS itself publically available.

### Verifications
#### Nginx installation
To verify the nginx installation, you need to use a browser after you've logged into the AWS console with the Administrator credentials.  Then you can point your browser to:
http://a595eea9e1f3e4281beea0fb443fa499-1007758848.us-west-2.elb.amazonaws.com

#### To verify the kubernetes dashboard requres using kubectl proxy.
After configuring kubectl to point to this installation, then run the command:
```
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
```
To obtain the token necessary for authentication. Copy the token from the terminal for use later.

Then run the command:
```
kubectl proxy
```
After that, you can run the following which will open your browser and give you the dashboard.
```
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#!/login
```
### In closing
This was my first exposure to EKS.  I've used Kubernetes in the past, but not through EKS where they seem to be imposing some IAM rules or something.  I'm sure I could figure it out if I spent some more time.

It was a fun and unique challenge overall and I thank you for the opportunity however things go.

Sincerely,
Bruce Hellstrom


# edify
Unfortunately, I was unable to satisfy all of the requirements for this test.

I do have the three peered VPCs working and have video to show pinging servers from all three AWS regions to the t2.micro servers in the other regions.  That entire part of the challenge was done via Terraform and the files are here in the terraform folder.

I was unable to get the EKS cluster to be publically available without being logged into AWS.  I thought it was working, but when I tried from a private browser window, I could no longer bring up the nginx deployment.

This means that I was also unable to contact the EKS cluster from the Ohio region.

The kubernetes dashboard is installed, but I was also unable to get that publically facing and working even after using a load balance to expose it.  I'm pretty sure it's related to my overall failure to get the EKS itself publically available.

This was my first exposure to EKS.  I've used Kubernetes in the past, but not through EKS where they seem to be imposing some IAM rules or something.  I'm sure I could figure it out if I spent some more time.

It was a fun and unique challenge overall and I thank you for the opportunity however things go.

Sincerely,
Bruce Hellstrom
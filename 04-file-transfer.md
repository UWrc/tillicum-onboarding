# Data Transfer: Moving Files To and From Tillicum

Efficient and reliable data transfer is a key part of working on Tillicum. There are two main ways to move files between your local computer and the cluster:

| Method                           | Best For                               | Notes                                                                            |
| -------------------------------- | -------------------------------------- | -------------------------------------------------------------------------------- |
| **`scp` (Secure Copy Protocol)** | Small to medium file transfers         | Simple and available by default on all systems                                   |
| **Globus**                       | Large datasets, unsupervised transfers | Automatically handles restarts and failures, ideal for long or complex transfers |

## Transfer Data with `scp`

`scp` (secure copy) works similarly to `ssh`—you’ll use your UW NetID credentials to securely copy data between your local machine and Tillicum.

**Pro Tip:** These commands must be run from your local terminal, not from inside Tillicum.

### Upload files from your local computer to Tillicum

```bash 
scp data_to_transfer UWNetID@tillicum.hyak.uw.edu:/gpfs/scrubbed/UWNetID
```
Above replace the word UWNetID with your UWNetID in the login and the path section of the command. 

### Download files from Tillicum to your local computer

```bash
scp UWNetID@tillicum.hyak.uw.edu:/gpfs/scrubbed/UWNetID/tillicum-onboarding/loop_script.sh .
```
The `.` at the end of the command tells `scp` to place the files in your current working directory or "here."

## Transfer Data with Globus

While `scp` is great for quick transfers, **Globus** is the best way to move large datasets reliably and automatically.

Globus provides:
* **Automatic checkpointing** – if your connection drops, transfers resume from where they left off
* **Integrity checks** – ensures every file arrives intact
* **Unsupervised transfers** – no need to stay connected while data moves

As of Fall 2025, Tillicum is available as a Globus collection for data transfer. Globus is available on Hyak Klone, Kopah, and UW OneDrive, allowing for seamless and high-speed data transfers to and from Tillicum.

## Sharing not Enabled
This service is still new to our environment, and we’re actively working to understand how Globus integrates with our current and future security posture. As a result, Globus public sharing is not yet enabled on `tillicum`, but we’ll provide updates as we continue evaluating and expanding its capabilities.

Globus public sharing is available with [**<ins>Kopah S3 storage</ins>**](https://hyak.uw.edu/docs/storage/gui#globus), which we recommend as a compliment for your research storage portfolio if you anticipate reuiring regular sharing and collaboration.

## Getting Started

1. Go to **<ins>https://www.globus.org</ins>** and Log In using University of Washington as your organization.

![Screenshot of globus.org showing the login button in the upper right corner.](/img/globus_login.png 'globus')

2. Sign in with your UW NetID and complete Duo 2FA.
3. Open the File Manager and search for the collection: **UW Hyak Tillicum**

![Screenshot showing how to search for the Tillicum endpoint.](/img/find_collection.png 'tillicum endpoint')

4. Bookmark this collection so you can easily access it later.

![Screenshot showing how to bookmark the Tillicum endpoint.](/img/bookmark.png 'bookmark')

The directory `/gpfs` will be the default path when you connect.

5. Navigate to your working directory by selecting `/gpfs/` by double clicking it, then selecting `scubbed/`, then your working directory, which should be you UWNetID, and then the git hub repository directory `tillicum-onboarding/`. 

![Screenshot showing the git hub repository directory and the Tillicum path on Globus.](/img/globus_path.png 'path')

This navigation can also be done by typing the path into the Path field, `/gpfs/scrubbed/UWNetID/tillicum-onboarding` after replacing the word UWNetID with your UW NetID. 

## Set Up Your Local Endpoint

To transfer data between your computer and Tillicum, you’ll need to install Globus Connect Personal:

1. [**<ins>Download Globus Connect Personal</ins>**](https://www.globus.org/globus-connect-personal) for your operating system.
2. Follow the on-screen setup to name your computer (e.g., User-MacBook-Pro or Lab-Desktop).
3. Once configured, your computer becomes a personal endpoint in Globus. You can find it by searching your chosen name under Collections.

![Screenshot showing the result of setting up Globus Connect Personal Properly.](/img/gcp_endpoint.png 'personal endpoint')

4. Bookmark your the collection representing your Globus Connect Personal for quick access later. 

## Practice Transfers

Globus has a two-pane view option which can allow you to see two collections in the same window and perform transfers between them. We’ll use the files in this training repository to practice moving data both ways.

1. In one panel of the Globus File Manager, open UW Hyak Tillicum.
2. In the other panel, open your personal endpoint (your local computer).

#### Try:
1. Transferring a file from **Tillicum → Local**. The image below shows the two pane view with Tillicum on the right and your local collection on the left. Select one of the files from the `tillicum-onboarding` repository to transfer and click start. You will see a green status box and detailed transfer steps can be viewed. A email will be sent to you when the transfer is completed. 

![Screenshot showing the 2-pane view set up with local and Tillicum collections, the button to start the transfer, the transfer status box, and the checkbox of file selected to transfer.](/img/transfer_to_local.png 'transfer')

2. Transferring a file from **Local → Tillicum**. Repeat the same steps but in the opposite direction. **Uncheck the file on the Tillicum side**, this is required to send files the other way. On the Local side, check the box next to any file and click start to begin the transfer to Tillicum. 

![Screenshot showing the 2-pane view set up with local and Tillicum collections, the button to start the transfer, the transfer status box, and the checkbox of file selected to transfer.](/img/transfer_from_local.png 'transfer again')

Globus will display progress in real time, and you’ll receive an email once the transfer is complete.

## OneDrive Connector (coming soon)

We’re excited to announce our Microsoft OneDrive connector for Globus, allowing you to move files directly between OneDrive and Tillicum.

💡 Did you know? UW community members receive 5 TB of storage on OneDrive as part of Microsoft 365. [**<ins>Learn more here.</ins>**](https://uwconnect.uw.edu/it?id=kb_article_view&sysparm_article=KB0034422)

**As of 10/9/2025, this feature is not yet in service.**

However, it will function the same way. Search for **UW OneDrive** and bookmark it for easy access.

![Screenshot showing the Uw OneDrive endpoint in Globus.](/img/onedrive_globus.png 'onedrive')

![Screenshot showing 2-pane view set up with OneDrive and Tillicum collections, the button to start the transfer, and the checkbox of file selected to transfer.](/img/onedrive_transfer.png 'onedrive')

Stay tuned for updates as this feature is finalized.


## Learn More

* Globus User Documentation [**<ins>Learn more here.</ins>**](https://docs.globus.org/?_gl=1*s0ry7u*_ga*MTE2MzI4NzMxNi4xNzQyMzQxMTg3*_ga_7ZB89HGG0P*MTc0NDA3MjY1Ny4xNy4xLjE3NDQwNzI2NTcuMC4wLjA.)
* [**<ins>Video Tutorial: Introduction to Globus for Researchers and New Users</ins>**](https://www.youtube.com/watch?v=-j7Mp3FN1zo&list=PLLCSx-IFoBeu2F-HF-DMoc5_AUsvYft8c&index=2)
* [**<ins>Video Tutorial: Globus Connect Personal Setup</ins>**](https://www.youtube.com/watch?v=bpnVcAN99WY). *Note: the Endpoints Menu Tool appears to be deprecated and now "Endpoint" and "Collection" are synonymous. Your personal endpoint can be found by searching Collections.*

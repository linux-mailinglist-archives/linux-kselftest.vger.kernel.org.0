Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5B175DE50
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 21:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjGVTiX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 15:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGVTiU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 15:38:20 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011013.outbound.protection.outlook.com [40.93.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0FA1729;
        Sat, 22 Jul 2023 12:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSdWTbIU6OHfMdQWixsSnrekBm/oeRtn1zhR4IU9zad2osmCbJ9fS44CFanog25qtezqL8uFQUnjlj9IzTe/URDmJHCj9z2VQHMaWYmgvxBYe8HFfhZ21Dm+6jhmiVhGRvJTRgG2omNpPiA6tSWmd4seKqbCQTiicUizlEmLNMkf77KJaiF+RG7PHinV7Mx+zP8wSiFxhFvj8QP3tT7wWvVR0bo14RxQ5Fl0M9mtEt7bAP8TU7A2rlKXH9ktNelykFwNefeDCHv82kR1Kdmet72Gr5cD6pZ2I4yOXsg+XL0/XU/uNO3Bu13Iu2HMhS6TyYp0AONb7yzERzfLXpEh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlOVHAEMMJ3T4ltouvj/h6bm6UkWmSFFTtpIqzlH/LE=;
 b=ib33VbQjdvwBqCq9l4oE3TH6S0E5TMnhHvg7M0Zhm8Jj0sCJVOpvK4EP9achYzGDn/89LgtbuPAU9Zep1h+qUpewqOCQWmcfHxy5dxKYv0+qjlNUY8r9yZ7HgihOkKKC3FuuMiyMQuneFySjGi15M6eGmDJwQ0j0y6o1GJdOCg8PKv/QVSVGzefQVUSG8sLgM1Xn9K9w90MnJEcSZ3RIblBeB1s3zNhTJU9QDlbb+VK3VbykrCWn7iJ4MKVnZYfZsIy9BlFQkiQxYNy9W9kXSB8LcPq5FqAOO4pdFZ2GBAoDl9BKUgr6/0QY0n6xLy2OCZsaV04D1C2DW+hkUB9udA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlOVHAEMMJ3T4ltouvj/h6bm6UkWmSFFTtpIqzlH/LE=;
 b=xlie9hCbBdIbAhmk5bFiU1vb9PZfneXw+NS1LphVNSTQklh6zGrMXMeIKaphMPkitcm0mYXKqd10C9aoSHwXz+FE6m20BTaGK1mCNq54ScANNANoq1q+Xxw/NJ/nJqYqEZ4nDpnSiYL9IHObQ6UlcQgcLzQoZuJksE3xGpPQO2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MN0PR05MB9005.namprd05.prod.outlook.com (2603:10b6:208:3cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sat, 22 Jul
 2023 19:38:14 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 19:38:13 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v5 07/10] eventfs: Implement functions to create files and dirs when accessed
Date:   Sun, 23 Jul 2023 01:07:02 +0530
Message-Id: <1690054625-31939-8-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690054625-31939-1-git-send-email-akaher@vmware.com>
References: <1690054625-31939-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::22) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|MN0PR05MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: d543070d-006a-4f31-d3e6-08db8aeb3067
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMH24bYDHZSk8VNSdKbfOWgxZGFPOwh2bMc5kSDfXX7xGA0kl2EkPFStL7tL1mdA4zZBVWNjow+rb7QMrG4G4UHtWQSBlTyFCOfrSxJ6gcwj4gNaUbanoUuEJapuhVbPZVhTUOShvu6uPhqXUhZmFsmYTpQraSq4rcl4hiyOAkvj74VF5+wIs/0ay6dp03xgx6OC9q0jYq/sXxicpuzULG+xguAr3AMvrnKJcoyg7Cm9WoXETaQoGSwheu+XPnvn/kslnq5muOSARifG5UD52W1PVOYRjzy904eXJ4ClVsME2cwIDDc2UxvrDYrXR3oNArmQ1V9EcgLTzLCTTZMJxJFYTLXW0jgsjGXBfn2+IWypy7sZ7ZR3nRlh6eb0dcoQ6aGlCB8JFRNKF8HTE9lanqMVHJhRpE743nzJYkOwj0wm9I55iBEfA83aYK0PUGfvGL3puIbOTYQeZkx4FQonjKe6p1kKKd747CnYbvQmYLnTjqDf60ebyccgzRKCpsYasi8EbT2JIrG16KREP/qZFdXX/X/M8v21unCikl93MnqUgeQ3posnr7kTHQwuuWamHO/RIsXrnbGc8iEfBfwxf7Arcfh5FVv7N3NUlhkfLNEytSyrMvEJ21+T0qBrro69Ias+WOgGzdyPpAGTrZ0DTlwoFcQqyLKirjgYHY2bjOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(6666004)(52116002)(6486002)(6512007)(478600001)(186003)(2616005)(6506007)(26005)(107886003)(2906002)(316002)(41300700001)(66946007)(66556008)(66476007)(4326008)(5660300002)(7416002)(8676002)(8936002)(38350700002)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pXr9ripU0ByShBwFuZRTeOOJDWiqRm85qZKsoTIIfT2CK9PFzMRSopGPVumr?=
 =?us-ascii?Q?Lrgg/bzTJgRlbGEWutrsadQ2Agai6etq2BFuMtNBitB6W3usckXX0AP8783Q?=
 =?us-ascii?Q?YaeFvcuN1jPmARnuTqgSOm7TjMv+jVidtYeoGPclIXRgxg3LfkAt414uW9Sx?=
 =?us-ascii?Q?k4dLlnU3tDpBPF6FKX1GkdUGnCpSB2eaT6tLacKLOQR9TUedJ+1XiwbEuezN?=
 =?us-ascii?Q?aYzyAlKZmNhKHEF5qcm4Z/w2Xi6xNTvQSrcPluVsVxqkfkYL2ruYwx6nssSK?=
 =?us-ascii?Q?I36uot87IpIAVoxshZwRqzhVXIZei9v/x8NbQnFyZrKn5zuFXIgefd/EEtm4?=
 =?us-ascii?Q?w+FPd2M4JEwEyKfJEZpJ+kFmswCvbaa1m3SLfj76uUMeO8UXxVRqT4vJPa7t?=
 =?us-ascii?Q?yxbFWyCtcoUcNA3uEpJJFu0wLgnCjAUoHAUpBdAq33xcfzFK2eufgwezQ2Wr?=
 =?us-ascii?Q?ISMk6FpUOHyTKzmplADSOUxiknrSt24FVjlCBwIrIYXewkgMIcpIROOh8zu8?=
 =?us-ascii?Q?8fjmT0pedCbaAP4O0N/Fxv5Y40jvBx/6n9H3a+W3m0bN71/hBybSHzkwxkgO?=
 =?us-ascii?Q?kfbqJOJuLy2vMjZbfgjYiUfe5WpicCbR2CSaKnxHe7PS+XCs/Ueh5trFgnZE?=
 =?us-ascii?Q?wohcftYZuyN6wBAZo87TpvDoqS6WTL1vVQ5KQE1cbvGI1TxucFW9Uld91CDr?=
 =?us-ascii?Q?6HM9Yt4KKEayMxjR1ivmFtcJLijRnzV62HQwUnfW93J7BqccmJtVd4rb9RR4?=
 =?us-ascii?Q?iBSgjtdB4AN/hkO36JZ3bDb/T23jR8w5w/pfg/+7fwRGpPKfOXFyE3zTDzwW?=
 =?us-ascii?Q?W6c+bsSBMSNVp/tQQx9OWXQrtx/X+vS19LmsgIlOGNOF/jZehymdBokPAg4H?=
 =?us-ascii?Q?js+nv4gAvc75mGB7WTZKS2/Fd4Ad9r2ls4z3G67PpS5UQdeKPxbb/+BlZPHS?=
 =?us-ascii?Q?wAsRcOrhS5S/So6tGNVK9WLQYxqH8uelSSIRl6CRkW0dst/TtuJOhxdW7t5o?=
 =?us-ascii?Q?Ocvn36+C3JR0VXoyHPW+aBJtJx39u5K8E0/iy5R7uwGe7/bDtVFlIS8Dsiw0?=
 =?us-ascii?Q?SNbSTT4FVzGCDl9RUdiFC96bHsNdktdl8ZXRuwLPChnTkOupkWn3N0Jed5Gh?=
 =?us-ascii?Q?Y7GcGTzQ8TMxnmHQn/s2Vpe+ELN64fO67MOdYCRtjcoBDZeStXx7KAtiGGtr?=
 =?us-ascii?Q?rfXjJj0s0XIdAWIkse3REugyryBHgVvHT9KJmXFxKo3wbvWuy0eN1bdWALtd?=
 =?us-ascii?Q?8rHtIO7dqmoxq7pIbRjuNSGmANb+lhZTHUkUk+onHIxydImVvsjzPyVYciMj?=
 =?us-ascii?Q?5kj9CCtpdYYAyXxe309R5rgLarI0untdjXoTTwN8ZrEXFc4/B4y+CCvpDu/H?=
 =?us-ascii?Q?f20Ax8cvLz8b9EOVM68qw3LedI/hLxKTTeesv4XHj+JgkPOcbX2mqoO08jSI?=
 =?us-ascii?Q?HJPgZ2w54swdj9CsTUoxhqi1WyxQ1eybnqmsyvRaFlv0MOA/rkJQ7FHjUUKE?=
 =?us-ascii?Q?M7iIQh/G5F/Xqhr0xs3xB86VrW/f5KartUmrVZRuec7Vm713TqGr0wFKHXyN?=
 =?us-ascii?Q?T2npOGAMqmvFeFecCADSgzdrFazauycBpsETsghQ?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d543070d-006a-4f31-d3e6-08db8aeb3067
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 19:38:13.8631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0kK1Df13LbMse67JzReL1rYxHM5qqWf2tjRsB7BnlGI5i7C2CxZXP0ZrnU08T5Dk/2Fsd9xhKJAbbwD+z9i+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR05MB9005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add create_file() and create_dir() functions to create the files and
directories respectively when they are accessed. The functions will be
called from the lookup operation of the inode_operations or from the open
function of file_operations.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/event_inode.c | 55 +++++++++++++++++++++++++++--
 fs/tracefs/inode.c       | 74 ++++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |  7 ++++
 3 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index a3c1b8bf7192..af70d6ffb923 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -101,7 +101,34 @@ static struct dentry *create_file(const char *name, umode_t mode,
 				  struct dentry *parent, void *data,
 				  const struct file_operations *fop)
 {
-	return NULL;
+	struct tracefs_inode *ti;
+	struct dentry *dentry;
+	struct inode *inode;
+
+	if (!(mode & S_IFMT))
+		mode |= S_IFREG;
+
+	if (WARN_ON_ONCE(!S_ISREG(mode)))
+		return NULL;
+
+	dentry = eventfs_start_creating(name, parent);
+
+	if (IS_ERR(dentry))
+		return dentry;
+
+	inode = tracefs_get_inode(dentry->d_sb);
+	if (unlikely(!inode))
+		return eventfs_failed_creating(dentry);
+
+	inode->i_mode = mode;
+	inode->i_fop = fop;
+	inode->i_private = data;
+
+	ti = get_tracefs(inode);
+	ti->flags |= TRACEFS_EVENT_INODE;
+	d_instantiate(dentry, inode);
+	fsnotify_create(dentry->d_parent->d_inode, dentry);
+	return eventfs_end_creating(dentry);
 };
 
 /**
@@ -123,7 +150,31 @@ static struct dentry *create_file(const char *name, umode_t mode,
  */
 static struct dentry *create_dir(const char *name, struct dentry *parent, void *data)
 {
-	return NULL;
+	struct tracefs_inode *ti;
+	struct dentry *dentry;
+	struct inode *inode;
+
+	dentry = eventfs_start_creating(name, parent);
+	if (IS_ERR(dentry))
+		return dentry;
+
+	inode = tracefs_get_inode(dentry->d_sb);
+	if (unlikely(!inode))
+		return eventfs_failed_creating(dentry);
+
+	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	inode->i_op = &eventfs_root_dir_inode_operations;
+	inode->i_fop = &eventfs_file_operations;
+	inode->i_private = data;
+
+	ti = get_tracefs(inode);
+	ti->flags |= TRACEFS_EVENT_INODE;
+
+	inc_nlink(inode);
+	d_instantiate(dentry, inode);
+	inc_nlink(dentry->d_parent->d_inode);
+	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
+	return eventfs_end_creating(dentry);
 }
 
 /**
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 4acc4b4dfd22..d9273066f25f 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -474,6 +474,80 @@ struct dentry *tracefs_end_creating(struct dentry *dentry)
 	return dentry;
 }
 
+/**
+ * eventfs_start_creating - start the process of creating a dentry
+ * @name: Name of the file created for the dentry
+ * @parent: The parent dentry where this dentry will be created
+ *
+ * This is a simple helper function for the dynamically created eventfs
+ * files. When the directory of the eventfs files are accessed, their
+ * dentries are created on the fly. This function is used to start that
+ * process.
+ */
+struct dentry *eventfs_start_creating(const char *name, struct dentry *parent)
+{
+	struct dentry *dentry;
+	int error;
+
+	error = simple_pin_fs(&trace_fs_type, &tracefs_mount,
+			      &tracefs_mount_count);
+	if (error)
+		return ERR_PTR(error);
+
+	/*
+	 * If the parent is not specified, we create it in the root.
+	 * We need the root dentry to do this, which is in the super
+	 * block. A pointer to that is in the struct vfsmount that we
+	 * have around.
+	 */
+	if (!parent)
+		parent = tracefs_mount->mnt_root;
+
+	if (unlikely(IS_DEADDIR(parent->d_inode)))
+		dentry = ERR_PTR(-ENOENT);
+	else
+		dentry = lookup_one_len(name, parent, strlen(name));
+
+	if (!IS_ERR(dentry) && dentry->d_inode) {
+		dput(dentry);
+		dentry = ERR_PTR(-EEXIST);
+	}
+
+	if (IS_ERR(dentry))
+		simple_release_fs(&tracefs_mount, &tracefs_mount_count);
+
+	return dentry;
+}
+
+/**
+ * eventfs_failed_creating - clean up a failed eventfs dentry creation
+ * @dentry: The dentry to clean up
+ *
+ * If after calling eventfs_start_creating(), a failure is detected, the
+ * resources created by eventfs_start_creating() needs to be cleaned up. In
+ * that case, this function should be called to perform that clean up.
+ */
+struct dentry *eventfs_failed_creating(struct dentry *dentry)
+{
+	dput(dentry);
+	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
+	return NULL;
+}
+
+/**
+ * eventfs_end_creating - Finish the process of creating a eventfs dentry
+ * @dentry: The dentry that has successfully been created.
+ *
+ * This function is currently just a place holder to match
+ * eventfs_start_creating(). In case any synchronization needs to be added,
+ * this function will be used to implement that without having to modify
+ * the callers of eventfs_start_creating().
+ */
+struct dentry *eventfs_end_creating(struct dentry *dentry)
+{
+	return dentry;
+}
+
 /**
  * tracefs_create_file - create a file in the tracefs filesystem
  * @name: a pointer to a string containing the name of the file to create.
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 54c9cbd0389b..cdb21d63a127 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -23,6 +23,13 @@ struct file_operations;
 
 struct eventfs_file;
 
+struct dentry *eventfs_start_creating(const char *name,
+				      struct dentry *parent);
+
+struct dentry *eventfs_failed_creating(struct dentry *dentry);
+
+struct dentry *eventfs_end_creating(struct dentry *dentry);
+
 struct dentry *eventfs_create_events_dir(const char *name,
 					 struct dentry *parent);
 
-- 
2.39.0


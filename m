Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A820767470
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 20:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbjG1SVq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 14:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbjG1SV0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 14:21:26 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012009.outbound.protection.outlook.com [40.93.200.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B704231;
        Fri, 28 Jul 2023 11:21:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjSmNbxJd1/uV17f/qI80Fxmw0uWfzafPTPFWFrXW365VZ4q/Bir+0jRQjHclkIyhXcpg/wtv+lKxnNnOMRHoX9o9CXxnAs5pbLEpBEk3eUz9yWFn8bbexghmKOEtLkoxJS2dBJFkiFaT6Dc+kp4ZZ+zS1fHKAZse6Y8jOUQcV3U0qrqhIuAoqvFuR38rFS14NcX7n6v+Qe9pcBct7g+iO04M4x1WeXYeJQYLdscyJTKYD6XVJA5WS3TJCqjYe1fVJ/aMbXXsoRs57u/Xxe2ft3miXWmmIFuw9UrxVO1Xe97wJyvRHnjnKHmozHaGx9A1aXtvhH/6AGJ69ph6a1O/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMrfZpD+/VgyMNu5S59jgiJp8+d66EeCuVSA16vQWxk=;
 b=jaFhkvXdT/cnHrhs8JjsuFklW/7QPIC4mwUCmYhxPNLl1mCGvfoainiEkvFXeaGSHAkggeYztD2IUAHzDUblDlBOofZ3bIlnqWe7r6UTEHkkDEDN7cfSBdZqrYXOzZ7+0HEn1DdSDX3+XkGQhvJV6LFIug4oHwoaMkzY5HXIGO5W5Dusr2ZTCeVZPo8TMnFIF2Ou4ZnAnqf39Ux6/3r1DJyDcZzA33i+MSlaOWrwU000Wx+AYSuox4+EnJt6FKzoFrDHPI2y0Tg8RzG0FZxodLJ1ol76bzXfj7ZUwk2zfNlcK15WN2dPZxjyX7h9AiXIvDIBJ6FwwUqvunIlX3UfWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMrfZpD+/VgyMNu5S59jgiJp8+d66EeCuVSA16vQWxk=;
 b=Kr7Qg8cUgCOWhnu2PmPdR53jFM+cpxg36VBzamkDvPLCa5xCnzBF1i4QqhiQG2F0LjypGcMwnytRB3jyb36XPARRerWYTkt+0MQvPMkD52ZRSAwXyKlxg4X1guHRhMn1zj+XT7JpOlwkKfcuY4N/6uO3iHKLx59Bn+nkRcvBdkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by SN7PR05MB9264.namprd05.prod.outlook.com (2603:10b6:806:26c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:21:22 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 18:21:22 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v6 05/10] eventfs: Implement eventfs file add functions
Date:   Fri, 28 Jul 2023 23:50:47 +0530
Message-Id: <1690568452-46553-6-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690568452-46553-1-git-send-email-akaher@vmware.com>
References: <1690568452-46553-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0090.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::31) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|SN7PR05MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: a45cb9d8-a454-47c0-6f33-08db8f977212
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w89hFYI3q5kzkGF6LiNSK+NXpCHQGQsnahK9vwRrQLHtILTKJrkOXM94PRLrBvwq90/FitAl8U/eH3//v2RnusOhleDI1tZVJWPLI4fG39fQ52EEYt/B2mgzc5rN7bf8AMa7X7IkAJlEzI16wOPTre9SjS0XgIKLhh/N/e9Rcz69RWWDHomHZPOp9DDzZi1RIhprCkvitvw+tKBe1HpKZLrLlPspBfLAdorHLO7p1FV2dtOl1Z1PS1N9jDA5o2AYJ7W8didzX8tEhCKKHZT3jtcBZR8cw/5oMr4sKnGvXmEM1Zx43rZTf0hANzgoX6jn9M/sSdLUIpRx46CF1r6OV4rhWWL+HgYKKb6AtDCSege2GvLVKB7otHLvzYiHtq2qaSoy5fsw7kbM9oXKsQlGCoFI/LRBow52hD/hoAEYd3yK4anXW/ggxCg/Q8NuyjfGQPpJ+0pKl2gRWL1g0c7lUTlc8D4QnBPLFS/Ba28xmVZ/O2bwJ9x7OeYGtu/UMBbphoTP6OqMIJzCJl2eLItQ1okLFgr2y5jUjtqsDa+hflmBL4nNMO+YcHZoDE8IRGCdIjYDo+1FWarELp7povO8g8eM8HR0T3mGtCLDMDIV0rg9WHO089BRO3rtYGy6LihevAaowvNONYGfU2r0k735XrqbptVbDVFSwdve2Jt9qAG/NekmtiW1fQ9LnxNZCCTDxWGyL904try38EzSUW6W9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199021)(2906002)(316002)(7416002)(8676002)(86362001)(8936002)(41300700001)(36756003)(6512007)(5660300002)(966005)(107886003)(26005)(6506007)(6666004)(6486002)(52116002)(83380400001)(478600001)(38350700002)(186003)(38100700002)(4326008)(66556008)(66946007)(66476007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?POepEnsqCFqrnOjejg5PsinHOt0W6p0oyTUWXLHmW6vW8R4uAUYvp/xMbI57?=
 =?us-ascii?Q?wjnNyQBPOAsbEJFy/p6m8j3raqQtjtbTfZr49jjbFX8NSklQoGU/aq0wzTgR?=
 =?us-ascii?Q?br6LJq8xhSZPS2/qbc73GjDtG20kuCwcDY9OkhE1Xb+CxHJdmuT8RCjcWw0J?=
 =?us-ascii?Q?30WaQmlWBwgih4mr4lab6A6j5P+zQpgsfd28T2FOxVfbDcwkvaGEecL0bpZB?=
 =?us-ascii?Q?HgtWHIOckteucbMJPGHy8+XOSGxTetFjwg7PrcY35WCqWaWTwovo30IgFrMG?=
 =?us-ascii?Q?/TQ/CBdSqNMtfUlueBB/Y9VBNXSRs54sNVzMTb0JKniJYAKb7FF4kbNTEqyo?=
 =?us-ascii?Q?J9AVhoo+MUo5oSmtrSswhVMWOJ5hLiVotj7h0Qt85Ccy9RN4R2sYf0G+D6LJ?=
 =?us-ascii?Q?J4LA4Qo44tZmaM4j0AtdcoA4fooEJHkC3UrKuNkPZnFlyweU+8uHVqtZMXGa?=
 =?us-ascii?Q?nA9GRjNKuKGTvByCD/6oMPQtNuTUAmgF56Td1afuSwS/ReGl+BcBNoxEnXSe?=
 =?us-ascii?Q?Whi8R9I/5aKHR6BwcifHxfAKKOFazrIKGaXLIpfefq+lcwTf1NSDMVbVSBWQ?=
 =?us-ascii?Q?Cx83EP8tSRGSwZZGuDvAE6nWGdorbvu+j2V6NKZaSExr6oXVz7CXTw4wAmiB?=
 =?us-ascii?Q?DmUyYgcw6yOSmRDcSiiyo/0x+nxrrb5hMiYhcn/g9rO9PGPfGfBs672RQoV8?=
 =?us-ascii?Q?F5uSMdjrYLabJpMhRl4pS7f0iOD3aGBqIs0zL5DTsTfD3ImrCKXJyy2urK8N?=
 =?us-ascii?Q?a5lTx9UDRAPZGkN2FF8pGX54chBpJl2lOu1739Rvdy2HRRQKIYfe2W0pJfxp?=
 =?us-ascii?Q?276SF1n8GQMgcir8uxNdSqUlmQEFJLvTW3dKRXQgUCAq5mkQqgp/KDBPTfCN?=
 =?us-ascii?Q?98OdetX4MSYIZUztqgCK/Ym7a5Y2d3gOFMC0Ttu8K11Sqz231Xipqs22TUZ6?=
 =?us-ascii?Q?wUtLZ3bjbWzNd7psB6Jh2t76Zla+u2joV5oLbyd3vw7YbYY0y6oqwUfszXma?=
 =?us-ascii?Q?6ME9oT2eKKQsHXseuoM6Wk82Q8VD3zGDqUkjo+HniRBdNxVEUpnM/eBhBZ6q?=
 =?us-ascii?Q?XiZd3Jil7v3vEZycZJPZ4/yHbpUe3hCDQ2a+O3FiwbPyZQJj9BQyCKxdx+1l?=
 =?us-ascii?Q?B+M/XYA/XsKB070d7Z6K/dfmJEbAYEfCFr7X5ekRQEtyA81MVewE4wD9Iyul?=
 =?us-ascii?Q?dCH7+9uZ0ywwCoptZtnLDxTf+ZJ5fM6gDDLehQqSqOThYwj1efmBSvLdd/kz?=
 =?us-ascii?Q?MYExPTNv8en8VmNlWeb71ZLzxfPfB2d3U9i2acXKY0zjDbZ56iLyOVKg5eCn?=
 =?us-ascii?Q?4e/FQvbRar3O2NZYpKfe1UxgvfovgkzKpnm+TM+hMoYbkp/sEifuQ/KNkE+7?=
 =?us-ascii?Q?nwd4zzrxkIO72o/eLpmMynRYZRwkxVltCYLkjNe8S8vtfcdvufM+BhoR8KWO?=
 =?us-ascii?Q?KA/rMbrPy9HVQ5GKQcPEfJWbYtPA9yHa2pGD6o9HXVfymm2olm211OHCohWz?=
 =?us-ascii?Q?s3R1TSofIQEuxI1DSjJTX/ra+rr8skJxL8rfwqL6xPaAMllqMpazsYkQOs1j?=
 =?us-ascii?Q?WqDKrVxA7rtTbY4r33TywbvaqPprbLQoDyD1Ga+u?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45cb9d8-a454-47c0-6f33-08db8f977212
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:21:22.1401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOxc26G07v7y9WjvQQ2BWt8gGkN1s/oAwaMIWbvUG6mEL2PFsnOOirGH+a31IOs9sE/wqbYiyhsL8MSwgNkPrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR05MB9264
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the following functions to add files to evenfs:

eventfs_add_events_file() to add the data needed to create a specific file
located at the top level events directory. The dentry/inode will be
created when the events directory is scanned.

eventfs_add_file() to add the data needed for files within the directories
below the top level events directory. The dentry/inode of the file will be
created when the directory that the file is in is scanned.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202305051619.9a469a9a-yujie.liu@intel.com
---
 fs/tracefs/event_inode.c | 86 ++++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |  8 ++++
 2 files changed, 94 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 8f334b122e46..9e4843be9dc9 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -209,3 +209,89 @@ struct eventfs_file *eventfs_add_dir(const char *name,
 	mutex_unlock(&eventfs_mutex);
 	return ef;
 }
+
+/**
+ * eventfs_add_events_file - add the data needed to create a file for later reference
+ * @name: the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @parent: parent dentry for this file.
+ * @data: something that the caller will want to get to later on.
+ * @fop: struct file_operations that should be used for this file.
+ *
+ * This function is used to add the information needed to create a
+ * dentry/inode within the top level events directory. The file created
+ * will have the @mode permissions. The @data will be used to fill the
+ * inode.i_private when the open() call is done. The dentry and inodes are
+ * all created when they are referenced, and removed when they are no
+ * longer referenced.
+ */
+int eventfs_add_events_file(const char *name, umode_t mode,
+			 struct dentry *parent, void *data,
+			 const struct file_operations *fop)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+
+	if (!parent)
+		return -EINVAL;
+
+	if (!(mode & S_IFMT))
+		mode |= S_IFREG;
+
+	if (!parent->d_inode)
+		return -EINVAL;
+
+	ti = get_tracefs(parent->d_inode);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return -EINVAL;
+
+	ei = ti->private;
+	ef = eventfs_prepare_ef(name, mode, fop, NULL, data);
+
+	if (IS_ERR(ef))
+		return -ENOMEM;
+
+	mutex_lock(&eventfs_mutex);
+	list_add_tail(&ef->list, &ei->e_top_files);
+	mutex_unlock(&eventfs_mutex);
+	return 0;
+}
+
+/**
+ * eventfs_add_file - add eventfs file to list to create later
+ * @name: the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @ef_parent: parent eventfs_file for this file.
+ * @data: something that the caller will want to get to later on.
+ * @fop: struct file_operations that should be used for this file.
+ *
+ * This function is used to add the information needed to create a
+ * file within a subdirectory of the events directory. The file created
+ * will have the @mode permissions. The @data will be used to fill the
+ * inode.i_private when the open() call is done. The dentry and inodes are
+ * all created when they are referenced, and removed when they are no
+ * longer referenced.
+ */
+int eventfs_add_file(const char *name, umode_t mode,
+		     struct eventfs_file *ef_parent,
+		     void *data,
+		     const struct file_operations *fop)
+{
+	struct eventfs_file *ef;
+
+	if (!ef_parent)
+		return -EINVAL;
+
+	if (!(mode & S_IFMT))
+		mode |= S_IFREG;
+
+	ef = eventfs_prepare_ef(name, mode, fop, NULL, data);
+	if (IS_ERR(ef))
+		return -ENOMEM;
+
+	mutex_lock(&eventfs_mutex);
+	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
+	mutex_unlock(&eventfs_mutex);
+	return 0;
+}
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 432e5e6f7901..54c9cbd0389b 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -32,6 +32,14 @@ struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
 struct eventfs_file *eventfs_add_dir(const char *name,
 				     struct eventfs_file *ef_parent);
 
+int eventfs_add_file(const char *name, umode_t mode,
+		     struct eventfs_file *ef_parent, void *data,
+		     const struct file_operations *fops);
+
+int eventfs_add_events_file(const char *name, umode_t mode,
+			 struct dentry *parent, void *data,
+			 const struct file_operations *fops);
+
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
-- 
2.39.0


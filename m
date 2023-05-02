Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFF36F42B0
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 13:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbjEBLYm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 07:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjEBLYj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 07:24:39 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013011.outbound.protection.outlook.com [52.101.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04F859F3;
        Tue,  2 May 2023 04:24:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcPSRmRxRyltqxg32BYv9bN6EzceINDbdlipm4xz1r+A7SpRjh45lv8arUJXfJTFBruN0d0pNG3wwX7QdbPfYbchZcD/4eGYRa81vnZDbyAj8M+tES3KBNnF239m+2lZ8yY7ObDyMkZVd9VM9exTY2tlZh5tcSk6+v/XhG8uR3o80JFTDujHkvaI0rOOntNxjDpMUmaefuZ5+j6f2aNW9GZiNhu+91UFtxo+1J34ic8xa1tCNyWLxmX2jvMLFN8JURJLI+vWO9/mb8DsfmGGfBaVrQWDDnTewfhHkXFDsLjJC8+tq0wWV7+A1cfBj2bcXiW17cURnGmUeRoWAS7adA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tb0M5jJA1d2NZBOTyENLsWq2jwdjAnZmR28h8eWoMl4=;
 b=jY46pK742t3yBJyCjZdffIgwABXyyHTRkufDr6BDOTsnd4PQldJxf9YGFGbZb63+PilgkLIw/I/1UbRj3uv/Xoq0jInG1v/1REK07Vtq3v2jJrzgu4KglcYcaCP7zPxSCvA273QnhiaSTPTjezdYkNFJA31Y1lPb3M7YGLoSaugRQKkXwBoKeodRMKezZVnVbN86cCU/wLmyP+1uh+bI3QM/UxzUqc3VS/rSvyhFbMghQQQzd6QD/k3RkT+R4CMUlIAFqiVrhRCrnxEwKu425jjO8mR2lqgJPOmWU95nWhqSkmZdCl/6askVf23GWGP0KO6YxHjZhPz6cQ78hXuSXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb0M5jJA1d2NZBOTyENLsWq2jwdjAnZmR28h8eWoMl4=;
 b=0uk1YJtAW7la0jFLBGoemXvLb0DYYdJ+ssc+QV0rIf6eCH8FblEL2UF8lQQFww22oyC+OdfuWxK88TNfav/NsjnTmWtI+kOU4+Yr97p6t2H/W02/odE2nxNUXlF3VYR4HaOOKvvwcuKB8+2iTtTW5hg/vfIVWJmlRQaLUjzK6AM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by BYAPR05MB6648.namprd05.prod.outlook.com (2603:10b6:a03:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 11:24:17 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%7]) with mapi id 15.20.6363.020; Tue, 2 May 2023
 11:24:17 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com, Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v2 2/9] eventfs: adding eventfs dir add functions
Date:   Tue,  2 May 2023 16:53:13 +0530
Message-Id: <1683026600-13485-3-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1683026600-13485-1-git-send-email-akaher@vmware.com>
References: <1683026600-13485-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0101.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::42) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|BYAPR05MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d1098e-2944-4931-edd9-08db4affc3ce
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qHj3FuXhgDi2gwWoZ2pDQi/0Eksezxs9ayHG/9wPbQ8Jlix67HVk6+9jt1dx82qqe1RpFYTWfdXESIlJn3MqVY28ISR074stxamF/fiP+EroD/Di8PrkC2ZyFDtgF6IOvziihOfuOGyfheA2BFagFXkb0mOurDcdnjDUUke7Q/dCfWwFi30doGrKTayeWruYmr/6/likE8idIhCXd/Q2m2hLahrsp6NqoKkEWijf26gG2MSaCzojBGTzfHL2pwXG321jgUk7H796+AMaXHgfZbTWD6A0w7nMKuBOb4NhvhRq+H0pi7gCQZIcqNRC4FdTic4vPBw+IvO2cAkwGbpt+jj03zF3O/X7Swvuh/H0MYEekbSYc6sYvFJ+P5hTUS1/z9LVW62WWT92NbvEHEm9Jb9o3KOcTfQgt5bnJyPBOGDPLGj4FTkpWGm8ctoacH/M+x/33mSZSoyRAPuGuYvx9an48jt1ZgOL+Zdbmy7Fkif73wk1M/y5Vr76hLjcIc+pEJDLxBwaTOZWROXu2/0qmAi6ysxvoHGqTd8KdWUz80F/ZaIolg3sJLFT09bj+jpHQFEJb41AuvssQk396UIhbrFhiRK1+OtC0VzfI24SeaCFGJT43yP4o+pHgblqEAzU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(6486002)(6666004)(52116002)(107886003)(38100700002)(38350700002)(2906002)(30864003)(86362001)(41300700001)(66946007)(66556008)(66476007)(4326008)(478600001)(316002)(5660300002)(8676002)(8936002)(36756003)(6506007)(26005)(6512007)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NS3oFz0Vxp6P0kEl6s/g8DEMGl5EvFndBQtRmfODo7xjWbhknpxWnGTaR7zA?=
 =?us-ascii?Q?EVOKeuLi7v6LqZplPasRaKTZixIC8/NMimohUDg5i2Uh4/Lf0Aa1YM58tn2c?=
 =?us-ascii?Q?Kl3EPX4wPZbgJDdl0nICN/cNY7UjyDcAs4/1BPNuysQuq2ENYRi9JOB4WKsm?=
 =?us-ascii?Q?k2qqHhNvbPcKObBU+hlCGmubqhKQ2lFumxyZoU7BjWX5z69ZqDBUrkb0GRW/?=
 =?us-ascii?Q?dubstxj4OZWJHY3hzVgDyIoqnGonSj5W9pTRJg1tQkp17xBwiY7H5XdODkYa?=
 =?us-ascii?Q?+qTAJg7VQJVgkW4iufsovV4uIP7hxrYecZT/xabSKBqGhgv5ARD7hhii1269?=
 =?us-ascii?Q?OqP3CMqup3iayEpvoA2+nlukKaKB4JZgu6bJAD4aCPZOj9Bz/Ch+551asgCy?=
 =?us-ascii?Q?OdYBmcsk3hOkffE/TaVBJcxjwaIppscRX8qD1a+9gnp/MyeNTK9q83LgyNJu?=
 =?us-ascii?Q?53gLmhL5QWXAv9k5lr6q+hGxjRQQfBV06nLgJ4ZP/I5zccG26wCDqCc4mRys?=
 =?us-ascii?Q?gXohWjN1Ulg8tqDME2Sg+siZvVCbyUcCXHHbFLlRWqCUpiDXfFcwcQeQcj8T?=
 =?us-ascii?Q?mohAQ34ZhSE8Srnh9T6INN+EFkW2HPO+IhAPn2zYUZOyxPe/vkeMK2LL4TGF?=
 =?us-ascii?Q?afWBWqx9/i2/2NQcjrmx4ev2SG4ZBzPZAdjxeFOiVPzd1rd7vLrKCWgGm1VW?=
 =?us-ascii?Q?U5m21Gq068LRQFhxdLoPAEhO95CehKhFKnlf8aJbKc1niegRNk+Ugi5rTHk3?=
 =?us-ascii?Q?xSGFtJ0FiiPphVvsV4uQaOGC0990c85pPkVkSz2xma3xoiUaQznxcdBd/huA?=
 =?us-ascii?Q?dGVX+Cl5CiieXHnO2o26daEHmi3Vk9M/kwkpXoLKKuZdM38i1KM0WododwTM?=
 =?us-ascii?Q?UxC7XnfZvxMgFtqhdVH3J3ZIfvHtV82WevekhxFH2yPGaz/06RRbeOHItKMf?=
 =?us-ascii?Q?ruRJhlxwC8d+UisfmngPs6ymqfVLra9K9aCKbYXVRa1SX5pvrG3s9hTBmvi8?=
 =?us-ascii?Q?18dsLaMHUUeev++vhAF+ftkjWe5x5lr+h6g/kCtZfwlc27tHcJ/Hzzc6hJOV?=
 =?us-ascii?Q?GbZuPNStXcIEEV+SQStoX0hbBxH2BIk6fAaMrIWCmsgAadTft2ZrbXFxlJIH?=
 =?us-ascii?Q?lWUKjA4cYMtKxuKeqbt5+I+fGpq7ac1XWFKbh9hLwIq0b7r6EghbhKzX7Zrd?=
 =?us-ascii?Q?I0oPEib2LFw6UJas1mxul+lDn53U7iTYzYkEDCGoPKqU+CbmF9YeNSFj+I/9?=
 =?us-ascii?Q?2oOw9JVzeXrC4xR+C9av7Dxx9stWS3iiGUNDYfCA42h9a9yZ8NrF989BoBsX?=
 =?us-ascii?Q?k/E5MZQY9t3XOjCwmLpkebHl7NMsWbAtNWTLckqSETWIzfPtF0AFNfXl5xGT?=
 =?us-ascii?Q?omyTRmiDDSRVpLSRTkvuAPSt3a9f7PMA0UPTzIxjR9ibTZ4PXXkq82U6M1JZ?=
 =?us-ascii?Q?reMpz+RYtyUGSPvd5XhYstjMwDJHD7QJxHHZ0IMdfkDURdfYqYRYlvpaxET3?=
 =?us-ascii?Q?YSZx8y5fEvCu3OcKbLQvSxWcpO3KJqmeGABOEXrKBADuYXz6bFlXvak/hOPb?=
 =?us-ascii?Q?VtHdHSOjexBlhD5szvlEHiEcLnSziVoN1dAqH8cd?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d1098e-2944-4931-edd9-08db4affc3ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 11:24:17.1260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/w6GVHIO9fKL04VoDqD2ktUmxIyCWl2peqa/3k/3vQEjgIT/cy/6W5fuD/lm5VoxXf1PLlMn8iQhudr+Ul6RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6648
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adding eventfs_file structure which will hold properties of file or dir.

Adding following functions to add dir in eventfs:

eventfs_create_events_dir() will directly create events dir with-in
tracing folder.

eventfs_add_subsystem_dir() will adds the info of subsystem_dir to
eventfs and dynamically create subsystem_dir as and when requires.

eventfs_add_dir() will add the info of dir (which is with-in
subsystem_dir) to eventfs and dynamically create these dir as
and when requires.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/Makefile      |   1 +
 fs/tracefs/event_inode.c | 252 +++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |  29 +++++
 kernel/trace/trace.h     |   1 +
 4 files changed, 283 insertions(+)
 create mode 100644 fs/tracefs/event_inode.c

diff --git a/fs/tracefs/Makefile b/fs/tracefs/Makefile
index 7c35a282b..73c56da8e 100644
--- a/fs/tracefs/Makefile
+++ b/fs/tracefs/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 tracefs-objs	:= inode.o
+tracefs-objs	+= event_inode.o
 
 obj-$(CONFIG_TRACING)	+= tracefs.o
 
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
new file mode 100644
index 000000000..82caba7e9
--- /dev/null
+++ b/fs/tracefs/event_inode.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  event_inode.c - part of tracefs, a pseudo file system for activating tracing
+ *
+ *  Copyright (C) 2020-22 VMware Inc, author: Steven Rostedt (VMware) <rostedt@goodmis.org>
+ *  Copyright (C) 2020-22 VMware Inc, author: Ajay Kaher <akaher@vmware.com>
+ *
+ *  eventfs is used to show trace events with one set of dentries
+ *
+ *  eventfs stores meta-data of files/dirs and skip to create object of
+ *  inodes/dentries. As and when requires, eventfs will create the
+ *  inodes/dentries for only required files/directories. Also eventfs
+ *  would delete the inodes/dentries once no more requires but preserve
+ *  the meta data.
+ */
+#include <linux/fsnotify.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/security.h>
+#include <linux/tracefs.h>
+#include <linux/kref.h>
+#include <linux/delay.h>
+#include "internal.h"
+
+/**
+ * eventfs_dentry_to_rwsem - Return corresponding eventfs_rwsem
+ * @dentry: a pointer to dentry
+ *
+ * helper function to return crossponding eventfs_rwsem for given dentry
+ */
+static struct rw_semaphore *eventfs_dentry_to_rwsem(struct dentry *dentry)
+{
+	if (S_ISDIR(dentry->d_inode->i_mode))
+		return (struct rw_semaphore *)dentry->d_inode->i_private;
+	else
+		return (struct rw_semaphore *)dentry->d_parent->d_inode->i_private;
+}
+
+/**
+ * eventfs_down_read - acquire read lock function
+ * @eventfs_rwsem: a pointer to rw_semaphore
+ *
+ * helper function to perform read lock, skip locking if caller task already
+ * own the lock. read lock requires for lookup(), release() and these also
+ * called with-in open(), remove() which already hold the read/write lock.
+ */
+static void eventfs_down_read(struct rw_semaphore *eventfs_rwsem)
+{
+	down_read_nested(eventfs_rwsem, SINGLE_DEPTH_NESTING);
+}
+
+/**
+ * eventfs_up_read - release read lock function
+ * @eventfs_rwsem: a pointer to rw_semaphore
+ *
+ * helper function to release eventfs_rwsem lock if locked
+ */
+static void eventfs_up_read(struct rw_semaphore *eventfs_rwsem)
+{
+	up_read(eventfs_rwsem);
+}
+
+/**
+ * eventfs_down_write - acquire write lock function
+ * @eventfs_rwsem: a pointer to rw_semaphore
+ *
+ * helper function to perform write lock on eventfs_rwsem
+ */
+static void eventfs_down_write(struct rw_semaphore *eventfs_rwsem)
+{
+	while (!down_write_trylock(eventfs_rwsem))
+		msleep(10);
+}
+
+/**
+ * eventfs_up_write - release write lock function
+ * @eventfs_rwsem: a pointer to rw_semaphore
+ *
+ * helper function to perform write lock on eventfs_rwsem
+ */
+static void eventfs_up_write(struct rw_semaphore *eventfs_rwsem)
+{
+	up_write(eventfs_rwsem);
+}
+
+static const struct file_operations eventfs_file_operations = {
+};
+
+static const struct inode_operations eventfs_root_dir_inode_operations = {
+};
+
+/**
+ * eventfs_create_events_dir - create the trace event structure
+ * @name: a pointer to a string containing the name of the directory to
+ *        create.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is NULL, then the
+ *          directory will be created in the root of the tracefs filesystem.
+ * @eventfs_rwsem: a pointer to rw_semaphore
+ *
+ * This function creates the top of the trace event directory.
+ */
+struct dentry *eventfs_create_events_dir(const char *name,
+					 struct dentry *parent,
+					 struct rw_semaphore *eventfs_rwsem)
+{
+	struct dentry *dentry = tracefs_start_creating(name, parent);
+	struct eventfs_inode *ei;
+	struct tracefs_inode *ti;
+	struct inode *inode;
+
+	if (IS_ERR(dentry))
+		return dentry;
+
+	ei = kzalloc(sizeof(*ei), GFP_KERNEL);
+	if (!ei)
+		return ERR_PTR(-ENOMEM);
+	inode = tracefs_get_inode(dentry->d_sb);
+	if (unlikely(!inode)) {
+		kfree(ei);
+		tracefs_failed_creating(dentry);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	init_rwsem(eventfs_rwsem);
+	INIT_LIST_HEAD(&ei->e_top_files);
+
+	ti = get_tracefs(inode);
+	ti->flags |= TRACEFS_EVENT_INODE;
+	ti->private = ei;
+
+	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	inode->i_op = &eventfs_root_dir_inode_operations;
+	inode->i_fop = &eventfs_file_operations;
+	inode->i_private = eventfs_rwsem;
+
+	/* directory inodes start off with i_nlink == 2 (for "." entry) */
+	inc_nlink(inode);
+	d_instantiate(dentry, inode);
+	inc_nlink(dentry->d_parent->d_inode);
+	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
+	return tracefs_end_creating(dentry);
+}
+
+/**
+ * eventfs_add_subsystem_dir - add eventfs subsystem_dir to list to create later
+ * @name: a pointer to a string containing the name of the file to create.
+ * @parent: a pointer to the parent dentry for this dir.
+ * @eventfs_rwsem: a pointer to rw_semaphore
+ *
+ * This function adds eventfs subsystem dir to list.
+ * And all these dirs are created on the fly when they are looked up,
+ * and the dentry and inodes will be removed when they are done.
+ */
+struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
+					       struct dentry *parent,
+					       struct rw_semaphore *eventfs_rwsem)
+{
+	struct tracefs_inode *ti_parent;
+	struct eventfs_inode *ei_parent;
+	struct eventfs_file *ef;
+
+	if (!parent)
+		return ERR_PTR(-EINVAL);
+
+	ti_parent = get_tracefs(parent->d_inode);
+	ei_parent = ti_parent->private;
+
+	ef = kzalloc(sizeof(*ef), GFP_KERNEL);
+	if (!ef)
+		return ERR_PTR(-ENOMEM);
+
+	ef->ei = kzalloc(sizeof(*ef->ei), GFP_KERNEL);
+	if (!ef->ei) {
+		kfree(ef);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	INIT_LIST_HEAD(&ef->ei->e_top_files);
+
+	ef->name = kstrdup(name, GFP_KERNEL);
+	if (!ef->name) {
+		kfree(ef->ei);
+		kfree(ef);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ef->mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	ef->iop = &eventfs_root_dir_inode_operations;
+	ef->fop =  &eventfs_file_operations;
+	ef->dentry = NULL;
+	ef->created = false;
+	ef->d_parent = parent;
+	ef->data = eventfs_rwsem;
+
+	eventfs_down_write(eventfs_rwsem);
+	list_add_tail(&ef->list, &ei_parent->e_top_files);
+	eventfs_up_write(eventfs_rwsem);
+	return ef;
+}
+
+/**
+ * eventfs_add_dir - add eventfs dir to list to create later
+ * @name: a pointer to a string containing the name of the file to create.
+ * @ef_parent: a pointer to the parent eventfs_file for this dir.
+ * @eventfs_rwsem: a pointer to rw_semaphore
+ *
+ * This function adds eventfs dir to list.
+ * And all these dirs are created on the fly when they are looked up,
+ * and the dentry and inodes will be removed when they are done.
+ */
+struct eventfs_file *eventfs_add_dir(const char *name,
+				     struct eventfs_file *ef_parent,
+				     struct rw_semaphore *eventfs_rwsem)
+{
+	struct eventfs_file *ef;
+
+	if (!ef_parent)
+		return ERR_PTR(-EINVAL);
+
+	ef = kzalloc(sizeof(*ef), GFP_KERNEL);
+	if (!ef)
+		return ERR_PTR(-ENOMEM);
+
+	ef->ei = kzalloc(sizeof(*ef->ei), GFP_KERNEL);
+	if (!ef->ei) {
+		kfree(ef);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	INIT_LIST_HEAD(&ef->ei->e_top_files);
+
+	ef->name = kstrdup(name, GFP_KERNEL);
+	if (!ef->name) {
+		kfree(ef->ei);
+		kfree(ef);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ef->mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	ef->iop = &eventfs_root_dir_inode_operations;
+	ef->fop =  &eventfs_file_operations;
+	ef->created = false;
+	ef->dentry = NULL;
+	ef->d_parent = NULL;
+	ef->data = eventfs_rwsem;
+
+	eventfs_down_write(eventfs_rwsem);
+	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
+	eventfs_up_write(eventfs_rwsem);
+	return ef;
+}
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 999124459..aeca6761f 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -21,6 +21,35 @@ struct file_operations;
 
 #ifdef CONFIG_TRACING
 
+struct eventfs_inode {
+	struct list_head		e_top_files;
+};
+
+struct eventfs_file {
+	const char                      *name;
+	struct dentry                   *d_parent;
+	struct dentry                   *dentry;
+	struct list_head                list;
+	struct eventfs_inode            *ei;
+	const struct file_operations    *fop;
+	const struct inode_operations   *iop;
+	void                            *data;
+	umode_t                         mode;
+	bool                            created;
+};
+
+struct dentry *eventfs_create_events_dir(const char *name,
+					 struct dentry *parent,
+					 struct rw_semaphore *eventfs_rwsem);
+
+struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
+					       struct dentry *parent,
+					       struct rw_semaphore *eventfs_rwsem);
+
+struct eventfs_file *eventfs_add_dir(const char *name,
+				     struct eventfs_file *ef_parent,
+				     struct rw_semaphore *eventfs_rwsem);
+
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 616e1aa1c..3726725c8 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -359,6 +359,7 @@ struct trace_array {
 	struct dentry		*options;
 	struct dentry		*percpu_dir;
 	struct dentry		*event_dir;
+	struct rw_semaphore     eventfs_rwsem;
 	struct trace_options	*topts;
 	struct list_head	systems;
 	struct list_head	events;
-- 
2.39.0


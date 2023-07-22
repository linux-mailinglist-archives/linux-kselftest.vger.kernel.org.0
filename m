Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8F275DE4B
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 21:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjGVTiU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 15:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGVTiP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 15:38:15 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011013.outbound.protection.outlook.com [40.93.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04226E71;
        Sat, 22 Jul 2023 12:38:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGq4EtVvodlCjdk7/OcQ2L5eWFoj+fFBinql67BAhBMBRNlcAgl2XGiJe0K8RWEYCpp3nNcIB55s80REnLyN/jdn9AM9U1NbA0a+cPLW3YGuTguyrXMmmPK4deScLcC2T+2C/v126dC4YtqLEoOeVktWvhf0T1aCqf5Yan6E1eUK/YuSgfzN5Vb23U0MpB6JyHL73+PGFNtoXdLKg+RiuVgcNAuNaN2Ytq7Ien228yoVKOkvhBK5MIIu1MG5uCThA8UVxbbc76qfQ5VbIBUOszsrHPbcNbLFmoBSy6REixMyKRswA2Imf2e0iZyQ3Qn3C+mGFXz/SGaiIuRtvK4ECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCnnF7HmCpcAVudvYD3EPZkeHtk9ADrdcpxVzKWR6Rw=;
 b=WBUPr9IJkQ6hvXxlS1StBg5+CmrCZmIZP7fI0TV/JrffU6aSFo5BIa9kk3Kj7DTNgeRwNtK4bTkxflXJIqEzyaKvSb/pFKWsmaH5GY/55lJB1n7EzA5+J2JBhiHK3Lo9ofbdUGZ6b7UD2fcpIUacff/OMHxwZ9tuWJ8jal+8Vrxdk7Sj/mU37HI0xtpgII8uGqpwjLSmBpVW/hUkrYe/pI1SEoilRBXETr2750Wd0G9PuKYFTnsa6BY/P+gRoHpglgXOJAnvAe1kftgoH6AI1qAJmhscDcYCsjiADz7Lo1w3Y8IIJsOHm3uLEutJGtv74r/dlaCe83tm7TX720gUbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCnnF7HmCpcAVudvYD3EPZkeHtk9ADrdcpxVzKWR6Rw=;
 b=BMZUs5G5soCNfLV7cDgMceE7h1IGy4b469cWJ1pIiTWvgTcaSRBC4O45BNX+4Irof/hWuS6b2ZM+eBDPdGZtjCL2xSxXnS9dp8tfTJ92RBY0Wmn/QyDf72V9BtT441DLvZ4XwoxwN702QwaxPveKZ9N8lIQgoofS1ijcRwYcQ+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MN0PR05MB9005.namprd05.prod.outlook.com (2603:10b6:208:3cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sat, 22 Jul
 2023 19:38:10 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 19:38:10 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v5 04/10] eventfs: Implement eventfs dir creation functions
Date:   Sun, 23 Jul 2023 01:06:59 +0530
Message-Id: <1690054625-31939-5-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11e4a7df-895b-435f-1bae-08db8aeb2e4d
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7sO6ROECXKYAWGghfzJewykb51rAx0ZfNs1JCH5opV+4K9cyYMFX5yJWW2AEhL1SaLS8VX+7voKfR51jBG6BZMhLU2JQhGMBX5Pt5jjIDkxW6pbj99oNWL2c8fFZCpDuPSIldv/5ezKsaJWsln8CjDS1kS6LDux9TL+dnGB5MpnBFM14WeQUR4dKBsW5F/Dlqk3BWFuvq8MylEoSPM+Kl2JcnS3GFl9FEZ/rr11IgMJZZKhywc4QKsPfgPmBPm6at30Tfe253wbnd7/zru/2RjxTVeBG4m+Ld+U/5DCZwis9HKebZxGgebNKE93UA12SeAAspWrHxLtrOrYHba/5/oiOlm0Aap92AxGuLJBiAw0xeSHdJ65dkTGQnZrYE6KsXiXV0ppKlHkbo76a7gO0sKEd6sXnqZAlUVmVl8yqVA4hmKaTz2vk9YnKl8PWs5bglB+ch1pxa/V8gLDSauIp7LjsBVzd0uEhZ49wj2t2hY+3b9IZA6hs7MJ0LVUwgRRdpkzZjwUDb1isoqU2ooM/5XeOXLF5n/u330flOJ8y0/2qW5WsKgi8yTmEd7xcjAagu/RYZw5f/k2vxpSMOZ68yqiGo/soiPbUVHkl/ANrEzN0qlSAJ4hmWiQF6q3LnQfPs69g269bXRFb8Si0zAJluC06776qU11QIPy0fFO5Ly2gTvFr6f80PbTsbFEbVUmG63y7gTEzmyaUs6VH4bB8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(6666004)(966005)(52116002)(6486002)(6512007)(478600001)(186003)(2616005)(6506007)(26005)(107886003)(2906002)(316002)(41300700001)(66946007)(66556008)(66476007)(4326008)(5660300002)(7416002)(8676002)(8936002)(38350700002)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NKbqaIsTIIUD3XUNGVCLyrPrkkE/pK+b0oTnSsJIYrVPTHKcXyzGiLNyzhkD?=
 =?us-ascii?Q?6Wh+hpe5Nj2HmS30/g/Z8v30tRGm3Y8u8UNmgV1lIF4li5qjUp5vKegmMoPb?=
 =?us-ascii?Q?CMEiwyvU4eLgi/WhlQjbx5HuQSIqbxNF1Hb4JatcCpmayquwNOknRjD6gpcg?=
 =?us-ascii?Q?P1lsfILFN3yayu4eEqQSBu6jMEv73RevwbDGdQ3pTW8Wp3BdmSN58o2VF/OD?=
 =?us-ascii?Q?46POu1+5ncQwe9Ef7cQXeghz9+z78UGOvOhoV2cVgt6zRxpQkQvDhcFwQh8d?=
 =?us-ascii?Q?3wXRrDyEIFjOP88Fe6a1UNKFSjMHZ4AnuIXTER+Gx00A6GpgOd1sszP+OSo8?=
 =?us-ascii?Q?A/PuOElm36t/ltg+HME2HMbuCzn36qOQI8Ilj1bfCwRDMICuotV52q1/0Rtw?=
 =?us-ascii?Q?otlxacINSuaYUUgz9HqrF0aP8CjBYYqPaZVCpeOvfx0osSSETluDaJk62oDy?=
 =?us-ascii?Q?e8am1vc6nPCZqlDEHAwwxo4UtRP/XrveexhXObV/bAJZXCEqvsVigOInX/8R?=
 =?us-ascii?Q?TOt4vuJ1arWQWDP46YuntSuBW8nzguhQdB3nkjruuUcK51V2xEV//CVygTVA?=
 =?us-ascii?Q?GNc7uPHwvwxAPAd3QbS4LCvbUAYkWJ4Fj2ohiOQMVXunPDlFkTPT7v4iopHY?=
 =?us-ascii?Q?Ryav95HWSMHLiUV74legnDxdbuCBKAOGoIj05XMHWxX8hnPdbjSZgd7YiBEK?=
 =?us-ascii?Q?uj36qZt2/CnbZ7W+NpksVkD87L2jzpzh5z1hlDiTd1DO5hDBEyslH6WDNbNh?=
 =?us-ascii?Q?AkQ8S5JwzS3mSnFxMnjTkWBiRPnRkbMMsocqs1v3j7kGCKyUokljqr9u2ZEt?=
 =?us-ascii?Q?gLfEgwhoL1jq1H+LUYYJZEPSscsnCpkKFyTZ84cFXAwnOV4jIAHYmmJwZIp5?=
 =?us-ascii?Q?bE3aE5XfEXKQdhPqeNpujoWPlz6EsIGeTfUZa+pXxa9XxaavJlo2KQ3EYxDx?=
 =?us-ascii?Q?5/oZc5cPbj1B5Ltw3CoDXjQhej97OfOj8m695xohjEyAjlevDa+8g9LbrQ79?=
 =?us-ascii?Q?SuLqbouZkWAXyfgUKxnbCPC7+mR8dnoGm0yUX5Nv6cN7BaWwHWzYoGzOeIuT?=
 =?us-ascii?Q?pfpNVy1CWtbiR9hmkDJn70jYabZY6czJrG/T0nMSi4NgOXLURTvdOF8ie1y/?=
 =?us-ascii?Q?TAeceiTySakHChVa30EunA9mmfJzdYabuC/3iPhgio55yihteTfycbZ/OUa7?=
 =?us-ascii?Q?IO8Xvby7K/Rmxc+JUJl7vDuUNHY+w4ffjkwR2XyjAHrDYna6LH8doQgbCQLD?=
 =?us-ascii?Q?baUBcf7uyImID4vGPt5nWGQQrEttRZxk12C6HbAZ8WeIxA3ceFHBn7jIpzei?=
 =?us-ascii?Q?T6OwmI9a+lG+C20Yn+sVrPBuZpaYzvcldccVcFz8bVpLSlMNjVcGipavmtUj?=
 =?us-ascii?Q?OnsoPm82P0hx7YTRd8fpSA+CHEm/i4qorJdTSqdFz4HQKtPPTEtuRTkf21FI?=
 =?us-ascii?Q?dgXhnctgon1ZPNd2krNOduk3WKbYTIlkoPPuAEwcehBjdjjf03CWPnWfKIQ/?=
 =?us-ascii?Q?kV4TdQamxLjGISr+YWZKxWyTWTsDv6FOObUFCQxNikHklqsZnTUcoNY2AP/3?=
 =?us-ascii?Q?bmURstFeyAr08wqgD/BC8BQnvqbyIermw1eWLHlm?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e4a7df-895b-435f-1bae-08db8aeb2e4d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 19:38:10.3699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZRd06B/1ANclkOmvymm3ud9pyCYqyVfIVuY029oXr6pmTCbc8wE6xF8mxlsLJwbsqahl84MwZsl8qp5z35whA==
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

Add eventfs_file structure which will hold the properties of the eventfs
files and directories.

Add following functions to create the directories in eventfs:

eventfs_create_events_dir() will create the top level "events" directory
within the tracefs file system.

eventfs_add_subsystem_dir() creates an eventfs_file descriptor with the
given name of the subsystem.

eventfs_add_dir() creates an eventfs_file descriptor with the given name of
the directory and attached to a eventfs_file of a subsystem.

Add tracefs_inode structure to hold the inodes, flags and pointers to
private data used by eventfs.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202305051619.9a469a9a-yujie.liu@intel.com
---
 fs/tracefs/Makefile      |   1 +
 fs/tracefs/event_inode.c | 211 +++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |  11 ++
 3 files changed, 223 insertions(+)
 create mode 100644 fs/tracefs/event_inode.c

diff --git a/fs/tracefs/Makefile b/fs/tracefs/Makefile
index 7c35a282b484..73c56da8e284 100644
--- a/fs/tracefs/Makefile
+++ b/fs/tracefs/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 tracefs-objs	:= inode.o
+tracefs-objs	+= event_inode.o
 
 obj-$(CONFIG_TRACING)	+= tracefs.o
 
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
new file mode 100644
index 000000000000..8f334b122e46
--- /dev/null
+++ b/fs/tracefs/event_inode.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  event_inode.c - part of tracefs, a pseudo file system for activating tracing
+ *
+ *  Copyright (C) 2020-23 VMware Inc, author: Steven Rostedt (VMware) <rostedt@goodmis.org>
+ *  Copyright (C) 2020-23 VMware Inc, author: Ajay Kaher <akaher@vmware.com>
+ *
+ *  eventfs is used to dynamically create inodes and dentries based on the
+ *  meta data provided by the tracing system.
+ *
+ *  eventfs stores the meta-data of files/dirs and holds off on creating
+ *  inodes/dentries of the files. When accessed, the eventfs will create the
+ *  inodes/dentries in a just-in-time (JIT) manner. The eventfs will clean up
+ *  and delete the inodes/dentries when they are no longer referenced.
+ */
+#include <linux/fsnotify.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/workqueue.h>
+#include <linux/security.h>
+#include <linux/tracefs.h>
+#include <linux/kref.h>
+#include <linux/delay.h>
+#include "internal.h"
+
+struct eventfs_inode {
+	struct list_head	e_top_files;
+};
+
+/**
+ * struct eventfs_file - hold the properties of the eventfs files and
+ *                       directories.
+ * @name:	the name of the file or directory to create
+ * @list:	file or directory to be added to parent directory
+ * @ei:		list of files and directories within directory
+ * @fop:	file_operations for file or directory
+ * @iop:	inode_operations for file or directory
+ * @data:	something that the caller will want to get to later on
+ * @mode:	the permission that the file or directory should have
+ */
+struct eventfs_file {
+	const char			*name;
+	struct list_head		list;
+	struct eventfs_inode		*ei;
+	const struct file_operations	*fop;
+	const struct inode_operations	*iop;
+	void				*data;
+	umode_t				mode;
+};
+
+static DEFINE_MUTEX(eventfs_mutex);
+
+static const struct inode_operations eventfs_root_dir_inode_operations = {
+};
+
+static const struct file_operations eventfs_file_operations = {
+};
+
+/**
+ * eventfs_prepare_ef - helper function to prepare eventfs_file
+ * @name: the name of the file/directory to create.
+ * @mode: the permission that the file should have.
+ * @fop: struct file_operations that should be used for this file/directory.
+ * @iop: struct inode_operations that should be used for this file/directory.
+ * @data: something that the caller will want to get to later on. The
+ *        inode.i_private pointer will point to this value on the open() call.
+ *
+ * This function allocates and fills the eventfs_file structure.
+ */
+static struct eventfs_file *eventfs_prepare_ef(const char *name, umode_t mode,
+					const struct file_operations *fop,
+					const struct inode_operations *iop,
+					void *data)
+{
+	struct eventfs_file *ef;
+
+	ef = kzalloc(sizeof(*ef), GFP_KERNEL);
+	if (!ef)
+		return ERR_PTR(-ENOMEM);
+
+	ef->name = kstrdup(name, GFP_KERNEL);
+	if (!ef->name) {
+		kfree(ef);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	if (S_ISDIR(mode)) {
+		ef->ei = kzalloc(sizeof(*ef->ei), GFP_KERNEL);
+		if (!ef->ei) {
+			kfree(ef->name);
+			kfree(ef);
+			return ERR_PTR(-ENOMEM);
+		}
+		INIT_LIST_HEAD(&ef->ei->e_top_files);
+	} else {
+		ef->ei = NULL;
+	}
+
+	ef->iop = iop;
+	ef->fop = fop;
+	ef->mode = mode;
+	ef->data = data;
+	return ef;
+}
+
+/**
+ * eventfs_create_events_dir - create the trace event structure
+ * @name: the name of the directory to create.
+ * @parent: parent dentry for this file.  This should be a directory dentry
+ *          if set.  If this parameter is NULL, then the directory will be
+ *          created in the root of the tracefs filesystem.
+ *
+ * This function creates the top of the trace event directory.
+ */
+struct dentry *eventfs_create_events_dir(const char *name,
+					 struct dentry *parent)
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
+	INIT_LIST_HEAD(&ei->e_top_files);
+
+	ti = get_tracefs(inode);
+	ti->flags |= TRACEFS_EVENT_INODE;
+	ti->private = ei;
+
+	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	inode->i_op = &eventfs_root_dir_inode_operations;
+	inode->i_fop = &eventfs_file_operations;
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
+ * @name: the name of the file to create.
+ * @parent: parent dentry for this dir.
+ *
+ * This function adds eventfs subsystem dir to list.
+ * And all these dirs are created on the fly when they are looked up,
+ * and the dentry and inodes will be removed when they are done.
+ */
+struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
+					       struct dentry *parent)
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
+	ef = eventfs_prepare_ef(name, S_IFDIR, NULL, NULL, NULL);
+	if (IS_ERR(ef))
+		return ef;
+
+	mutex_lock(&eventfs_mutex);
+	list_add_tail(&ef->list, &ei_parent->e_top_files);
+	mutex_unlock(&eventfs_mutex);
+	return ef;
+}
+
+/**
+ * eventfs_add_dir - add eventfs dir to list to create later
+ * @name: the name of the file to create.
+ * @ef_parent: parent eventfs_file for this dir.
+ *
+ * This function adds eventfs dir to list.
+ * And all these dirs are created on the fly when they are looked up,
+ * and the dentry and inodes will be removed when they are done.
+ */
+struct eventfs_file *eventfs_add_dir(const char *name,
+				     struct eventfs_file *ef_parent)
+{
+	struct eventfs_file *ef;
+
+	if (!ef_parent)
+		return ERR_PTR(-EINVAL);
+
+	ef = eventfs_prepare_ef(name, S_IFDIR, NULL, NULL, NULL);
+	if (IS_ERR(ef))
+		return ef;
+
+	mutex_lock(&eventfs_mutex);
+	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
+	mutex_unlock(&eventfs_mutex);
+	return ef;
+}
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 99912445974c..432e5e6f7901 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -21,6 +21,17 @@ struct file_operations;
 
 #ifdef CONFIG_TRACING
 
+struct eventfs_file;
+
+struct dentry *eventfs_create_events_dir(const char *name,
+					 struct dentry *parent);
+
+struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
+					       struct dentry *parent);
+
+struct eventfs_file *eventfs_add_dir(const char *name,
+				     struct eventfs_file *ef_parent);
+
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
-- 
2.39.0


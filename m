Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1966076746A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 20:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbjG1SV2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 14:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbjG1SVZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 14:21:25 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012009.outbound.protection.outlook.com [40.93.200.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53C9422A;
        Fri, 28 Jul 2023 11:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAbCn5x4cxl9ahUDoklJ/nVln2T2hokyHmSUBv/dZYP60YSkBjWDZbSZGMF53kbtBv7IcJY3aoTbiehnvs9brwUfmUbondmbhL/Grpz3k2eXUJzEpQFql7/scExiH+iaJWbq4WhfDTqV26r7E9klVtqFnT3uJilparEqxOemQ27VGuMimuNqUsxcpNXZhGV9MeNzGafxy59iwGeX7gQqslay81UUtOvaqqfFVTvFYNkja9ZC58c6Ww+iK9Yhor0T9gDeYYsGliaH6bbRrGmDkgjkltvQZUmKng7a9F+DxhhAkwSdc45oP1JA5KDWoGI3k77sAAL5/Z50x6f9DtRryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDvwg1P4xmQElgMzF3qShwdTNxBZYbqmBfS4jTzgkyI=;
 b=WU2Pcc3FNIKdEhKFsz0482ykID+pDbDZFCtKJhcK5ozY9oeOfcT4/PahjLd2VGhuP6n/t2pAaK8ZK0/Achwlu6G1Ri1lQ5tFaMVc8ditSQHNBeaaxszrm7XtEJcOfCD/5xZdQ+umMgMS5gbm5XN6Nc62ruZp6f0LBGyjC6U2AC+U7CV+5P/8TjHTAY6iD/H5IZ14k0MQI8lCeqfQZ7ug7B2Quee2FoTWv9tnGMCkKtX+zkzl7qaZ13zfCn6zhKoEkutaQOLjmKwWj4ZGnOt0wOpWUX2H8vBAZJpL65CNZten+JUlE0Tz6B5xDScbA2nstzPRv2uhIsxB3UZBWVdCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDvwg1P4xmQElgMzF3qShwdTNxBZYbqmBfS4jTzgkyI=;
 b=QDtrTegGEq5HK4aCaMsu32D5VS5SEEDPTGRazmHe7bjHvKP3xH07oOoQBbdfNWrBJ6Gp5VahWgztkCsC7O3dNUMRZwg8erhRjjN/h5AtGpx50SRPmwCPmgF5klG76Ku+S8pEJbLWS8f9l30dKHEZYpgiDJfpybPqeOxbKVIgKOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by SN7PR05MB9264.namprd05.prod.outlook.com (2603:10b6:806:26c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:21:21 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 18:21:21 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v6 04/10] eventfs: Implement eventfs dir creation functions
Date:   Fri, 28 Jul 2023 23:50:46 +0530
Message-Id: <1690568452-46553-5-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 924ed8dc-6989-4012-f484-08db8f97716d
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B62boKZSBGYM1u0UehmQC+FAzeFkaQUTOACtIF9igRduVS3akKk1lQgY/lzF/7BjwjIMcLaGc0oxfwVdJYLwNQTn17010KL+Uj15xyjH+AbvvripzGsh3Xb7pVCHDYHw6RDnEnwfcDmAMdAMTseaB8GNvapwTgKVOq6aoyjrEaRANmU6+9upoCps9pVDH3RMuqPJD2fjtPr8+6EjNFZebGoaimGcyK5hP90+m9NqA6dbVPMY7uiLRWTyJdkTcI88eTR/5g4fllbyIquiw/N6Xy/0/QxYbnpc0WAsm2aM2XXCcfWC8ZvSzdqlOl/9a1SnOExATvLWX2t1jzE6penHU1TYQtVoLMGeXl8TfYWYUdXP+bhNiQmFdhsbWtZSX6P+EVzDkGo9RLp+yDBob9pPV8LawCJ6aUfFONOcKqW2vvbXPn6v1yP7D1nMl4ABDNlsMi+Ty+Ca9XtIGd1qa78FNo3Q1AyhZ+5ozlEosUiKBzhvGplbNop0DtwW34ffHoszYZehypxcgzG6IY5lvbS1HstF3j7LHRsCSmUVLXagl/rVXvrVMVYdt2q1JTTewsessBoIrDhIc6RRdt6cTn48z8WXCgPGUUAa/8o0Z0qz/tgYnv2RRa4qYP0qudv6nKOmRYJ9VOAL57SYfHBdb39oiYRCTEluNtONf83euCuIXqjOe8bq+aeS7JollblvbnnJmWaFbmMX49XzXXfYF6F1ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199021)(2906002)(316002)(7416002)(8676002)(86362001)(8936002)(41300700001)(36756003)(6512007)(5660300002)(966005)(107886003)(26005)(6506007)(6666004)(6486002)(52116002)(83380400001)(478600001)(38350700002)(186003)(38100700002)(4326008)(66556008)(66946007)(66476007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GJtRE3avbmPr7rFo+ARLsEdcoBAp7QBqMs0aBU//lVLHt8nMvpBWPPDZXhot?=
 =?us-ascii?Q?cqr/CFNfarEVh8Y7pyeO6qZj5RdMHfvPSWFdVJofuKOJxOzWqChfeeQmFfvU?=
 =?us-ascii?Q?qVwWhMlt57pmqbpqupPGkWolvWWgo0s40R5woKy0tzI6hVxocaR0Nl3hTRuX?=
 =?us-ascii?Q?gXmhuW4EcGZzIKvSmKNcXHt4HCOcMymstJDo2DgyjAxRNYUPPbmK9oqfeonC?=
 =?us-ascii?Q?1YnfxiEa6O7HaC4YEO/rxnCR1MKTHoyOIMrOVFHR+aWJSkzE5gd5MYIyo76+?=
 =?us-ascii?Q?TnW+/RW1NARnZ3dx37vu7YlRQngktPe8KS2gC0jM1f6ExlzeCcP0U7lulDNT?=
 =?us-ascii?Q?/gCQG5qGphOxHuOiGiPR6YPPZxVAon0Jg/V5T+7aagVz9ebzQdQWoEYPTscJ?=
 =?us-ascii?Q?Cees8WWrqL/TmaT7g76/FAVdfka6cQ3XKcjdZ33O/ABEob2OPzTUk39tomlA?=
 =?us-ascii?Q?gLpwKdBas8EjL0C36QHPS5JC1K0YhKLg1K4K0XlNtoAKgXEWyiYQp6sECKAX?=
 =?us-ascii?Q?YpjNxYrP+/P7D8OgSVKVXN9HFSd1Y5X60qMqaBdJ9rdlGxQnTM9q0lisSGFX?=
 =?us-ascii?Q?DiowhhI1GwQ97AKZ/D//uMwxHU4Kj7+D99bVhKhCvWsVSR43s9c+biVHVweH?=
 =?us-ascii?Q?iJrmieM94HqTf/5cxadTVbIzy6QQJikR1JpNRohgGsygK4gedOHlfGPYJLOi?=
 =?us-ascii?Q?50jqBji16LBxVuOMFekwOC/xXqfJXqxYInwX5udmfv+UKgYYFN7MskByHZBd?=
 =?us-ascii?Q?RCYQsQdUjX9qDFYEO5AmONSMK6Ou0af/cmWj1zSYRwzpJ+90c3XmF8gizrr+?=
 =?us-ascii?Q?9JoIiPlF/TU+wlZlPoFb6/SQA9RfQeejW5b93mu2V7Spa630xsvy7cBf+jlc?=
 =?us-ascii?Q?HGojST9sr/F/9g9ZKGUrr1iXSvqk+acIYqdaSHZyB/PdiYwDUAa6K3A+zyIq?=
 =?us-ascii?Q?yeptF/gwNIa9qZqW+tXx47D8anIcKBoJV6PQGy3oBHyeZnCVXBtI5OaJF74r?=
 =?us-ascii?Q?qTPtnuzjSOa0FtZyVFMXGtFlBNQxvpgNhrkmt8Anz+ixSNtrbn3zHd7+Y4qo?=
 =?us-ascii?Q?iKU7lby7pUbwAXZKNIkiNjOyMEWbYjO4mmuAMtSzFpw94e24kWR+sp9pPDH6?=
 =?us-ascii?Q?9QUlrV5XtphdmBPp/QM+3PPMRm3NNCrMfbkj8Tynl0E4IQ9UAuIa2UnW67Qn?=
 =?us-ascii?Q?oRWIPDBuOnsJ4cr+nT0Sgnr36++bgpMdTfq0e2HGE+AoOwsF88JMFjTvk1W8?=
 =?us-ascii?Q?CcDcv2ad1PcvnMIhAMUPEw+/keNDG5oyEaRCu1mwJ+slR2eraMCS5XroUiS6?=
 =?us-ascii?Q?QYx5GslEnMGQWMxjyS4sqRqQVfbqJZZpGB5KbzDg4uzH0OijGp8X7CJupBc9?=
 =?us-ascii?Q?0bCfPv5Dl40hTlL7uwXSq2lyBnuw5qiJPIB+5sg9m+kJ84V1e7Qneh+mkNrF?=
 =?us-ascii?Q?dJx2dS6dCpsLzyHt06Hk/PAE+sOqjr0WCo6axjPNMVkqf5UTr206P+uxcCyJ?=
 =?us-ascii?Q?PmxgivC9qFfOboIIfj+y7h+qv9ghgTQJ13bw+R6GiKQvzikVdoppvqxgBM5Z?=
 =?us-ascii?Q?Fy/K6w8PmTdLTVEyf6h0VZIpzJmUIXGmQoBGqbhT?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 924ed8dc-6989-4012-f484-08db8f97716d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:21:21.0476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OLh2rceS+0LIrdUzdyaTHYS9fVbxoERGnRsMsceA8QKAN/sq2MruZP9LC++5NrM8kUbeI60EUbbqVfSG5T3fQ==
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
 fs/tracefs/internal.h    |   4 +
 include/linux/tracefs.h  |  11 ++
 4 files changed, 227 insertions(+)
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
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 7dfb7ebc1c3f..f0fd565d59ec 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -2,6 +2,10 @@
 #ifndef _TRACEFS_INTERNAL_H
 #define _TRACEFS_INTERNAL_H
 
+enum {
+	TRACEFS_EVENT_INODE     = BIT(1),
+};
+
 struct tracefs_inode {
 	unsigned long           flags;
 	void                    *private;
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


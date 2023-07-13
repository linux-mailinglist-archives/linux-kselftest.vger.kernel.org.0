Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A31751FF8
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 13:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjGMLeI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 07:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbjGMLeH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 07:34:07 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011008.outbound.protection.outlook.com [40.93.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11801E5C;
        Thu, 13 Jul 2023 04:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxVFleAajR14KtR7DwEFEP7gZzglNqMYjC0OBtHpNkUYH5eQamyqem5ko2SgcFEoVfLpkjouCaTm1V2yOT5vCFuz5qTHWXH/3YPhVRHm9og/9fLxA1arDo16vYF2e/heaYbUVZvAjozNOHOfvVbuuW5MkwsTqAhnWq+SOsK9VFSe0LUWMQ6IIe1pKIf1OglKFDWUDeoeL8H3T8gsmjK9xWjHt+d2R3rBdMRB9n8I4MASFaW6VDKU8QF5s9zOCx7WPtAvY/H2AVcdhjOi3LSWsxw5sdeXw0KW0f3MXe1nmIwmw0vj9QaDHxOjF1/lysI1Mhdbly14tJpI1SLhWsb8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsAuxbg+1+SENfvEaP6JfB4b4cPJP/4miM6CPc202ZI=;
 b=gP6KVN3WGhfsExC97JWionPqI8NwkBolTCXG6q7WH9X3lOvzFXZ+lVCFTF+3BT/0GQiFbol9fMqkvavAKV4hgwlUiYDGYD1Gqwev4yuav0oLvAp1N0oCeLaCClVKtA72fJeah7n49pyXPKt5GqI/mEC02PTVz79jbGG1A5FxnodqMxGN0iDQpLyxRfdV+VEfhjjUPtfIvl0ch/JIsAhzKthNgPiBYMQO310AC/qVmE6zPcdNVPtkhHfVaN17xnQgEwEA+52Mu8xR2rZz0eAdrfGzWRXMgcVr5Tw7gTWs36JXgff6+T/zLq18XgbnaCs29Kne8F7ljnEITj8wkOe6JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsAuxbg+1+SENfvEaP6JfB4b4cPJP/4miM6CPc202ZI=;
 b=AJRLpBozuKxT20xPQxv8qVuh6Z/d5teLrEbFYvnuowuXAZz6e1hmXI1SJ/lr99J0JHEWEPDz//vwv+PsFRJkRFCQvPXLjTJuA166W4LKIcajQ+95x80JITFWH1cSDEu7tWxDRNY6lnUGGLBx9U5f+3MPIVzkBca+HVX6euacfPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by PH0PR05MB8719.namprd05.prod.outlook.com (2603:10b6:510:b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 11:33:59 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 11:33:59 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v4 03/10] eventfs: Implement eventfs dir creation functions
Date:   Thu, 13 Jul 2023 17:03:17 +0530
Message-Id: <1689248004-8158-4-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689248004-8158-1-git-send-email-akaher@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|PH0PR05MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: db33943c-4cbb-4747-ba95-08db83950cc3
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tUTSzQGyD+/M+1vSNP0Agc+8lftN/iWJA7HtHDQNPyQt2+BrAjT2BUMwKkCecH+NICbCpctGaK9/051EDQJMrorTJo+JPzE5c+lL7V3Jh4lC6j82imLsFSv+df5zpnxbnSuWgktyEDvavo/KKB92sClEdmFKlLGsOAcciifUk+PHaOE2/3r6b6BX51eOYxrcWTes7IJ3hWsv9MxrI6lns9j74YsP7twq5SIWE5PAf1VwNg+LgjBsbr1rtDbWTb/jkOyoDgAN+bAjcg1qru15FYlL4M91Z1oLwGiBVyXJZw9biP1cRakvU23xJNoF0qR1F2shvz1IqSyLhBMTG7IzRzi1fd5jg4I5nXfUywJGN+zryTlYk6uTfc423/Yyc8xqVSAIf2DqZEzpY23AHejql0cX2onWNc1P1zOR92rWcT69M9BKBvg2wP4CZxZQrtAipLtl8/vn5r5dTGyCmfTnETywcekZFZEt7bLkTM5lkeQNQQogcNs0+7bnfv+WerRWdm8ZM6to4zpIL44q/tuXbtwHyunOHgIPVDTqeNw9MahfPKTO/r4Hd6UYg2PT0AxTxEUwcYuwGO1IDHtwQgKVczwizvDg9MoDtatQ5qC7nYWOGs9TX+wuzJbymp2jWGTgbj7gr7r/+myw/3BE8ulZpoLSNWQK+1xKm5MmTLhCrzu+YvdJh3AsGmmt3gz0MmxVcwoJxx15dnOb2YGtYhwbag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(41300700001)(2616005)(83380400001)(7416002)(30864003)(2906002)(186003)(36756003)(5660300002)(26005)(38350700002)(8676002)(8936002)(107886003)(316002)(6506007)(66556008)(66476007)(38100700002)(4326008)(966005)(66946007)(52116002)(6486002)(86362001)(6512007)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HlpRmZIJjfFrA5iCtdoZwRNJeB6V3wwDgixbcpvdVRNNPXQf8Ssus/bNtbj3?=
 =?us-ascii?Q?GKKy7StQAZ2w0NkCiwkG2lXex408Au7mUVCGaehEaC/jJ0AG3d74xHJL7vWO?=
 =?us-ascii?Q?pJZCaDkAJ38V9AZqiy/d4LKbarX9fEVTwwgf4bUX+VdGC1iselvVGVvWdTsa?=
 =?us-ascii?Q?SwanNTVBLs91qAdzQ+4MLHlaoslvxD6/5/dj4S/ecNjBC8wlMctgaO/LKDjV?=
 =?us-ascii?Q?QGF8fnf7lPA2O/srSJHAki2jCaSqV+Nkpx9I4SYrIgyhJZcbWPb1H2J/3Tp8?=
 =?us-ascii?Q?p4Q80RnXQQCq55doDbJEcY6I4nf8tIlx0SCpbgDzNojXwYq4wk5dIGcLyHa1?=
 =?us-ascii?Q?rfA7d+SPMn+PQNF8hu5SMSeTDPNkjvS3o6bHiv/ACxoZuYHLb6EFxNPsy0Sd?=
 =?us-ascii?Q?gU6nlXEx0xkwarnuskLLbo7W/Ya3HKB8+xIl+26eKgJBL19womdh1rPD8Z9w?=
 =?us-ascii?Q?GJ2WKYvAVb4bTYcUi8UrPcffatm9Lwp1Kl7ChygjipLzd+68Gi2K2diaIx5N?=
 =?us-ascii?Q?tB/d+T8jOkxmWtfypO8T7FeHsn0UP9av9NuAXu8n2AtS+XKKFO884Jq3+tCn?=
 =?us-ascii?Q?l6PbsYgyVea6ieOQye929d0JjtP2hN1BOb6R6IMvEPkroY3WYACmsIt1q81n?=
 =?us-ascii?Q?cOcT+LrGeungbTEozAoeXxAxwOY/1Py+VVEpIXZ3Zs5G/inV3rwS9M3qpz9W?=
 =?us-ascii?Q?9zNTF/5W0Ke2vvBwfDNlBQVyFcxxBOEqSRf4MdsDX958QpD2xaoJs7NQNk49?=
 =?us-ascii?Q?OPj3RIKsKrGONNWOr1i7+ae0YFR4TGqueUEl3/af30O7Da+xpMm1KEKSEf++?=
 =?us-ascii?Q?kaNH6t+ilbrr7N77L+X2jIwBTs2cFEWifViuVpfU3/s77fdHfqNh0olx1wH6?=
 =?us-ascii?Q?k/WSHj1LXlSDSvKK5y3MvmY2HXDKLH8UZ+eHmrKARMtUEa4DcfOFd+4BYzZE?=
 =?us-ascii?Q?z18VWK2E5vMoyYRzXNidCJQiQURLs7/1hTjpVnzojFkJUCMxC3n6txzRT3tz?=
 =?us-ascii?Q?YypDkP0c8BzAzR/Xe9tye8TqmONU9nYfjjZWmkZjSLVCoxtQHEfNyZpDS9v5?=
 =?us-ascii?Q?4OWbJHzQkH3maBBYXHBVTyLMd+343AtpkNvlvAFQQq3T6WqpEdsM03OFKyKB?=
 =?us-ascii?Q?aBb9LQXmqubQ/oeS6ompsEM2Eu4vLM6jD7xcQNkjQlgbIMmM24j1GOiJQPSi?=
 =?us-ascii?Q?VylkNxcmr9lKdmT/KCP6jmmpsc7zahPT6l4Dt/sXlgHH0Nb3plfyldN6UXqa?=
 =?us-ascii?Q?6QvG5XTevItF5asy88Rou7ME4qaJGL881dR8czbKmKQ5wIm9YsvQ2/cmKplr?=
 =?us-ascii?Q?+Im4xtAcPjKRnmOVYsbVQf0iZD7/2VJvOAKT/OA3BufHlykAj0PIDbCnSoM9?=
 =?us-ascii?Q?FRQT2pl4laloSnPGSK81Qn2vlj43KdBklIpoP4gd7fXaayHjW+0/mmDTtTTZ?=
 =?us-ascii?Q?NBnBhBw9QFMVaV7DCu2IiBWYHHTDN2bVc0oVaX5WQcqg22HKLx38kKDG7fTO?=
 =?us-ascii?Q?gbDsQOyaT2xMK2kIPppfYBTsJj8E28Hilpwxw6XCUT8B+OrySJfrikK2Mhl7?=
 =?us-ascii?Q?rd3VnCgtGvphclcpR3TzETJbhvm9hKpDPoIPQvoo?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db33943c-4cbb-4747-ba95-08db83950cc3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 11:33:59.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQMdZREEp9oct6nkd1Znf8YQRLFqZIv507OP9GZOD6kwHAcGPioEHOUZKlUfkUY+ymYmwuuOpiEUI4BQBIzEWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8719
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adding eventfs_file structure which will hold properties of file or dir.

Adding following functions to add dir in eventfs:

eventfs_create_events_dir() will directly create events dir within
tracing folder.

eventfs_add_subsystem_dir() adds the information of subsystem_dir
to eventfs, and dynamically creates subsystem_dir directories when
they are accessed.

eventfs_add_dir() adds the information of the dir, within a
subsystem_dir, to eventfs and dynamically creates these directories
when they are accessed.

Adding tracefs_inode structure, this will help eventfs to keep track
of inode, flags and pointer to private date.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202305051619.9a469a9a-yujie.liu@intel.com
---
 fs/tracefs/Makefile      |   1 +
 fs/tracefs/event_inode.c | 217 +++++++++++++++++++++++++++++++++++++++
 fs/tracefs/inode.c       |   8 +-
 fs/tracefs/internal.h    |  25 +++++
 include/linux/tracefs.h  |  11 ++
 5 files changed, 258 insertions(+), 4 deletions(-)
 create mode 100644 fs/tracefs/event_inode.c
 create mode 100644 fs/tracefs/internal.h

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
index 000000000000..4e7a8eccaa0b
--- /dev/null
+++ b/fs/tracefs/event_inode.c
@@ -0,0 +1,217 @@
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
+struct eventfs_file {
+	const char			*name;
+	struct dentry			*d_parent;
+	struct dentry			*dentry;
+	struct list_head		list;
+	struct eventfs_inode		*ei;
+	const struct file_operations	*fop;
+	const struct inode_operations	*iop;
+	union {
+		struct rcu_head		rcu;
+		struct llist_node	llist;  /* For freeing after RCU */
+	};
+	void				*data;
+	umode_t				mode;
+	bool				created;
+};
+
+static DEFINE_MUTEX(eventfs_mutex);
+
+static const struct file_operations eventfs_file_operations = {
+};
+
+static const struct inode_operations eventfs_root_dir_inode_operations = {
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
+	ef = eventfs_prepare_ef(name,
+		S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
+		&eventfs_file_operations,
+		&eventfs_root_dir_inode_operations, NULL);
+
+	if (IS_ERR(ef))
+		return ef;
+
+	mutex_lock(&eventfs_mutex);
+	list_add_tail(&ef->list, &ei_parent->e_top_files);
+	ef->d_parent = parent;
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
+	ef = eventfs_prepare_ef(name,
+		S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
+		&eventfs_file_operations,
+		&eventfs_root_dir_inode_operations, NULL);
+
+	if (IS_ERR(ef))
+		return ef;
+
+	mutex_lock(&eventfs_mutex);
+	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
+	ef->d_parent = ef_parent->dentry;
+	mutex_unlock(&eventfs_mutex);
+	return ef;
+}
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index b0348efc0238..7ef3a02766f5 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -127,7 +127,7 @@ static const struct inode_operations tracefs_dir_inode_operations = {
 	.rmdir		= tracefs_syscall_rmdir,
 };
 
-static struct inode *tracefs_get_inode(struct super_block *sb)
+struct inode *tracefs_get_inode(struct super_block *sb)
 {
 	struct inode *inode = new_inode(sb);
 	if (inode) {
@@ -399,7 +399,7 @@ static struct file_system_type trace_fs_type = {
 };
 MODULE_ALIAS_FS("tracefs");
 
-static struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
+struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
 {
 	struct dentry *dentry;
 	int error;
@@ -437,7 +437,7 @@ static struct dentry *tracefs_start_creating(const char *name, struct dentry *pa
 	return dentry;
 }
 
-static struct dentry *tracefs_failed_creating(struct dentry *dentry)
+struct dentry *tracefs_failed_creating(struct dentry *dentry)
 {
 	inode_unlock(d_inode(dentry->d_parent));
 	dput(dentry);
@@ -445,7 +445,7 @@ static struct dentry *tracefs_failed_creating(struct dentry *dentry)
 	return NULL;
 }
 
-static struct dentry *tracefs_end_creating(struct dentry *dentry)
+struct dentry *tracefs_end_creating(struct dentry *dentry)
 {
 	inode_unlock(d_inode(dentry->d_parent));
 	return dentry;
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
new file mode 100644
index 000000000000..c443a0c32a8c
--- /dev/null
+++ b/fs/tracefs/internal.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TRACEFS_INTERNAL_H
+#define _TRACEFS_INTERNAL_H
+
+enum {
+	TRACEFS_EVENT_INODE     = BIT(1),
+};
+
+struct tracefs_inode {
+	unsigned long           flags;
+	void                    *private;
+	struct inode            vfs_inode;
+};
+
+static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
+{
+	return container_of(inode, struct tracefs_inode, vfs_inode);
+}
+
+struct dentry *tracefs_start_creating(const char *name, struct dentry *parent);
+struct dentry *tracefs_end_creating(struct dentry *dentry);
+struct dentry *tracefs_failed_creating(struct dentry *dentry);
+struct inode *tracefs_get_inode(struct super_block *sb);
+
+#endif /* _TRACEFS_INTERNAL_H */
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


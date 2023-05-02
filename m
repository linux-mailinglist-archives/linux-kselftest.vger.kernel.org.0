Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4247D6F42AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 13:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjEBLYi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 07:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbjEBLYc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 07:24:32 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013004.outbound.protection.outlook.com [52.101.54.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130F540E6;
        Tue,  2 May 2023 04:24:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLuKSVd9egv3WjILJJYz+3zOrLeNiCiq4L5nURxu6Zbo5K0doxbDwTquyPY2Fa+daIgj6ul6HPxALiFjOypcYi7jqGx61Yyte3fbwz9U1mOwiMzuLjxnMT81VycDancc1d4eQV0Z0OlfZ36Zh4yg7x7Bh8N2BgdQg1WrY027Pf4Oojq9m83/t7BHFqAYM48+TWfO5z18wZd5Cr5mIeppF3kTeiKJhy6lUatE9Nm+liryEhizX4TjCAWKs2qUGPxY1mi3Wj9YIXE+jNNpLCCLjOl5OB3dQUQUNEDgs5MJ5V0x/pltYn4v0dJqmymY9SWUooAH4aGZWMUojwIC4GOyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDLRwQWnus2YNb0srng3/2Q1Dfsq3j8kFA+cW1Oponk=;
 b=A88GPfBEEiyeRc2fmLBjrLKkVW2iu+I3513UHNCocifGkarS9Ao2NRCESHEJ2qIEwCHVo/JKUPHLW2LPrrw6rUNcxN3BQlFU3la5Kjoavmiy73j7avbRkxRiSOuFSCM2UhumHl5LGTgETBjffhEcp/DBhRO+Toe0vkaKET7n9T/A9IdO+55g6jJl590HrQjDctVajwI7CJxOxCdvHLQqNldK9dqISxRN5cJx5lTCkMi7u1BNGMnta3reCC126YQcF0yb9fZCF25TEk6tU6BvM2yhOvNH21UT51K0yoye1wJYf22krymPIWKwTts2OZ79KEr+ILDy9mGBX8vPYFMqNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDLRwQWnus2YNb0srng3/2Q1Dfsq3j8kFA+cW1Oponk=;
 b=Q++lEQsTgj1MeoRTwdjOt2tpHKDYF6ygt43aQN6QGDEGAkhb8gErPFk4qgy5PF0JAghWiuqOtsN9mUx7LBltaVj/TGv5OSaXwYQ4xiQJCQLNOKrALgG5v3iZrehTbM0NJSDxRlovIs+QCZcjL5miL9/JEmIsm33IWl72nVSJSOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by BYAPR05MB6648.namprd05.prod.outlook.com (2603:10b6:a03:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 11:24:15 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%7]) with mapi id 15.20.6363.020; Tue, 2 May 2023
 11:24:15 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com, Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v2 1/9] eventfs: introducing struct tracefs_inode
Date:   Tue,  2 May 2023 16:53:12 +0530
Message-Id: <1683026600-13485-2-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 52d37a4f-4bce-4c31-1098-08db4affc328
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5tYkGEHyF3TlWNm8HxsP7P1Ns+Rlst0ViSfpyXmmV4hl6MXaBYSvfENOpTnI6ZSwai2s2kdCd4+4UAnH7hKoCWFKyWRZWzkvbcRtVYQSq7lxEI7g66QrDw8VmPgszJw6GtsjYrSa+ApziFlFyFeNtTxKO4DKBCCvFlj+3eyS+FeqscoCLizpMBvJ05o0QCGkTJYIpGaFa6dCg6G261HT+h0xTrCb5ZZ9KG4bYk6nm2prr20T9HAI5YGIswZBWQEoDCx/EE4FQLQAC/N19x7pLVcKzcAgYijVDIJb97i3M3C87XO32aKaT6SuSpUpDt1oD46Snstff7Tut9DoLv4xnAD0ekOOaQmfXxcEtIZanOTOPB9dm021gPuvoUF2hMam5MTdgSa3hzvqi5SrLa6FFdAhhBMTXUSA7+Qz/em6XhtlvsUbib3LMk4lvZ8byho0DjJqG6VrSIsdzilMArdSosxgd0wtImr30MWh30/pZmOQCr2d1qc4eu7bfNHmtUbw/lLwxzCONZRzB4NheWezt5QOnNOMxYCg3pwEB86PsLIwhEtGHrP9xHTGmQbpMnAqvjIhOPUd7E6Y71DAjbsGAtUyTn6aq1fqUegUhojsZuSZbQsjBe2Dv+iUEw3V42Zj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(6486002)(6666004)(52116002)(107886003)(38100700002)(38350700002)(2906002)(86362001)(41300700001)(66946007)(66556008)(66476007)(4326008)(478600001)(316002)(5660300002)(8676002)(8936002)(36756003)(6506007)(26005)(6512007)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?quR2zWEidODZ9yMAUTL6SKANlfkOAVaS/tOqHJrx8hqsvNUBOU+x0Tky5Tfp?=
 =?us-ascii?Q?dCHDzpuxGxu7dkgMVwI2SH1l7HFsey50/88gSgCfp2dbXE3jVvq7kmBI4F3H?=
 =?us-ascii?Q?N3x93/2acmhzAWSwRhtCH8BAvbJPIE4NZvNqk6p7qm3rKE9QorC21LMoE8mn?=
 =?us-ascii?Q?WrgSENA+63CmruOM/+hJcSAzSh+aQwxqQK3YW4rBw6QE4O6C5KKQ6YV9SbL1?=
 =?us-ascii?Q?cDrlqKUIRevsS5JGC/mJdns9D0S3oy0q/e+TAnz2KB8292LOlvCiuJPdUXrk?=
 =?us-ascii?Q?5p6NIVTp6MtmBwht4NI8zsRdjVU9hUzSYkF2MHao1zoVQ7ssIwj0jKSyuADM?=
 =?us-ascii?Q?aeWTUttL3MOGD2XrdHMMv6rtWJosKVcJ6D+EcwpAqK8rHgTOUhJVzx1PeH8D?=
 =?us-ascii?Q?0ifxPAJZ8jdavT7XDpsbDdFH75KwAGct5CgVB/LiV2kTpzNbtHjHXphS330K?=
 =?us-ascii?Q?4hSdo4HZNUz4cfBvB8Qg1QM5nOPp8zYuLTJOUE33hDRE5mNtRKYSgmvXfGAr?=
 =?us-ascii?Q?MpfJDq3iI8GXDS1kwiBD71EWxUsUqhSsAL59UpiPSxF4XYzSG/ONpMoSxnfw?=
 =?us-ascii?Q?hwTtLvgJsI+6slQRespl0puALMdaMtUiWYeMM0oIfqRljHELZ366dVJRK2yO?=
 =?us-ascii?Q?KhIIKi1OQQquyCfJXqW3YUdcYNlqF5KsSGvkfGu8ZMtvwLxBRMsf9ict2SK3?=
 =?us-ascii?Q?8pcgsyy2reSk92e5+8Mqj9J6ZdhyLI41PL63726FimuUAse8Ezubu8otcJ3T?=
 =?us-ascii?Q?Gu+RivupAo/dx1hUmKmhgHmeOWNjKT9MrLecd1nsMg0yrkbG5JDPijvP4cFZ?=
 =?us-ascii?Q?93rPT2JycvAhmMxRDYY9jwg9GalclIZuNMEG3LjvMcnjs07DwRY75loLEw6Z?=
 =?us-ascii?Q?4oapyJDDokPb4u2uP8WdtfALUTwApLY75TYLpqwkuHx0ArOJSJaIQphHpVdV?=
 =?us-ascii?Q?oT88zIcvcYfToiGEoOVCwIaMz+4yezzfqnELM1N5//o1Dwq5bIqoyXqHOs5n?=
 =?us-ascii?Q?Td618u0SlLmdEDAQfQNYth3Gvq897vV0AmV6iOrrQAEt5pLofCRlzJEodloc?=
 =?us-ascii?Q?wrRyz+fqYwaUA7ih1dNz/Iwx4qeIW4sEnf4GuJMjOHXz0VzzkZ5X0XqmXUxq?=
 =?us-ascii?Q?FWGTquRZR+6Sta8JqVsFV2feZENACcWndjJ5ykXwTAWziIzh1Xggnjnn0cPz?=
 =?us-ascii?Q?Dfd16HXTCkQxq6jCQuQjzG13VbqW4+BihRotqTGVcSiDWZWYR0ajqbM3pzsi?=
 =?us-ascii?Q?X4QYsuw0YNIUu/N3X39Z9TUB95zQQtl6n3Lt3/V4d/JW5k7lBl8AiaiWGN0w?=
 =?us-ascii?Q?drFstLzR/r4BVrxJKkTgp0mumDf3HwbMQX+jVQXg6uoOOaicm12xPViu4vwM?=
 =?us-ascii?Q?68Li4teL+ioGovvm/3Ly5H4pjgiwNPcYbNF5AnpsnO4C+ONKfUUXFhJ7HYaO?=
 =?us-ascii?Q?/c/uoxLVh0e9kpQaUsO4r8M+CspCrlC/Ym3xYIsZ4hMksXfkLu2EtDvNuorJ?=
 =?us-ascii?Q?25ZVAvpiEu+qNQVcHDeZyHS8aHadggj/F/+P3uDDwch0lTDNPByWS8ypn9lw?=
 =?us-ascii?Q?fobV1G1HEmggMVwaElVsPYoxNXptm0FEU2/yBTn6?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d37a4f-4bce-4c31-1098-08db4affc328
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 11:24:15.6305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieqlPkxUB++FmhpM/qYIxG/HMR9tEb/hmlUwG3MUtd5cD7xbAHwUz9RAZxbkNDRJUuKPljeB/Av5wRSHcO7ArA==
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

Introducing tracefs_inode structure, this will help eventfs
to keep track of inode, flags and pointer to private date.

Renaming, removing static property from some function name.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/inode.c    | 21 +++++++++++----------
 fs/tracefs/internal.h | 25 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 10 deletions(-)
 create mode 100644 fs/tracefs/internal.h

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 57ac8aa4a..7df1752e8 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -21,6 +21,7 @@
 #include <linux/parser.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include "internal.h"
 
 #define TRACEFS_DEFAULT_MODE	0700
 
@@ -127,7 +128,7 @@ static const struct inode_operations tracefs_dir_inode_operations = {
 	.rmdir		= tracefs_syscall_rmdir,
 };
 
-static struct inode *tracefs_get_inode(struct super_block *sb)
+struct inode *tracefs_get_inode(struct super_block *sb)
 {
 	struct inode *inode = new_inode(sb);
 	if (inode) {
@@ -399,7 +400,7 @@ static struct file_system_type trace_fs_type = {
 };
 MODULE_ALIAS_FS("tracefs");
 
-static struct dentry *start_creating(const char *name, struct dentry *parent)
+struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
 {
 	struct dentry *dentry;
 	int error;
@@ -437,7 +438,7 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 	return dentry;
 }
 
-static struct dentry *failed_creating(struct dentry *dentry)
+struct dentry *tracefs_failed_creating(struct dentry *dentry)
 {
 	inode_unlock(d_inode(dentry->d_parent));
 	dput(dentry);
@@ -445,7 +446,7 @@ static struct dentry *failed_creating(struct dentry *dentry)
 	return NULL;
 }
 
-static struct dentry *end_creating(struct dentry *dentry)
+struct dentry *tracefs_end_creating(struct dentry *dentry)
 {
 	inode_unlock(d_inode(dentry->d_parent));
 	return dentry;
@@ -490,14 +491,14 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	if (!(mode & S_IFMT))
 		mode |= S_IFREG;
 	BUG_ON(!S_ISREG(mode));
-	dentry = start_creating(name, parent);
+	dentry = tracefs_start_creating(name, parent);
 
 	if (IS_ERR(dentry))
 		return NULL;
 
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
-		return failed_creating(dentry);
+		return tracefs_failed_creating(dentry);
 
 	inode->i_mode = mode;
 	inode->i_fop = fops ? fops : &tracefs_file_operations;
@@ -506,13 +507,13 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	inode->i_gid = d_inode(dentry->d_parent)->i_gid;
 	d_instantiate(dentry, inode);
 	fsnotify_create(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return tracefs_end_creating(dentry);
 }
 
 static struct dentry *__create_dir(const char *name, struct dentry *parent,
 				   const struct inode_operations *ops)
 {
-	struct dentry *dentry = start_creating(name, parent);
+	struct dentry *dentry = tracefs_start_creating(name, parent);
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
@@ -520,7 +521,7 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
 
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
-		return failed_creating(dentry);
+		return tracefs_failed_creating(dentry);
 
 	/* Do not set bits for OTH */
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUSR| S_IRGRP | S_IXUSR | S_IXGRP;
@@ -534,7 +535,7 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
 	d_instantiate(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return tracefs_end_creating(dentry);
 }
 
 /**
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
new file mode 100644
index 000000000..6776b4693
--- /dev/null
+++ b/fs/tracefs/internal.h
@@ -0,0 +1,25 @@
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
+
-- 
2.39.0


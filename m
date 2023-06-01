Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EA5719634
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 11:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjFAJBV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 05:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjFAJBQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 05:01:16 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013010.outbound.protection.outlook.com [52.101.64.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1032BE7;
        Thu,  1 Jun 2023 02:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLMmGwbsq6VOTiV4DpuJxcT9mHeDxDR5gafxwCeKKzv/v8aXXabPgxX9+mnVHuWnsHO1uM2OwzFfjCRHwIn/wXZ2cXKsCeM6SxZfeB1lhkb8796qSudl/vFtBhvscL6ylvc6iIUPukvwfkzljQ/i5c+d2lIkfcPnl5pbjlbNSSXh8zaVTLfrxi1UAHneQAOdUxoD8xdlgQxY2vIQRkXoxJLbWrJNeZDrUJC2HU8oAM89AlNrcgsE1eTNo6+5L0LWzRdBMke2QuvD6kn/BJGGGl2wNbzadZhk5Mk71FMPhO6zA1EwCgKRG78txepM5c7LQ6IXGZBTksQAo75Lc8eEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqnypT5cV3uH674kkDeSLFcG0cpa0F83Tc9rmS5VldI=;
 b=dB/hEWEhFhlTjGsfhiXC6EW/K2QglIZYtwFYU40AZ/1I6LJA3tGK8PTX3FN5M9SAgZXDtygAdpZvpSgnrZr0V/nSkqu3Xkuq+rFUbhT+kMsb8Eib7hdvit/YjRorCAhuFKRu7f/eD73KQk+wMoQv3xDL0L7t5rvem5RKDtaGMirhTzCD2aHYPrm7tEYNIGaZ+nsQBvSbVDbXfumWZNM+waOEsjTuFUt3j/KyTm0o2VgLu8YhogB+rjAOuHn6sMAIUqXBmI5Jaof0Fp71XaV+NIi+Tkni+6cjqHiIfxYFOrawcy1HR/8Qb2SL2vHAjNybW92eD1WcH0H4eGgqTxZo8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqnypT5cV3uH674kkDeSLFcG0cpa0F83Tc9rmS5VldI=;
 b=uxaBZCGrKdTxpPNs99cdo6QzdNIzi27DrtD98ZHS5F1bFMH+2AQPg09G646xzXLoafYeEXql6sytyjqRSOEXR59Zfo9IP58rtpPy4g0RgWUzhzwZiBw9cNcSxF6BTUSykrrx0YNmObbJ/ZQENeTQHhqZ0hZB9cvZeWl6IMP4jDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB8617.namprd05.prod.outlook.com (2603:10b6:303:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 09:01:06 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 09:01:06 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v3 02/10] eventfs: introducing struct tracefs_inode
Date:   Thu,  1 Jun 2023 14:30:05 +0530
Message-Id: <1685610013-33478-3-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1685610013-33478-1-git-send-email-akaher@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|MW4PR05MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: 47556847-b537-4ddf-54e1-08db627ebc14
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ccznUqMGkyOV08tSwKhasf+jUfAWAxQu+xJWqN/JqjjRb4QljVZjNI9dYotGfEToTmmQsPragMRLMS8033oBbygvLUDLrdiZQST3JNKXDm6mhAZ3VEv1WSmc1UZfZPq/OqQu+3nCF+Fw3hHA6TYiQOsrNqfjJ5S3k+Jn/nkv4w4SZZ0MHdsZyPrRVkUgA06467nFKyJaA3o4o1YHvF16BdEf2n+rOupOCnFVRLVQgwfXSw5NdzQLSZW7syWMEV5G1zaSzkwL9QrSDELxdZNinNFGOTtHA+cZsPl06pA+uMDgv5tf1lFaGYzZJaiQ9ZZnoZxzXLqaZIbw4rvEwAIE1bj8rIiuA/TDIqgkCB6l/5SFCYl4USjFDCCM5Bv0T47/mxBE/bfvTy0iOuAXR+YIwdJy0FvnVBbFokffTMk8UpL2yIF4OmReR3eayt84waEi0dWAA6wbLrSoP4r8UKLujWm/43Zb59fcx1l3C3Q8a/Xzcqcqub5MKJNqy6oYHJFtHrSF+CroakQw/X9+sPL/LHqBJdvemeNKw45KxJ0z32OOoHY94bhjElPpjjUB2oMuJMUN0EKPXvt8Xxtdvt05ncUkjx1KemPo424o385lwQyV8nU+MJ59IdeOmmK2va0H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(52116002)(6486002)(186003)(5660300002)(41300700001)(107886003)(36756003)(8676002)(38100700002)(8936002)(26005)(6506007)(38350700002)(83380400001)(4326008)(66946007)(2906002)(66556008)(478600001)(66476007)(2616005)(6512007)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/bpdYTwVCv3niqn7AdXnfXaq8Z+nhpuZP/Bx5d2/zbthkRZFm1jH6jOktJ8H?=
 =?us-ascii?Q?IC3BSNMfdnhQjDryxMEBttHbk7xKSvqdyXBawF+U6K/Cmr1tHzVfKXsyfxbP?=
 =?us-ascii?Q?9gm7LNJ67HvNYFJMOZ9HR1F5PJ1Y+Yj7SOdMLAH2M4nKnuTtTi+oHnVJWaXU?=
 =?us-ascii?Q?J4igtg9ohMjlhJkhjJazH7heB3KAcEn6nSMglYrcIdbSFCeSeLNxAUJh7U9a?=
 =?us-ascii?Q?XuCGYro8speb0iUdZAjwpXRAxeNG7Na6bAUjoA8x4WE1lVT1nANKSsYo01VA?=
 =?us-ascii?Q?D8HzvwGhHyaUucpjXkcTRbN094q2nyms1sKxXCG8UVSZTgoAAaCdDdO3XBaN?=
 =?us-ascii?Q?k6O0yc+d5qgOCpzgRPxZj8wdtKlNGgCTVGjUQ65ujaIaI8fjau5jn6gM2W26?=
 =?us-ascii?Q?BZtojZ35JqWYeN5NJo0hUlN4c55Xz2j5UK5Hcfdhw8VKVxapBh4S7rc1L/TD?=
 =?us-ascii?Q?7vcTLQ/Ji8qBUyT2y+z8s+nfaHAgBIv3gDKegz/sS0rMhoOKbj5TmfF8hmCK?=
 =?us-ascii?Q?3WaXRbPBKDzhI0OjEKlDxJEGd51BonB5Seuj4nMr7o6fHim2XHLrkaiBWvjz?=
 =?us-ascii?Q?FGoP0yLRBKKrDq+QiLCLfD3ecBxkgfImLFadScxdL8ArU6lvHh1sx/fcCJqS?=
 =?us-ascii?Q?Vgd3TcwMZIRwgUbqZ+z5MelyeNhDNKiWwM2GmszJ97kNiTyADwv2S175481B?=
 =?us-ascii?Q?IYQutr0kbpkLMkIBV24IkeYpSL3Y9hXzRMAH7ri1VRPPqPHM9giqXoVPRAOK?=
 =?us-ascii?Q?AZrNzWbWh2IQHlE0avAfmeCLzASfX8KjmtKHVDW0JL3mABuDIy76cko3tam7?=
 =?us-ascii?Q?psbaQ4Bz621JCQZSz3kasIaILiG2Vq9jhXBvyodBAO//0oQkApzrj7Q1HbVT?=
 =?us-ascii?Q?oLgLpmZGFJjjPXJHRyu0pWPvtWNRBngKdKinOXDeOfcoQ+glP5r2cIfQQW/S?=
 =?us-ascii?Q?13wmkt+I3yfCsuC2Doozt6eZ81BAgISwfAYaPZv4thV0Ac14C61I8bb7gkak?=
 =?us-ascii?Q?WpVYr4/LUGIr0m68Wz5l7OgivI3iu72JwYvtvWFQ0watBbwJ2dupxQ7vf8fI?=
 =?us-ascii?Q?vQYqBRNPYkVFu3tUWqWWdre4ZABoaTQKDqOWnakZEqSFFdPLj7cHloCgRI7u?=
 =?us-ascii?Q?tvi1QZTWAimX0hQPh6TIEkla3wHfayRnKAa9eB8qUXVoyP0jA5IPzCvnKcNI?=
 =?us-ascii?Q?71FPx+Pz/2UnPD2yLPtaXenpdVrvmABZ/DCru8AIv2xOXWwVSy2XEp7P3FeL?=
 =?us-ascii?Q?2NwBtvLbnE/JQz6SSFWzArqW8T7HDT+zD7Yuzi/VQ+pSTFM0UuurmVdtoKpf?=
 =?us-ascii?Q?SwUkqEoFANJs/1a4khxrQqsFKfmFCvIb23sAG7w31FVBU0dInlGZ2ySfwthB?=
 =?us-ascii?Q?kpyJKq1gNQo8VQxR9e/nL9FroLw0DYHXHDSZGIgdiHOqsm2RIQdeaIJNNhUC?=
 =?us-ascii?Q?me4qezo4QKqN2c9grG2PC7gXO8/e0/wpJ3glpTgWaZxL83fcXXwWeHZavgdv?=
 =?us-ascii?Q?fv3QQAlV/aoLXOvannKcZoSai4Q4BUU3p3EiKiY4j8HGdRDyYvufTOVK8l7v?=
 =?us-ascii?Q?1Rg7SYtuI+ufFvVTAqcOGg4I65JaOfuPcdtlM784?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47556847-b537-4ddf-54e1-08db627ebc14
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 09:01:06.5827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRNCnwg03jRRB4JTf6SyEIxb7iaKczufgujwkMCvR72sXqnvRwM/B20717GwsvpAk+PWya7q1jgf5ZHOOBb/zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8617
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce tracefs_inode structure, this will help eventfs
to keep track of inode, flags and pointer to private date.

Rename function names and remove the static qualifier for
functions that should be exposed.

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
2.40.0


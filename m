Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E4D719640
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 11:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjFAJCF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 05:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjFAJBo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 05:01:44 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013013.outbound.protection.outlook.com [52.101.64.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69591BB;
        Thu,  1 Jun 2023 02:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNtnqzgu3WztXdm09NW9akRh+O9iDwXFJCQwXrhFxLP6KBzLqQrnSsj6L2HQtLuNF380RcxjJ1w7+TBR8Edc3LYD7DoXsfRHwpnpTRHhT307vshStvAQeuGOJ0+FoKWKDVd0LR+TFJ8sMxKXoVXIBNgrAol8MsZhbSjgLc5xrEErCYV0YEzEifoVuZhfMT90+IOErToyGApHO0O/u0Fa6Jr5dpJ42y1L0Li50M4m+a4NbO2RCjhsQCHvs8gU7bKW19fImgpm+A56dLPxljhndDfj0bacjTRzqTCkXRQG4RkSSjJyHF4HNuvqXJuk/J0aYkAOtnBXHzCaxU/fCjHeyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKcBE/cygiHxi/0/RQWaU+BoIShwEEohRRcN1Oc7Y0s=;
 b=XqeYetn9ocWGskDZLduMBIrKugYK8FQmG2V0lGMsLl4uhajlB3OJylVwtYSQl3ybM9quENM98G7jZIF6S0diOAVb2fNuqx4wfK2lmsCs1cH5CrdDrdx6v2VgC1sMPqmFk8T3E+GfI8+beAJtVoUFfsTjKOcT2pSZOOZgQXuSL4a2Dl0KdpKmmQwbLEMt4CH+ElRARW4ZPriGIM2D3j67OsyORfSl8NzKSwzagR//M2z+5w3ZJTRwtPXpyzC9pEkZ2bnQHnyh9N5tpu7QW5gW42K9MD9BcwSErMvU8qjluyV49Bjbsz6JGOvknsSWU8/x6L8uUM/xeyuJczeJQz4oDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKcBE/cygiHxi/0/RQWaU+BoIShwEEohRRcN1Oc7Y0s=;
 b=t1bpzWaMIJvig6yN/PkTa6WkjSuKtMAsaubI3Rz1eFLkNhuIVInGGqd+qj4i6YisBXZ3eazKy2VN7dsJlKfe1Rh9B9n6isSaZ59dGvAePJE2FcG4CP4FNSQAN/yNipUbaEC/zt1gJSp7WrOg4BTxTROxelzWg6n3GdbH2fXdC8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB8617.namprd05.prod.outlook.com (2603:10b6:303:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 09:01:13 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 09:01:13 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v3 08/10] eventfs: creating tracefs_inode_cache
Date:   Thu,  1 Jun 2023 14:30:11 +0530
Message-Id: <1685610013-33478-9-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: c32eaa0f-46b1-439d-92ce-08db627ec010
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YakZ2LURSnyoKba0mTJUc+3Io+a0RH9MROIaIxpa2HrDetpVhD24/2xMP0LIK+fI3Huys9HwVeX/OtG6o8xOgg3SmTIaHKsvzLZvbW+uDb/0QjdVTEA4lzhXtrD0IEgtSTZcUnlodZg3IDeUBHdFntXPg3/1q0t/251G/Ihzf2AQ6oeQ7XO6zbhFoJmE528ZbR561Mo5neMOn+fWirbzHw7MR/uG1dgmB8jtufdKeTmooJXQG3WEDwkmDmHDIVAxDTUZus/uHoq48c2+Qbz10E5PxCazxWwrvBcWfhd+Fp5h/6TSsPU1dtZvxCr3SzXpY8lCf6FpLoLfO8ZueaukYleX+rOiItn0HNsGPrXT2PM/WuAbmuhClDDxO7WN7PzeekuM7EgP1eWcHyAlxSMGxETmmlRNU9/jS0cySD2vLwdRTgcvUEm9WPEltn6rDNOq4BnSKU5EX+n9tjQvevMMCTTc5/A6TGkE2xcU22it0tWvAAPaEz7ByeG0tA/z3ZGQQlRkRgimKNBqvKC7gE9cgFZG69FekkLosxY71N8il5AHfx5VblKmvSIu4azLxSiEDi2KuIFF5f9t+Pr4TLwsAGJ4x9hhFn/Tn1yJx6I2QwYk5bBsBGCLS2A4bfsFlL0J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(52116002)(6486002)(186003)(5660300002)(41300700001)(107886003)(36756003)(8676002)(38100700002)(8936002)(26005)(6506007)(38350700002)(83380400001)(4326008)(66946007)(2906002)(66556008)(478600001)(66476007)(2616005)(6512007)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9swLPnYLmckwlLGPd464+QyDXHiqZ0Woz89N6n8nNJ48AH7Ntmh02zs0oTHG?=
 =?us-ascii?Q?r7qBi+8ErxdgaLGiwPryB1DIdbpd6F80T1Y0njHev2U7+oZmpa4H8h+6buwJ?=
 =?us-ascii?Q?pvabGh0/lenEzZReLrWQn1OZNdZoEMk0/SZJGVUF7Fm6eauZZ0YzbmH9o02L?=
 =?us-ascii?Q?L2qteIqL2u0YX1gE5AVG52X0fFRjytcqQVKDz4OMkYPfrGZSLBsaxF7OlkZl?=
 =?us-ascii?Q?xY7skVE86Uf4QnmrtbuY+547DxVt8z2N1NV5I1GW76ZXZH6oKKbwiZ6WH2jk?=
 =?us-ascii?Q?SQ66N89jUqjwd+oyh3yjekTpCT1v45ACx1wVuWS1lJVlhwc692cmBQpdIrHT?=
 =?us-ascii?Q?t2qjO/V5f/GFFS/U54rnIILeSbaEu6AQbbrP6YL91wclMCrE88Rr3ICTcesO?=
 =?us-ascii?Q?3PaIICbuOxP+OXrY5TuthpVwSI8f/a886HG9rYH2zANcjJ2lqoHgtb2SZ4vn?=
 =?us-ascii?Q?UHOd7jInjcTE8lIzxlL6+eGa76wgeNsde/qiCBvroo2ocbparnbTJjUE/8o2?=
 =?us-ascii?Q?CF/kZYw8iy7+zcovEcHsyAFLn7NdO7KsAf9FiaWeLUwxxhETNXqBJTAMx6zb?=
 =?us-ascii?Q?5BpmUJr9keiJJJczWpEegGmuxZXO4knsI4RH4mt8LHjaTqd8DbDyrXRKKJ0i?=
 =?us-ascii?Q?7Q/WQjfo9DmJ2Omhznz/naSStDg2yfDnWeHiyI+dDhipFmZwrJs6lW0GlVZq?=
 =?us-ascii?Q?J3t+Xo+LbW5/podq73qvBh3kA5CNwPolTrTiEqx4iS78gDia7ItFosHLDmKJ?=
 =?us-ascii?Q?nynYjMbpdbi7CaQULV4rsy2SfiRt7IMmQb/eQEtra0e0fTEoRoiOlndxSuxd?=
 =?us-ascii?Q?8n8EG/4np4bQabB7KCbBP6c0zzbub6CfRR8Fl9uYButqz384NY0l9//xXVz+?=
 =?us-ascii?Q?w5jdR0gImn0ZoytS2ZXNDCkXEvBuqOLgt5iHLam60DyEzm5BmQfnRkK+QLoO?=
 =?us-ascii?Q?ZDFO+sy3ejWJgpln52eg2lLhlbQzB6ECoghf58rQKYS4KwywrI3uXNKH8hss?=
 =?us-ascii?Q?1Ugvj/eiRrZq1wGX93aA8UIqG6d6+q396av2E3q3ZWo1b3LQ/2dJ106qQg1S?=
 =?us-ascii?Q?Wk7aPCjuWCdjgHhAR1kVAom6TeH1ZTLo4osdeGDqMKOwR7pbCCemdzfUwJYZ?=
 =?us-ascii?Q?Y6sNJpLycxCnDcFnueENo+1iLuexYYIJjyVHSAF+pyGIAYKgfcfz2RQOMfOS?=
 =?us-ascii?Q?OzV73F1OKtE+PuH1FvrGOBPJrAAE98vHAb+WwCYtdCBCA/rdPT/9r5voHQEY?=
 =?us-ascii?Q?RZAJYK2Zy2CJzeJiLphSTHDh6bv9ro4BV3WekwiwCaO7f1AISp1b1f3Ng0LP?=
 =?us-ascii?Q?WAe31QDGl3hRToqf9Vm+nPeRUPIiA5m/D3TzuEKaAeUctCqS2L96v8bFaDOz?=
 =?us-ascii?Q?4U13Sqzf6DVqiXlqUD8e1njso8KvyH1Sr94aaPmigJQL6+CpD5m7ZRZ6pbBM?=
 =?us-ascii?Q?EaOPb0wErffoV45K27VOUWR5CcL2xMUWOuKo7BhrBWhXfGmhLitVxGYN5Ut9?=
 =?us-ascii?Q?wCD82QprSE1XP/o/kyKYX4J0tILQzVshPMu78nX2QBdDnc+OzMbNOqZqNnko?=
 =?us-ascii?Q?M16hfpk8t059RJIwUvn2CsWA1tm3jV69SOQ/HwGb?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32eaa0f-46b1-439d-92ce-08db627ec010
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 09:01:13.2165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USMoihawouqkpeblLsjobu/le3T4AKOXso5mKDAe/vMfayRrAnYJ3ZOYfI+hvd3V9DV0MMOtrSmHXgjxnQaePA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8617
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Creating tracefs_inode_cache which is a cache of tracefs_inode.
Adding helping functions:
tracefs_alloc_inode()
tracefs_free_inode()

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/inode.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 66c4df734..76820d3e9 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -24,11 +24,30 @@
 #include "internal.h"
 
 #define TRACEFS_DEFAULT_MODE	0700
+static struct kmem_cache *tracefs_inode_cachep __ro_after_init;
 
 static struct vfsmount *tracefs_mount;
 static int tracefs_mount_count;
 static bool tracefs_registered;
 
+static struct inode *tracefs_alloc_inode(struct super_block *sb)
+{
+	struct tracefs_inode *ti;
+
+	ti = kmem_cache_alloc(tracefs_inode_cachep, GFP_KERNEL);
+	if (!ti)
+		return NULL;
+
+	ti->flags = 0;
+
+	return &ti->vfs_inode;
+}
+
+static void tracefs_free_inode(struct inode *inode)
+{
+	kmem_cache_free(tracefs_inode_cachep, get_tracefs(inode));
+}
+
 static ssize_t default_read_file(struct file *file, char __user *buf,
 				 size_t count, loff_t *ppos)
 {
@@ -347,6 +366,9 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
 }
 
 static const struct super_operations tracefs_super_operations = {
+	.alloc_inode    = tracefs_alloc_inode,
+	.free_inode     = tracefs_free_inode,
+	.drop_inode     = generic_delete_inode,
 	.statfs		= simple_statfs,
 	.remount_fs	= tracefs_remount,
 	.show_options	= tracefs_show_options,
@@ -676,10 +698,26 @@ bool tracefs_initialized(void)
 	return tracefs_registered;
 }
 
+static void init_once(void *foo)
+{
+	struct tracefs_inode *ti = (struct tracefs_inode *) foo;
+
+	inode_init_once(&ti->vfs_inode);
+}
+
 static int __init tracefs_init(void)
 {
 	int retval;
 
+	tracefs_inode_cachep = kmem_cache_create("tracefs_inode_cache",
+						 sizeof(struct tracefs_inode),
+						 0, (SLAB_RECLAIM_ACCOUNT|
+						     SLAB_MEM_SPREAD|
+						     SLAB_ACCOUNT),
+						 init_once);
+	if (!tracefs_inode_cachep)
+		return -ENOMEM;
+
 	retval = sysfs_create_mount_point(kernel_kobj, "tracing");
 	if (retval)
 		return -EINVAL;
-- 
2.40.0


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA1875DE48
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 21:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjGVTiN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 15:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGVTiM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 15:38:12 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011013.outbound.protection.outlook.com [40.93.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBC0E71;
        Sat, 22 Jul 2023 12:38:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibVPzTi4PilVGf/pQcIwHYdgyXrSIYl7cYHnVDZsVYkhmag20tX0FUx4PrYtqlPTBjUaw0xQ7Vo5dphxOlAvQ0MRg+zirZRE+mXL+7uDW4zDNZ8ZNmp2210iiu6fdoIpdFH+PGKFOIjIKrY3bhrXbnYh8Cds1r3kuBu6BiSGjwPSqyCzGr7MinIpqyv5JBtCfd7e7tCZtnKRdKMG+pl1QyQxCxbgK+6UuluiL1kTpaS79as+YItHEglacymQRmdzp252x9HypMd86CRfORgcy9OKdIcDFRwfzKZIpuI5XOPWJbIkxBfRYelCn1RnzQg8bSi8vz5yczbcZLLQmFl99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXUtEczMGFElOJUhX84RQ+BxFK0f2GYe+dstmA/OSC4=;
 b=El6CsY4lA9e+7zhssuHFVbU3C4u8uATdTqsUCC8LWHNA/aSDh5hG52MPXjZMFzcPwc/EHE6kKpWGrXyUB8IGcC3f+giveZCjOHcQwM02gRq80OgvCKBlJKyUEPb6vSg7xN2RoJMycT1AwCPovViVP9EtxO3Pd7LKivFIcb41TluLUdxeQzM6JlY5WqxshK75/eKD/U9dhMLzvX0NxentlT0lX7Ponstk7Ke/5wkeg2ljnZmCG4fauRXEo5a8Zmw6kjoA87DIIUCErtimFHCWv38tsCA/cMalk8FASTz5wulLBDFFelQyXbb+LgJZftizoovInFmXi4gZ9iHIazWECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXUtEczMGFElOJUhX84RQ+BxFK0f2GYe+dstmA/OSC4=;
 b=PrHd7B8AN60SHbu3g/sfN5X5vDEDE6haMsmRfpPjVDzL2xYGRknemaE9lM5kdky2R69TIG/XXr+5IlyxKYKSHiLqKPSGtXjO4iehMCOLu7Hx6hj3dl/a4DWMf22Lb/1UnoGemkO7yfHxDhdpaYcUCjFUw4k03+zhsASK3clE/Y0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MN0PR05MB9005.namprd05.prod.outlook.com (2603:10b6:208:3cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sat, 22 Jul
 2023 19:38:08 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 19:38:08 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v5 02/10] eventfs: Implement tracefs_inode_cache
Date:   Sun, 23 Jul 2023 01:06:57 +0530
Message-Id: <1690054625-31939-3-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4f3a94fd-2f2a-4257-2646-08db8aeb2ce5
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q0C9ZgO+PcoWZRzWRz3tLD0vMJxHv325ga29qtCH7Oh746v/O63cNmzlMM2VkdVkEjdEipoxeCeRumTG8N/CiNNis93x0tz/rVq7ns+CjpcVfGSs134RWGTcJVNbx14IaA1G9xWUhAKIQFlx5MIujHVmvl/M1Wcn/yIuGa7oEYhaL6DRn0aqSZLmX5Ppsj9NRE3UulFYfsFJIrGNIW3fI09OFVTDRraO0yVE1AhJu5RRwaXRLlIa3KW6lscUJAwhEb3tuPeTnZPuZgPs0gqH59/06vXSeKEPa2caMLGwU6IgxdzmPBc6oHKtE2NkHB37ra/5Dv4dxP/cEPkHu1KMqSj3Tc1j6BQYo5hVXB3T3e8jtUEPc5a6YytnNe9Q1XiDi23yIMceab5xYQK9G72An7m3GdA+K7ou8BVX9xXm0cX90gJ4mgl56WzJ6QInLYGyXmGpGGYlSFZJS4O85FDOX60y94btMT82RWAgIrhZ0wTDHOwG3uArolQeg8zUUVydCLT3DMCHmeZh76HvxwytqHjYbKlXKsNvcmASU45leH7vpLB3b/JqnM2oUnSmGpdMQX792vQGVJkYYoZYjIwshwF5XhTJlv9uKo/hd2hMPDxf6xVMFFypxU9RxOnzxtUS5Nu5CjFGtsbVLkiEEVnEzNWluWI5Zwf9F/INZ7a2R8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(6666004)(52116002)(6486002)(6512007)(478600001)(186003)(2616005)(6506007)(26005)(107886003)(2906002)(316002)(41300700001)(66946007)(66556008)(66476007)(4326008)(5660300002)(7416002)(8676002)(8936002)(38350700002)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ExuV9A4c62nqoTQjbP6VVRnisE38wfWHzSgsrh3JQO7MYLWkbMG9dQc0cBs1?=
 =?us-ascii?Q?lwERgshlO1WBdaMtTsfo352EYxLezdwQDJz1G5x1ic0n/1hJlG3LgvbPhfhk?=
 =?us-ascii?Q?IuVQ+Q0WJKYLt8yHvuZD9kcnqX0A4JoJbB/SgR9b9dlQIoz9UcWTM53z+9HB?=
 =?us-ascii?Q?Jnsa/tuRJe6jAthG2vsK91jxeqe+rFCAvB6jha8sJD/2fBUx03ZU5wQzAoD4?=
 =?us-ascii?Q?Gw14/YGRpPMYsR7iL8vaOI4j2si90OFEnvj6riqZfJN6aqjXg0FLL1EY6xxc?=
 =?us-ascii?Q?22p3V7/6dAPxvKO2zzM+PE3qbvhhM+X8LhSXiNDjcl9gH0KLliXBMTNWiP2a?=
 =?us-ascii?Q?Mj9N6qQ4z1xNle5ofKgZZc7HYLYCmWMkb1Z8MgE/5C+QLklQEkUrDIkvhgVv?=
 =?us-ascii?Q?TJwcDMSad6xP4OOQWsh6W0wBC66R1CipO6IsbWqyoGqHyc1kjJ7bHXmnVLNR?=
 =?us-ascii?Q?OvCgC6A3mBgLedLzP9/UhWJubnyUD7GTRd2nDRZtzZiNnu52JUlNxYIQyYC2?=
 =?us-ascii?Q?NbP2gzaGS8Peehjl5+4rhJEURuxGTcysANWQWMmN8QtkHSH0LXgFeUKziaCM?=
 =?us-ascii?Q?k5xPsFm2kYcMPIWiREq5B2Gtq/qftXdHtdwyo1sLvJut83xE71Xqvu/JLW0y?=
 =?us-ascii?Q?S5uXJoALxDujPedPBKIB3VbAGiv05Zx7afIuw4euOywLB+uF7GOvNJCbSgKI?=
 =?us-ascii?Q?+qoQfEhKuL2YTZfwCqfXFf18L8dcgI/Ad4P2EdJZNan6+1Pc1EBA5HYYvcjn?=
 =?us-ascii?Q?AedoyRCTr/cyClgpj/3gaelXTYHSshsIjK9DdZPoN/K4l+xbKwV1TcgMGr9Y?=
 =?us-ascii?Q?9V8W39fTeyIQm/koebHYGppfiIz13mNRihMUsaBjUlVYApnPXetibbStHi33?=
 =?us-ascii?Q?d8WOggHfZfbL5nHhfhkxpsq96ZVvEet6h9ovlyD39tqNI1DRnjaHoO9NNuPr?=
 =?us-ascii?Q?rl0ECC/2SWQ52DtDBiR2JXOEA+G+5RNN7g6gcMAe4OcDvDk1GonzLpt4xZkt?=
 =?us-ascii?Q?20IQb+u6k/8gg+MQdmwx8WUsGn5CnjP7wX/pgCtB5RfZ2yt2eIMNGoqiud7i?=
 =?us-ascii?Q?M673LX1fjf4Kz6c6/u4GXJJ0RNpHhoHEYZvryQpyS9QDsnGRDLub4RIy9yPn?=
 =?us-ascii?Q?hTa8cXh6Hvyi2wxEC74nc5uj8ia2APnrSAchOSIBJk/Q7CTjJgd5Vh3+4vW4?=
 =?us-ascii?Q?ySx2uXyTiJksEG2bCSfG4qdzNbZJutFGa/auAFMO8vvIMIS+cc/qgMbmxl4B?=
 =?us-ascii?Q?RJCHfL84e8h2ORXJfSYLZH6phTrbQN/PbQJfhBcW9I0INJY4w6WyBHoCNb0B?=
 =?us-ascii?Q?ZNHARFoEdhXU+9WnY77FmMokIt4QMnj6CwRt9/yY18LWR5h5evaVrrFx/DDT?=
 =?us-ascii?Q?yN3exAqxdrpi0EyQlkMaIx0/pFd+L/cGBlhXMZwWimzRUVpUKqM4aasRxKuk?=
 =?us-ascii?Q?yJOCpsabnByllytjFVRUc3sBxFYA7ELjbHgGieI+FxUkrAyDHgytLORJtvIy?=
 =?us-ascii?Q?X/cJ1cOba4TOL5AyYCxHSbA4TjwsBtMCC7brWSKAWzJu5TjVXWGEY9Ijwp48?=
 =?us-ascii?Q?kynw4pRQWCuzDzwjOyPWEJDdWVfGH26cjzedIZDf?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3a94fd-2f2a-4257-2646-08db8aeb2ce5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 19:38:07.9903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: macxPxHJAV5/gEnEkzBcOgne5+AteP0uvNw4GrzT9ixgiY0OuhSQOzKZ/IN1LbpAP54kYo2Z22oCToL0UXKOLA==
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

Create a kmem cache of tracefs_inodes. To be more efficient, as there are
lots of tracefs inodes, create its own cache. This also allows to see how
many tracefs inodes have been created.

Add helper functions:
tracefs_alloc_inode()
tracefs_free_inode()
get_tracefs()

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/inode.c    | 39 +++++++++++++++++++++++++++++++++++++++
 fs/tracefs/internal.h | 19 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 fs/tracefs/internal.h

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 57ac8aa4a724..2508944cc4d8 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -21,13 +21,33 @@
 #include <linux/parser.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include "internal.h"
 
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
@@ -346,6 +366,9 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
 }
 
 static const struct super_operations tracefs_super_operations = {
+	.alloc_inode    = tracefs_alloc_inode,
+	.free_inode     = tracefs_free_inode,
+	.drop_inode     = generic_delete_inode,
 	.statfs		= simple_statfs,
 	.remount_fs	= tracefs_remount,
 	.show_options	= tracefs_show_options,
@@ -628,10 +651,26 @@ bool tracefs_initialized(void)
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
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
new file mode 100644
index 000000000000..49b5e8949e1c
--- /dev/null
+++ b/fs/tracefs/internal.h
@@ -0,0 +1,19 @@
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
+#endif /* _TRACEFS_INTERNAL_H */
-- 
2.39.0


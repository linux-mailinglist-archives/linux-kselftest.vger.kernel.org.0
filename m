Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10912767468
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 20:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbjG1SVY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 14:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbjG1SVW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 14:21:22 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012009.outbound.protection.outlook.com [40.93.200.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B728422A;
        Fri, 28 Jul 2023 11:21:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbHXSB6lK+GYztEgq1esT45tQ+bSTT+z4FBsKiNEIN8vN+DhptNlA1AbSN0qlJw/Mmdb+HdHC6yp5Wy95eIakQwmVI48gWQSUAgBYtuBxoMckcACyk5fmgnSGvXpN7bTrqXcyo4hnUFv95xgyF4Hj7lsy2mV5RGKagX72FvNk4twihzSgUmH7xh4PZZVOHFdyujU0m3pKPDUBh9JI08s0kzbQRKAGjxWyke7CDlpCgVro2JZGfnZl6M75jcfe9OnhCOoTRGB8Vll3U0xqrkbtrfInS1oed+Cfmolt/39FDIZaLTx2O1vjiuhjIjm1Ntw5mnS27B3Z7JHDSrYWWVDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9dr8VcqHnHafKIs/SE0VyRBuRoqJbRFE8lhfXDwGdY=;
 b=Kj9GTXmM1o/Rs1Wr7xYcDP+UW0KHfR2yh2u+P87TysT8l1uJ9pM1rVPuu9gqVSF744RVUQ/AUDpfrN954nweaYZSbaG+fOimbUYRzZowtVyKRYLk5xj5GsjRq7LcJ7PeAHL5AR1oPJRA+EyNcABW20E5MbUleayV65eumt1I3r9x3u8CVgzEM3udran7Cog1OrGfE55z7Q68XrgmlhM3fQbc2mLRvInU/1bN2GeaySLW0AQIFKAuk+eyOnvlTtrB+gH9SbCkJO4B8Yqcb36rBJR2AvEc6a4DYOlNrMd6lQlKM84qoBMUtr8mXy95z1FEsUxEY+xigzkudN+s8roBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9dr8VcqHnHafKIs/SE0VyRBuRoqJbRFE8lhfXDwGdY=;
 b=g/xUxHe1wz1UZCEchaoEwf4bzJvDxOQZv0jVH0wWj8QLmB3AhfRc9zrt/f9cLrclFD47LLSWpJ6sWmQmcF94C/1yXCCZpoLbSYrJ02YExP0XHGoL3K5ZhwBu45Un2BTTJDIX50AqWhMc5VvRPTowe8eYZu1A9wSx2oxPYcpiNwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by SN7PR05MB9264.namprd05.prod.outlook.com (2603:10b6:806:26c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:21:19 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 18:21:19 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v6 02/10] eventfs: Implement tracefs_inode_cache
Date:   Fri, 28 Jul 2023 23:50:44 +0530
Message-Id: <1690568452-46553-3-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: ad2bbd36-b5c7-4bb0-64e5-08db8f977027
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yeo7xqc1M5VtVu436TWhqr1WYzwFuX+K7vR+PYvyQb8lDPthRdUHKbDm42ydIZHucVcX/5p7nDa4kbcMfZ7B+CW7YA9azo7Or2aEL5kXMDBLXhqJqOIwks6v/asXtHFRZh/DB82Ld4V4G5PaNJTcLOl7a5mnvG1qZEzTl+HxovZ206hc7ZKy8uGnn3uMfanxvMP4FnBiFDlh4M/lOG/VipAsfJ7s2FbNVvbZEPnmp/qkZFsADPyBOySdfMKkYqglFbGjP6tsHYyGG4kk9N0MbkA8eSXN8Ap7NS1roNJKKPMcdTbrYmPD47E25Nct/LP50a0HjPwDmOI1fzRocZbYHzqLrzG6lZKZP3zes0YqV1upweoZOE89Vnzxx8KYzsfQ8li15GwmEU7DnOMYlwLsU7xwIaB7U6FI5398RIuN4CybyJagp7XliMnUYS0W1bzYo65DqSn2BHIyJ8uRw1a9o14tSmi28pYBa3GOfcR5Y/vBun3wy062Y5eJSLYLfUzAvWiXZsZy4WB7XMHwNoBpLHmwZA1s9MDazUYh1PTsKsK224j80sJ9+qZpJlGF/CUckD1uv2hXoaRSPGHOieierGpwOVAfdXz7S7z1gHaaxhpGToUDT6jozlr8omAQjGXXxrw99gLFi++ZIrImP96L0khjWVjO5eEhcFKejEsPFb4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199021)(2906002)(316002)(7416002)(8676002)(86362001)(8936002)(41300700001)(36756003)(6512007)(5660300002)(107886003)(26005)(6506007)(6666004)(6486002)(52116002)(83380400001)(478600001)(38350700002)(186003)(38100700002)(4326008)(66556008)(66946007)(66476007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FT4kDbKFeog1QQTHAEjr0zKDhcWf4NAqNAqgf0atGwUCVt1vg5G3/EHSnsDC?=
 =?us-ascii?Q?7tA/SDn1Z/YV8TvIL65P2AfJTmimQ6O17t2xr3o9yO95rJFcSF1A6HqYFsAp?=
 =?us-ascii?Q?0rkCHii5iWvtks/70BUx/kol3+scWhWA/tNk6LIIJaPvwTza/kD1Z0shXbEy?=
 =?us-ascii?Q?6GAQzawP6BLU73htIlRswe5tLBFqW3RhqM2EqUuvQ+JEy3ntSrS4/V0F0ZXe?=
 =?us-ascii?Q?OTmMwFRJW2hNp6qCM84pbOttTB+bVSUwBYV4SU/ugA1vuZ0xpcAVtlxMSbDg?=
 =?us-ascii?Q?82b9eb146C7Jouu6bZcNaib5jHnJ7RX9XmQsSNsG858SD9JXx36w0HMHMd2E?=
 =?us-ascii?Q?oYpJkJTX7CkjTRupaCNIwCMbqTOnMG0v9dxmvhcxQ487b+wUUz9BUE2yvkmo?=
 =?us-ascii?Q?n0oNsIVpqeFmLP79/jV3iSPGvACc9asBLqUdlGFTQL5bcgSp6tHtjFhrrEPo?=
 =?us-ascii?Q?LJBj19pDdkEkigmPdRPu8EkN7cBTlN54ZLm+72Wf3oLiy5JacbwnMJUTjYGw?=
 =?us-ascii?Q?t9yqYLpkqUqnrgpMiNormERxl2ueeknCczQQ7iBcTg0guP76MWuNf0uoRVpN?=
 =?us-ascii?Q?9r4vTNRqLCmYUQ3HGKOMzMnrfx3VX38tocRRhY33LY/y3DVUDucGn+8d/1bn?=
 =?us-ascii?Q?eE+LjWXP3IbVZ/7BHoDdMNqnCoieKrjfDPfB08BZv/VlFWth32tw3L3kgVfY?=
 =?us-ascii?Q?vZLtvF+2s/YzPSYsSL0418KByIPASqUKa3hck6dR++A3PDriRWVdCQRIfX1Z?=
 =?us-ascii?Q?WeRVYihYepfT7QvfryUKb9Ps+9wDoAqCiZO2MrJ9ZxCv0FlGytc29+8OZMLa?=
 =?us-ascii?Q?E4JrA+SUOYdsUW9+NrZW/XF4y9/mq9Df3riZ5Xs3afpKjXsCAjkFfl+HjAZw?=
 =?us-ascii?Q?RW/b0EQjwzTgEMfhs2cc5JMswU2iqlnK7p2RBwry2EAelp8IxGbSaaOaiL10?=
 =?us-ascii?Q?S6waB2Xm8UQORcWsNmknJTeljDyEgwI1cd86fx9Ho40XMVzpDJk+aPE/1VgU?=
 =?us-ascii?Q?gTXy1PzW67CoADgW/IZLbHHDNuBfBsNNQfSMMmHXRuuCKtL16OHKENLULjGz?=
 =?us-ascii?Q?gbxzdJWOzHSzLwzgd+LEHgb1SRKWyMAKe66hFnS2zgAolaOkFRtMLizBSb5u?=
 =?us-ascii?Q?aCoUYPfxnRQvg/pigigEnHN9I40C5/YCaUiH+buS+bcEP45cO73Mxdc2zIIH?=
 =?us-ascii?Q?d1X6zKWgoMKH5MSgfHSuwRdhEXL5BWj048EM/hU28WpZ0UvM0yNM2RX0xCHm?=
 =?us-ascii?Q?hAVpqsFdZQznHu/7+PU9DOMzea9dz7mCyz5GE3aVvL/wU2IyMdOrsoTSPw0O?=
 =?us-ascii?Q?lCIR/YGcLZymIi+xvJI3lqlvkPW1R51GNWhgEhpoNEL9XohODnacJjdWvIaM?=
 =?us-ascii?Q?uFoMJZbbnJ++kVgH7aPDNPRqRHriitrsS1Oj22lYnoFdsGJujjVmyxc7i8uG?=
 =?us-ascii?Q?Fb1XbTyD7c8ysnj6qr4IBSJhe/XGtXz/Ss7el/uf34jLY6Ff3BjADH5oxMyS?=
 =?us-ascii?Q?kra7wLacCBqGXDwLRpn5Nmv1xD0d2jv65oimw3S9towP9nWwztm35gSHshdV?=
 =?us-ascii?Q?zjVU6olcIaSqV49tNNviwmL8XXzwXaU76w0rj6SJ?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2bbd36-b5c7-4bb0-64e5-08db8f977027
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:21:18.9072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckH8W+j2TocyhhE8cWr03ICvNYJh5h9KNKjUquNF2vjOk+oIv65/6kmik5lOL+G66uAVz6I3ea8wY5htajpnzg==
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
 fs/tracefs/internal.h | 15 +++++++++++++++
 2 files changed, 54 insertions(+)
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
index 000000000000..954ea005632b
--- /dev/null
+++ b/fs/tracefs/internal.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TRACEFS_INTERNAL_H
+#define _TRACEFS_INTERNAL_H
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


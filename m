Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA9A6F42C2
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 13:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjEBL0p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 07:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjEBLZG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 07:25:06 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013004.outbound.protection.outlook.com [52.101.54.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D935FC8;
        Tue,  2 May 2023 04:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYqEaCUmQH0jYH7IpFcQlQz2ccx57hLYwRmnB92KBOm3sD6yAZjde7kp8t4DC48upmkkXtgmVJTbFAVM8sElUWR8bLTmp9CT1yKvnzZZ1aa5Tkx2xtkJCIxIwHuuau5Mv7i4Cj5Q6r822syXE8lbiQOn4S45zOAedlX7hSI8ZzdFxB3zjVf7HLaHxeEy+rEDGk6agZKZ0H0vp6120/c2RSjdyLOiRiHKFNYee//NxKSlfOtRSFtXYBmoEDEjs79Hz2EDpZWJHw+o6EGpe/aYQ1RzeMx0olifyWOmf38M/T04GKFkaGivdcC/3p468gFZTJvf3U9DRsdJCX/T4AtVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uInKmho4B1o98gZBl2Y1AdyjuUqybZlbhrWd2mDIjDI=;
 b=DzttNHlFtRU5n7ZEwSkuVy21H+G83AZ6TS9qYOxS8OJ7rcX1dLgB5QPOlGhHbhUJybROBnMPHMyhptdrqqXaVhXQWvCIzzJkY93jgQRro7G0kAj0jFRDf3dZjy6J/WH7BV7e9w3Y9pFEg6Bp9/mkqWpOn+AgdRcmmZW7kEwMtDjNHHjJH8jzSA0eZa3O7+5r0fwtlpDb9sr0zHKuLKqNwARylNzTKdpO4etIhVKL14+J6C4sEFLVZ/WhvubnIpTvpKqXc3c89lzdNE9Q/KQ1diFEaU4rVmgiDJM8yZpjOIotarfCy+YbXGAgTUHcZFc/bqWqBotWk/tPPwJLlBCo6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uInKmho4B1o98gZBl2Y1AdyjuUqybZlbhrWd2mDIjDI=;
 b=Beu7G/VxNRosAgKEWT+qpzD5BHqZqqYdaEKf+uAsC2nONvn8vehgkrb0tUYJ96RjtPC82/P9b0ZH9f+ePix/8vrbkNaf3HixIlsUoOIlJFJvxRFm59JY6fBtUYLfIMXzqs+OxB9ovy9hcq7VhRis2Y1y6S1g80f0fwaBWZjJy4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by BYAPR05MB6648.namprd05.prod.outlook.com (2603:10b6:a03:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 11:24:22 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%7]) with mapi id 15.20.6363.020; Tue, 2 May 2023
 11:24:22 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com, Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v2 7/9] eventfs: creating tracefs_inode_cache
Date:   Tue,  2 May 2023 16:53:18 +0530
Message-Id: <1683026600-13485-8-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: cc1e70b2-96d4-471b-ed67-08db4affc740
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLypwlOTLCrY4O2skGwn5uBcDjjpz0SGzTLvDk287+BD4+Phsvbokqg0prPmg9oFwpUVSUcexD5qlYhMPQyGUJKUwO1sA2QFbLZqMKZwUCSkMN9AnaHp4xeXXB2iWKT8h92vzwVfSvzCQZ9+eImKrkhEW88ak6eUF+w6f70fAOjpt3fnQjCMt6PX5b9DVZsnSJGWZA/5l/rv6UIGgkG+rrpSWapHcGxGNHv/PLxhV8hw6CWaq11QYVYV3qdB9dV2Jr80iFEOMU53jzPUtY2grEHApsWLY7SZdWcb7re4lLCSmq8lg4BhNHu7zR+zzPKa0TQh4fccPagMVMrQxn8FtFTWWWulXt2Sv1GoZ5MWVzG+sJj7SITygj8a8uij0gPlGcBlv2p0xyjSEMMIa6JhH6y3PlxGEarWyQB7XXdS0eE7F0ukFz1YWudCMg0ikegItK/QpA32u6LVh+Q/boHTyGZTqCzW0Mxn8UY+eQcIGd5FuEGQmQ3fNH1uqsuUkOmczm/jibEBc3v91jsy/ukiP7UI0M2XMIH+27pL81D5Va60uPuRUxKvJkB+39/8NhRUHELYxgz51f0OJ+DqAOQv3hMtpEjtehS+3CXuhqU4ewz+D+d1iixaIgVz5SV46Xpg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(6486002)(6666004)(52116002)(107886003)(38100700002)(38350700002)(2906002)(86362001)(41300700001)(66946007)(66556008)(66476007)(4326008)(478600001)(316002)(5660300002)(8676002)(8936002)(36756003)(6506007)(26005)(6512007)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FAX4z+vI5hd737vvWi1urWDf6Nj8cJ9p/D8k6r6bm2NP/TGlLkfgrB7yjpUK?=
 =?us-ascii?Q?XWEmHkz8hjDoQNpBLT8UQgsRSGT2TDcdN4X70Ha7pAISUuaTvtInKjg2kpNQ?=
 =?us-ascii?Q?Z9fO+Y62vHiw0jGzUldkh714mk8VexmRpkb9ZMA9A1qlSfF5M9lxGS2uU981?=
 =?us-ascii?Q?EClLsYxnVkv5Xx4mUoJLL1QvIQvsniS3Jp9PqkcpPHONIQ2MVwPaDmZZ9MwB?=
 =?us-ascii?Q?zb4rSe6HoBLrduOTB977DRhAYv4aDJp8fE+hkyg6mLZbzbsd87WJYss0mp9E?=
 =?us-ascii?Q?4LAhOqWheweyUWMfvOkM/hJIblanDJ2LOKPAw6mPvl535Y+GRHfXWBZKjhvv?=
 =?us-ascii?Q?vtdUsG95qm4se/iG5f5nl4SmbHGsMbwCqzxQzXo+fApkNLvDDusGzGICDJov?=
 =?us-ascii?Q?0bVPMbBVL+GUlyokncX5HZUGcwSgZ+rmwU/cs4L4vi5BdCYuJ43I4smqepxg?=
 =?us-ascii?Q?3R/mKhPfNG8yz2Hf1ROJjf2mNuVjYurpmgNQt+MTcx6+XX+BuYDIKiiMOYma?=
 =?us-ascii?Q?x/bXe3VdU2M9aCBNO+mip0T3FJ8kIGdSYZSFBYHqoPqkMCSNJ1qGcM6CbP43?=
 =?us-ascii?Q?nnHFHqL8qyYn2rAUDm29AMlcmAhR9UD+G+SKRj8kuZ4rSh2Fxq181oGNjdTf?=
 =?us-ascii?Q?a17IAd9SEDA7jXgzpxGK8SxoGWttsbO6WzE9JhlNxadZnPhjdDVHdDLeR9h/?=
 =?us-ascii?Q?8NdV2x3WjmxbYcoWUfhkNz6Ugsxo2UTj5oVrCRgRSzX/D9/JS8P2YmTJ689R?=
 =?us-ascii?Q?4X+euEHQw1neCmYhfwPvOCfyMQ4Gfu/9VHU2qamxd+5+aGzqEUQvmQQmngrN?=
 =?us-ascii?Q?X0syGKarkxICgg0ILJeNrmdiU/ynE1Imtcl9g4sr9TfX9rO0zQ+ozsfNIbwy?=
 =?us-ascii?Q?S2d5l+D0H1EGt7/XX7WPtwQ95yfJOsSJX+Zg5CHhE9D9V7rg7pFcXd34Bp3W?=
 =?us-ascii?Q?82rlm4arEmjCN1lka41UJ8/Pcg+KfLiKeIrMJu1ZQU78Czj15FdCPeIrttPL?=
 =?us-ascii?Q?SM1bXsq4OmObU1QgST7klTs9sDEoZQ+Q1qRjHAHWBQAfxUftEKi0HGcUdyOd?=
 =?us-ascii?Q?kluCeWOb8zdJc7n41mKwHJWEHPZbz9iabX8RXLAu9h3kDcUqCS+JK9mzPdIA?=
 =?us-ascii?Q?fXzq5MLIyXZRiOFViwJBlLH4GGAuVjuCafjICGLsy8cG0t3UWoAbZZKqbD+B?=
 =?us-ascii?Q?xGwj7tKh/iOUA0NO8R9dAL+Reslv7nCCo0jmh65kUUm6hhqsqko6d6QG8PRK?=
 =?us-ascii?Q?tHKYZthDvLVvCHOO9qWjxquuf9ewWQz+wsHLwPijPiyQ5nwh5adPiwLDvVkG?=
 =?us-ascii?Q?+juk0OWsK7F717JvFtDdKPu+JrgjSKgWFxvr06j79CG8p5SiqwTwHpXeb9vX?=
 =?us-ascii?Q?qQPtSXrGLQPpTf4ampcdrCQ8KO7HMJs9pGTIr5OKXre4usDUQgRUmbaNhQEe?=
 =?us-ascii?Q?L9yIF0s6OdiZoFG1bQBuDfUuAfRexh0FcpB2tMF4cTwriqYvY2nZw6S8h7Yv?=
 =?us-ascii?Q?j80x9a7yDXxsScU258upFFVx+yM1W5GF8SMkqUlkoC+qNePxhXHT8XnQV/ll?=
 =?us-ascii?Q?s+vsUAse7RJxusdTYfGm2ay8h+LG3s4fFgkA8KKA?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1e70b2-96d4-471b-ed67-08db4affc740
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 11:24:22.4737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJlYoaGXw4hTISy/15RLsLMjRIIFoSsVjYwmC/YFB3KYHnY/BkqDXLjpByqrk/dN4SUuVcksNr7bPqcpNcnscA==
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
2.39.0


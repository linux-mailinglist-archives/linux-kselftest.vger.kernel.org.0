Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC69751FFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 13:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbjGMLeO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 07:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbjGMLeJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 07:34:09 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013000.outbound.protection.outlook.com [52.101.54.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C702C26BC;
        Thu, 13 Jul 2023 04:34:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnCuXYaA9Sovi+Zy1lQaopC5MRyShmSvSfEfRZwLSL1nA76/s5AzhPiDMvoXPrznwnM9ti4WIKBiCBmzTMqHCJOzTHkPFB3MIb4m/XtGwRQ4R/71lSYHGf+/dOiEMrnd/D5PgXfC4821HKzcYtSDaI0SckHODoCYCyt7Tj4kRgluPAEvKMhTIo0tQFrZQjLBn5rvNUoMA1SKlqmNY/avIFt0lEQSltTghuyJGQzkdyLFPge/c4MldFf+FrZnHu+SiSs4dGXx3V1FBImy1H9xoI+sFQJ6SvASM0TRgCgyUgvZK3QZ/PyoopkKu/m0XtC9e71+z+viiuC27v+ssQE//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbuhKy+qPAdxyOC3p4T5oQ+vQWR4mVCWww69MpvfbWg=;
 b=jGI3Zx9Eb83wlpAH09OkgJ3FMgg44YozI9AU1U0LkET1B6aUqnNYeR8pSfhBK43OQXFWxtvwgrljU9CZO4p4y59E8F26u6yFjyaGzD0aCrj2hzv7gMA5bKYnaqU2jFYbMPalyfJnkTwW1tYLrDElDhU77lGWc7OvOl62111EfA1xfCRux6WqjFI6mvWUpnqgiXTtBi9F7lHMIFOJ6TL3JB7gur6tiwxxk+WttA8zs5vmRbiFYfyY5Zx3IrlPitPjvIfsEXoD6kLUDVqX16rTYvh02L+8nEJ1z5gRErQ0hDzA+jmZvhR/AxQBDiDKPbcBRTkGgFIfTXmo9750/Y0LRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbuhKy+qPAdxyOC3p4T5oQ+vQWR4mVCWww69MpvfbWg=;
 b=QQAno0XNCDGBfK+/i3ADzhI23PLBXfSXqk3qeNAM/2JH+vTfS7viBzOFIzFsZlLFdDlcQIw1HX78lo6mBjtzQd4Cy3IAKeij3fFFH/5i53WQvgVy5iUnwbqNCIHxlCyg8vyYrXjTViw1nMaXweJ3RplrenK+vq9q6/4kExkB2ro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by SA0PR05MB7452.namprd05.prod.outlook.com (2603:10b6:806:c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 11:34:05 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 11:34:04 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v4 08/10] eventfs: Implement tracefs_inode_cache
Date:   Thu, 13 Jul 2023 17:03:22 +0530
Message-Id: <1689248004-8158-9-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689248004-8158-1-git-send-email-akaher@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|SA0PR05MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 12751f85-b0d4-4f36-a983-08db83951003
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tUDGVB6/G8P1Jm54dZiDA8AZueteLficoo84q9a9OBdnxGz/wZrz05S3opCo3VG0qZI6xxki+9ls/oCUezttGybHPeFpTwiJIetwSuM1JSboupvB6YY+JancdTQWPq/AUUZkVIFyyS6P+txDeH3XU1UvkhJCJwTFcGkvCKTw+EisvX9wIxomEBARJ13kN4+eFil4ERsLFJQTmJeZLeJVucezUUEwLfgQ8+TGoXvmeNQPgNgj9dx+2HDf7rI5h5lbrOe0MGg8Eu5AnGpleSXpKFlHgrThMORWkZH4M+hAtGNx6BuEXh9h0IO0/EdZkv6cpSu0ExPAx5D2B+++WKEogAl2FaHjwK08/ySiPejJoNBXudzcmN1J4sR54rjFToTKbqqt+IlJAZgu4vWUWLGuGWjaRgsY7yEM2bKqs8GmTtfVGN9rtHGwYi51xzK3yj8UR9ou0emBzV1qvDIihA/6bDPAyB/TVhBl2QApyMvU/HL7m3DVxokEg+KAsKi3bFu1lB0t+a9Wg6aFQ9ZR/JmtEHUUr2OaCthk7PShhf8s7t2Jej2X8yaUzgS3QGCLLLebNdwDGnS6Z/zpYxWL+3Z+RNGJkGlJQwMFFfaaut97qPxcPvd5Jzm9ZeDYzHPsn8DPWLdchdAtqq5ZyM5W24Rl1S63cmk+3jV+/6b6Db4yQF0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199021)(6486002)(6666004)(52116002)(478600001)(8676002)(5660300002)(2906002)(36756003)(7416002)(8936002)(86362001)(316002)(4326008)(66946007)(66556008)(38100700002)(66476007)(38350700002)(41300700001)(6506007)(107886003)(26005)(83380400001)(186003)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?74A1lK123lkgh1W6KtpIHEzpx0jA/kGlW41mw8FwvsLPMJs0XmM1EybEuDPh?=
 =?us-ascii?Q?LIjgSgH6Gks4KnwlbfTN41cafx8wa9BxkEGapwSUD7BkGKG75NZuX9LJgwuu?=
 =?us-ascii?Q?ntd8cvajAGnHWos2X+7zSJif8cLyhWbDLfpZ0pRGUqGWlCFx13vuOGuHCSob?=
 =?us-ascii?Q?tLY70NiyU2syScMmRaPqyqXi5PvmCZxbUInS+2VByhtLNnYnjgQ7cpNZIHLF?=
 =?us-ascii?Q?AGEE9cMZelwzgRu1VnGnJhYJ78KQDeGDMlgt93hCIZWVMU9y1FA0sBRA61It?=
 =?us-ascii?Q?9/AN7La4H/oGBplYAEKFTSsH6BK40sCT1rg+uD72VkAuSIGsot7e9lktH3gx?=
 =?us-ascii?Q?jHHwA+UjonsPVAKwX2xaiitJLU1Xnih+4aW1WoSkDqjxf1SZ61B1vtpcDK3C?=
 =?us-ascii?Q?9CEp7rUahRhAXjMHKhDKWe3zauJ8wKM4X473N2S2cv30LjXBnW8EVHNd4jXd?=
 =?us-ascii?Q?0vmllDEJ5qKv/xfdFgJfhs4mBokIMHDE+ZNCqrd74+WFCLOfW9AiGc0xFeoS?=
 =?us-ascii?Q?g2CdwUJjz19o5Vas1Z5PN+G1ilHpSiGEEhUv+8fz5pT5kkHYYlCJnh9s/U39?=
 =?us-ascii?Q?lF2taX5RTRlxusxUoc8PwFk+gq6IG8L3UkHTgUedOfkrsX7XMkMceByJAbO7?=
 =?us-ascii?Q?TTj7rK5vUqWJG6/Q579i1CcZ06GD1aqBMtitIo+BJueMkNCS+LH6wO9njsxI?=
 =?us-ascii?Q?Lgrgyaysp6duCIeONnLBW9mVfDAN4kZ541pua4E4VKOsdYKooj7cao+Pf1hu?=
 =?us-ascii?Q?kTvKYiwleCPY6X/nqE6XD8ORCxHy5aQq7pv7+GT25Zn/fVBba0lQYSCh8nzc?=
 =?us-ascii?Q?pU0JRjy2XKyZzqMHVVFC0tL7SOlSRO3OwBm4cFdqTIlljbh0oGDhFoJcAMKZ?=
 =?us-ascii?Q?Rsouc92DvUHYYwmYjGLcgPcAwf8B1S+R+/ZULEIAery5lGakB/EjrDaSu/qr?=
 =?us-ascii?Q?0L8A/KNwq/N5qcHwkXFP1aegxqfHGTl7fu9tVpa30sIewVtqk6fcJkJvtNHQ?=
 =?us-ascii?Q?vam9fvSXbWtBV0yUbQkdU0dFPga1VttHAE39Cu8lef/C3WgfCr8sKEKk+Yos?=
 =?us-ascii?Q?e53W0TyrtXlpqZfUq4+FFaHO+IOa90zhvYd/AjH2SxB0sEUo67+W4zwZyMgP?=
 =?us-ascii?Q?ywJnlCXnDIiKBn3rENbc9rozfEKIpaelXqS7rGjXxYwE5pmfR2JOwgCboIPW?=
 =?us-ascii?Q?JEeQLmXRnjfj9IFFnYDRy+0k+mEtS+nrn9idcAV/x8bGEuhZncg1udw0uGvh?=
 =?us-ascii?Q?vJmtaBxbVLx56LdN/iQb5IiujhqLHRZMuhr6+KSQxw6J8ckD8RI4vv5/ozg2?=
 =?us-ascii?Q?E6sWkEF/fvf+LfYV6EVdH0pipM6OdIzjoi5JCnHxKninBvX+EYhFA9U6XhWh?=
 =?us-ascii?Q?tsJdyjkIzjL/yhheUj//rdbD+d1Vzr9T6DBBxcDA+sKiC/zXZK3aKl4iFf2t?=
 =?us-ascii?Q?V2MCmUizjprqIkRvjv/Eg2JE+GHh5fCc9XHaqdKQPfe8k+6IKYqAV0gOq6TP?=
 =?us-ascii?Q?oKlKswZ3p6jC9wrP0DWD6H5DNER1PiA2Sz5FOCWRvONe5MDdqucjpJzFIK/s?=
 =?us-ascii?Q?bqsLopgNqoQaay8oxs+aRMOMCx/4mmaO+VnvBpiw?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12751f85-b0d4-4f36-a983-08db83951003
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 11:34:04.6505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CGyh2zjym/NRq23RQjV4hmwNM9Tx3PgP7r5/8zOxmDUW74/UR0HeZEDHg/ZlE61ifaqwvzwjyW6SszcErvcKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR05MB7452
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 fs/tracefs/inode.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 7dc692a5fee1..76820d3e97eb 100644
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
@@ -675,10 +698,26 @@ bool tracefs_initialized(void)
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


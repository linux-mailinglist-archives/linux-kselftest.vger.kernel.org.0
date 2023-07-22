Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B77F75DE4C
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 21:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjGVTiU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 15:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGVTiQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 15:38:16 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011013.outbound.protection.outlook.com [40.93.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7808AE79;
        Sat, 22 Jul 2023 12:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBL3E0egpdO22eSUyornl3G0iZ3EXl61irkyEXi+jW0WKRqvzj95Q1rL0IwD9bkUytS0ERAIWqt9lVYVpU0MKKFuVqkp5NeGyB7nscz4RPHnzTLP/fgdv9jJ7qsfQyN2LwA8+q9mTXiQ3agQp96yd2L299kJS9lc+XphQfr1NLKox70uTbSi9qKnBn3BGZGWPbCwXqLSzohaMxReKrd+Ix3CaOsn5GA9CJ94uixtcOIupSS8fDbWvBcY+KSVUvbixOPNCLTfBERG/vPy1JGqlX77fLetK3msfMf/+lkYGOl2f4AwD00auYHrQzlFJ8zo9eF6TacSPZ5adIk7sQ0bFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMrfZpD+/VgyMNu5S59jgiJp8+d66EeCuVSA16vQWxk=;
 b=Jh5jws7/irnrW8MKVJ96NYP27ofFQu34MQFACrms5oryxxrxPuUAxA5skAULzC2IUp/PBUbagnK2SGI+ArQZZYCtnrsKyLPrS9Ox/x+ziDS4tmGrlTo09zM5d6WpFB0aoAF4PvnARC6bI8GjzB12HBD+6r8Jlof8EvxH/hEepHllOf0wAU3NNRyN5jmSgVouWPa4mcOpsH9uXDLIndAeSNc0L/XmcsvYP/67xVmboNEzMi9qGJug6v5ycX2q+sD0VJ8NZvVsTpuMkp9jcWYHEAHuAhsbJ/K5Yj5dFzDLChmIRtsEFiKrXrPtQptDSyeZNkeSdoZb6ootA/9HEgpD4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMrfZpD+/VgyMNu5S59jgiJp8+d66EeCuVSA16vQWxk=;
 b=x/YVwJ85EFcEkmQJ5tI4ngF7U/mvQMG4O9A6jguBmZXq0U8p/YEGfvpPFNOaSdbkxf5ocE7m3yBRA1vQlSwFz3fl0npm4fnJUEaTQDK3qlEAvR9Zfu0yAx57eXIucENvJVvmEb/I+OKm2DFJwf9soVB0kLuTs2BTZgT2KIfmFnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MN0PR05MB9005.namprd05.prod.outlook.com (2603:10b6:208:3cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sat, 22 Jul
 2023 19:38:11 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 19:38:11 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v5 05/10] eventfs: Implement eventfs file add functions
Date:   Sun, 23 Jul 2023 01:07:00 +0530
Message-Id: <1690054625-31939-6-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: d2afaf07-6057-41c4-a904-08db8aeb2f04
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4UgtIG64BScm8xUfIap5RUr1T1aPKm06DS4PbZcyFbV2gcz8MlXC32Xx+wDlrSeT/8Hu3UG8niyiiqNwo3pRnfA+Ac9mHhcUbzXI6M0+stTB1QL6tWI6fP3ymKU/TSJ5MiOYoG24D1clgcFVKucVvHKgJXW2oT2iftHNozdmqj8TALxZ8uCXoaPXuJ+wvemYA2g68j5I4yI+e88AoQJM+OUYYhHkkZ/k4/jECvtl0T4igijR6LpT2SjOeEgeiLBrJ7wLhQ82EGlGbYuiUXgAOsn1Bi4deI9Cr/nPZAeaBth7bv8b1d5gOoCBEfnQ/fYYoncuz7gWFBeFG/L17+H7KD/ZOrrdojo6pX845QwLWpALyj1LIYpHAJwscfWyjTVVa9rHKVHid2KGkgGFEuBJtSdS+9xrcifZpGkJ/5K6BLhZdoYNd74/MdtfZPcFHpRQx7BTL4i2OfVwbjbFfjby9FQFv7xWMxIVSQgjvuvz24N0WL+OQ9VUfnzZTH/4Pb64I1kLBMmacVWFEPsEnDuVfqR5FlawtY1xedhTmnPUt4nFJHep80vFqZX5hXrKbOshq1HMqE0jRNV8mh1z/kTz0MRg69GEkh1Gt4Ktj/NP7saXbrcwJ8JNEg01uR3QFuERhUY0Ixg2neouNqNs6B2o3QKlVzGBR0hZvlz2gW5p1En7CE8lLEGpqbvCs0h9UW9LkBzoNagQGRhlxCVoAt+Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(6666004)(966005)(52116002)(6486002)(6512007)(478600001)(186003)(2616005)(6506007)(26005)(107886003)(2906002)(316002)(41300700001)(66946007)(66556008)(66476007)(4326008)(5660300002)(7416002)(8676002)(8936002)(38350700002)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kfOIg3zvq1EGDKE3QM3rx7fPVc/LLeMEUQ5PaYJPHnuTo4+6JgsxIToLQfPQ?=
 =?us-ascii?Q?bCp4MgDSWjgjkdo9GReZaTuIzrdQEnjtxtbZ/gpjMTFG8VfQhoWeU5XVoxyT?=
 =?us-ascii?Q?gFo3n8Vak9Y2NW1ep5gGoQhZ88wwQNUbBwG0ZnqDHMT19ZOoiK1CQbaTUUpP?=
 =?us-ascii?Q?+qVo9D3YxAe27JRlbhqmwa/vidEK0kje4labhMpRoxAWid8pWoah0HDci4ru?=
 =?us-ascii?Q?S9gyofnelat4yC/V37wVBmPwJCM04exFo3rUDI8wNR6IjmPp64k8QZTLp4CC?=
 =?us-ascii?Q?8dW8Ky8rSh2WBTkjGTeuMyk9QZH5ynHiXiOY0aUkHwF/tXyaqg+m1cQrxdAF?=
 =?us-ascii?Q?2U66VrGXfIK+1APbuIannDdkePpl0rDWgHaQuIvjR0k7TDpEa9q8ByPu4dI+?=
 =?us-ascii?Q?mJKNcMk5GdOz47f8l+KJWSfafcpj1I6743EIzYBbG4fAI8qGqAJeoGaVVwpM?=
 =?us-ascii?Q?teBg6UL+oSY0Q5XSBFJ6X1RXHs7xt8PErHkyVbTsvcNjcA5Boq+TczpiO+3L?=
 =?us-ascii?Q?MFzDF3BKKzygAvmKcymrDM1L8jT8vtTIE4irepmmb5r/cDFNPwsd37QEfwuV?=
 =?us-ascii?Q?hRa6idQx+DMNn+FrTQmOPDjLU1f4xeEWjSU5cHpZnrIkygqy7zENuOct3CFy?=
 =?us-ascii?Q?EpD0IHgj0CjCpAhXtunij3oeiSKjwopQzuDtyaPMG7qqEhKjvSxmXkkRk+JO?=
 =?us-ascii?Q?vQtUBjNuAYaENPxbPfiNf8R7iVT4p831kkBJNhguyJdqcpH2cDOh8FHGSExF?=
 =?us-ascii?Q?VRZeiQTuwAKoUOZl7ZjEyG+PXRJ11OuARaEvTYXdM8ixfsuEa6znpRUeg0sM?=
 =?us-ascii?Q?fJqwc2+RC7tY1uCt9sMUELI3kJEnVjE/u1SRj3/C/mYDOHvthRM0kdEMTVYe?=
 =?us-ascii?Q?gCcbDv0iKVSn2P6bAR6QrenkpuAUdZNxHxDceDAWc9BNy3xYOz3jweHBrAf6?=
 =?us-ascii?Q?Tu+w70VUGn46VATOvEhQMNbuutCgFVK4MqOH1mYBAyZo//BkEHdFiyXe6Dv1?=
 =?us-ascii?Q?Har+tC7j13DILTjx7SxsN1Ig1lVRsfn1B75JWfCuv7dgdLPJjAtwgPTqNgQW?=
 =?us-ascii?Q?GbZvlQaAmCpML/dBtsVCuYnQsTmu0HeIErhu1OSSW1qTNHZoWZd9ZKrYJvL3?=
 =?us-ascii?Q?6AfKgItQY3CPjKx92NjVqbz3RxBwZHiY1SOGOPkDU/HqIFvEd3Ms9KnU/lUg?=
 =?us-ascii?Q?+q/cXtcQ30IxVndgR4q80xpz+4BgZNfO1Let8sEkEeO7YoivB3ZYz1Auo9sM?=
 =?us-ascii?Q?TVTaVlyIvEGGxRaSPcX4JbCEa4fD5M1cdLPbKAD07F1UYnT99Fsj7GbHYkjV?=
 =?us-ascii?Q?ebk+PWGU+6qdvJmqHcrI5RqtNGX4Dy4UqYAjPZHf/sI0DyJr1nMrCB4pC+Hu?=
 =?us-ascii?Q?eCimgRc9ONmjGvXRFO9gfUgLO86kKj8giqyKq4vGJGmaHGq9AIZrHKcj3uEM?=
 =?us-ascii?Q?S3zz1kJes4SCfoEyFf7ctFB5LYinXPGQlHQXiHMMCxiVMGq+wJ1XFvBnvhns?=
 =?us-ascii?Q?LeV+j6UlIdmldUEoMWuN+SbOF5p3m9IIltEXEPRJA9WEFHw3z++RJRQs0IBO?=
 =?us-ascii?Q?LjqmHyC3PrES4Shvo1ag1jo3JxZi3/Efr+ZXZfq9?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2afaf07-6057-41c4-a904-08db8aeb2f04
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 19:38:11.5256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttKTbWmplxRQecU9FjZoJUxvwXSL7cteC4w9+6ZdG31uSrUT07+Qbq82ykJgwTXAZB6lYTlIQvGPXRJvvxfUTA==
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

Add the following functions to add files to evenfs:

eventfs_add_events_file() to add the data needed to create a specific file
located at the top level events directory. The dentry/inode will be
created when the events directory is scanned.

eventfs_add_file() to add the data needed for files within the directories
below the top level events directory. The dentry/inode of the file will be
created when the directory that the file is in is scanned.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202305051619.9a469a9a-yujie.liu@intel.com
---
 fs/tracefs/event_inode.c | 86 ++++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |  8 ++++
 2 files changed, 94 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 8f334b122e46..9e4843be9dc9 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -209,3 +209,89 @@ struct eventfs_file *eventfs_add_dir(const char *name,
 	mutex_unlock(&eventfs_mutex);
 	return ef;
 }
+
+/**
+ * eventfs_add_events_file - add the data needed to create a file for later reference
+ * @name: the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @parent: parent dentry for this file.
+ * @data: something that the caller will want to get to later on.
+ * @fop: struct file_operations that should be used for this file.
+ *
+ * This function is used to add the information needed to create a
+ * dentry/inode within the top level events directory. The file created
+ * will have the @mode permissions. The @data will be used to fill the
+ * inode.i_private when the open() call is done. The dentry and inodes are
+ * all created when they are referenced, and removed when they are no
+ * longer referenced.
+ */
+int eventfs_add_events_file(const char *name, umode_t mode,
+			 struct dentry *parent, void *data,
+			 const struct file_operations *fop)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+
+	if (!parent)
+		return -EINVAL;
+
+	if (!(mode & S_IFMT))
+		mode |= S_IFREG;
+
+	if (!parent->d_inode)
+		return -EINVAL;
+
+	ti = get_tracefs(parent->d_inode);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return -EINVAL;
+
+	ei = ti->private;
+	ef = eventfs_prepare_ef(name, mode, fop, NULL, data);
+
+	if (IS_ERR(ef))
+		return -ENOMEM;
+
+	mutex_lock(&eventfs_mutex);
+	list_add_tail(&ef->list, &ei->e_top_files);
+	mutex_unlock(&eventfs_mutex);
+	return 0;
+}
+
+/**
+ * eventfs_add_file - add eventfs file to list to create later
+ * @name: the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @ef_parent: parent eventfs_file for this file.
+ * @data: something that the caller will want to get to later on.
+ * @fop: struct file_operations that should be used for this file.
+ *
+ * This function is used to add the information needed to create a
+ * file within a subdirectory of the events directory. The file created
+ * will have the @mode permissions. The @data will be used to fill the
+ * inode.i_private when the open() call is done. The dentry and inodes are
+ * all created when they are referenced, and removed when they are no
+ * longer referenced.
+ */
+int eventfs_add_file(const char *name, umode_t mode,
+		     struct eventfs_file *ef_parent,
+		     void *data,
+		     const struct file_operations *fop)
+{
+	struct eventfs_file *ef;
+
+	if (!ef_parent)
+		return -EINVAL;
+
+	if (!(mode & S_IFMT))
+		mode |= S_IFREG;
+
+	ef = eventfs_prepare_ef(name, mode, fop, NULL, data);
+	if (IS_ERR(ef))
+		return -ENOMEM;
+
+	mutex_lock(&eventfs_mutex);
+	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
+	mutex_unlock(&eventfs_mutex);
+	return 0;
+}
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 432e5e6f7901..54c9cbd0389b 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -32,6 +32,14 @@ struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
 struct eventfs_file *eventfs_add_dir(const char *name,
 				     struct eventfs_file *ef_parent);
 
+int eventfs_add_file(const char *name, umode_t mode,
+		     struct eventfs_file *ef_parent, void *data,
+		     const struct file_operations *fops);
+
+int eventfs_add_events_file(const char *name, umode_t mode,
+			 struct dentry *parent, void *data,
+			 const struct file_operations *fops);
+
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
-- 
2.39.0


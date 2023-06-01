Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C51F719636
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 11:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjFAJBZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 05:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjFAJBY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 05:01:24 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013013.outbound.protection.outlook.com [52.101.64.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7F318D;
        Thu,  1 Jun 2023 02:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J65KaQsKduLVvu8RAkFfNQ5NOzwIDdBibWhvubI89egSgyS861I1Bglo49EcEoMKUcPPhkBqSqmizwCVa2ayxs6LcWMmi50mrdF84QpZ6Ar1hiUjmxQgJ0GlQI8g6POG/Dj0p/Vp6QGyR/7CFzA0MYifikaanfK7pCzhvoNAnoyIXu/V0/cFkalCHb2uK7KWYG4m05qUYRxPgV8gTD11LCPaGR/gAV6Ftoh2gpgOgEUEblKHVnvjKioItxhNg3AzyugxPeJhdgyk7BTtBjEtZpSL9skKypk6gmAh0joNcpcwcPAZVSzeRlpY79Rkg7k/fKJ/lG8ZEhJRgA2pQTNtVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsLlpR9iDNj7N0wDvwwEXuC2d9AucQzonSxF8qegTZo=;
 b=GY+PqAgKPB2f9bwyvYPoT9hqLzhe+x0LDW3pMbeagwSsaYXBQ92NylX2kBtBZ9aEauFDbnzj0nDjoYKUJ/1cFHmzFvSobxpCc0OZ0ZfZ4lY8u+rbO2XcTllgix8UFZa/xCESIWesYaN6oVleeXpnBpukZ9FikutdIDT1WfeWt+RDakmCMJDFjezHikTaunQnX4Cz5xocLDzIAvOl8FGVQqzt8YCkfLbM7Z2p5dF9FWrQavLqTtlWGQoNk+5Cv/67JuQk1S3RGHQWiqx9iFIvv9yzRUo3txNdcZQqQMYHuOd7/8wqljHCyEUpbmz4svjhVmD81bN8QDLJ7+x9HmNz1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsLlpR9iDNj7N0wDvwwEXuC2d9AucQzonSxF8qegTZo=;
 b=ALcO5DKoKouHwxvL1/RiCZTjoDB5Z21azr2C6ULzUNuhtC9X/8kBe6Xw+R3jqGpz45tZ8qUAtQqX0XKNxugVVP+x1JAXJooPjtItjn0CkAMKAxmA0PTESHMwGmQj6j3JqaDB+1Ha2Cg8iuC3A6xXV/IkG4MflC5zkHXMu39hnHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB8617.namprd05.prod.outlook.com (2603:10b6:303:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 09:01:08 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 09:01:08 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v3 04/10] eventfs: adding eventfs file add functions
Date:   Thu,  1 Jun 2023 14:30:07 +0530
Message-Id: <1685610013-33478-5-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: acca4f1f-f360-458b-fc49-08db627ebd4e
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E9gMnap/s4K9tn6eA8mOESOsLTUPKvk3cE8jgz6xC+yZYv8w/tXkOKIdjdkZg7+srQYZNQtZ8owPsvEbX9nheBvueYOIuFWFWyLzzrok3T32umVJa3USB1sm5J7U0IVy7tluebbAWG2aeHYg6FuOV+O+XuNN2eX9/OmUdRuja9jYZ+ouZ1uASR7dj/3Ce+N/O7lmukfchKVCaXBieitfkvte+4FLS1fKSg3H+tEhToyuNYeax5GYfGte0kbQmV8Fyea0fRZk+mQNOSZAU3hCh9G4llzSx85vJ60A4rquOEpxORFWkRh5TtuRXjBz+Wtk+x6top3/lvwAXceG01fe86uavcrgR0CzhbKNHDSnJQqiCSwVPuKtRCArhp8/qe6Q+fSrfSFID9hFicPnJvQE7BPzd+waZIhpTsHWokCbYKKVX8OqHCBDtqmm+r2Lc1sFL8neDtGB7RipVzVN1o6AKk5wuOoYPHRIuHlUCkg6AaibT3en0+FyHQ03VqoUkq4d3QTwcVJC/B3Z4soTMESDtpv/7Nf2WQNCSUVLQtsGwJyaxkdTiFOJddPTV1d7lKwCcv9XW2Oa4EyOzZbHq1p+azFQJwRytkb4dio8CoUwepkTdZDO4kQXkkh6xHEjCjFu6ow1UIKgw1efKClzWwrcFuhpo/0FCn+TdnnXGCAm5rI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(52116002)(6486002)(186003)(5660300002)(41300700001)(107886003)(36756003)(8676002)(38100700002)(8936002)(26005)(6506007)(38350700002)(966005)(4326008)(66946007)(2906002)(66556008)(478600001)(66476007)(2616005)(6512007)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lz7Rea2M04lnAMbCBbs0aVLCG4okEagDGICep64pPGZ6vW9GP0NKcn0uj3OI?=
 =?us-ascii?Q?BXc0Z61nsa2mVMXUzsyvQx9k3eaw3N3TyxkaCe5Se24N2jktgTU5V5DXAo+B?=
 =?us-ascii?Q?TGaDKLeU1MjoUdNGKwIk0g0yR1orPHuaSnSE1g4CF/FR2BokIX2XA04TFg45?=
 =?us-ascii?Q?zfZC6QiP+aoydebKXdqPoGu3S72FKveVIV5Y9yALvTwKWnsKq97hIRBvs1ay?=
 =?us-ascii?Q?Awfs/zyBa1+MyE3cT/zb00BGRzqAtWVBhCa/kWrSOQN4HtwVYadQfjEfHgWX?=
 =?us-ascii?Q?m5p76ULkuNTwI1qEMLLIwpJwqmskuuHI/93JBxVimQee6zlkVqU9r4HaTpqd?=
 =?us-ascii?Q?IbwVHvI22MNJ03q8Mi6vDcJ376vHT8vHlnMaSZvfVln7B8L64iicyqgQimaV?=
 =?us-ascii?Q?OKNi9LZtXtWyzfNxjJYX/7QHOkuwfDEBU78cqKS9kV2W1RlWBa5615BFZ0VQ?=
 =?us-ascii?Q?1heZpsvSPKhkkuLn2kSTCZpEhMco442WbNkyLFzgS3CCZ7UiglVs6n7asFoy?=
 =?us-ascii?Q?Bkg4XdLRqg9iZbrv48NnH9jRnjcj8e28PRD1UmeaO+UGtL5MCHdkoI7WjxYe?=
 =?us-ascii?Q?UALfslejK+XZRi8x3FDKZYubHeTXFE8aO85b740so8HmU7dmK12+Dxs/QDpa?=
 =?us-ascii?Q?0fTvN9I5O35+rIc0yg0kp3EZUp4dusGWITSGuFjAWPuZPQemiz3Er7KK3HkN?=
 =?us-ascii?Q?tQuW77dUV0FmrW9OLwZw9Dm7ad/RbjKXMicSYHpUW1mXWjWXHmIt6cshXgIi?=
 =?us-ascii?Q?qfzK8KgcMSXabbC5KbJeFz29tU2VEhbBAXIoqDHd9NFvoGZATxgnpm+O9GQU?=
 =?us-ascii?Q?bnq/bA6O2Aq2I/VtMYZVkSSGg/+G2mACXXSoc239OwQv8T+nQ4vmskV3Ipcw?=
 =?us-ascii?Q?Z7HLa9RrALHG92p8jcCp2rkd2hv9fHiY4fD6QppiKHXq0kE+6Ed8+JHyAIQS?=
 =?us-ascii?Q?BS7Pu4IARq7gUbMRexj9pA5ruJiLVar6Yhi33itD++kKBBAITTMVO/VsqE5h?=
 =?us-ascii?Q?bADgBbfYJmdnU3cWolxlAkPbXDPh9D736qjFq130UHil4qH3iswVPcUZUjY5?=
 =?us-ascii?Q?1SI/jvLJUSut6ADJUDAf852DFtUz6rjH5MhWVbWpiVO6jasmS6y5OXAanP+g?=
 =?us-ascii?Q?KSydmCue3sMdEbH+Tey71yZedlQ07M8RSipqXYkVJ/tjK4lLDpGgjQtyPTZ+?=
 =?us-ascii?Q?rgnLUciz267QJ2ESzNsQdMH5BHoBmE7Uo6Az3BG1WH4vvMwGQkLZvgj1v+Rc?=
 =?us-ascii?Q?fKt7LHtz5jb9PHWBaWxylOHP4U8/iT1bvMHwHRM+sEUvVxdqobHsogPk3Xxi?=
 =?us-ascii?Q?DRiqBmW6YQsGfGJ81q3n2k6shNTivVUNotb24GYEEjNJ35t1Z4yKkzyTgKMy?=
 =?us-ascii?Q?/gN9v4aOauNTIEAR3o5LGTP+XZkavOylaefTs1bjC1LCF9l3kK3czfs0JVOj?=
 =?us-ascii?Q?Rbtv7uqPW3g5+LdvfwYYhbo6QCnrBoLKMqMLdr4CXtxDebNOZvBpYfi83cQu?=
 =?us-ascii?Q?B/rnRRBY269Wy+7N0dKXlS+yhjej6xb6pFF4Fp7IYGSvYLJ8h1A/wCZsNwVy?=
 =?us-ascii?Q?bq0IeWyRfDT5HnM9pT6mi2ybfvNOWLMwObNN35Nq?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acca4f1f-f360-458b-fc49-08db627ebd4e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 09:01:08.6084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QdaOPpbajV6csH2YgMXrv1GR4CT1p66SfM3TmSpr6RvGM+rJUCHIs3CseZNxAMzUk4C2mru61keFSvJfbOOwQ==
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

Adding following function to eventfs to add files:

eventfs_add_top_file() adds the information of top file to eventfs and
dynamically creates these files as and when required.

eventfs_add_file() adds the information of nested files to eventfs and
dynamically creates these dir as and when required.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-lkp/202305051619.9a469a9a-yujie.liu@intel.com
---
 fs/tracefs/event_inode.c | 94 ++++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |  8 ++++
 2 files changed, 102 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index a48ce23c0..17afb7476 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -270,3 +270,97 @@ struct eventfs_file *eventfs_add_dir(const char *name,
 	eventfs_up_write(eventfs_rwsem);
 	return ef;
 }
+
+/**
+ * eventfs_add_top_file - add event top file to list to create later
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is NULL, then the
+ *          file will be created in the root of the tracefs filesystem.
+ * @data: a pointer to something that the caller will want to get to later
+ *        on.  The inode.i_private pointer will point to this value on
+ *        the open() call.
+ * @fop: a pointer to a struct file_operations that should be used for
+ *        this file.
+ *
+ * This function adds top files of event dir to list.
+ * And all these files are created on the fly when they are looked up,
+ * and the dentry and inodes will be removed when they are done.
+ */
+int eventfs_add_top_file(const char *name, umode_t mode,
+			 struct dentry *parent, void *data,
+			 const struct file_operations *fop)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+	struct rw_semaphore *eventfs_rwsem;
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
+	eventfs_rwsem = (struct rw_semaphore *) parent->d_inode->i_private;
+	eventfs_down_write(eventfs_rwsem);
+	list_add_tail(&ef->list, &ei->e_top_files);
+	ef->d_parent = parent;
+	eventfs_up_write(eventfs_rwsem);
+	return 0;
+}
+
+/**
+ * eventfs_add_file - add eventfs file to list to create later
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @ef_parent: a pointer to the parent eventfs_file for this file.
+ * @data: a pointer to something that the caller will want to get to later
+ *        on.  The inode.i_private pointer will point to this value on
+ *        the open() call.
+ * @fop: a pointer to a struct file_operations that should be used for
+ *        this file.
+ *
+ * This function adds top files of event dir to list.
+ * And all these files are created on the fly when they are looked up,
+ * and the dentry and inodes will be removed when they are done.
+ */
+int eventfs_add_file(const char *name, umode_t mode,
+		     struct eventfs_file *ef_parent,
+		     void *data,
+		     const struct file_operations *fop)
+{
+	struct eventfs_file *ef;
+	struct rw_semaphore *eventfs_rwsem;
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
+	eventfs_rwsem = (struct rw_semaphore *) ef_parent->data;
+	eventfs_down_write(eventfs_rwsem);
+	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
+	ef->d_parent = ef_parent->dentry;
+	eventfs_up_write(eventfs_rwsem);
+	return 0;
+}
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index aeca6761f..1e1780a61 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -50,6 +50,14 @@ struct eventfs_file *eventfs_add_dir(const char *name,
 				     struct eventfs_file *ef_parent,
 				     struct rw_semaphore *eventfs_rwsem);
 
+int eventfs_add_file(const char *name, umode_t mode,
+		     struct eventfs_file *ef_parent, void *data,
+		     const struct file_operations *fops);
+
+int eventfs_add_top_file(const char *name, umode_t mode,
+			 struct dentry *parent, void *data,
+			 const struct file_operations *fops);
+
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
-- 
2.40.0


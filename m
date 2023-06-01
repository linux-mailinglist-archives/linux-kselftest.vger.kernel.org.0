Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D6A71963B
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 11:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjFAJBp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 05:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjFAJBm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 05:01:42 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013013.outbound.protection.outlook.com [52.101.64.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3774A12F;
        Thu,  1 Jun 2023 02:01:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZxhvLhWeFvLZ1/XA3oZHSnSxzZqJ/uc8rNl4aFf9vCYqfti90Vm0zbR6NhoJm26EbZUYVhuXkYI7dy6McLukZliMYPgg1eevndxDhvAzk9jynE5reTmyYlt8cvWHWEbvLOhnRFxODujrlRUbWyWw867AMPQBXuaf/QmoU56gmeN0RQ4dJwkDYrcigaAPCw5U++h0dzxVST/ni09hzS++2pfELbFsmLKaInGCR3kbxK3chX4hzS+iRozgE4u02pHjcx3CVlNkIfLKI6s3XQ/CooeFeLsW/uEj3EsZX+tAwgf9zcLzLJvigZDkAEQd929AMeR9hNfwxX9cPKKCuVJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xih5OExW+DnTJV1GC776YEU7McEv0s7u1IdLzCNQJsY=;
 b=EXNZsGKu4Bgmt6Zqqo6obFDu/VDqh64c0+0u0EVBuYnkNeU2iQrO8Vdvb/nvUZ3sngKPykXO3VVn+bXsO/AqyUzPEDPoLF19gzCcnLmt3gP9fmZx+MkS+3U/gltTmD7u5FrBXsTgjD4agnVdbgxo4KTG7yVkR+ngf/i6e9iLlQpLFJ9HONSDh90DWK40IqiyZc5goSFcJJRqNk3sw/L7KSGJFwM//zTirt1+/NJ7yx2exD6AlAT09X6rfdtu/Ud7aagFye3UBzw/EcTaRe+/ccA6ZJV0B1RL2QtT+ihQVvGEfnMwhAHWH7FxJBYQkkG+IbqLCN2GXGEsFxEJzwMK9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xih5OExW+DnTJV1GC776YEU7McEv0s7u1IdLzCNQJsY=;
 b=f6No3xTZO9ph7WDaVCmMe0OY0Wq6wJNGubvHOlN8WrfNdpKo4wLkMnnWLuLa2djjn8CR2K0EW1mbqoWX1sZlUu1SGcFfJu2dR/mnNmySSJx0/2ftO5uftAfaIP+DeBlO7gqv1r3iMWY8Thyz7BgI5A+FCH8TwmdlEKvJcek/Rtw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB8617.namprd05.prod.outlook.com (2603:10b6:303:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 09:01:11 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 09:01:11 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v3 06/10] eventfs: adding functions to create eventfs files and directories
Date:   Thu,  1 Jun 2023 14:30:09 +0530
Message-Id: <1685610013-33478-7-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0b0196e7-80f1-46c4-eb66-08db627ebed5
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Btx8s1BgBwLiY64PiXFNajvqlnv4XL0gu0slidMxUTOXerNzCc2v8duj8YHFpkgTit0H7KkQGsECLK+I/hQJJ+OA5bK8hHfDk3s3bM+nGMZa455ak5vWatbUTERdGm0HeNM8P+M8WAVBPtoriLL3rQiCTlb2Fny0lHeD8XyKumJPLfCLoqhnqQa9Alggf4yrINYQjArbl2dguWG0B7u1Uu7x4/E9xbs97Ss9i61k+xs3V23pj1HfbHGQaKZewn9rX35AfH24EI86o2BFOcMeoE2eYpJ3hA5+FypWvVDxKSXzlWVzA57MZR/j8u7cNqi0dqQeB/ppGd5aWYuuDQBjNAXY4eEIYn4NmZtY+1HG7NpTNeBsqP9D31ebrPKSDSgIPyhBKZxwVE9RbylxVJ9Jhu6Ulde8xu1lVRFpe/2ucB6Om+jOBFCssmqlKymUNc3UGQ/26/o6WC3XbF3iIGj3EWjq75Sz9EaKMhzqJb/b38/f9HhGVx31JlOKl2ReMem0fpw8VEeGpSl57Ru1w6HRGmbIpx3zW/tjXIcDtvhH63bRAoWKtzBnqkRVjgZeuQzdW0//nMDoagpoCyKWFA50c6GYAJT8XJKy7qEPSRq0CKy8ixieZ38nv8KjcImL88O5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(52116002)(6486002)(186003)(5660300002)(41300700001)(107886003)(36756003)(8676002)(38100700002)(8936002)(26005)(6506007)(38350700002)(83380400001)(4326008)(66946007)(2906002)(66556008)(478600001)(66476007)(2616005)(6512007)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S16VEb4GUSA5WsB9QdF1DWXiZcTOGYtFMsTlW/a6JywCBaScL9on0dllnZrv?=
 =?us-ascii?Q?6UWeK5si1J71R0tmZE1xX7QhxSJad5xvwHUEz+FYNDFJLMvdHgtaGI6cDja/?=
 =?us-ascii?Q?htHEvHkugTwe//MJtrCj5iKhP9/fSVSpqr4S6RCylZmOk8I+V+lfrD6uGobe?=
 =?us-ascii?Q?nvhf09gQJH0x0Pn42o0M7O4be9EsUijOrq+zeWG4YrXQGJOggC/PtISJezwY?=
 =?us-ascii?Q?1Y9E66PHJsHlISj6xcM9r5HpJGMf7dQ5nFCF4hwvjwPfYUNISzJ6DbY6d1/Y?=
 =?us-ascii?Q?PShkkFfsqNiAOaOnO6edjLgPrVgNQAknfKJDXlSJpViLJJB6pYv1J70sGA4L?=
 =?us-ascii?Q?VcCn4XgNlB2K8HNK4F8tC68LgaT3zjF371dJ8tG4H03LO14vGyvt3Dbu+oYO?=
 =?us-ascii?Q?Rk5ei6OXxre28FZzlGs6xbX2+6/AUkcujk5/WkAA7exs7VqJcM9ULdmNqTA+?=
 =?us-ascii?Q?fT/clwiNL2dJ3V4s9H2H4Fd2t2LBlNMvcR7B4e1wlRwGBda+gTZ8snShySrv?=
 =?us-ascii?Q?sZkHtNw4kl+HMt+tWFrDMq2V3fZW2G0EQH0VQRj4ajeOfByJvYXPb4BxPh0R?=
 =?us-ascii?Q?1E6GQEJnyswoI3WWS8XAV7/Bw42esrv+zwdOrnwd8o5FXEyKnz1bDcf6HW1F?=
 =?us-ascii?Q?xoVNK8Oby7OVuwrtZl8+yUkLjngTf3bqTmDkX+jAf7PGww/g9uZMLEmjOsYD?=
 =?us-ascii?Q?K0VS5U3je/TnhE4IpcZXn5/J7oXPkBPloXfYSreKNtaoh3Qsd2KwOmCmujph?=
 =?us-ascii?Q?bWXID9ycDZvVo19L8QdXeBBAUgO4Q+Gvj66TdERX1iqQVNzDvjUpr21JHlX7?=
 =?us-ascii?Q?ZUqGlyjq6U8Z8c23ad6DciAz/Zp+spZmPKcVy8A7Csg6Ex5Hw8v/kfksHFGx?=
 =?us-ascii?Q?BP5TnJ1XIqy1xz18h+6OR1Stds7ws3Fg9Z5IbsvdE/nhTWwdQFAEck9nflJ2?=
 =?us-ascii?Q?St0U95/SQXoZgODMrIkStu/a+q0B9husorN+RC+X2YlUd0/WN99NCR4U3qDN?=
 =?us-ascii?Q?LlRiVWvaTWoc9mUzipSaOZFs1rY2TUCn0CB96yaDb8H9TkWzpiZfC5tIUEpA?=
 =?us-ascii?Q?6OjDSLazXcMUmfP3Rdh5UJMALQizvi5bmrLhOUJpI86MsnNyS2pvwU3MAqIc?=
 =?us-ascii?Q?lX/3StaEjqsnl7AGAVOj3ixO43pxwRPeGwYBSbHLu0NjxD1tJGFn1qidS0Ms?=
 =?us-ascii?Q?CzEdZU7/dEh9Hc3qJHQTVey/T2R5KbZ3IjlTq1y+1zaS8nYejRBFTUUPjgaN?=
 =?us-ascii?Q?eD7aj3Oj3AgiWxrSuRHnuZotswQtEcJdYt+Y4UXVEuruEFbT5ono2qPwns3w?=
 =?us-ascii?Q?TgtFmAWVfNfWVdcNYx34iKtcD1MNFQ0KDWI42e3pf/oIC4rOBUyxJsVLo8K2?=
 =?us-ascii?Q?iwvqJFBbCDwGcefIOm5uq9vz3iNjTfeKtEI8+X278T77oQwky8uP020aU3uI?=
 =?us-ascii?Q?1mnAfVVF/bdPUVufwQ/28qTMDN3/ITPi46CD0nSb7LWSmbDLqUpAAdjqdGv1?=
 =?us-ascii?Q?lmX5440FRNLhUdD73merzk5zKMUXyuFj4z5xrDMqitfaxUtd14jQFe2667+N?=
 =?us-ascii?Q?Z6fEEvOwRLV6mlx23YZ0EDI2vvbrNpoZQg7LTdi6?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0196e7-80f1-46c4-eb66-08db627ebed5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 09:01:11.2078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TxsvSMkJNS/URJ612TQbTDdPtGQDIl1QRwDpoVkv9cdjeMdYk7ZejEe6TcZCigHKYVpyRyq+DGQu0bfGtiPxA==
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

Adding eventfs_create_file(), eventfs_create_dir()
to create file, dir at runtime as and when requires.

These function will be called either from lookup
of inode_operations or open of file_operations.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/event_inode.c | 125 +++++++++++++++++++++++++++++++++++++++
 fs/tracefs/inode.c       |  47 +++++++++++++++
 include/linux/tracefs.h  |   6 ++
 3 files changed, 178 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 874ef88bd..0ac1913cf 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -83,6 +83,131 @@ static void eventfs_up_write(struct rw_semaphore *eventfs_rwsem)
 	up_write(eventfs_rwsem);
 }
 
+/**
+ * eventfs_create_file - create a file in the tracefs filesystem
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is NULL, then the
+ *          file will be created in the root of the tracefs filesystem.
+ * @data: a pointer to something that the caller will want to get to later
+ *        on.  The inode.i_private pointer will point to this value on
+ *        the open() call.
+ * @fop: a pointer to a struct file_operations that should be used for
+ *       this file.
+ *
+ * This is the basic "create a file" function for tracefs.  It allows for a
+ * wide range of flexibility in creating a file.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the tracefs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, %NULL will be returned.
+ *
+ * If tracefs is not enabled in the kernel, the value -%ENODEV will be
+ * returned.
+ */
+static struct dentry *eventfs_create_file(const char *name, umode_t mode,
+					  struct dentry *parent, void *data,
+					  const struct file_operations *fop)
+{
+	struct tracefs_inode *ti;
+	struct dentry *dentry;
+	struct inode *inode;
+
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return NULL;
+
+	if (!(mode & S_IFMT))
+		mode |= S_IFREG;
+
+	if (WARN_ON_ONCE(!S_ISREG(mode)))
+		return NULL;
+
+	dentry = eventfs_start_creating(name, parent);
+
+	if (IS_ERR(dentry))
+		return dentry;
+
+	inode = tracefs_get_inode(dentry->d_sb);
+	if (unlikely(!inode))
+		return eventfs_failed_creating(dentry);
+
+	inode->i_mode = mode;
+	inode->i_fop = fop;
+	inode->i_private = data;
+
+	ti = get_tracefs(inode);
+	ti->flags |= TRACEFS_EVENT_INODE;
+	d_instantiate(dentry, inode);
+	fsnotify_create(dentry->d_parent->d_inode, dentry);
+	return eventfs_end_creating(dentry);
+}
+
+/**
+ * eventfs_create_dir - create a dir in the tracefs filesystem
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is NULL, then the
+ *          file will be created in the root of the tracefs filesystem.
+ * @data: a pointer to something that the caller will want to get to later
+ *        on.  The inode.i_private pointer will point to this value on
+ *        the open() call.
+ * @fop: a pointer to a struct file_operations that should be used for
+ *        this dir.
+ * @iop: a pointer to a struct inode_operations that should be used for
+ *        this dir.
+ *
+ * This is the basic "create a dir" function for eventfs.  It allows for a
+ * wide range of flexibility in creating a dir.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the tracefs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, %NULL will be returned.
+ *
+ * If tracefs is not enabled in the kernel, the value -%ENODEV will be
+ * returned.
+ */
+static struct dentry *eventfs_create_dir(const char *name, umode_t mode,
+					 struct dentry *parent, void *data,
+					 const struct file_operations *fop,
+					 const struct inode_operations *iop)
+{
+	struct tracefs_inode *ti;
+	struct dentry *dentry;
+	struct inode *inode;
+
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return NULL;
+
+	WARN_ON(!S_ISDIR(mode));
+
+	dentry = eventfs_start_creating(name, parent);
+
+	if (IS_ERR(dentry))
+		return dentry;
+
+	inode = tracefs_get_inode(dentry->d_sb);
+	if (unlikely(!inode))
+		return eventfs_failed_creating(dentry);
+
+	inode->i_mode = mode;
+	inode->i_op = iop;
+	inode->i_fop = fop;
+	inode->i_private = data;
+
+	ti = get_tracefs(inode);
+	ti->flags |= TRACEFS_EVENT_INODE;
+
+	inc_nlink(inode);
+	d_instantiate(dentry, inode);
+	inc_nlink(dentry->d_parent->d_inode);
+	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
+	return eventfs_end_creating(dentry);
+}
+
 static const struct file_operations eventfs_file_operations = {
 };
 
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 7df1752e8..66c4df734 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -452,6 +452,53 @@ struct dentry *tracefs_end_creating(struct dentry *dentry)
 	return dentry;
 }
 
+struct dentry *eventfs_start_creating(const char *name, struct dentry *parent)
+{
+	struct dentry *dentry;
+	int error;
+
+	error = simple_pin_fs(&trace_fs_type, &tracefs_mount,
+			      &tracefs_mount_count);
+	if (error)
+		return ERR_PTR(error);
+
+	/*
+	 * If the parent is not specified, we create it in the root.
+	 * We need the root dentry to do this, which is in the super
+	 * block. A pointer to that is in the struct vfsmount that we
+	 * have around.
+	 */
+	if (!parent)
+		parent = tracefs_mount->mnt_root;
+
+	if (unlikely(IS_DEADDIR(parent->d_inode)))
+		dentry = ERR_PTR(-ENOENT);
+	else
+		dentry = lookup_one_len(name, parent, strlen(name));
+
+	if (!IS_ERR(dentry) && dentry->d_inode) {
+		dput(dentry);
+		dentry = ERR_PTR(-EEXIST);
+	}
+
+	if (IS_ERR(dentry))
+		simple_release_fs(&tracefs_mount, &tracefs_mount_count);
+
+	return dentry;
+}
+
+struct dentry *eventfs_failed_creating(struct dentry *dentry)
+{
+	dput(dentry);
+	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
+	return NULL;
+}
+
+struct dentry *eventfs_end_creating(struct dentry *dentry)
+{
+	return dentry;
+}
+
 /**
  * tracefs_create_file - create a file in the tracefs filesystem
  * @name: a pointer to a string containing the name of the file to create.
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index ea10ccc87..57bfd1322 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -38,6 +38,12 @@ struct eventfs_file {
 	bool                            created;
 };
 
+struct dentry *eventfs_start_creating(const char *name, struct dentry *parent);
+
+struct dentry *eventfs_failed_creating(struct dentry *dentry);
+
+struct dentry *eventfs_end_creating(struct dentry *dentry);
+
 struct dentry *eventfs_create_events_dir(const char *name,
 					 struct dentry *parent,
 					 struct rw_semaphore *eventfs_rwsem);
-- 
2.40.0


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CD76F42B4
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 13:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjEBLZE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 07:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjEBLYr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 07:24:47 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013004.outbound.protection.outlook.com [52.101.54.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D115241;
        Tue,  2 May 2023 04:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oY+5fzu/iAcKHLmaHUUXehCI3BBYXVvpBgCuMj3t51zyFScZXUFJVUn37GkQ0B2UcriPBTjqAHUOFdRARykb3qLqe4RwVZ5qhQO8TPxr8tMs75VlwDhL4oloTj9vucABRGIK1baqOv4HY9dG5Bc3lXkO1LhlpTLE5hrbVjnitgFiohifL8wORD4Z6pIVJUdasvEw/8PRp1Itwm/acqvp8b752U9gQwpdz8HiunJUpalcf3n8gBhK0xlHhgPdZf4HSC0Zh3CnY38EpPUEp9M3/Qw03ngWhU3DZ/2/cRLnzA1U8K9VcyzsiFhFuthEwnatxQR2Htt98SSlkA4T+0FQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHID1jxyIqha3NrAukk48LnTgeOjGeMGMwy8PE6DaoA=;
 b=OsdcmzyA8EQ8oR0plspJyCQCyfIQ1Ghm64PUkOmm8AeegreU50ZnLq6I2S/LUKHHJyR1a2mBJQMJsJiFkgrzWwsJrk/npNaYP6q7ilb7IPiPZwE+yUv3L+Yxl4zHrpn96uIPOJ4KDy4KOd7HfTbbqU66U4Nsb5jH5szLG6JdP3EUswm4RHLe5Bo4RRKL7wfp/dAprvc0Wl9FfIcZH+dD4DmifEHQJuqoATel17Ups5JgVe0t9/Wmx5cAYHM7aWAkPjqcBry+LVWP9pl3N1ZWaLsl8E/eP3D6lTjDzTIrnxORoAIIyvnO8SeE0NAVYzZdNdVpROSV71lky+hukAfg6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHID1jxyIqha3NrAukk48LnTgeOjGeMGMwy8PE6DaoA=;
 b=nQD6e7ni0yzPwo7uekio5fu+9yhEQAwm5dXzHIQGsD4rvdIxCmCIPH4WEIVgE8cp/K7UMfzsvNgBIIGwlUZR6Ic5YSD2ykB8IUx9EfZP0Fi5lcEs+UQwjgy+S/c4JAbClYqtZVRWn8uMtW4TXEV7iJBpfpWa3OufJ4faAHT1Z/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by BYAPR05MB6648.namprd05.prod.outlook.com (2603:10b6:a03:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 11:24:20 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%7]) with mapi id 15.20.6363.020; Tue, 2 May 2023
 11:24:20 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com, Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v2 5/9] eventfs: adding functions to create eventfs files and directories
Date:   Tue,  2 May 2023 16:53:16 +0530
Message-Id: <1683026600-13485-6-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 21ba7af8-2ade-4659-5964-08db4affc5fa
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rkUVedR+NiBRdf3DEftLJql2SjOi2eCUa4uX7VCmTJIGuDuv5zdWulcbR+Rp8oAnuQWuB1/kohNX8F3eXw14V7HenhUZYd3oQHMElslM3mnScnNPI6bi0l8O+TFH8n2G/f0fe/cmoE0SA8c+q4Xdc2H3SOB9pTbypIroo0KlVc9Mau26zz7Ynmp0xEcs9EWFOOTo5+nXo21v6Ph3hlrb2wRRMPe1BB1wEX3sS2nZAw358e37cB3LEb/rBau5VqgLq08TUAWk/vZiOCPj5DHqhxmfihNB4kTd8aVyUN+fpcsz5oGfjXNduZTiB7EReYxVyh+G7Z1tSC/1cJdw4qzQDY5wNOZ0JMxwvqfpFr2Ov8+Lwee9fRwSv9D7H9cbxCiZKw1PKahC2E7YJ91VZVWBQpXmFzqwk6Lb+1/IykCXRMI/nTqUnMfbCdLl0ujrnVdHjIqZV2LbLLo+AtQQEhHAkRFXozI2eXlHl69VQ32DMRola59uqBK5CG/kphG6BmQ6OpWdPhgMopOPWGA3COIU7MLbuEoDCVPQCXkUHgL3qhsEtEKgEw8HdgUzh2pc5ka3qOe3spfAQ5Buhw7dsyWB9nEfAptI7GfeqvQyW7W6fn17FaNFF7EgD7b6/ZkHGsRz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(6486002)(6666004)(52116002)(107886003)(38100700002)(38350700002)(2906002)(86362001)(41300700001)(66946007)(66556008)(66476007)(4326008)(478600001)(316002)(5660300002)(8676002)(8936002)(36756003)(6506007)(26005)(6512007)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b/k7D+rjMwlNQfJs/2qPHoPTQWjrD8eDByl5rdrwhB92kLf2sCFuxHyCF7oL?=
 =?us-ascii?Q?KvDG8/M34f5DlRud5646nhfCaqs9DUm2YzpYwM5I5PicVv7yH31MPuHSf7YL?=
 =?us-ascii?Q?4bWzYmutgHcmkd8TTyVz+y8SQ0JQgQZuL+J5y4O8zGQB/4lUhM0rhRmADFkk?=
 =?us-ascii?Q?io3BDj3qtxDVpnuc77qECzIHe72uqEUaikHYhEPhig7gESyYZ924s7yuzMXu?=
 =?us-ascii?Q?0hYztYbrZfMsV6faHxCBvE7ldZke2g8PHsqofMsmo1zSxnrXy+GqyJP6o6kI?=
 =?us-ascii?Q?YBNVzK3d8CA9Umqkny1WQPF0V69sS9X+3la1kOPcSQymVVxRjVTVOQxjEgUK?=
 =?us-ascii?Q?nH7NHCv0Dz22YR5K0myWcO6W9gqjIXl+WZRXtz+i0lRDI+YE19jQzru+5yId?=
 =?us-ascii?Q?8PIfXhQopMs3CtDk8A/id9PDCIXjXIx+j1HtWoEtluGrtWlvu5E0Hgm57EP0?=
 =?us-ascii?Q?6rmoyAG4yJwQyWaO9Q5OXNbS5BUaHUbjaAH+XLvs7v0VJ1yzsYNQ3UhIqPqx?=
 =?us-ascii?Q?PqKk/fV595y39UDH31zlOi6rFgQ0exZbpEIlbiKmImmPrCuPsToZNwJ71WtM?=
 =?us-ascii?Q?EqYDNe61xyQIrnu/MfwDqOHW7Jbt13ntFOG2T22s95Hy2hi3cMpwUcG2tJZD?=
 =?us-ascii?Q?2lz7qzGJTdSaAKZIqrFw15p2Ue1Ku/o23dZWVDc/8vK6wB7U8kGVadBm+oxk?=
 =?us-ascii?Q?phZ60x7YfxJJJNIERGQ/+HggApUg1LabOxGrl2era+qbZ/yPHJuDS7iAXiTh?=
 =?us-ascii?Q?ERcMAT0v4te7dDdjv3XLEHT1KcTqwLqd2DZgLCnMOZb2Jf8TVnU9Z6JQ3MwH?=
 =?us-ascii?Q?PKx87D5xDs1u9LEgpuQj3kjL5ZGux9fPzE84mioDBxbhsHkDgAe3ibMvXL0L?=
 =?us-ascii?Q?x/cR30YE8diy1WQN6qr5EiDhrFqDD5exZquC8NFi639A6YIeYBZ82ONT4sNG?=
 =?us-ascii?Q?UJm3Kj/FgWuKtn69Zi9Mj19FnkT078T2OE2FanxCZH+PKnz240R+TNcfx38h?=
 =?us-ascii?Q?mPuqhd9gJeyQnGAL++M1+cAP0zWhKBIDN0Tsk08n1VOcSeJB5zEoGf5C9Fvn?=
 =?us-ascii?Q?wNkLwUTn/rPBHRzvTYcgVMjvw+IZG71Y91cQ73fzX/H/Cd30QPHXXwoQgnQl?=
 =?us-ascii?Q?ptzMq9IUsH2l2aBPlS/j+Sb3oDB6kMHPpj7ufoizG6c+kSIxOv72ooPKHhfj?=
 =?us-ascii?Q?chaMPdlSysy8s9zPznmPKrLpX/WIA530SaOgEsL7rS1taWNVnPTlrtulmnLo?=
 =?us-ascii?Q?Ik/RsaozSF1ZZEZ1xjClxqYOJfoFXf3bg7ngU6cm3bKLnmKf4bF7sZlSl/3C?=
 =?us-ascii?Q?KFsBtFtX2qGtLGTsChVIriDBwmoeutoedyZmgM7vpEXZTFn6Jrdcclc1Kx83?=
 =?us-ascii?Q?1l1VbQQP2TTRLje2Ww1FQoxtXgQHBLSXfjHXL8V98jRc0zU2su0anjexlSW0?=
 =?us-ascii?Q?VqKHlfDjKebxVjbV/t2j2Mi6nloL1X19K5THYYSsF+WkgREwt+OBkwgOFsx1?=
 =?us-ascii?Q?nsNkzKdA7yAsbOkBy4BGROV51I+dGwFJs8rY0gbkwQF1Nhx38PHe14bkK7jE?=
 =?us-ascii?Q?ouLcSHMp/Tq4/AivZ53w6/ADe4cpDFbndoWjSzCC?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ba7af8-2ade-4659-5964-08db4affc5fa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 11:24:20.3514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvPaM7/xUFOh6V+9UtJo9W0WXLJ3+7+zIEzhWhNHTGABE+fYJAS9aa8oWGROScQ70dkBFVjx0IUzD87bfAdbJg==
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
index 9ab675edf..0ee27f7c8 100644
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
2.39.0


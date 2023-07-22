Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18E175DE4E
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 21:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjGVTiW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 15:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGVTiT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 15:38:19 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011013.outbound.protection.outlook.com [40.93.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3CE10C6;
        Sat, 22 Jul 2023 12:38:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwSq8VfyNqBm0A3xaAGf7mVUNO4cck2G1mbhhqpBX77rYAXeiu7Ryjc+3gaTL6/DTv83yFFydPkfAyjzshrBapZRy8R7YYsk5q1tvNlP+PGISjgbMjEJSs9dIiv8omNXHZtO0w5AYQB1htOXd7sWOQB8mzqnAwgfWddBBswcYXPTb3ASfsXCJK66uwldTkUUpUQcbxqLQCzY8L8QuBYkAbXpd8MJnDj9SXDJKg8DiX0+hhncFa7TIj8IRamK+hKSjjCaLPlNViNlRi0sLdKGIZzxrG2CfJG2/FvuS53/5epGJURKCgsCpn4xCnR8pFtNAw8XHWFGpm0ngTu1+s27Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOtqtJs8MLO8UMW6/gM93XTEUi9kA5V5H9NcrDO1YAA=;
 b=k+v0E3XDkpp4+05FA6gROkRldEH6CJlDl8aEiBR4egAPsqBPvW8a7nSorW1c80ZaHb+fKaSqgKpwszKTzG/vpKVmxODhJC3EbVrNH6LYrIG5n1zsvV6eSxbUpc7DOCmoYk7y8PWgAuVFeTeaGgcznqRH+0Oy/eX7Z7Fzh2ujlEHHOFbU2XA4xyNGHBN7bX0AlXT9wHVgmnXwSS2hqAH3OPBN06FA9lJr7FaSvJuDBI0BLVFXT+q0b8tN5gicWlOpt8991HWhTX2vGwsGIaSLSNHsoYXCdlLg9Mv4bk/wKEYJrVAfNDfDnLw57Z6Kf904SRCdbO/HFxM/R3V2ThgUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOtqtJs8MLO8UMW6/gM93XTEUi9kA5V5H9NcrDO1YAA=;
 b=yCTXpWifJTYmf4WhZ4g/qm1HWwMTO3ZUqy48ug0liUL8migYhEpPXyCip0lyKVkWgYor3IEWi0yEzd0CdcwFb/RnsjqyD5Pl2nVH1r+PCpug01NPoV0o6CxH8z6UgSNmNhKqkRMGgMzQdzE6BdRYPwOcFbuuNVv/Iz1UcWpLiAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MN0PR05MB9005.namprd05.prod.outlook.com (2603:10b6:208:3cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sat, 22 Jul
 2023 19:38:12 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 19:38:12 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v5 06/10] eventfs: Implement eventfs lookup, read, open functions
Date:   Sun, 23 Jul 2023 01:07:01 +0530
Message-Id: <1690054625-31939-7-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: c10f742e-82ac-4bbb-6dff-08db8aeb2fb7
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7WyepY+3g77jQrfp1iK9Ui/am7LL1O1D3goitreJ2zKu/uvWMuhYXTozx/i4qvjbEv25uTdeMW7CIzmXxQgD9R6Wi6NQSoFK10f1c/CM/Pw35zuJpmGU8sBweC/HQ1wEtZFZUU1+xXVxt8JDg1ByRRYSB4fieXHrG+1TmIF/hF4HemPgPLbzk6b8INYJbWpZ0QUC5Bwqkn4pAf1KVPlNCwRli2atXyY5HVAmtL1Tp5WM1RBiwwgJGvsxjJQmle96SaZOXr+c2YmHbpBjq29jmEzhCrWcx58Z5bRoy3e2Eq4P7lkV53bMRK1ndnE0DLzWldHJttBwvLnV+/y4dXFzLZSO6DQ1vRo+N0KBrTqnG83XiCNB3Pb/q3ocET4rJIg385PvCxY13ICuZEtzWD5jUod6ND7StFFOoVDAtmTs/ZwYoJJ6ato5hwI8psJUeji3r1YOCUXQEedqbgWeVHilbZ82XDVkn53ow6S2c2tPNCRFkeie2eeezr9WThC/STqrup0SWU7+LAe1GK+Y9/VhFSqRfvvQ6GtGRs6IjpSEr+GR76oDdGIGBsJ+kqw57/XfssgQJi/pPgyVyKDTJzJk26A+nDtuBpjW7KTtI40xA9vUmnj9MScfhblMK7wIf3Hi3iZ3JDs6g766AWp/Qu9sUmuWblmnGjMrmYvoJoFAwLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(6666004)(52116002)(6486002)(6512007)(478600001)(186003)(2616005)(6506007)(26005)(107886003)(2906002)(30864003)(316002)(41300700001)(66946007)(66556008)(66476007)(4326008)(5660300002)(7416002)(8676002)(8936002)(38350700002)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MBMtKaWH8u1If6FcoCk3KOVcoqRvCA8eI81Frwfjcoy4u+It8hl3bJGNlhf9?=
 =?us-ascii?Q?h66zgboyTX8Jv0lzXY4kc3b9wLtkE2e1+7MFUAUXJWxPYrJJmHpr8+LzDndA?=
 =?us-ascii?Q?U7Or1QUcrlY7aPUEVm1/uKefFB9R8whuSDmTb+9uZYZqz2wz8IQ91iEvTDCm?=
 =?us-ascii?Q?ibZ8qOkZP8sX8KiPnz2+Ss7gk5Xhgv0gm+HPy5rth9zm1T8IM79c/iKhx8Yt?=
 =?us-ascii?Q?yPUTY39zxVcKJDMKgBkqYHmxz8oZ2TZMAWhsV8KzYgJlXzHZ/J4qJ9fOcf3Y?=
 =?us-ascii?Q?5yLTBgpSLVzTU4zjOwA9Ti62R6oDIZv0cV5qSMTppT+DjRcgWRr8LXyYf6Sh?=
 =?us-ascii?Q?Q2Y/LpHRYm4xPkJys/bfb8UaUZVMb+BoG4i5WaVHhOjHx08RT9QxSG66AMnP?=
 =?us-ascii?Q?Ic/Y7sAoyqzykuxuH6TsnfW5xS6N30uvGVWWZLS0NTi71o4Ea+LDzXcSPH34?=
 =?us-ascii?Q?/5MSsxttJaxLHNExlJ/G+oWANrvl57m9IAG1RYChXt7WmJwP0l7JN6ZmkPF8?=
 =?us-ascii?Q?C6SWCZthCF2+pbTpCw/zKs5P42Y+yw6xFXJTR4Z2yJrwJhPMbe+PpL+FtFLA?=
 =?us-ascii?Q?F/13MCWMG07yMorACSTA7mmrJXd+saBoi/C9X9SPK3BDtOVgnfE/iloY7+HF?=
 =?us-ascii?Q?IGb3py8otAqI1iVNw79a2vTbPFPIH7GKDb3r03byFHwClg6pnFX/YlguoWE1?=
 =?us-ascii?Q?zqQFBupmJ6ROHcVOwmVeIiVcvt8LJGf6J6hNMVfHK+c7FBbR3scpDKHf4bHg?=
 =?us-ascii?Q?dOq0c3f9QeNWCuH2knVFx45/QExDIxT7GSUgelD5XlKda6QnyIogSRJWFJ5V?=
 =?us-ascii?Q?7k1XDxRnnS1Ke4vk4hyriNDha6uVZel36QGmW9sEFkl7uge/RFYfuOj/ov57?=
 =?us-ascii?Q?rOyIhq9ON/R7pp1CEH0SRdMO4jndydo6a05tsGwYz9n1TxnjhLLgTcLXaCGY?=
 =?us-ascii?Q?RTN6OkGaUn9ud/GpDueNQIVO+O/qwviKA34pW8tSZLvYdY3rlRQZrF9qu7BY?=
 =?us-ascii?Q?BR7luPKT2TNPVMDD9UQHvtcma/ZkQRx12kOEFgcJBHkOs2SRE8BuY9Q4qUJx?=
 =?us-ascii?Q?9PSVq4s+yl0FeoNJWD1qpEQ8aJS0kyk2wulezJnMfr8ui6t8X5q2JXJmWA7g?=
 =?us-ascii?Q?sKubeVg6659zig0TLjTc+lkekZdl8WziSvqFJl1CdLHVIe5U6Zz9NFXM84Lk?=
 =?us-ascii?Q?ehnNZ33Q1ndJTxahX16jTRVaOM1E0h+bsSm86Mudlrv8V/sxh8X/uiBO6DCH?=
 =?us-ascii?Q?GyRdCI8CSd53zaKqWz4jhUNWk2JzSH9JWvf1Kpbadpx/b0h/yLkuTCO4WmwH?=
 =?us-ascii?Q?461ay1VbnaR2WKuDEsk5nN1JwO+B85yXdG3wPwNcPC1s+4uu+CbmkAylt82n?=
 =?us-ascii?Q?hwwU3rEDAWs0Lx2TGnr0wiH5DTZsVvCp+jUtV9cxOIlDhuxmN9Jdz2EHTF69?=
 =?us-ascii?Q?ba2njcLXGQAyrMm3kOLt8+enQJ4O5y6YIgDdUwmoH0lZZfCIS2SPaTNirnMp?=
 =?us-ascii?Q?IoxiHmOCT8bCPbTKXjEzuvLGPQGAUO46EoFGgWm2BiBFms12Qia3B0iGjzkE?=
 =?us-ascii?Q?SHb1LlzCchSuaTXdi08XNRBT1TX31s8gLTROKDSd?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10f742e-82ac-4bbb-6dff-08db8aeb2fb7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 19:38:12.7123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isJVlWwIV8g3J3hhhUSZERxs7ieXOhGqKY4A1o6ZJbEdVclt7Qo0zJuQSc0qkOx30EAt2Akgfbfn0HE1ZpX/5A==
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

Add the inode_operations, file_operations, and helper functions to eventfs:
dcache_dir_open_wrapper()
eventfs_root_lookup()
eventfs_release()
eventfs_set_ef_status_free()
eventfs_post_create_dir()

The inode_operations and file_operations functions will be called from the
VFS layer.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/event_inode.c | 312 +++++++++++++++++++++++++++++++++++++++
 fs/tracefs/internal.h    |   2 +
 2 files changed, 314 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 9e4843be9dc9..a3c1b8bf7192 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -31,6 +31,8 @@ struct eventfs_inode {
  * struct eventfs_file - hold the properties of the eventfs files and
  *                       directories.
  * @name:	the name of the file or directory to create
+ * @d_parent:   holds parent's dentry
+ * @dentry:     once accessed holds dentry
  * @list:	file or directory to be added to parent directory
  * @ei:		list of files and directories within directory
  * @fop:	file_operations for file or directory
@@ -40,22 +42,328 @@ struct eventfs_inode {
  */
 struct eventfs_file {
 	const char			*name;
+	struct dentry			*d_parent;
+	struct dentry			*dentry;
 	struct list_head		list;
 	struct eventfs_inode		*ei;
 	const struct file_operations	*fop;
 	const struct inode_operations	*iop;
+	union {
+		struct list_head	del_list; /* list of eventfs_file to delete */
+		struct rcu_head		rcu; /* eventfs_file to delete */
+		unsigned long		is_freed; /* Freed if one of the above is set */
+	};
 	void				*data;
 	umode_t				mode;
 };
 
 static DEFINE_MUTEX(eventfs_mutex);
+DEFINE_STATIC_SRCU(eventfs_srcu);
+
+static struct dentry *eventfs_root_lookup(struct inode *dir,
+					  struct dentry *dentry,
+					  unsigned int flags);
+static int dcache_dir_open_wrapper(struct inode *inode, struct file *file);
+static int eventfs_release(struct inode *inode, struct file *file);
 
 static const struct inode_operations eventfs_root_dir_inode_operations = {
+	.lookup		= eventfs_root_lookup,
 };
 
 static const struct file_operations eventfs_file_operations = {
+	.open		= dcache_dir_open_wrapper,
+	.read		= generic_read_dir,
+	.iterate_shared	= dcache_readdir,
+	.llseek		= generic_file_llseek,
+	.release	= eventfs_release,
+};
+
+/**
+ * create_file - create a file in the tracefs filesystem
+ * @name: the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @parent: parent dentry for this file.
+ * @data: something that the caller will want to get to later on.
+ * @fop: struct file_operations that should be used for this file.
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
+static struct dentry *create_file(const char *name, umode_t mode,
+				  struct dentry *parent, void *data,
+				  const struct file_operations *fop)
+{
+	return NULL;
 };
 
+/**
+ * create_dir - create a dir in the tracefs filesystem
+ * @name: the name of the file to create.
+ * @parent: parent dentry for this file.
+ * @data: something that the caller will want to get to later on.
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
+static struct dentry *create_dir(const char *name, struct dentry *parent, void *data)
+{
+	return NULL;
+}
+
+/**
+ * eventfs_set_ef_status_free - set the ef->status to free
+ * @dentry: dentry who's status to be freed
+ *
+ * eventfs_set_ef_status_free will be called if no more
+ * references remain
+ */
+void eventfs_set_ef_status_free(struct dentry *dentry)
+{
+	struct tracefs_inode *ti_parent;
+	struct eventfs_file *ef;
+
+	mutex_lock(&eventfs_mutex);
+	ti_parent = get_tracefs(dentry->d_parent->d_inode);
+	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
+		goto out;
+
+	ef = dentry->d_fsdata;
+	if (!ef)
+		goto out;
+
+	/*
+	 * If ef was freed, then the LSB bit is set for d_fsdata.
+	 * But this should not happen, as it should still have a
+	 * ref count that prevents it. Warn in case it does.
+	 */
+	if (WARN_ON_ONCE((unsigned long)ef & 1))
+		goto out;
+
+	dentry->d_fsdata = NULL;
+	ef->dentry = NULL;
+out:
+	mutex_unlock(&eventfs_mutex);
+}
+
+/**
+ * eventfs_post_create_dir - post create dir routine
+ * @ef: eventfs_file of recently created dir
+ *
+ * Map the meta-data of files within an eventfs dir to their parent dentry
+ */
+static void eventfs_post_create_dir(struct eventfs_file *ef)
+{
+	struct eventfs_file *ef_child;
+	struct tracefs_inode *ti;
+
+	/* srcu lock already held */
+	/* fill parent-child relation */
+	list_for_each_entry_srcu(ef_child, &ef->ei->e_top_files, list,
+				 srcu_read_lock_held(&eventfs_srcu)) {
+		ef_child->d_parent = ef->dentry;
+	}
+
+	ti = get_tracefs(ef->dentry->d_inode);
+	ti->private = ef->ei;
+}
+
+/**
+ * create_dentry - helper function to create dentry
+ * @ef: eventfs_file of file or directory to create
+ * @parent: parent dentry
+ * @lookup: true if called from lookup routine
+ *
+ * Used to create a dentry for file/dir, executes post dentry creation routine
+ */
+static struct dentry *
+create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
+{
+	bool invalidate = false;
+	struct dentry *dentry;
+
+	mutex_lock(&eventfs_mutex);
+	if (ef->is_freed) {
+		mutex_unlock(&eventfs_mutex);
+		return NULL;
+	}
+	if (ef->dentry) {
+		dentry = ef->dentry;
+		/* On dir open, up the ref count */
+		if (!lookup)
+			dget(dentry);
+		mutex_unlock(&eventfs_mutex);
+		return dentry;
+	}
+	mutex_unlock(&eventfs_mutex);
+
+	if (!lookup)
+		inode_lock(parent->d_inode);
+
+	if (ef->ei)
+		dentry = create_dir(ef->name, parent, ef->data);
+	else
+		dentry = create_file(ef->name, ef->mode, parent,
+				     ef->data, ef->fop);
+
+	if (!lookup)
+		inode_unlock(parent->d_inode);
+
+	mutex_lock(&eventfs_mutex);
+	if (IS_ERR_OR_NULL(dentry)) {
+		/* If the ef was already updated get it */
+		dentry = ef->dentry;
+		if (dentry && !lookup)
+			dget(dentry);
+		mutex_unlock(&eventfs_mutex);
+		return dentry;
+	}
+
+	if (!ef->dentry && !ef->is_freed) {
+		ef->dentry = dentry;
+		if (ef->ei)
+			eventfs_post_create_dir(ef);
+		dentry->d_fsdata = ef;
+	} else {
+		/* A race here, should try again (unless freed) */
+		invalidate = true;
+	}
+	mutex_unlock(&eventfs_mutex);
+	if (invalidate)
+		d_invalidate(dentry);
+
+	if (lookup || invalidate)
+		dput(dentry);
+
+	return invalidate ? NULL : dentry;
+}
+
+static bool match_event_file(struct eventfs_file *ef, const char *name)
+{
+	bool ret;
+
+	mutex_lock(&eventfs_mutex);
+	ret = !ef->is_freed && strcmp(ef->name, name) == 0;
+	mutex_unlock(&eventfs_mutex);
+
+	return ret;
+}
+
+/**
+ * eventfs_root_lookup - lookup routine to create file/dir
+ * @dir: in which a lookup is being done
+ * @dentry: file/dir dentry
+ * @flags: to pass as flags parameter to simple lookup
+ *
+ * Used to create a dynamic file/dir within @dir. Use the eventfs_inode
+ * list of meta data to find the information needed to create the file/dir.
+ */
+static struct dentry *eventfs_root_lookup(struct inode *dir,
+					  struct dentry *dentry,
+					  unsigned int flags)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+	struct dentry *ret = NULL;
+	int idx;
+
+	ti = get_tracefs(dir);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return NULL;
+
+	ei = ti->private;
+	idx = srcu_read_lock(&eventfs_srcu);
+	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
+				 srcu_read_lock_held(&eventfs_srcu)) {
+		if (!match_event_file(ef, dentry->d_name.name))
+			continue;
+		ret = simple_lookup(dir, dentry, flags);
+		create_dentry(ef, ef->d_parent, true);
+		break;
+	}
+	srcu_read_unlock(&eventfs_srcu, idx);
+	return ret;
+}
+
+/**
+ * eventfs_release - called to release eventfs file/dir
+ * @inode: inode to be released
+ * @file: file to be released (not used)
+ */
+static int eventfs_release(struct inode *inode, struct file *file)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+	struct dentry *dentry;
+	int idx;
+
+	ti = get_tracefs(inode);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return -EINVAL;
+
+	ei = ti->private;
+	idx = srcu_read_lock(&eventfs_srcu);
+	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
+				 srcu_read_lock_held(&eventfs_srcu)) {
+		mutex_lock(&eventfs_mutex);
+		dentry = ef->dentry;
+		mutex_unlock(&eventfs_mutex);
+		if (dentry)
+			dput(dentry);
+	}
+	srcu_read_unlock(&eventfs_srcu, idx);
+	return dcache_dir_close(inode, file);
+}
+
+/**
+ * dcache_dir_open_wrapper - eventfs open wrapper
+ * @inode: not used
+ * @file: dir to be opened (to create its child)
+ *
+ * Used to dynamically create the file/dir within @file. @file is really a
+ * directory and all the files/dirs of the children within @file will be
+ * created. If any of the files/dirs have already been created, their
+ * reference count will be incremented.
+ */
+static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+	struct dentry *dentry = file_dentry(file);
+	struct inode *f_inode = file_inode(file);
+	int idx;
+
+	ti = get_tracefs(f_inode);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return -EINVAL;
+
+	ei = ti->private;
+	idx = srcu_read_lock(&eventfs_srcu);
+	list_for_each_entry_rcu(ef, &ei->e_top_files, list) {
+		create_dentry(ef, dentry, false);
+	}
+	srcu_read_unlock(&eventfs_srcu, idx);
+	return dcache_dir_open(inode, file);
+}
+
 /**
  * eventfs_prepare_ef - helper function to prepare eventfs_file
  * @name: the name of the file/directory to create.
@@ -179,6 +487,7 @@ struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
 
 	mutex_lock(&eventfs_mutex);
 	list_add_tail(&ef->list, &ei_parent->e_top_files);
+	ef->d_parent = parent;
 	mutex_unlock(&eventfs_mutex);
 	return ef;
 }
@@ -206,6 +515,7 @@ struct eventfs_file *eventfs_add_dir(const char *name,
 
 	mutex_lock(&eventfs_mutex);
 	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
+	ef->d_parent = ef_parent->dentry;
 	mutex_unlock(&eventfs_mutex);
 	return ef;
 }
@@ -254,6 +564,7 @@ int eventfs_add_events_file(const char *name, umode_t mode,
 
 	mutex_lock(&eventfs_mutex);
 	list_add_tail(&ef->list, &ei->e_top_files);
+	ef->d_parent = parent;
 	mutex_unlock(&eventfs_mutex);
 	return 0;
 }
@@ -292,6 +603,7 @@ int eventfs_add_file(const char *name, umode_t mode,
 
 	mutex_lock(&eventfs_mutex);
 	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
+	ef->d_parent = ef_parent->dentry;
 	mutex_unlock(&eventfs_mutex);
 	return 0;
 }
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index f0fd565d59ec..9bfad9d95a4a 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -21,4 +21,6 @@ struct dentry *tracefs_start_creating(const char *name, struct dentry *parent);
 struct dentry *tracefs_end_creating(struct dentry *dentry);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
 struct inode *tracefs_get_inode(struct super_block *sb);
+void eventfs_set_ef_status_free(struct dentry *dentry);
+
 #endif /* _TRACEFS_INTERNAL_H */
-- 
2.39.0


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB02767473
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 20:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbjG1SVt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 14:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbjG1SVp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 14:21:45 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012009.outbound.protection.outlook.com [40.93.200.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0982423C;
        Fri, 28 Jul 2023 11:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2TtkS0oBcYA+9a9s6+GLSp7emEUUNIy29Iy2NpxGO0YhEU6e8aifaSdvecm6tpNYIY/K6VOGRH7QxAF5ulEC6DgWyK6wCmW521217nMZ6exd4zt+rQ2UTWb22G1/yd2mmt1tHZscMhdylcQejyaRLRR0KnkqVL/Qd+gsl5InvtfVeIlH/H/KSLfR458cNxcrJekxIyeR8Bz0u4a57hgX+5sZmxSIn710Mv6zCAzm1g2EvieaHVmH4pj7QqyaR1HuXmfSsprVBpry1hydnI15zsYsIMRAu1/mEoKZYjTCMkMAXvgxigHHKByc9FJA+c48ivDdo8HWf0WNj9W5ABwJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpztRKNqiLZRLmIX3tLph7rQE+3o6etfWtzVfR7fqTA=;
 b=M8Px4ZgDRsmNQe5O/HdLPZWxqNDJUTJwShUtlXrCm+G4CWnd9vt7xxHaToA+xZiZ/JJHraPLIL/gvugOaBiOvbjxkUcQkzZH4kGgLdZ1psHgtSFGqKCiSZ1oE5tTwCceKU53FMhC/YlHoS+kyQ/pv6xNNHOHubkLA8zo7cW2X5Ko4QRH/N7ETc3c93dX0W8fjk1PYpFkPXGIejtmPjbnEWNUcEjRMZhbgMCMk4K1R2Pnx2fub1u65l771rdH19BKbi9UVKiB3eHl8n1AazpTl+zruJxXoGSIAGcici+HCKeJj/d21AAyLTySg0AwidScCaP0L9b1Xh1qQ9SBDXmppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpztRKNqiLZRLmIX3tLph7rQE+3o6etfWtzVfR7fqTA=;
 b=WZdYvfVy76WKBu2jmUpwTjTdN2aZ6ON5tX19yVlwE9m/XXBSgm4yzTxJEWsKm/Om5922MybSUHPA68ak7IDkQxRpetccX92RV1uXvrfr/iDbau9YBz9ydfYNnxzKxkyuOe9vc4tEgJsPBbh2D1HgiN2fgIagwjLwccmLkU5/qq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by SN7PR05MB9264.namprd05.prod.outlook.com (2603:10b6:806:26c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:21:24 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 18:21:24 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v6 07/10] eventfs: Implement functions to create files and dirs when accessed
Date:   Fri, 28 Jul 2023 23:50:49 +0530
Message-Id: <1690568452-46553-8-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: b10deded-9f54-4f4e-64ac-08db8f97735b
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wq6rwrf16G4IvavG8jzAaFYT8Wrc9CsoLuTpMWWQQPWKoGP42OekXhqpLOKoZilF6xY1AiwlPvL2N0TLEGBJg2hx4Q9lul7R/cjzCkzxKVIK3LIOeqr6vD/H9EzO4pyFprMSONNpr9EvrxlEoa6qWh1CjcJBjuG9PXccL6UMwy7asRdet6wxhtaByYAuo/6ZdPeqTQrauIFEK28hD2xmRhgJiXeeC1p+u0QKRjxOf+VUgET/bc7Ae8VkV1Et4wyIego6H/0e4Ll/8fW5wPNQwmX0X/25fzGNSR64h0mVQesymu9zgNGJNKNnX44Ls3k+QATfmfG+dYxT3DJ9VySLJjlK47YTejdc0/3BHpv77tC4ulVJW546lkCCrHc8tNvH/TMMPT2BrSHh2ORMVZs0C6lxPt6xYY+IBby3fz8CtAxA7/+utABsdcXlOswzGgO0/V+Z2ZM83qk8cym/NPtT1xW0kqjsJt2bnl+jLbAKdZTj8ip5n5DnB7BCMGr0/O70C2Ff5EiKxteOylBe11GtgGGN53VDI/CQdoVchxRJGrin3XWDMetjxjlpcgPYO67UX6wA7rGQKdgY2qu7H7luWdWmFHkLa05XqS+i7OUTNkCld2ZyYSCJGKI+Q0Z/JDiND/Ezao17JBtCMGM3f73LdmWAzeJ4oy76iN8sDRxnpIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199021)(2906002)(316002)(7416002)(8676002)(86362001)(8936002)(41300700001)(36756003)(6512007)(5660300002)(107886003)(26005)(6506007)(6666004)(6486002)(52116002)(83380400001)(478600001)(38350700002)(186003)(38100700002)(4326008)(66556008)(66946007)(66476007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JXwZCoywUvmNXIhVFD0ZQuD04cEFKDOktZohw43+WNXY6cT4g30u+mWnwUT0?=
 =?us-ascii?Q?Yyemg+fHJHafSi/+TVDjrYRnKlP0CYD0PPyOU/sQDB+EDQDu13Id9YVe/1kt?=
 =?us-ascii?Q?ay7U8VB0I/ZgX0rdCKqB6n6rlvFMnfS0ApZN8qhiJlk/tqx0l03VURJMz2ir?=
 =?us-ascii?Q?e1nkgeMyOaZoC4dxN07QD8A2sT/G+FeQN9yb+14S00mtY1F6QGuRShpNHQZ9?=
 =?us-ascii?Q?5klJwDW+OAFq1GPDwu016Z3iqXykDbbc83wFG8UypMP9SNyhn/B2HMW/ICL9?=
 =?us-ascii?Q?7OBCfdoEpgCwuMFSB5NC0Z5YICIt8zdsJLppUVHu3xJcpTzGlMknj5PocvVz?=
 =?us-ascii?Q?nT6WbAXioUpuLQ1lOunJqSFvtMFcOH4jAHBUKaXTb611AiTBxxZXxmtsm4e1?=
 =?us-ascii?Q?KkSjV4Eyf1XI3PYJM9I9CjLbN4x6rrYRem+2Zqqr3eKrXX8LRKqgBdiYBjzq?=
 =?us-ascii?Q?smDU8zy/F7gPC3AFP3iqitHcflQWgeMBanGpusFC/Ct1+LrMZ61auIExB/yW?=
 =?us-ascii?Q?a2/nu9mN9rFwZWvHSOoa+VZU4iuev1XXmJS339Rd67rFl3vheS6v2tB2vQjJ?=
 =?us-ascii?Q?nG8USZjFHS1ywMRJUVCQuajZXEJ04Q7H3PNmjpoCRjKZEn2AZupqxTUVFCcJ?=
 =?us-ascii?Q?MB7SKlpGowAzrfBLYWQLYixT47Vo4ZA5/jdBvL8G4mXOGcLas/iumV5BVUWS?=
 =?us-ascii?Q?X/9YiZfFa1/pi62CVcytI7mrtd6Q0eFiR1VlztEsHhJL/PEHwNi7gBJjLcVH?=
 =?us-ascii?Q?WNnmmENkQmLFVu6I0hQ10JYVx7bbjQWFVIuv40wcJWUWGA+AnQ7ZfupCwwBu?=
 =?us-ascii?Q?9GPWhlfZPKv4H0+w/otUO3hn+2PlTvxoob3BqejwNcJ4g2I1nkjJFGOxLSHV?=
 =?us-ascii?Q?0VEFKmZq9h0/QDz0KiVYu8+O5crA3b/HqxUMogFr5kQT1CDD0E/pMqqQ+ZHf?=
 =?us-ascii?Q?bJY+TPktlzKX6qcvzjiyclc4QstVTTilR3yCGmKSrv9gFFDDWMI20E6upUb/?=
 =?us-ascii?Q?EyT5IBILmbPXygyGJYsQ5kZuXdLYKhgjJKNtMtwgmwe/pmrrGGrFON8NWLYZ?=
 =?us-ascii?Q?KMUTAsIR+6vspLPNANcVSGGNY7Oqu6faC61sMuX8ZsNaw3S66CGhCot33Aw6?=
 =?us-ascii?Q?n7DbkNPQZaad/zf44AqURR76oOmhWWbFnXlnIbZxYB8BwUzCvlHtug9k6Y+e?=
 =?us-ascii?Q?c9AiA1GcU/hcCK7pwybpOlJp9sIOn3lxGg4gEv1ZCFaXU9+il7eNo5baiYYL?=
 =?us-ascii?Q?G9i8rBoYiVMVvVrNVjdG5R8vMiOVSERvHAsJ8XCP1GR3myNrQ08BmTkeVgcJ?=
 =?us-ascii?Q?iKN25101zu/ipful4hWcZN8exLugfkaC0+wuKq+PbXfEzCR/C1GjeTMEyukK?=
 =?us-ascii?Q?lCEGndQbRcfPBIYYYORLWvZB6EOSUiIOAkofIRv7UyVBzeS6IpkYCuQ+A0hm?=
 =?us-ascii?Q?RRPQOP0Ox5cqFPeIfnruJ4MuKOgGU8gU+QnmoW5DCU4NVXqywZnbcJCGlczZ?=
 =?us-ascii?Q?jkOE0IGidD1xkMuGFKYkb7U6iNqJW7/iQ/0B66LFz8h0nQQCcR7kTJiRC8/H?=
 =?us-ascii?Q?6eFlwYO74IoFGPy2LKDNyHsoUPqVedx9VNtCu8Ot?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10deded-9f54-4f4e-64ac-08db8f97735b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:21:24.2871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bn0TbqD5mp0Iu3LaTCkejSjQOnLV7Viz7kETC3ZDEEIdvRywF72a3svJQYBnUKZP4ZaQYWewVTdGMXc37u2s9Q==
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

Add create_file() and create_dir() functions to create the files and
directories respectively when they are accessed. The functions will be
called from the lookup operation of the inode_operations or from the open
function of file_operations.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/event_inode.c | 61 +++++++++++++++++++++++++++++++--
 fs/tracefs/inode.c       | 74 ++++++++++++++++++++++++++++++++++++++++
 fs/tracefs/internal.h    |  3 ++
 3 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 24d645c61029..5240bd2c81e7 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -101,7 +101,34 @@ static struct dentry *create_file(const char *name, umode_t mode,
 				  struct dentry *parent, void *data,
 				  const struct file_operations *fop)
 {
-	return NULL;
+	struct tracefs_inode *ti;
+	struct dentry *dentry;
+	struct inode *inode;
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
 };
 
 /**
@@ -123,7 +150,31 @@ static struct dentry *create_file(const char *name, umode_t mode,
  */
 static struct dentry *create_dir(const char *name, struct dentry *parent, void *data)
 {
-	return NULL;
+	struct tracefs_inode *ti;
+	struct dentry *dentry;
+	struct inode *inode;
+
+	dentry = eventfs_start_creating(name, parent);
+	if (IS_ERR(dentry))
+		return dentry;
+
+	inode = tracefs_get_inode(dentry->d_sb);
+	if (unlikely(!inode))
+		return eventfs_failed_creating(dentry);
+
+	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	inode->i_op = &eventfs_root_dir_inode_operations;
+	inode->i_fop = &eventfs_file_operations;
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
 }
 
 /**
@@ -234,6 +285,12 @@ create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
 	} else {
 		/* A race here, should try again (unless freed) */
 		invalidate = true;
+
+		/*
+		 * Should never happen unless we get here due to being freed.
+		 * Otherwise it means two dentries exist with the same name.
+		 */
+		WARN_ON_ONCE(!ef->is_freed);
 	}
 	mutex_unlock(&eventfs_mutex);
 	if (invalidate)
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 4acc4b4dfd22..d9273066f25f 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -474,6 +474,80 @@ struct dentry *tracefs_end_creating(struct dentry *dentry)
 	return dentry;
 }
 
+/**
+ * eventfs_start_creating - start the process of creating a dentry
+ * @name: Name of the file created for the dentry
+ * @parent: The parent dentry where this dentry will be created
+ *
+ * This is a simple helper function for the dynamically created eventfs
+ * files. When the directory of the eventfs files are accessed, their
+ * dentries are created on the fly. This function is used to start that
+ * process.
+ */
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
+/**
+ * eventfs_failed_creating - clean up a failed eventfs dentry creation
+ * @dentry: The dentry to clean up
+ *
+ * If after calling eventfs_start_creating(), a failure is detected, the
+ * resources created by eventfs_start_creating() needs to be cleaned up. In
+ * that case, this function should be called to perform that clean up.
+ */
+struct dentry *eventfs_failed_creating(struct dentry *dentry)
+{
+	dput(dentry);
+	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
+	return NULL;
+}
+
+/**
+ * eventfs_end_creating - Finish the process of creating a eventfs dentry
+ * @dentry: The dentry that has successfully been created.
+ *
+ * This function is currently just a place holder to match
+ * eventfs_start_creating(). In case any synchronization needs to be added,
+ * this function will be used to implement that without having to modify
+ * the callers of eventfs_start_creating().
+ */
+struct dentry *eventfs_end_creating(struct dentry *dentry)
+{
+	return dentry;
+}
+
 /**
  * tracefs_create_file - create a file in the tracefs filesystem
  * @name: a pointer to a string containing the name of the file to create.
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 9bfad9d95a4a..69c2b1d87c46 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -21,6 +21,9 @@ struct dentry *tracefs_start_creating(const char *name, struct dentry *parent);
 struct dentry *tracefs_end_creating(struct dentry *dentry);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
 struct inode *tracefs_get_inode(struct super_block *sb);
+struct dentry *eventfs_start_creating(const char *name, struct dentry *parent);
+struct dentry *eventfs_failed_creating(struct dentry *dentry);
+struct dentry *eventfs_end_creating(struct dentry *dentry);
 void eventfs_set_ef_status_free(struct dentry *dentry);
 
 #endif /* _TRACEFS_INTERNAL_H */
-- 
2.39.0


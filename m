Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FD6767471
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 20:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjG1SVr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 14:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbjG1SV2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 14:21:28 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012009.outbound.protection.outlook.com [40.93.200.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15F2423B;
        Fri, 28 Jul 2023 11:21:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5se+9Jx2nFhvZYj2H9dllrNcGjDFYwjtnSy5foRXsujs2Aehfgl8MtUkXassmy9HYdRn6HyL8XsSQDoLQ7s0nCk5eZE8AFHbzcE+oHnUEj8aJPQP9JuHvQVPImIQRQ89ujoGJxQf+hk9qNvkEbLE7Y6v7vmWvv8/WbxOG+33Y75HDjkT4USEN0PwWPrmWgedvgHvUHa7I0P7K3pCGvOylAnmVCqwYIxaZH+VpYK8NchtNeBMnjbtAJGzLP8TQXdwi/DhDUot74O6B2X8F79TNw4A7audgel7h2Vdk8VldIH7EW8rcsyD3jV9g13hMj6Ai2PEtqGIzvOiHbShWC7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+j2ECXuIFgkHJbjiZKpVjXM9BCd/BAVHq0XLry5FGY4=;
 b=V/Zv47yjS9IRgzr2ihnG/+kpN+IgNqFmJgALcrrihkIfAC4vx2WtReKIAo72lsdFNw/FW298rVCmprBelo877wcm9ycd6PjE8xf5tWARJhk26VCZ8Q/4lQYl0MY2eSTklDQ6C8wCy19E/hJ10yH+v2aQPET/RhykENJ3HLiIjA/P4LPLBJAc1x1TU3TDaSF2QG8fLdv3ctPwVKDrCvQ15VaujGfMsSuk9Yw3vr2+3x6ULhaHceHxUQT/4PqpghMA/b4Gmy/1/VEBdvjbDZCmmnurDtNS8DRHJOURmbUNrIIxc/dW+J7XONMUyceyKzqTLrXllV3RDKeXjbXXa9PUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+j2ECXuIFgkHJbjiZKpVjXM9BCd/BAVHq0XLry5FGY4=;
 b=JPsfjpYjPjdalwVh07Hblyg6m1iwkqs4ksPdG5AQO5lbhCC2ewV7yPezOzZjvptOf6W/6rMEH+7S68BsSA/3eK3eSs6wyXTtPUmIcirxJiFggilvcCysBLLvQ2Usg3vWZejqWbXVmwDah2G1Z66oDu5TeYAan4nkRhoxXUx3sGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by SN7PR05MB9264.namprd05.prod.outlook.com (2603:10b6:806:26c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:21:23 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 18:21:23 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v6 06/10] eventfs: Implement eventfs lookup, read, open functions
Date:   Fri, 28 Jul 2023 23:50:48 +0530
Message-Id: <1690568452-46553-7-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: cf4bb05a-5850-43e7-e9ec-08db8f9772b6
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CzckxtOfM6/N62vvwWXevr8yNLHfYj4MjUzvRKaP5dEZZ4AAxHHGP7nNkRLjDP0Tqcbal8qCINwz/8+IbtThqmDl397e6b/yaXL/306nHE1+TXLDCwOknCKJwAN9xeihouoNt00afwXuY7bjCpKvXHdug37CCxz3O+7QzotshOORJc06gUkwvGEzIIEAyVgKE3s5TPz/G/W+xDwRscTYBIM+Xg3AkKmA+buPQouYBfh+qbgNtHCtD8R5IHhNyyQ6sVtmZomcxkrIU7RVERFxMkD/lKhxMxMaq/jx7Tv9q2nnDwzqhMomLYxdKHOC6hrcoH8UG/xIeecX4cn4UaiM/WACmvGF+oI00YQQuiifjyCXeqbqY89leS2eQgESv49CJVHZ9fckxDmIMPX8cS2VVlifiobLDeCaR86Aw7QDWvEQsl06/pxsFxlq/KtNLVF0lQc7GbiY0r0ndyHVK/b2pzzZzuPopyygvtyGlc0JiHTiQunNF9BMHjMfJ4UQfBj2MA1E9IwpbqII4Se+O1d91aB0pED7AWt8QGQaf8A+qpMver4fquIwZ5w39hyR7zrd/fSME8Bhu7Vlrtib6IGaXLCwe9vNWejTpHoVGCGRO8dkcc74asArAWeqq/d4UawuEYYZ/hK5KTZmJSCCDZZfyd33gM3LfyL1WDtk6aqnok4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199021)(2906002)(316002)(7416002)(8676002)(86362001)(8936002)(30864003)(41300700001)(36756003)(6512007)(5660300002)(107886003)(26005)(6506007)(6666004)(6486002)(52116002)(83380400001)(478600001)(38350700002)(186003)(38100700002)(4326008)(66556008)(66946007)(66476007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UoxCbgPLM5eSJU9QFXpLF1kauc137RZW9mVNPypDdGIFT3v/YYLUp4Y26Guq?=
 =?us-ascii?Q?QukgcOX0+aQoLiEEG3f8+9D8hcmRC9ZXEdtyVdUXPrA3Ds7M0uf3ZBZg10zY?=
 =?us-ascii?Q?plwZlI334Aq7EnQKKPldzhfgZOvXcPd17Lr6s2MC3/fTAtWAW1kosK7SgcSP?=
 =?us-ascii?Q?CuDboX1+Oz+561TP5svRT7Y2MqBUVqKxQf6cW4Jq3pY7tJGZG67jVOcbnvhw?=
 =?us-ascii?Q?r4jX0Go84dt9z6Mb2zdHIT9WuvQaStMn6p9uy3TvQdFXYi35vBINGiAYmj3H?=
 =?us-ascii?Q?iUnwwLqoRkQPJzm4NKIW1nW8ejqbppofnLHe7Oojt4OQii6fjMqo0HtKcMp/?=
 =?us-ascii?Q?57884cVUk9XJ7oMbJQHiMQS7yWCDNAfnS39WQNmYbpnXu3eTuqwC9POKhZkx?=
 =?us-ascii?Q?5Z+oLveAsN3hO9yYs69DhpdISnm5dfNWLKeW9lQSYossO9zhSkZsxtpK2xDL?=
 =?us-ascii?Q?0V/2HtRSzWQeVtrNJ96QJS7wBQHGwx2IYwhlFjKT1T+MK4U3begqIQaq6Gt8?=
 =?us-ascii?Q?FPKinJKS2e9qHSFa2Oo7moPD+p9AZJKTLDfIQbE9GJD2dFC9cEcvaIHOMWBi?=
 =?us-ascii?Q?Ia7zEVcC3/9AULNiDo2GmAdPAHryJuM7MK0792l1bSThNE7V3vqBmYAEFUAi?=
 =?us-ascii?Q?hpOQYB6DKa3G4jhScE6h8ARigYEn4qjBjXjyNTUlIv8qb2ee1APcxbuCfp66?=
 =?us-ascii?Q?Ql5Ai0Q1iKQdqzBCH/XnmUkPkbKlLKUpPm8t3xmhNB7sN15kh9GFsdHqZcjO?=
 =?us-ascii?Q?kcpOtNOhaE1S8awqiVufC1upg0k07RKBN7/SciCuaGoD9EPjGWS6VGVyhTjB?=
 =?us-ascii?Q?zK0RHFZoT/GmWGVHhXfZ+R4ScNCgkYAiFiqgm0hjK6Tw2aaFVItd85lqJU7/?=
 =?us-ascii?Q?WsEf3GhavF4QVbqn+okwGN4aKLSryMUV+AB9RrF8Mm+ApLpL6GGohDX0XBJ+?=
 =?us-ascii?Q?BoA6VnpcJlVNPlzQKEmDyiGBNLInfZkv4n3uEsYvfuSE1J2DeONpYKt67cDB?=
 =?us-ascii?Q?7TXSo4x9e53Pu5MLeSAD9Lx0tjvVW9i4CqF3tWnqFwIVr+S4LhHJbt/Rczvn?=
 =?us-ascii?Q?eirhTAliltwsdOhhdg7oNN9ScINc5VxZKrHhm9UCq4vcpIO14pPIAx1hCtRM?=
 =?us-ascii?Q?dd/QO89bOUwxMA+bB0gk7Cy8fQ0Cz0RTlrdxNUbWJpVJ1J+lZXvhavzC339T?=
 =?us-ascii?Q?j+Q2LwNx6BH+3I78uvNMWyo4sB6hddR78ARq4TvCUq42LiiwChpjzbMlsxpo?=
 =?us-ascii?Q?vPzwtWqiNXazkaFP/0Uv+qaML4ePbtKJCiLv7EE4h8F6z2UK0bv2HtHRHhkj?=
 =?us-ascii?Q?UVFxUxXpE/uLF3pqkkuNZXAE3LwycwgfOZoYfULOY6VJ8aa68HD40oMvbXP/?=
 =?us-ascii?Q?4AApnijPG2cfUy5hH0PWhN9rkzhXmMcynPWQP6B3UQy8x+xaevJ34dDhnFD3?=
 =?us-ascii?Q?FA99PrLCSxt9rncjUOYKTpsNpT/uYV2a3ISX6i20zxeZaS6pHKkV23bW8IKs?=
 =?us-ascii?Q?r+mqecLpqRmsEebyZd9kAeZ8veLvbnFphvxOrIfZLd6c4Ef8z+ovdF6izTU3?=
 =?us-ascii?Q?h3F5KxPNrl74yaNI8cSx1gsx9zCOxI7APobPkaD4?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4bb05a-5850-43e7-e9ec-08db8f9772b6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:21:23.2154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFxjxJYruT5vWzIwHiUxYrnlYJiEQkGDT+a2YREBKX2H6v2CJq8TBMw7A5Wv8E2JYV710fTtd81uSkLzfqftWw==
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

Add the inode_operations, file_operations, and helper functions to eventfs:
dcache_dir_open_wrapper()
eventfs_root_lookup()
eventfs_release()
eventfs_set_ef_status_free()
eventfs_post_create_dir()

The inode_operations and file_operations functions will be called from the
VFS layer.

create_file() and create_dir() are added as stub functions and will be
filled in later.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/event_inode.c | 304 +++++++++++++++++++++++++++++++++++++++
 fs/tracefs/internal.h    |   2 +
 2 files changed, 306 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 9e4843be9dc9..24d645c61029 100644
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
@@ -40,22 +42,320 @@ struct eventfs_inode {
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
@@ -179,6 +479,7 @@ struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
 
 	mutex_lock(&eventfs_mutex);
 	list_add_tail(&ef->list, &ei_parent->e_top_files);
+	ef->d_parent = parent;
 	mutex_unlock(&eventfs_mutex);
 	return ef;
 }
@@ -206,6 +507,7 @@ struct eventfs_file *eventfs_add_dir(const char *name,
 
 	mutex_lock(&eventfs_mutex);
 	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
+	ef->d_parent = ef_parent->dentry;
 	mutex_unlock(&eventfs_mutex);
 	return ef;
 }
@@ -254,6 +556,7 @@ int eventfs_add_events_file(const char *name, umode_t mode,
 
 	mutex_lock(&eventfs_mutex);
 	list_add_tail(&ef->list, &ei->e_top_files);
+	ef->d_parent = parent;
 	mutex_unlock(&eventfs_mutex);
 	return 0;
 }
@@ -292,6 +595,7 @@ int eventfs_add_file(const char *name, umode_t mode,
 
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


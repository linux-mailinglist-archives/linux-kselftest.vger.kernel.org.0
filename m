Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD9D751FFF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 13:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjGMLeU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 07:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjGMLeL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 07:34:11 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011008.outbound.protection.outlook.com [40.93.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5629C26BD;
        Thu, 13 Jul 2023 04:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLYDNPI/kk79TpnJuF7Ah/JHcSzyOWyo+hBKR3eglyR6uLDHvpGgRXOLPCVFLqa0clErPOI6rcktwzlEfD12ZYSRcnlDacLyG/2LLNOFgghhoOv+RxPnG8NYgtsAJgpYVnSo4IikZokrCjB98i8B03Be33pwFuV6bw3ACTcbEh3QM+4GvU+no70VPL4lf/14QjN3nzFmUp28uP8UjUDxwNNer1OYUQToZymnoe2dhkrcBBgEWYOuuVJyCvsNC8r4sbyJUgWOOMQX/Uz2sgN2tkLrnvmjkRIB5aHk1Uk3TgtxI6zMZhr3qcA9SaLDRw1sUh03i+vYAzb6ywRq2ER8Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLxf/SgzKZwR9lAZZcyEKZCmnSGiq1seDxjBPzxCdQE=;
 b=O6XLwLKdSwdtiPQdBELXCprmGrmy+/G9M2kxCcjdUK10c4s/yj9hipoDJKX4ASxZmQrjCGZzUwCm1Xan+1YvgLPWtTrY+Su3YiCExMUrXkcG39TEY9Pd6ePY2FCznX2wBnNyQp4W4FnZpsAAJgTBUHPkEFDb2ROf1dgOV9rSdHDHcIdCnhjVqgyr4RTNwxEO5/jjQh9FtyN+yV8/UvaEkNjX28rQKo2pp9PAtdVNM9pe1iVmeeZ7mJ2RJTDaQQbA8ZZsP7ElcIHCU/LlGNXdyAlSqFa+bHPIN3uEE0yXw0SfI+7DXQLic2FP27Lmv/6Y+/vZJlpurhH42/9FOH/7Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLxf/SgzKZwR9lAZZcyEKZCmnSGiq1seDxjBPzxCdQE=;
 b=ihnaYsweuQzyoWAWh+gBr0UrsYl4PBq6dacbR3xuAK7Vrc/W/HRFuMMjO/L67lChnW/qGX5sSGbLuCAtzBY3LSoMB2MptYiwc1No8aUKYm6DRXE5YyT1f8ipW/5yOuydleT13olxsWjEf6KwyA+CTDQBh8faMNPwGGnugmveLnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by PH0PR05MB8719.namprd05.prod.outlook.com (2603:10b6:510:b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 11:34:01 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 11:34:01 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v4 05/10] eventfs: Implement eventfs file, directory remove function
Date:   Thu, 13 Jul 2023 17:03:19 +0530
Message-Id: <1689248004-8158-6-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689248004-8158-1-git-send-email-akaher@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|PH0PR05MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: 973606d9-4f12-4eaf-c4cf-08db83950e00
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zT1DP6zW6N2I+GF3PxIxdtOFw9JgsHvdc1xEgFSSYa0G97ayhT839f+OayLzGHLmcOduWZQfRZZd9yiv1ndIwwFSO30DT5ACMk4qT1pDuOD6HUHfcqjf4/sCfpual083hUF7PjfnJxO9R+pqrN8D/5vTvYyviS0r3n3zs/Q+NTcO7cn9bR7T3tKGjCi8HI+0ZoXVEHxvlpPEQ9sY5Uh3YQCWNfbd3h79PYYf/tDzbgp/WxpZOWqn/VeikfNKt7FmdV/mf+gjtTAjPOZw+QhcQtAhygEi61i4vi3r5EEeEChF+WvUflEVaSw+4TybzpbCyXNuo0ddA6Fa14M1AtMCxsyD5e5ZVRZlUP97mHYpX4xlfHEnmWBPVoLemRILmIGEfgCSpsW4fRgxNUdUmpIaGIANgMUUHVT1DHZjmlw1lglKBedbJfA55JYtW2BCSb5Zv7Agpgiz8jCpYzIMfVP6N8U1pyfHuwXs37xveQjucLnypFWgt9ITa2yWCzf3sFv/RwOUbA5l4hvI2bRtUxgfyAj70Trh//FhmGTOcXU34mVMD5fikhUZovlrkatQ8E32PomjMv9Tyc34nf1Iyv8bui30sSsk6o/mUM30/uVcGWKI5ayVX7qXLyVu5hpSDvLUjtuZxjkeeVYB7uMmtiIQaHlT54yu/4ywpUNxS5pslHaolUzXA1C9GjI2VMDdel41iSAABGzTRTzMzPIitYeIVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(41300700001)(2616005)(83380400001)(7416002)(2906002)(186003)(36756003)(5660300002)(26005)(38350700002)(8676002)(8936002)(107886003)(316002)(6506007)(66556008)(66476007)(38100700002)(4326008)(966005)(66946007)(52116002)(6486002)(86362001)(6512007)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zDeteWh1/dGgkedRhmgI+2Go1YU6OL1jStyKvkAzeUE9sdHyQuEguo1+rznX?=
 =?us-ascii?Q?gVaorin44ciQU27tjLvwgvrfEtCr8LVlV7AmHgTlHVXE1Dz7zRTbNt4Pnwwa?=
 =?us-ascii?Q?Cs0NsYYKaaHGP3pRuqKuY+ovYf6uQr+mem8TtmGBZUFnfq62NsZm6AVjwy1R?=
 =?us-ascii?Q?SK87f1oAA8vjj8c5TtFP5YEmPF4MjawV4uPcXJLfedfQEfm9ptrvFvz/4bqj?=
 =?us-ascii?Q?Dm835c+u1Ywc5RzSvTVfH7WQKXJpf80cowNQHpQNn8Tm+TskUMRQtwOpq+5C?=
 =?us-ascii?Q?aZ4ABiOKcl6OTHeC3mc/zbetXSiLlbLOuY0Gih8xjVSKBhC93zl0xNaw5gpi?=
 =?us-ascii?Q?mTwPZmZ6162OeWo7BAUtZSt1F0xpn9uXYAXCcdBY7rHP6mspbAQ9qAo+ZwQH?=
 =?us-ascii?Q?IjkX46wXGWPrXJybmwoVJnLgcZg8U3ScRLbhcUXcoBCR3Y5T3orE0YHlda3z?=
 =?us-ascii?Q?mucjS8XAOlV/3WLghtX0QshTIx6xE0SO6hv75QIgrvOlK5KePB+qbjRlDcfB?=
 =?us-ascii?Q?T3gtBqGpDH6hwblBGxYzukmGB/SmxnoVFPx+d/SUXED3hCCoW6Lo+RWjYktp?=
 =?us-ascii?Q?clHVV0oNW4vO9A/r1n1LoTme9HDX34HDe1KNoOeZkhjaPi+6KFPeU70Tbcde?=
 =?us-ascii?Q?GsXDnLO3DHpX99qomdL7RF2hh4iasB6papOB2SVzGVGuhT+a1vrTkPn6Guh7?=
 =?us-ascii?Q?1/e3KxvYd1qW6k2r41Cv/6x6vIq2XmR847kuyIW3bPU9Qo/1cfTuUevidUXU?=
 =?us-ascii?Q?Uw09pgzRW+WGiAlPHvgOfBV7O01WFTY+806fONk9KYgy1shqBOCws2mvlw86?=
 =?us-ascii?Q?Pjt+mArGnJHgdkqsLKWmG6l7SzBxfSK4O6IdY3jiMC1ZLyQQJTqBTVKEhZQL?=
 =?us-ascii?Q?kwCGU/j6lMHCdOPViD7ftv+Is1jkfbAIDUUHAR4mmpa7UJr4owWILn2QV4I9?=
 =?us-ascii?Q?Zs9mGINfbohQIy1XwJGhhLTvAwCUTpTq/3et5HYpJ6GwZH6ZurVI9UtjpR4p?=
 =?us-ascii?Q?FZYFlMmO6Uh/46gIfOrbBOa7wz12AHH76EyCctU4yyEIvYVG96Y/BGTGM1Ao?=
 =?us-ascii?Q?J9Dp7KSjEc0RWtfcXYXcM1/wOOzqYc6T4kqOSkvcCtL5FRPOmWmFxWhzfTiT?=
 =?us-ascii?Q?kyY8GRHJn++xsiZIXJ82B1XOuHBFl/RQQ9vLE04/5zy7b5uYsucFUS/bl5t1?=
 =?us-ascii?Q?XwxYgk9bDalvLhI5BkVvPR3BLB4rFVARoS5dZwluwKzKPrPkFQ04VaMIfh9W?=
 =?us-ascii?Q?W99QpGozjRwG+UBCUeCRCZ7HfvDy+K6XwPnwvZx9QPTXiJ5FsNyLk9Vrs4Wf?=
 =?us-ascii?Q?6Shev4v7WAqmdYKZv1J8QmetCKEIZEj5wIYQg030UbLm1p971haVk4AjM/4G?=
 =?us-ascii?Q?9nSy/O7trQZ96N+2kX5aied4R5vZU+ycXiF74Fp/30hs/uNQVPonIFkeKB+V?=
 =?us-ascii?Q?M3XJWDRKmA7eLf0tU08Pbgt9Px+BGBnxSTdeGLEbT57UO5ZQBBT2qVmGxRAl?=
 =?us-ascii?Q?qBAQTECbOrDz0ZI1ZWfg+PtYokNXnFeCOQ5AHBNl2uouehW+5agywPoQH4gT?=
 =?us-ascii?Q?27yB8KxFA4lI9ecAIys4s+PhbuOGgjr6uC7MGanq?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973606d9-4f12-4eaf-c4cf-08db83950e00
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 11:34:01.3093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0Ug+AJtlM6hAv8KCvPN/1/gbqIBpuccZjqEfc9F6Y3N5nKOYnOhgA/kOWP2XTYhAHgaSNokQvboL2B0QcvcpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8719
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adding eventfs_remove(), this function will recursively remove
dir or file info from eventfs.

added a recursion check to eventfs_remove_rec() as it is really
dangerous to have unchecked recursion in the kernel (we do have
a fixed size stack).

have the free use srcu callbacks. After the srcu grace periods
are done, it adds the eventfs_file onto a llist (lockless link
list) and wakes up a work queue. Then the work queue does the
freeing (this needs to be done in task/workqueue context, as
srcu callbacks are done in softirq context).

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305030611.Kas747Ev-lkp@intel.com/
---
 fs/tracefs/event_inode.c | 110 +++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |   4 ++
 2 files changed, 114 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 75dc8953d813..322a77be5a56 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -45,6 +45,7 @@ struct eventfs_file {
 };
 
 static DEFINE_MUTEX(eventfs_mutex);
+DEFINE_STATIC_SRCU(eventfs_srcu);
 
 static const struct file_operations eventfs_file_operations = {
 };
@@ -299,3 +300,112 @@ int eventfs_add_file(const char *name, umode_t mode,
 	mutex_unlock(&eventfs_mutex);
 	return 0;
 }
+
+static LLIST_HEAD(free_list);
+
+static void eventfs_workfn(struct work_struct *work)
+{
+	struct eventfs_file *ef, *tmp;
+	struct llist_node *llnode;
+
+	llnode = llist_del_all(&free_list);
+	llist_for_each_entry_safe(ef, tmp, llnode, llist) {
+		if (ef->created && ef->dentry)
+			dput(ef->dentry);
+		kfree(ef->name);
+		kfree(ef->ei);
+		kfree(ef);
+	}
+}
+
+DECLARE_WORK(eventfs_work, eventfs_workfn);
+
+static void free_ef(struct rcu_head *head)
+{
+	struct eventfs_file *ef = container_of(head, struct eventfs_file, rcu);
+
+	if (!llist_add(&ef->llist, &free_list))
+		return;
+
+	queue_work(system_unbound_wq, &eventfs_work);
+}
+
+
+
+/**
+ * eventfs_remove_rec - remove eventfs dir or file from list
+ * @ef: eventfs_file to be removed.
+ *
+ * This function recursively remove eventfs_file which
+ * contains info of file or dir.
+ */
+static void eventfs_remove_rec(struct eventfs_file *ef, int level)
+{
+	struct eventfs_file *ef_child;
+
+	if (!ef)
+		return;
+	/*
+	 * Check recursion depth. It should never be greater than 3:
+	 * 0 - events/
+	 * 1 - events/group/
+	 * 2 - events/group/event/
+	 * 3 - events/group/event/file
+	 */
+	if (WARN_ON_ONCE(level > 3))
+		return;
+
+	if (ef->ei) {
+		/* search for nested folders or files */
+		list_for_each_entry_srcu(ef_child, &ef->ei->e_top_files, list,
+					 lockdep_is_held(&eventfs_mutex)) {
+			eventfs_remove_rec(ef_child, level + 1);
+		}
+	}
+
+	if (ef->created && ef->dentry)
+		d_invalidate(ef->dentry);
+
+	list_del_rcu(&ef->list);
+	call_srcu(&eventfs_srcu, &ef->rcu, free_ef);
+}
+
+/**
+ * eventfs_remove - remove eventfs dir or file from list
+ * @ef: eventfs_file to be removed.
+ *
+ * This function acquire the eventfs_mutex lock and call eventfs_remove_rec()
+ */
+void eventfs_remove(struct eventfs_file *ef)
+{
+	if (!ef)
+		return;
+
+	mutex_lock(&eventfs_mutex);
+	eventfs_remove_rec(ef, 0);
+	mutex_unlock(&eventfs_mutex);
+}
+
+/**
+ * eventfs_remove_events_dir - remove eventfs dir or file from list
+ * @dentry: events's dentry to be removed.
+ *
+ * This function remove events main directory
+ */
+void eventfs_remove_events_dir(struct dentry *dentry)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+
+	if (!dentry || !dentry->d_inode)
+		return;
+
+	ti = get_tracefs(dentry->d_inode);
+	if (!ti || !(ti->flags & TRACEFS_EVENT_INODE))
+		return;
+
+	ei = ti->private;
+	d_invalidate(dentry);
+	dput(dentry);
+	kfree(ei);
+}
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index a51312ff803c..2c08edd4a739 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -40,6 +40,10 @@ int eventfs_add_top_file(const char *name, umode_t mode,
 			 struct dentry *parent, void *data,
 			 const struct file_operations *fops);
 
+void eventfs_remove(struct eventfs_file *ef);
+
+void eventfs_remove_events_dir(struct dentry *dentry);
+
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
-- 
2.39.0


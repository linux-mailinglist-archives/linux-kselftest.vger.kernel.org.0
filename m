Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15D4767474
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 20:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbjG1SVt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 14:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbjG1SVq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 14:21:46 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012003.outbound.protection.outlook.com [40.93.200.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2B64487;
        Fri, 28 Jul 2023 11:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrCQoll6/bElj4a5Ba42tyl4sonBNWt7iU0tbBbHvmVxAho//JkAv2bSAa+OhIV/w88D9XA1B2Y59SS8Sg49ORFmX9LB989BRn6jXAJCAkXnGQn57V/E5j4AYD/IPDB2VLkpoBRtOD9NQ0Ja1vNo98e369ra36oaEwptDdKt4N/9JxYQ28WAjdgtc6EAk24UHVHksI4+bzmR3SCnG959OQb6Vi4xBouDQS/VVEg1KPAAehxVsTOP2NZf0UMkE5/R5vCXk0hOEgqLg68kn/TN/0BYLKMQ5nnoYXQpQtFe27kb3r9sjAqCvNfyN2PIXPXookuzxUFWs8VLtGTsNUa/HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0W9SYDTExcnlkYMizbDBRWmEhwytQWhcrs/5sFtal4=;
 b=C+S+Pxv6ftdG2eATJUy9184ub2MqeYV8hZMO2bWHK4gecovrcnDkvEQyUrmVAl0/pSrdJDWb+U2SSu3TL87VqYq4FLG2gWA1ZCp7dmpOaRl55SVu6He7SZjwI2BtrC3U5/oHH5St8r4EeSapA6WDJsl+/nUIv2nRgkaBQxoHBVDDqALQUQDeWbj1ZlE2tGT7tVBMfeJ1GCbgRG98D96WPlNpodAasNJaGTopAHwfBROjm+B49Tx5T4ovmO1LfTxCdPC/sSdun3Nr1KJkVt1yfg87DkI3D9gdNMsm7m+A4/BjeqrWKY4V/wVB0zONFET4f9RVqr22VZAp+6HI3fSBvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0W9SYDTExcnlkYMizbDBRWmEhwytQWhcrs/5sFtal4=;
 b=ypeP2DxzVnPYQttIvPCVgSASOixsT+9V5/yCSpwRXcSBNt3gphLhM/TCTidjurS+0+DDZKYjf3U+gXSocJPCmrcbPASIckRfISTfRWn7ixjf5JMGyglHYUPCXRJ5yq9k+UH+dGgupbjQdttheVr74K+S3B+iO6YGX9AUVnaW0HU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by CH3PR05MB10004.namprd05.prod.outlook.com (2603:10b6:610:123::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:21:26 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 18:21:25 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v6 08/10] eventfs: Implement removal of meta data from eventfs
Date:   Fri, 28 Jul 2023 23:50:50 +0530
Message-Id: <1690568452-46553-9-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690568452-46553-1-git-send-email-akaher@vmware.com>
References: <1690568452-46553-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0090.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::31) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|CH3PR05MB10004:EE_
X-MS-Office365-Filtering-Correlation-Id: d8500d61-cdc5-42db-062d-08db8f977407
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7UT7B8vcCB89BRlJGDefuTW9t9a0vhTwqDcUdHr/iC99vm1h9/PaSKuberxOCp5hh5zXuc3k/6WUnajyONrPyIWcvPDx1s+2ONs7GySKSe+OJKdbOhIfVapLn6MI37RCJhqWEyUUYCYdNQhLgadzWS7N0Xn+mJrGgG5hWtwG38U8IiFqINPfi/j/AcSYVw+M4LLf+Flh7ACc1Pbds5qoZ/4PRYGii7/LopXyKN8XKCEt05OHABzdb/K3aIb+wb6IrvuvqZS2uHWmz4rWBgkmPTLX7oH8REpyM+ArRqqKJ9HJWOGrLEMVSzah22PdbAKFAhQ0KeEba2VZaTkOY8/0TgfGm/DVP574M8xBi3yvP6516TnDdwILDh1H6pgaIfNjsa8YLbaeD1bTHSDC0S4oMuifha9Yx9xZDekjE6s3jYCij68QpUppshH8aLJYtWWGgwIz0fHWby0v8+Ys0G7gLdDMiZhW8EF2oklf1ijXpoO7PiA2xBgsF28gS3zGcJ7NpQGq6v/XWvOEaKf0MsYQ/z7RGmskXgIP51UZU+jMq5KeZuUzsespy6xJqtcKOlxNX6+ag58MVgvczgeJRj+WBg6FJoFHcwsT2DShn2Tb/ylVsewFMLdOc+dPJbQBaF18s4qyc/Ff03N4/sHT0YE/93/cGXNra7R2yLAJ+Zn3z2qx73B7zImymwaOqkVVu3TuDPImmIFKorsRmN8r/IMXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(83380400001)(66476007)(4326008)(316002)(6486002)(966005)(52116002)(6512007)(38350700002)(478600001)(38100700002)(66556008)(2616005)(8936002)(8676002)(66946007)(41300700001)(5660300002)(186003)(6506007)(107886003)(6666004)(26005)(86362001)(7416002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6xoGTtsQwoNyVMYAodRdpeDcFs0e2lp7KaibXzvgUGqaJMQkSRUy8AAlMCxF?=
 =?us-ascii?Q?RnlHwLAovHxWgOmBHKTe6EEPr0e8OnLlE5mA4hM/CEwMRShjkYLbNIlyq4ap?=
 =?us-ascii?Q?4CVFRGTvbOrjWS67m1MFWYqma5Yx9/h6H8vjPYmcbVm4bIrTgJtBNoypL+Qt?=
 =?us-ascii?Q?MHMrcy1m2TMQdpZ9nBdFwehufRpuRL66qUkqc6CTMAo6ywH79XwmdRLsMkgm?=
 =?us-ascii?Q?lqgM5jlFDIZbmWwd3w2wHHbOr873htDjC+T+rD+rof5NZ8ymUVntEz3Gyw0i?=
 =?us-ascii?Q?+nYPWkOW9wBwIAxuut07IDNM9hzbbdNSAQZhSgCObDsw9FVAtbeVzJsT7y9F?=
 =?us-ascii?Q?c2cwaXRoAA5HaOZfZ2iBSMX2on1NuixrFLg9VjABPPEVTvS0tpNVA6BAkMPf?=
 =?us-ascii?Q?Fs4/N906wOaKnWh6TsxhTdy53ZrBqQnB7+GAIvfc8/HAudPdgnQEpgw0xugd?=
 =?us-ascii?Q?5a6av0HsndEMBKVLxyCSO+eihz8ehPPPCdtc/j2xfa/QwAEqo1sssir4Bt1B?=
 =?us-ascii?Q?aODd9BT7pUpl5qpWSUjztgHXHOJ2mUFbPp15nBr55LXHbxbybRiVNn0lYk7+?=
 =?us-ascii?Q?m17Vq6Mn6opEGeFprELt6NouI646+zP97RJNWUsVs8paGNMxloNcpStx/pXM?=
 =?us-ascii?Q?mYIhP+llPzolA7T5nSGe5Xkmn0mUlil4e//CdGy6F7g0Kb44h0Lac6pPK9V2?=
 =?us-ascii?Q?aVi9pseU0AFkkmQVRZ1zmG7aPezqPo9p9QsqLgkYHnQdBooMxxsFnBH62wGb?=
 =?us-ascii?Q?iIEPq5LlO/rRLfGRw6NrL+/DNLL01d3vn9C8mqDz9Avh5qnLEAiPMfKWuaO5?=
 =?us-ascii?Q?VRvpGJIPzW/S36JOI7n6zuI5YKXYJ/wLZuEA+bLTcb9FJRvLxIiDLm9R5tRq?=
 =?us-ascii?Q?v29Ow0y3TOKFtIEp8IWWULR4W+NZh0CYJcA3XPDo4EN0VC3pZiUsurfcOR4T?=
 =?us-ascii?Q?iECCLK9oH1TXOobRDCic2cmM3byYKrSHFB4eXvMNq5jOyIXrGq9GE4tpzUjV?=
 =?us-ascii?Q?LQyLFKjF6gYoBebsmf4WDoGlGXt/OdmYpB86R46p+QfyHUNby2rHX+FSllbx?=
 =?us-ascii?Q?RMfYmH2CKA50QWjEYdXZcS4Ni4mGLRU44PSpV7xoYtveJ9oSEWNKbu3Auo1s?=
 =?us-ascii?Q?xaAqTq4zpkJVa6LbXHohYoWQI9KeNPb2g09yfvt8AhFRX3WiWu6PAx+WSTuN?=
 =?us-ascii?Q?N4RCXKDFMT0Vic5/7m95RHie7pPBXMDLCMapkqPwbh17luSZTk6pTo21UULM?=
 =?us-ascii?Q?XtolxnBOB6ZeVD96NVIysplmR0zhSTMgIYvSce5C6ARpb9VcEog9xSs65szn?=
 =?us-ascii?Q?p3jJCr24m63udQgUBunFHRYnmZ1hkIv98PYD7qL0ryDMW1BNu7qWV7fi4i2Q?=
 =?us-ascii?Q?4hZNFEmXSIH7GUBPgB6Pyq4/WjA4rTCdxzrvBFySY3Vuj5lsVD6jw797WZ63?=
 =?us-ascii?Q?gsXkWtelrDls75Z5erN+jOcarZqseFzLZG7xzlGR4YDvaoQ9+Cj59ywfESTO?=
 =?us-ascii?Q?L8E77Zao0U8YMYg4YNKhWHPW66wVQUgXaaZde7R5oxEClyVev3252dO0g0tP?=
 =?us-ascii?Q?Ob1t1fVn83YLFYIJfKuE5mfvALObOZXOap1Y0YYg?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8500d61-cdc5-42db-062d-08db8f977407
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:21:25.3990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBQlJFTcUoJh9Eh9wK4WrDiPpGU54aMJqzYNxr8o6Y980Lw/5ScF3lYR19kyWu4sozxIY+SQWbCTRuFrPhaRHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR05MB10004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When events are removed from tracefs, the eventfs must be aware of this.
The eventfs_remove() removes the meta data from eventfs so that it will no
longer create the files associated with that event.

When an instance is removed from tracefs, eventfs_remove_events_dir() will
remove and clean up the entire "events" directory.

The helper function eventfs_remove_rec() is used to clean up and free the
associated data from eventfs for both of the added functions. SRCU is used
to protect the lists of meta data stored in the eventfs. The eventfs_mutex
is used to protect the content of the items in the list.

As lookups may be happening as deletions of events are made, the freeing
of dentry/inodes and relative information is done after the SRCU grace
period has passed.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305030611.Kas747Ev-lkp@intel.com/
---
 fs/tracefs/event_inode.c | 143 +++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |   4 ++
 2 files changed, 147 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5240bd2c81e7..2db7f1028f75 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -198,6 +198,14 @@ void eventfs_set_ef_status_free(struct dentry *dentry)
 	if (!ef)
 		goto out;
 
+	/*
+	 * If ef was freed, then the LSB bit is set for d_fsdata.
+	 * But this should not happen, as it should still have a
+	 * ref count that prevents it. Warn in case it does.
+	 */
+	if (WARN_ON_ONCE((unsigned long)ef & 1))
+		goto out;
+
 	dentry->d_fsdata = NULL;
 	ef->dentry = NULL;
 out:
@@ -656,3 +664,138 @@ int eventfs_add_file(const char *name, umode_t mode,
 	mutex_unlock(&eventfs_mutex);
 	return 0;
 }
+
+static void free_ef(struct rcu_head *head)
+{
+	struct eventfs_file *ef = container_of(head, struct eventfs_file, rcu);
+
+	kfree(ef->name);
+	kfree(ef->ei);
+	kfree(ef);
+}
+
+/**
+ * eventfs_remove_rec - remove eventfs dir or file from list
+ * @ef: eventfs_file to be removed.
+ * @head: to create list of eventfs_file to be deleted
+ * @level: to check recursion depth
+ *
+ * The helper function eventfs_remove_rec() is used to clean up and free the
+ * associated data from eventfs for both of the added functions.
+ */
+static void eventfs_remove_rec(struct eventfs_file *ef, struct list_head *head, int level)
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
+			eventfs_remove_rec(ef_child, head, level + 1);
+		}
+	}
+
+	list_del_rcu(&ef->list);
+	list_add_tail(&ef->del_list, head);
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
+	struct eventfs_file *tmp;
+	LIST_HEAD(ef_del_list);
+	struct dentry *dentry_list = NULL;
+	struct dentry *dentry;
+
+	if (!ef)
+		return;
+
+	mutex_lock(&eventfs_mutex);
+	eventfs_remove_rec(ef, &ef_del_list, 0);
+	list_for_each_entry_safe(ef, tmp, &ef_del_list, del_list) {
+		if (ef->dentry) {
+			unsigned long ptr = (unsigned long)dentry_list;
+
+			/* Keep the dentry from being freed yet */
+			dget(ef->dentry);
+
+			/*
+			 * Paranoid: The dget() above should prevent the dentry
+			 * from being freed and calling eventfs_set_ef_status_free().
+			 * But just in case, set the link list LSB pointer to 1
+			 * and have eventfs_set_ef_status_free() check that to
+			 * make sure that if it does happen, it will not think
+			 * the d_fsdata is an event_file.
+			 *
+			 * For this to work, no event_file should be allocated
+			 * on a odd space, as the ef should always be allocated
+			 * to be at least word aligned. Check for that too.
+			 */
+			WARN_ON_ONCE(ptr & 1);
+
+			ef->dentry->d_fsdata = (void *)(ptr | 1);
+			dentry_list = ef->dentry;
+			ef->dentry = NULL;
+		}
+		call_srcu(&eventfs_srcu, &ef->rcu, free_ef);
+	}
+	mutex_unlock(&eventfs_mutex);
+
+	while (dentry_list) {
+		unsigned long ptr;
+
+		dentry = dentry_list;
+		ptr = (unsigned long)dentry->d_fsdata & ~1UL;
+		dentry_list = (struct dentry *)ptr;
+		dentry->d_fsdata = NULL;
+		d_invalidate(dentry);
+		mutex_lock(&eventfs_mutex);
+		/* dentry should now have at least a single reference */
+		WARN_ONCE((int)d_count(dentry) < 1,
+			  "dentry %p less than one reference (%d) after invalidate\n",
+			  dentry, d_count(dentry));
+		mutex_unlock(&eventfs_mutex);
+		dput(dentry);
+	}
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
index 54c9cbd0389b..009072792fa3 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -40,6 +40,10 @@ int eventfs_add_events_file(const char *name, umode_t mode,
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


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B6475DE51
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 21:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjGVTi1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 15:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGVTiW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 15:38:22 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011013.outbound.protection.outlook.com [40.93.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A5010C3;
        Sat, 22 Jul 2023 12:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KB33Lg1QD8Sil54cLLBaQn6X5EiE6akaPZnruNDwUXfVwxHhV8OPvZuHSkDiZYQIRfEkJrr/sfnriis0MENWN8hqW3O43ZgJEWRX7JySMGVhVEA+SV1amkxqQVTfqrrLoWUHX4ae2TCNGgg8bhmQJrvPtN6MlZJH5vhMYfWym7L4iQoOx8gJdVykc5bXNHPHoUoNrd3LBM0JmFCTqvFE+5rhn6/rCqWzr7SDMR6dTInWVhvBnH8tXs+jb70xsA99bGFzzAKAss55jR9CZOiFXhgnDAcCdyjPfQWtAFIf0mGtXRiBIiPcxvMGf0uYXem2+cdzRKBF+GNlkCzMwqMRiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Huyy63JsflVJ8V9KkJcwW9V2AQaIzlqWfzoZVmQVpB8=;
 b=K66KmE1n/fBMhtdnDhiFh4+9NNi4y5SSEauMS8XsglRQuIAIEhAz1ltDFQNkXqlYEc8iPOiRqvqCu/sL9cXqPCBMq0ZWppEa82PyWaoFlJMCNcnqdiMGyC36i7TvEdWFta14S3xTEMEu1h8h0tDvmL4tWqCaOjkkYDp0hcgXPqmr2OTLP8A93l1htfru5Kh+0no+V72HIDj8G1CdJmrtFkeNZuDB/zTOlDzOMuTE9z8GpcGwX66tHz7HnY1K0JmYpsvRGIle1qBcM2b78y6lR8gUU2d4tmF5Tt8SH1h5PatbzLGak7Kv1R41RAt9vKWIBkdU6VrDG0frcS83y9BTdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Huyy63JsflVJ8V9KkJcwW9V2AQaIzlqWfzoZVmQVpB8=;
 b=DZxexpTwh8nVmzm6JRTJhDzg1yebaJbIv0TaNrZ1nO21E5oDlgJNJw2QX0JwkxxfAJypbNco+KVFRHaGyRdTS1aEQIkz9Zg6weBAA5BR6R9KC+dhTu6EkuTXNelqamQuRr3ryMZ4I2YB8M/Lqz6S+wCcoL2yw9FXf8w3eO2SmXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MN0PR05MB9005.namprd05.prod.outlook.com (2603:10b6:208:3cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sat, 22 Jul
 2023 19:38:15 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 19:38:15 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v5 08/10] eventfs: Implement removal of meta data from eventfs
Date:   Sun, 23 Jul 2023 01:07:03 +0530
Message-Id: <1690054625-31939-9-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 35b2dac3-1680-4ae9-9c0c-08db8aeb311a
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgCLRxag7TKyafJOAre8O/hcOy6C5mFrlZDG3k24afp4o/A980/uE3YD7EGw8B+i7RhMgsAjPneW9ozYDWjQxsyjjuK9sBSlVUfuPiWcbtS1A6RGALy1H6BVj9pq+cQNR8093J248HTIPuVsypKhhIAwIaqmnRE2bx32M/PRoDpL/3skKmr/R+OlK7NN01FFRPq2eHG81ohctixyJe1oAoqBFwcPx740up0dpGtmZ9iJOc5oJspAl9iRU9f3BhmJHd/W+8RtEfHpqZufwrE0288a1NRVX2XxXpdILquRZQhorxhIs55Dw5ex3AQqRkIoFwFB2ZyOzAt3bAJJSGZ1Qw9xFYHo39jihbNkUqoTyraT0L/zpAJhxjNLDrrTN6seutz7VzWJebIe8K0P4ykXIm2ilOaGzSCmV0F0mNaeuIgWH5mKhumfdT+T+wNSvJ2mwAaNJL6asakZSGOlTA+C+X8oSWgKfBtWxn7dnJ29ezoPLEt4GsMzbTmOERtC4XxBYgPtA2WGsZwDeUTSC2ot6OI5k9NUFj+9oAZCQ/UNS0TJ1q2/JsL+jYY67Cl2s9yAUE3Nsxgmd9/ZTbwN1rrC7n36WvlTNLcuELW3EaeVEhf5lysoXN2owMbjXEZNwy+/kC/qQDdx+ZSGz1JuN4pIKbHPCtrNtYnsQdw/aZs7NWKbvRdx4t//un3GY1AodCtGtOBhiVIX77zBYBdNNP6KEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(6666004)(966005)(52116002)(6486002)(6512007)(478600001)(186003)(2616005)(6506007)(26005)(107886003)(2906002)(316002)(41300700001)(66946007)(66556008)(66476007)(4326008)(5660300002)(7416002)(8676002)(8936002)(38350700002)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UrvX+TExv6GZlWOQ7IhQTapv3Zh1F3zzEVJ8O4qylOfGk5nicqL2fmep2kQl?=
 =?us-ascii?Q?IvYFO/JZf2NceUPPw4D8hisI+R4Qr8JiTFASWIdhGtoe87UAj/9GODh2Eyo2?=
 =?us-ascii?Q?7ju9u5zOf8evnPn8fGGtds7uKijsKB1wgocD8jf3f5U819zKXDplHxsp1k6D?=
 =?us-ascii?Q?yAIQu1rvD2oLnXnOhtWbrqrpJhYQjMWBGNynnGYySgm9wJc7mn53Nb+/M1f+?=
 =?us-ascii?Q?ZQua2TgNoFITE50C/kI1gA1B8UFNb2ZByW+HHbP3DNQZuPFrGOeRm4uuq6WF?=
 =?us-ascii?Q?x5nQcz4p6lDfVkVVW/BA+7mf3o/SIOo91pR2Zc6Dv6K+iWR9SRl1KWOeNPGd?=
 =?us-ascii?Q?vzliy2gtE4vpiXLULj7FnIFCpf+gN+Vjoef1iIRbyIklvpFH8xS9czFJUwhq?=
 =?us-ascii?Q?VPiamruZfJw+FvoBkbka/fzafsmgbxI6r14omoTRkCeJ44B/DDQvqEAmVQlh?=
 =?us-ascii?Q?3/AUzBZsZXePbvMYiWuzNp6KiulzhxEnkbXJMFCyjX3W8XC0v4ZhBY4TSQNr?=
 =?us-ascii?Q?iFLARB5/2YkF+1KyX8ERBOfNbK2hRAnT3YSiP9v6uDFik45EorrTWOrlyQLI?=
 =?us-ascii?Q?lx+TKvYW6AfIOPOVuBRiUAQ4D7GWl3Ac6l7xD1DfIBhjgkGAysOLpH96z8Mn?=
 =?us-ascii?Q?uweWCWQ2CvwHbuVeRHYiy70BvvgqXnYW28oOYvLHatyTx7AAJCmGFPcOC5ZH?=
 =?us-ascii?Q?HPo+x/RRNLMxDfVCWxx3fUSpPymDbHbAYMVyX7nOZyU1gXuKupdE19gbZDb/?=
 =?us-ascii?Q?u+nm9FaoF5i2iCLeLxugdO8UX5LQcO66tL8vumOyiR7HUvuY2dJJXW/+sYkJ?=
 =?us-ascii?Q?QOsVVhnhnON/V0TfUZQvK8lV0njOsM2sY/le0u3sXbN3kePHHnecc2LZyqPA?=
 =?us-ascii?Q?dC6K0sHeF67PcXeNo9lw49qyyIeTXWQSvXrgrnjMm2BEP9a/ziIvwHzKovVy?=
 =?us-ascii?Q?7TF7wcVQydMG84MX8ke16N/ALap+hWAqPG8dL/OXZd4czBd2g2wq4iXEZmAf?=
 =?us-ascii?Q?8+8+QHbNIZIFv2u9HdF6IgZClzXx6KrNHaVkzzfNJVAOEhsHUpAzKH2PjYAs?=
 =?us-ascii?Q?ofzBGlapp0srdVlkrEspCfiZkfBeUKkO9xV3PI09M3PlVImEuvzhzvcMY2l2?=
 =?us-ascii?Q?hmL4cDs9XYDe61NojoZ95rfCgVsb3XI+TBCvxI3bzPd4rVE9wHIz+gFeCt0F?=
 =?us-ascii?Q?OSIhRKwxtPmbGwpBYtpzy5T4hRiUilSMlxtIwf8OGaq9b5F1GDkfnvmd9C1O?=
 =?us-ascii?Q?50XxZvG+TzqlY/oLua4n6YCHKlgpXixr0ux5B0bEKjPniKi7zEafC8SxAQZi?=
 =?us-ascii?Q?v8xL0JkPr0ntZZezvnlem//Mp94F7iO+ht1O2h+om6VR5MsPq0DYGe8GbyDm?=
 =?us-ascii?Q?Oxkh6Jn7Sz54gcStAEuzXoWQQT7WfEWbWxmjcN4s+ivHRVMhUW3z+8kJrepf?=
 =?us-ascii?Q?cEZ/uAWHBWsGaJsnXl7x42cqW38S/sLPfnscUH4zvJLMkR7n/V1GixIhHsSc?=
 =?us-ascii?Q?MQn0j/IRTEOH0T3HaUbvEo1FZhyA3TCnnbRAwgGRgqh79AbVOZ3L2XF9EYfe?=
 =?us-ascii?Q?N3RlUF7cbbT1U4x5/au5aXPBaQ2zjuxn5GwhZ116?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b2dac3-1680-4ae9-9c0c-08db8aeb311a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 19:38:15.0268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQ50TwjrWaRJrQOJ/yfp2ptUgFVblxigj44zeFS9UqREIC3MUl75qDtCl+dh+FphSZLyt2xfkp4U4PJdmPIT4g==
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
 fs/tracefs/event_inode.c | 135 +++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |   4 ++
 2 files changed, 139 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index af70d6ffb923..918a1973d3ea 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -658,3 +658,138 @@ int eventfs_add_file(const char *name, umode_t mode,
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
+			*/
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
index cdb21d63a127..166d38e6c584 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -47,6 +47,10 @@ int eventfs_add_events_file(const char *name, umode_t mode,
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


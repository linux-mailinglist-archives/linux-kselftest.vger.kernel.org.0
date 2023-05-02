Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D374B6F42AF
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 13:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjEBLYl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 07:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbjEBLYi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 07:24:38 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013004.outbound.protection.outlook.com [52.101.54.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0825B86;
        Tue,  2 May 2023 04:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJrJTWfyv8DjcSlEgH+nMymBrrICDb6iK37RmGorHQZwZbEJn3CTxIlSPATSMrC6Z8c7teUFWoSkPN6mz0XiVmCyZlVP//UM2Yi+1B1zOq4bR+3OjQ4/FCL6Lc1kwrDkWg7xQEbM1zDX4lNWlmSHashgGpYDjGKzoBkjwSX+KR9GqKnsvh97O2RyUxdaKPReQum4WA21U8tW/q2K+pHc2uKdHLtuPeODTRfu4F0lgUlriYFOX9RIXzOWYFFqHOXhoQisWqJxtNEqaFWj3NweZp5aXIGZgLXsubRmbxEZ8ViaPxT/Biotzg7LHM2L9w6DP+zYudV5gVfLNhazn9d4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvfFuAsOE7stLNyZRI4oiYGvViyfqeFGHzc2Wiwd68w=;
 b=JcjQ6lytUoL+MT7iozVzBxtaMuHdtI3fciPO5emZo/6QH5/BogxfmNmz9hLscITK5vIs8zUuy+BHYD9uqx+6UUG4bf5yteIaK6HYv/9jijk1bUvQdb3wpnpLW0mu5fj7o7w4TQqB9aRZ5FzM/eVs4ueQs7+1c5t5SvCz8/ymP4fbGAnBWZnurgxdrQLhSc21oSMdAHVkVQx/ogbh6kIYNuw5mzUSBEnQ4/H5ZCYWRMQllBL/ndKPhyw+ZB9Wn1zaZqNXBr/g+DZWt9m1gl6dUpdKbCUAKMhmKdBdZWzqykOEv+DxaTpOh0T7D7qjhHVPq0hxM4L+ECJnkB1duBR8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvfFuAsOE7stLNyZRI4oiYGvViyfqeFGHzc2Wiwd68w=;
 b=zYX5XlwfyFiVhrIEKrpCvGYPQwRwez8Y1OaYphgez9oBbir9vGDr/721VOZZPQO+AUXXa0FQaKjQkMzCb7jg1BJ55KhBSL7NldmTNXFdh/qBrZGj40yy9nw+w+KMe79JuVhpGjMWeZ3tG11Nnq7HFIqo+qDmt/BgDSuspRewlXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by BYAPR05MB6648.namprd05.prod.outlook.com (2603:10b6:a03:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 11:24:19 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%7]) with mapi id 15.20.6363.020; Tue, 2 May 2023
 11:24:19 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com, Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v2 4/9] eventfs: adding eventfs file, directory remove function
Date:   Tue,  2 May 2023 16:53:15 +0530
Message-Id: <1683026600-13485-5-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 58a58413-62f0-4e4a-7c12-08db4affc553
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OlFc6e8jJ5fJqjAOHCg71Lx6azV0Yb+FKVM98RcWDchnlLZxFY5VmjcQzP52xvR29fcj4vHwj5og/8W3BQragXnQx4AbukiRYpCkVy26T9aelKtkcP8CtK0ecyq7aIuTn375oy5MhR34ZXosbk2cYJWRnuDvil2MAr+cJphKXYhO7cXhXgtpgZlgUgQaawHTu9tvijLH5k24lw5iiUuwI1FStse17yv41wwRzeKTZU6eeVcrK33RRKreIPaWVHewq5amBokF2pQVAaexwt7gywaYXr8hfqSRBfp5WeHM8xln8PULvYoCvsydidPJ0M9N5ET2HYT8PyTRf1hlrQ+/8zHR3IQuqmWplDyJYKO4KiypcNc7UP9C9ldvDoABZpGZEvxrTXD148DjIvJ01xENsoX71X6UKbXA8E1oRXMSbkIjPUamcvAew0SnsKe7GB5wvsFAiK/h3OF5tYyZT1gKD1LUc2+urNy0C1EU91rAejsquUMAEjU5Ud3gCBoXjZ6zhLlr/jua2HgUSyekit8hCpAzsKIcOxg+kOi52T6UIv/Ml/z40jqzWX3nwwvCzurmS1r2Ew6B1D+0WEmFy7jfTNmD+C5/T6Ni0g8UI9HjXE0cZFB5HPN+qz5lVeT2p+p9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(6486002)(6666004)(52116002)(107886003)(38100700002)(38350700002)(2906002)(86362001)(41300700001)(66946007)(66556008)(66476007)(4326008)(478600001)(316002)(5660300002)(8676002)(8936002)(36756003)(6506007)(26005)(6512007)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vuFNDgYy3aXuWjopTuseHS2CdaB8XA7FHEx3chg30tYeSCDEMUrPyhr2yG4Z?=
 =?us-ascii?Q?U5A2dpzuKf0oMxwuJcASUFAi19fsyRUpOmiTQYe5LC078egkNzP4cQjHZI+k?=
 =?us-ascii?Q?98TBkhPkdpbqLHK7uG5c9iwmutcz6Prxj87IvrMVJMCjWedGg5j03Wztfa3/?=
 =?us-ascii?Q?XhT5NmlJhINQNSVQmDz7UU4EIj6XZEVXTJ97hpGaHHXd/L3iYJKeDVGvAEYV?=
 =?us-ascii?Q?q1oXGB4UhoYB13Gso6oVHhRCOEkHaD7NYTACmpurFvwo23U+Anwv7O12qrWc?=
 =?us-ascii?Q?aIvhtmYBJltrsMLH2MZCOfRT2yAiMH5kRCET/3WbfGoTnDn5rU8nfhmoAKn6?=
 =?us-ascii?Q?fnWq7IMGrdIYkWcACgZvTypTFXWrCOHrZj9/vQq/7/9wODnifHCegRC9Su/T?=
 =?us-ascii?Q?9uilf6GrqvtQYRYUpedG//z71p88G9Hyq1X3WDX7dD5FH160BQU+f+0PlzIk?=
 =?us-ascii?Q?rg8h9rrXV65Cp31HIRsz3b0Lqe5ga53iYUj0OHE2sg6JUJQ4jjcm7PEPQtN9?=
 =?us-ascii?Q?Cn6PcIGmf3U5PsHGI/tyZxSkYBB/K/1S4zc5NJAMD3GOIw1to1nxD6yKSSKH?=
 =?us-ascii?Q?7MiP2HW13z4WMOvV3L0wb4WFNsfj1dcx374/nUIdtLhHrlQi4UfeMlvLY48E?=
 =?us-ascii?Q?10Kn97KYDJTxuOLesQJDBY/LJzWdEs3lUU8nE+BHhupE9Ohp6GKedLZjWPVa?=
 =?us-ascii?Q?ZITCMjJRz08ZOEkRWa8Dvka6P3SRKulVjwwFophCnyQ/dniEe3UnME+s6KJO?=
 =?us-ascii?Q?eG0SSNSMYEbDX9KON0WkrXCiG60TvCJ9WMxpVS8v7Iv/+G0KjS8A5SbeUUED?=
 =?us-ascii?Q?D/kEninlzjMaJe7g3LN8oWN9UNlt/yE1kuJt+PDmTL/+5r60yP1nL8dM7N3a?=
 =?us-ascii?Q?laKhWmn2UWdV+1AG8JaCWBQLrbeJ8SfIsU+gPvBmkxgpXZ7FtS9aL8kFtwG3?=
 =?us-ascii?Q?b5RMFynqZszTpUpDTITQqzJYBICrM79VL+IsrBM0QXTcB1Lik3U6EgnGgjwA?=
 =?us-ascii?Q?qKc/6QURxlo+TZhqPZ+x8vg9UjXQyCSsRbil7FA+r0brZhVgNx+9+utnY8Tx?=
 =?us-ascii?Q?qZLZloxuxDR91y4MFltH+QyL9NHtsCvZYByXALP89DZvOBsv38LjSJd5lb1g?=
 =?us-ascii?Q?zOWbPQSbs6q/jGNyYoeUPmoCkAaM8fCMAK/PCkErxq23tsP3NnhtmDD83prj?=
 =?us-ascii?Q?zu8dPL9AosODVLlDz/OAkjjBvWo51i5G+dfByn+4q5X16eDeSKvGPaXzfqR+?=
 =?us-ascii?Q?dPhY3DQ6ZBAFkZ/5QRt6xkIcQb7mwkKIYBGhiUqs7wKUNHAt8n872oAoaxy6?=
 =?us-ascii?Q?xxdcTthUVBvb4T6WPe257VsrhWbigKycWECrikvJoLHi8G8T3bJrsdufX9pD?=
 =?us-ascii?Q?0N5rwGFOY7w2LqmN30QfKl31EU0Z3qdkpMnJV4xpktGzWQ9bIoA4h08w2TyN?=
 =?us-ascii?Q?GAnRS17FvedddMpVtwGtqYcB6VJk5dwTLOebn6q7EYmHP3sPPnC8Uh5d4AHt?=
 =?us-ascii?Q?PK6msif31fQSYSUrOM8hvu81dt5wismsDzQlqru9ATlUUwNl1uqQmdgoIa1D?=
 =?us-ascii?Q?C4iLvdyeiuO/Ckl++nV8gd/PmtSKonDHPMl525ox?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a58413-62f0-4e4a-7c12-08db4affc553
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 11:24:19.2640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXWYDeg3UOhud4U+XnkDgYShi56A/IyLiXkFeDxZklFD3wKYnCv2Lzs1BpNqDKRUtkuzOHjTva5r6ON8xIIARg==
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

Adding eventfs_remove(), this function will recursively remove
dir or file info from eventfs.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/event_inode.c | 78 ++++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |  4 +++
 2 files changed, 82 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 93134ae40..9ab675edf 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -368,3 +368,81 @@ int eventfs_add_file(const char *name, umode_t mode,
 	eventfs_up_write(eventfs_rwsem);
 	return 0;
 }
+
+/**
+ * eventfs_remove_rec - remove eventfs dir or file from list
+ * @ef: a pointer to eventfs_file to be removed.
+ *
+ * This function recursively remove eventfs_file which
+ * contains info of file or dir.
+ */
+void eventfs_remove_rec(struct eventfs_file *ef)
+{
+	struct eventfs_file *ef_child, *n;
+
+	if (!ef)
+		return;
+
+	if (ef->ei) {
+		/* search for nested folders or files */
+		list_for_each_entry_safe(ef_child, n, &ef->ei->e_top_files, list) {
+			eventfs_remove_rec(ef_child);
+		}
+		kfree(ef->ei);
+	}
+
+	if (ef->created && ef->dentry) {
+		d_invalidate(ef->dentry);
+		dput(ef->dentry);
+	}
+	list_del(&ef->list);
+	kfree(ef->name);
+	kfree(ef);
+}
+
+/**
+ * eventfs_remove - remove eventfs dir or file from list
+ * @ef: a pointer to eventfs_file to be removed.
+ *
+ * This function acquire the eventfs_rwsem lock and call eventfs_remove_rec()
+ */
+void eventfs_remove(struct eventfs_file *ef)
+{
+	struct rw_semaphore *eventfs_rwsem;
+
+	if (!ef)
+		return;
+
+	if (ef->ei)
+		eventfs_rwsem = (struct rw_semaphore *) ef->data;
+	else
+		eventfs_rwsem = (struct rw_semaphore *) ef->d_parent->d_inode->i_private;
+
+	eventfs_down_write(eventfs_rwsem);
+	eventfs_remove_rec(ef);
+	eventfs_up_write(eventfs_rwsem);
+}
+
+/**
+ * eventfs_remove_events_dir - remove eventfs dir or file from list
+ * @dentry: a pointer to events's dentry to be removed.
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
index 1e1780a61..ea10ccc87 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -58,6 +58,10 @@ int eventfs_add_top_file(const char *name, umode_t mode,
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


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8798F719644
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 11:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjFAJCc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 05:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjFAJCQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 05:02:16 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013013.outbound.protection.outlook.com [52.101.64.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5824E10CB;
        Thu,  1 Jun 2023 02:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebe22mjj3nUxZ3NGmqze897OHzv8HyYBVlCIYLcsfZv4lmq3s4qE3pSKVnh9bao7Auag7aNZeHo09qLggzuBXoz0B7sTJAEuRv3g5OX1m6eMk7XkSW8ajsr1VtlfpLv6NVPEQwkB3vDeohdasixjpxruN7sZvEXCyd84Oc5Kqd6FqMyRa1LP0D0pbVklgXG8TWm/m8MsXUthhuORTAPl0kXQxGj5yED6YlJcuZdi4pdkF7CAD4R7BjnjlW+4fUpmTBdfqr/GERMWahvTgr7ngfVZ2WUjRS0K1ZybAWiaE0Szaa++9sB2ZitlxJN3T9QrLCbswORyP8Rfqx2pWbQIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfeFNhpRQruvCiJ19V7ar/8DL4+EfHjmUsxLaI9S1jc=;
 b=E9M/vdYqNISSGynIuZJ6uZ0M3TXd3w9e98e0T902uQgYw91FPbnFFKMhDtyJDTdxBnZCSnkhUN+FivkVFuAwZRhzTrk1qOAUtx9L0dciJwbhKUOJaQK3wr72vqJQ7DCQGsfRvdoami4Bnul61F0R+pPevUfT/FE56n7Jv/dR3jqoWf7orltHpgSSkeX5YmdESrg2zhcHQAbCyQAeds1dZWUvYiqvpVYd+W8kzi4vyEneQTyF4vEEG/cokcMGnalLun+hGwEC5q6QRO+J6KSYFhz8YMr2vAU23SXKBZIWfZc5KEYEmjbbBCYvsLRo60SChXeYB/gsu9GX2bG2qNRTWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfeFNhpRQruvCiJ19V7ar/8DL4+EfHjmUsxLaI9S1jc=;
 b=FyPXZNcgQyNIhx6PQy87FcwpJGPVPmAcb6CjR2ZYICdcC6pnEqBEDOxiiIEo5B7g7X3380s5GhJpIquRWfzsxkNyXqwG+mJwwcBwNO523b4zmXMxEM+VUgzupyZUiUKlvlKvIzKZ6yJFH5DB2MokQU/buZ29M5CfzZ+hfwz4erk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB8617.namprd05.prod.outlook.com (2603:10b6:303:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 09:01:14 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 09:01:14 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v3 09/10] eventfs: moving tracing/events to eventfs
Date:   Thu,  1 Jun 2023 14:30:12 +0530
Message-Id: <1685610013-33478-10-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0bddf763-7c08-49b2-5d6c-08db627ec0a4
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVfLVatDAq3X24lBHsBmBteb++YaRqmLVcGyuXVgD3tiOnZWWKm5539S18ou0aGAmv0wFAZv5l1qSFRInv4ld1fbnPVSCKa1dN13f2H7a+M5/zzy14Rk/8rQYgkFtkwFBLb+oTqB9pDMsRLnsODO/Vp7fC1kJYFsTkcnv0GFzXhykdZ8yBFdIfeKHiI5bFg8niyPCktNZtfoftxK3luiSPXZ1AkE41OMA3BLPG9j56C+OgLCQscrs5vkGWZvEfnc1SWTgA3qC6qGb4a5/5z6Jf8Oeg1WefXrfWYgl3Xn67NgU2cj+eRBEsXocqcNnNilnIDBhL46WZ+5X7k3p6Lq6IzUgSPX8MuZ8PpflLvWH+olnpW0iSdKSe1hc/uSuVTLOU0++JMRspCY7E7kTRT1Sa5lGltoiI0M2eDPnjlImOd+ESd1LzaxU6zcdcSygLfdmkWkas/DItlrEPka5pQRhiL92JaYoKhW1KAknlYuJoI5XciSazrc9zpBWUMLorPk0tDybtD+SSy+6x1uoZPaTDGaVjdQIFGrj9dMAYhtHK8aeMMZbZXQmG8I0r9L7wbm78NRcZYj4zpTFbiKGEjvfoj0vhxNFDT4twIYgLgDm5O14jAJ5ERGTrAEsaEcia87
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(52116002)(6486002)(186003)(5660300002)(41300700001)(107886003)(36756003)(8676002)(38100700002)(8936002)(26005)(6506007)(38350700002)(83380400001)(4326008)(66946007)(2906002)(66556008)(478600001)(66476007)(2616005)(6512007)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3HGu23MqcM4+92DSyAL//hUqbrepE8evatn/wG8fLhqPKmU/uK/+wL66atGN?=
 =?us-ascii?Q?oUeUdElRzfNkkyHX4uDEgF4Z86JLl9obirG/zqZFuIJ9QfPHo+X86tuv9p+/?=
 =?us-ascii?Q?2iFT9aXhZqYSv+5Vm7ByYXcblkv7ZevxqkAs743Hv6a3YFjGcgcIbJwJOkUQ?=
 =?us-ascii?Q?b5VqTYTRqH4dk2/2VeqLa4WvVxzZ/nyUrjQrmCd6uyhG99QQuw0NUJkIiSQv?=
 =?us-ascii?Q?lKzo8skMe582/9xBe9JCZxTfWF4ICRVvE1bDDIKyD/H/26RDamhKmrvWvcwW?=
 =?us-ascii?Q?Wklq/QcMEbElMjt1FdK2pZvq+DcLztPE36UfxnXfImveBYHvoKscUOBJH/gE?=
 =?us-ascii?Q?7WtUHlBsdQ1c85Ot+p45mAQxl7bUL/hCRFTIdi+cC6VEp/ENwhAVfzFx3UaN?=
 =?us-ascii?Q?6omYbYNa2DTvMssxbZJQkIJx60Nh+Y5iVllhYlFZ5SCmtMK3X5z5Q6ZoLTvA?=
 =?us-ascii?Q?rdXrw2f9c82ck7b33PazISCJQuIBntUvmuMjOdRk2AmRq5ythW5YRXUxY80g?=
 =?us-ascii?Q?uHzW4o+AB3OHGOjzyPn+YUvsaXGWFUdoWHHgOvI0t08rGFngISGDQZI64rp7?=
 =?us-ascii?Q?Oh7mmAP40eAnYiQNqyJ8tNNmwC2ZBAHQNugtyEJD3Wdh2QVO2wJ8wXCdpVg5?=
 =?us-ascii?Q?RTknfT56jx/P+9yMHe5kCUBdDMuE/xPy0wuW1VB69b8vhW7shsFzuteY/DiR?=
 =?us-ascii?Q?opFJoWA8pmQsoVPAdXsanLpZVLee5vM/xIaDJV+jI99Ee1g4WNX5guKgngn4?=
 =?us-ascii?Q?CQA8/O5hbnFBk6D3pB6uuK/l9oz0mBhOhqSBmntFlSyruXfJGwotAGOwhUjK?=
 =?us-ascii?Q?zpIYw7UFTE+t6qUaDbAFKftfgTFhb3IkCHUz7xpevpCxqF8EWG8Z5X/owtKy?=
 =?us-ascii?Q?Xw34Bp8EIj1hBfXCIu+TAcj4AhdOof1ak5R/aAWMbyDZW1umX7L2rAbSmb2S?=
 =?us-ascii?Q?q7DW5KU3APOcBeOx6FTNEYqF38mBjI2+OdY+9dJ7g9KsjncIToaoRGfP/2xb?=
 =?us-ascii?Q?F0nK93Yy8ALCOVGzu+plV07gPx6Xze/rT/jgI77nFIHaoathy0XGp5Hp4vJO?=
 =?us-ascii?Q?xwYgQhdEmxn+W/HOGivYuz3ahXTSfqpLyXibNiOzGO5Vwihs1lBk2I4baSh4?=
 =?us-ascii?Q?B8VWHFJ6lW6n02VOosmES3toHtMzs11JUH+NEu5UX1eNLZsqCxAANA2pSbEI?=
 =?us-ascii?Q?X2dZCbQNFThUIPiLLi4tomv5ueMZyNCXAzE1MCGiLqxka/7KpVCPNwf1i30z?=
 =?us-ascii?Q?oJ//fNGIzLN6gUyWAjBN+Ab8MjlGAzXXquRWLHPS6y7zyjvxE48HN0+eouJ3?=
 =?us-ascii?Q?jlby4xy4ByIeZRwnVkzzsn92RJIP3PXoTjas4p4NUqBr6psNHehUo5t9+ney?=
 =?us-ascii?Q?kF3WEPZCTdVu0tC3Ff21mMzbpihMpSRVmuSMjdty49ZpFkWdytY1Rs11TU7R?=
 =?us-ascii?Q?jfJt4XmladzGu+oVlHCXLG8an2DZcNnw3jV010fvD+fKvfUZqLETt9/CeGV7?=
 =?us-ascii?Q?sShSNhib3VU0eXCIRLyoePpVaCR8NEhogP1mXjMZmgBQe3iU/5ZeWRIPFNkL?=
 =?us-ascii?Q?NSJykTHRW/6xJKA/xCoYK/uSh33y1tEwAeQ3D0L0?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bddf763-7c08-49b2-5d6c-08db627ec0a4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 09:01:14.2121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: teyeobMJuEm8LdnlsXlooLqlb50IxHFKj4kK8lFOERZwThaE4UPFB2qcUAM3mMuNOQWskL625BWKeMKNbFEJ2A==
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

Till now /sys/kernel/debug/tracing/events is a part of tracefs,
with-in this patch creating 'events' and it's sub-dir as eventfs.
Basically replacing tracefs calls with eventfs calls for 'events'.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/inode.c           | 18 ++++++++++
 include/linux/trace_events.h |  1 +
 kernel/trace/trace.h         |  2 +-
 kernel/trace/trace_events.c  | 67 +++++++++++++++++++-----------------
 4 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 76820d3e9..a098d7153 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -374,6 +374,23 @@ static const struct super_operations tracefs_super_operations = {
 	.show_options	= tracefs_show_options,
 };
 
+static void tracefs_dentry_iput(struct dentry *dentry, struct inode *inode)
+{
+	struct tracefs_inode *ti;
+
+	if (!dentry || !inode)
+		return;
+
+	ti = get_tracefs(inode);
+	if (ti && ti->flags & TRACEFS_EVENT_INODE)
+		eventfs_set_ef_status_free(dentry);
+	iput(inode);
+}
+
+static const struct dentry_operations tracefs_dentry_operations = {
+	.d_iput = tracefs_dentry_iput,
+};
+
 static int trace_fill_super(struct super_block *sb, void *data, int silent)
 {
 	static const struct tree_descr trace_files[] = {{""}};
@@ -396,6 +413,7 @@ static int trace_fill_super(struct super_block *sb, void *data, int silent)
 		goto fail;
 
 	sb->s_op = &tracefs_super_operations;
+	sb->s_d_op = &tracefs_dentry_operations;
 
 	tracefs_apply_options(sb, false);
 
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 0e373222a..696843d46 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -635,6 +635,7 @@ struct trace_event_file {
 	struct list_head		list;
 	struct trace_event_call		*event_call;
 	struct event_filter __rcu	*filter;
+	struct eventfs_file             *ef;
 	struct dentry			*dir;
 	struct trace_array		*tr;
 	struct trace_subsystem_dir	*system;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b895c3346..b265ae2df 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1310,7 +1310,7 @@ struct trace_subsystem_dir {
 	struct list_head		list;
 	struct event_subsystem		*subsystem;
 	struct trace_array		*tr;
-	struct dentry			*entry;
+	struct eventfs_file             *ef;
 	int				ref_count;
 	int				nr_events;
 };
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 16bc5ba45..94aa6f9c9 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -988,7 +988,8 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
 		return;
 
 	if (!--dir->nr_events) {
-		tracefs_remove(dir->entry);
+		if (dir->ef)
+			eventfs_remove(dir->ef);
 		list_del(&dir->list);
 		__put_system_dir(dir);
 	}
@@ -1009,7 +1010,8 @@ static void remove_event_file_dir(struct trace_event_file *file)
 
 		tracefs_remove(dir);
 	}
-
+	if (file->ef)
+		eventfs_remove(file->ef);
 	list_del(&file->list);
 	remove_subsystem(file->system);
 	free_event_filter(file->filter);
@@ -2295,13 +2297,13 @@ create_new_subsystem(const char *name)
 	return NULL;
 }
 
-static struct dentry *
+static struct eventfs_file *
 event_subsystem_dir(struct trace_array *tr, const char *name,
 		    struct trace_event_file *file, struct dentry *parent)
 {
 	struct event_subsystem *system, *iter;
 	struct trace_subsystem_dir *dir;
-	struct dentry *entry;
+	int res;
 
 	/* First see if we did not already create this dir */
 	list_for_each_entry(dir, &tr->systems, list) {
@@ -2309,7 +2311,7 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 		if (strcmp(system->name, name) == 0) {
 			dir->nr_events++;
 			file->system = dir;
-			return dir->entry;
+			return dir->ef;
 		}
 	}
 
@@ -2333,8 +2335,8 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	} else
 		__get_system(system);
 
-	dir->entry = tracefs_create_dir(name, parent);
-	if (!dir->entry) {
+	dir->ef = eventfs_add_subsystem_dir(name, parent, &tr->eventfs_rwsem);
+	if (IS_ERR(dir->ef)) {
 		pr_warn("Failed to create system directory %s\n", name);
 		__put_system(system);
 		goto out_free;
@@ -2349,22 +2351,22 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	/* the ftrace system is special, do not create enable or filter files */
 	if (strcmp(name, "ftrace") != 0) {
 
-		entry = tracefs_create_file("filter", TRACE_MODE_WRITE,
-					    dir->entry, dir,
+		res = eventfs_add_file("filter", TRACE_MODE_WRITE,
+					    dir->ef, dir,
 					    &ftrace_subsystem_filter_fops);
-		if (!entry) {
+		if (res) {
 			kfree(system->filter);
 			system->filter = NULL;
 			pr_warn("Could not create tracefs '%s/filter' entry\n", name);
 		}
 
-		trace_create_file("enable", TRACE_MODE_WRITE, dir->entry, dir,
+		eventfs_add_file("enable", TRACE_MODE_WRITE, dir->ef, dir,
 				  &ftrace_system_enable_fops);
 	}
 
 	list_add(&dir->list, &tr->systems);
 
-	return dir->entry;
+	return dir->ef;
 
  out_free:
 	kfree(dir);
@@ -2418,7 +2420,7 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 {
 	struct trace_event_call *call = file->event_call;
 	struct trace_array *tr = file->tr;
-	struct dentry *d_events;
+	struct eventfs_file *ef_subsystem = NULL;
 	const char *name;
 	int ret;
 
@@ -2430,24 +2432,24 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 	if (WARN_ON_ONCE(strcmp(call->class->system, TRACE_SYSTEM) == 0))
 		return -ENODEV;
 
-	d_events = event_subsystem_dir(tr, call->class->system, file, parent);
-	if (!d_events)
+	ef_subsystem = event_subsystem_dir(tr, call->class->system, file, parent);
+	if (!ef_subsystem)
 		return -ENOMEM;
 
 	name = trace_event_name(call);
-	file->dir = tracefs_create_dir(name, d_events);
-	if (!file->dir) {
+	file->ef = eventfs_add_dir(name, ef_subsystem, &tr->eventfs_rwsem);
+	if (IS_ERR(file->ef)) {
 		pr_warn("Could not create tracefs '%s' directory\n", name);
 		return -1;
 	}
 
 	if (call->class->reg && !(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE))
-		trace_create_file("enable", TRACE_MODE_WRITE, file->dir, file,
+		eventfs_add_file("enable", TRACE_MODE_WRITE, file->ef, file,
 				  &ftrace_enable_fops);
 
 #ifdef CONFIG_PERF_EVENTS
 	if (call->event.type && call->class->reg)
-		trace_create_file("id", TRACE_MODE_READ, file->dir,
+		eventfs_add_file("id", TRACE_MODE_READ, file->ef,
 				  (void *)(long)call->event.type,
 				  &ftrace_event_id_fops);
 #endif
@@ -2463,27 +2465,27 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 	 * triggers or filters.
 	 */
 	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE)) {
-		trace_create_file("filter", TRACE_MODE_WRITE, file->dir,
+		eventfs_add_file("filter", TRACE_MODE_WRITE, file->ef,
 				  file, &ftrace_event_filter_fops);
 
-		trace_create_file("trigger", TRACE_MODE_WRITE, file->dir,
+		eventfs_add_file("trigger", TRACE_MODE_WRITE, file->ef,
 				  file, &event_trigger_fops);
 	}
 
 #ifdef CONFIG_HIST_TRIGGERS
-	trace_create_file("hist", TRACE_MODE_READ, file->dir, file,
+	eventfs_add_file("hist", TRACE_MODE_READ, file->ef, file,
 			  &event_hist_fops);
 #endif
 #ifdef CONFIG_HIST_TRIGGERS_DEBUG
-	trace_create_file("hist_debug", TRACE_MODE_READ, file->dir, file,
+	eventfs_add_file("hist_debug", TRACE_MODE_READ, file->ef, file,
 			  &event_hist_debug_fops);
 #endif
-	trace_create_file("format", TRACE_MODE_READ, file->dir, call,
+	eventfs_add_file("format", TRACE_MODE_READ, file->ef, call,
 			  &ftrace_event_format_fops);
 
 #ifdef CONFIG_TRACE_EVENT_INJECT
 	if (call->event.type && call->class->reg)
-		trace_create_file("inject", 0200, file->dir, file,
+		eventfs_add_file("inject", 0200, file->ef, file,
 				  &event_inject_fops);
 #endif
 
@@ -3636,21 +3638,22 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 {
 	struct dentry *d_events;
 	struct dentry *entry;
+	int error = 0;
 
 	entry = trace_create_file("set_event", TRACE_MODE_WRITE, parent,
 				  tr, &ftrace_set_event_fops);
 	if (!entry)
 		return -ENOMEM;
 
-	d_events = tracefs_create_dir("events", parent);
-	if (!d_events) {
+	d_events = eventfs_create_events_dir("events", parent, &tr->eventfs_rwsem);
+	if (IS_ERR(d_events)) {
 		pr_warn("Could not create tracefs 'events' directory\n");
 		return -ENOMEM;
 	}
 
-	entry = trace_create_file("enable", TRACE_MODE_WRITE, d_events,
+	error = eventfs_add_top_file("enable", TRACE_MODE_WRITE, d_events,
 				  tr, &ftrace_tr_enable_fops);
-	if (!entry)
+	if (error)
 		return -ENOMEM;
 
 	/* There are not as crucial, just warn if they are not created */
@@ -3663,11 +3666,11 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 			  &ftrace_set_event_notrace_pid_fops);
 
 	/* ring buffer internal formats */
-	trace_create_file("header_page", TRACE_MODE_READ, d_events,
+	eventfs_add_top_file("header_page", TRACE_MODE_READ, d_events,
 				  ring_buffer_print_page_header,
 				  &ftrace_show_header_fops);
 
-	trace_create_file("header_event", TRACE_MODE_READ, d_events,
+	eventfs_add_top_file("header_event", TRACE_MODE_READ, d_events,
 				  ring_buffer_print_entry_header,
 				  &ftrace_show_header_fops);
 
@@ -3755,7 +3758,7 @@ int event_trace_del_tracer(struct trace_array *tr)
 
 	down_write(&trace_event_sem);
 	__trace_remove_event_dirs(tr);
-	tracefs_remove(tr->event_dir);
+	eventfs_remove_events_dir(tr->event_dir);
 	up_write(&trace_event_sem);
 
 	tr->event_dir = NULL;
-- 
2.40.0


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A69B6F42C3
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 13:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjEBL0q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 07:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbjEBLZK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 07:25:10 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013011.outbound.protection.outlook.com [52.101.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9297E5FC7;
        Tue,  2 May 2023 04:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HU5P3g9R9Q/lgiXNVsKHUl824kFC7CGzNaVXgXCWK9vuvEorYKXJRV7k/+DVQE1YxJe10k6hn+my7dHwI9cLJ1VpQmiHQmqmktIVjU4R84rIka/WbtEnW5Ikz+McBcxYNpIXj3ylOWJv2sKtMXvdS5LqENWIa3Awop425ccLyZKgnt37+KqySNdwe5vP3DMIfvFQnRsvBAlw2klKrlJcnOigYKF0NEkp2qTulRXDnVeLI6Bd5seKSEDdA6oYcVrIUPC79aShRdr1+U6cMcQc1H1Pz+kDAk7I1gBw97KSuLTj3my0pCknUmBHsgiHqWOp1JYcPYGCMGcW3BPjYEdk9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERQimYWkxEJ0rbIEpqK/pcQLku99de6QyaNoG0OzoWw=;
 b=Xs7Fbxhm40IC2Yd44EPpVOHhgDntIBkPQhkuGjzKpDM5GNWRkIE3vDTzMv828ULB/D/jYJpGH8PqXhqge8ogZqjoc+lk38Nxub/ACPxl3SYGjhChKOe1QD41oZQwpM94/m5ESeyuScq6on3xOxZT8YdqhWpK1dNVgz6LikNSw3ry5Q0Jqf8092JmuEfI4cNcOiXMH/FDgs9rR/C1vOd9J+A6jZh/Mawj2yPTz9RRnYsxMSLvxAfc843pyK+rcY+27wSHDV4nhKMaQRM5xz/VO3dxSSbRdK/J+CQHrct8IkP9se0ZkmrIndXoQ4D2XP0yX73tYJZrMCgRMfsg8wfN3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERQimYWkxEJ0rbIEpqK/pcQLku99de6QyaNoG0OzoWw=;
 b=2hMnw5LyjAkIYO5YnBTXQ1KfQaGJj0v/M47lowlsjHUsnESjL91vOYF4kJAEBYJ8YYZ8lkWQT2KCnishL4pBRaN82VyU8MHc9KBIG+VQUMcLG1fWmYAFs0ZP3zGKndvKQF+rSW0H2uRRR0Zf1JsnLk0EPPnJM30ikALQssCBPFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by BYAPR05MB6648.namprd05.prod.outlook.com (2603:10b6:a03:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 11:24:23 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%7]) with mapi id 15.20.6363.020; Tue, 2 May 2023
 11:24:23 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com, Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v2 8/9] eventfs: moving tracing/events to eventfs
Date:   Tue,  2 May 2023 16:53:19 +0530
Message-Id: <1683026600-13485-9-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: cedb92c1-bd7a-4e11-681d-08db4affc7e5
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xCfLuXhXfeoaAj8mTIxnJDfY2jV+MBGlS2pc+4YKBp5fhbvTa+1fEAnoh4W3yUIviUx8C4jgJeFfmR/FNTFPFxatqcqsv41nbWTKF3ItIYDgdbFkx5tV98b1z5zJGiZpcM9zUaxZ4yuJqcjkOJscK/Cdbv2ZulLG7UuyLYplBb9wZ7wrMrnIAWr3qDm3S0JmDVKkU1zGKLFc0+v09XDGe9BnoVRWqDHwbnaIjiBoliMKHbKKxTexg4Um6ALJkMFcDjkQI3b4A2qbkzRQyapVmNaN+PZMoM5WyyGAsJgwpYfuz4ZjiTGMAJmaKVilrJclU3+qEq1/clRivIqSxq9W0oajQLsVAecTkDONj6Nts8Vz69GRpEv1zwgHj/g3JMtZWlRPU8bSXrtopGIOFb311e9I7qfYt3mVxbMMHi6cc5VlNAU1NYE4zcfSTm4ShQ3ajJr+kdoC088kZ0brYPFcAXKtaqa6RrzkpZCuosGOlYEQ4ONJSMJPtHODP6SXaM8lYm5VE3NXhWbbjRVrHSmjsAV+r+Lfba6dYqW+RZj+EZVMV4lMuqXy7vaqCDmLpUv2N/CHDBSQpKPUFg+612a8Ks+GVxUreRuJaGWaYj53YEJB8YInOOV0jHfQodE50Xb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(6486002)(6666004)(52116002)(107886003)(38100700002)(38350700002)(2906002)(86362001)(41300700001)(66946007)(66556008)(66476007)(4326008)(478600001)(316002)(5660300002)(8676002)(8936002)(36756003)(6506007)(26005)(6512007)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JY6MxwQDC1VvJnbV+bVTFDse4SCWRMPULs13QkVken9ZHcr0TUhmrGWZrQxZ?=
 =?us-ascii?Q?oZymtVA8olAZDLo7M3Ybv5xI5xiRuKABoxERFFMAPwdZ/9ZC9DwdxGdgJ8NW?=
 =?us-ascii?Q?+dUryWH2t/cGjNcqyul2ZwZs4EAQ+mTvdWljuUdPmNZV1BTKU6MxpYjXJUjV?=
 =?us-ascii?Q?7FLpsBkf8lgLc1eyLyNcGNuOX4BKp0LHPdrvV4TYgfcYoNqcBZVxEknS+mfy?=
 =?us-ascii?Q?BTdF40kdsDsyQumz3NtHed4QojJIbfpUSkPvXu/DJu32MGksLDDDDDDonwQ8?=
 =?us-ascii?Q?41Iq8X6EUNnkzxnfxdYjYclQwXOkWfovrYpt6s6hiA/QtJVDh1il2CoOOjuh?=
 =?us-ascii?Q?8o1NkX89LqVMd3lpkwMTcEgVSvIh3jx8hAhXFMT6+W/zNWCrWqrGlLlQnSta?=
 =?us-ascii?Q?tupnsLAfXiDC6MDM8ehVVU78iIPgQWFInF2Cr8TAP+oM+7V3fEphR7Hr6Qui?=
 =?us-ascii?Q?Y0LmlL4r53Dx/ubnHEAAuaP+2Bi53nvAm2DmRc2EKFStZs64fznwDIPEZ3S4?=
 =?us-ascii?Q?gerlVRv8sQx5aiJWG/h7wxp+kpcVEmDDzYTqYd61dpAtPtureadToAp5++EM?=
 =?us-ascii?Q?+JyOiPjVGQFWHO212V0mJFQbUJQ8iFyyLS56hndsu6TcKX6snm/oBxvrxIXw?=
 =?us-ascii?Q?YY2faauc3PWjNDa5v8OXc+zeoTx/WEHXB7mtbQLMBIVB9tzbi/3B5PysTa+p?=
 =?us-ascii?Q?QwetWpUI0PsRK7wgvPzu/bnxLjJNEyVutigtBOCKlncbq2M/BmguR5YWDJPI?=
 =?us-ascii?Q?WwrsJt8pRkhbLMtiyaSIEju09W7UtyfpDzYn7Ne4cG1BEFqbgoPlE2hxv8Su?=
 =?us-ascii?Q?tstaaphQbO588pmvcLikLZZKhmXBadWMSDrqDzowA0EtL88qzD+i3vKvcFus?=
 =?us-ascii?Q?ycxAy/E63odM6kYGP/yeR2L9YhioXxO7y0ac+a+8dqEERI/TeNITokcdSm3g?=
 =?us-ascii?Q?dXxqOrYhjoWTRdyQTYksbuC5pBv7F7XxBMZq4nqY17J34wloI2+6ksPShhp9?=
 =?us-ascii?Q?K/VW8BFgEKYdAPkFgbJyX4DHF9YwuzukMS8JfefVW8BqvA52aeXQNm6v1Srb?=
 =?us-ascii?Q?IxDbk/V/i4KNscsQ49twvHg+JmDwcgn78kXBm2m68DTKAENE12YM3ihCIwSX?=
 =?us-ascii?Q?rmcV8C15hcyjWis3TP2tO1IgDKUIAd26r5QlVeLFofxSQFfwtQh234wgpiSc?=
 =?us-ascii?Q?cxJv8HS49seYV+57m8qbd1bI/GSWqLDPm7xpKI3utlcQyjEuqaQcBx5fqwXC?=
 =?us-ascii?Q?8SVmIoHLCGvNFzLQ6GGzPKOdHsWsGk/eaKsQOl2mxMOx4mQTKVWXHxAgRXS4?=
 =?us-ascii?Q?GZFfhgaOljrRe5lICqjQPpNuazDqMkIWyuBVi8Vi3KxHYkBlUOwW5cI1YOfr?=
 =?us-ascii?Q?WxndLozBxY7/T00RPnnz3Q1W4WAOr7zr2B60aUP7I1/ruiLY3jwJCTg8Z2rb?=
 =?us-ascii?Q?S2pUDojuvzKTaiMt7ptmcB5/8DrzbWG4Qo5qImEAdAG9Ci2x5nADIuu3WCj4?=
 =?us-ascii?Q?8+NRlaG1EkIJIMSJFcmD3bMwzFURezW8wfikjI5W1JjF9fLdUlup6B/4hiAt?=
 =?us-ascii?Q?YCU0yaCInxCqfdBjkz16yOEtxCduUOYu+LeYyXU3?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cedb92c1-bd7a-4e11-681d-08db4affc7e5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 11:24:23.5440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5gIZDYEyRxegddG5/QeH1oiNb/ftwAvogcBOgikDXaVe9N427Tl7rKsqZ9GFgEPCGZdvlRWJyKnckEkSJ3E1w==
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
 kernel/trace/trace_events.c  | 66 +++++++++++++++++++-----------------
 4 files changed, 55 insertions(+), 32 deletions(-)

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
index 3726725c8..ee9002852 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1308,7 +1308,7 @@ struct trace_subsystem_dir {
 	struct list_head		list;
 	struct event_subsystem		*subsystem;
 	struct trace_array		*tr;
-	struct dentry			*entry;
+	struct eventfs_file             *ef;
 	int				ref_count;
 	int				nr_events;
 };
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 654ffa404..01bd3dda6 100644
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
@@ -2418,6 +2420,7 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 {
 	struct trace_event_call *call = file->event_call;
 	struct trace_array *tr = file->tr;
+	struct eventfs_file *ef_subsystem = NULL;
 	struct dentry *d_events;
 	const char *name;
 	int ret;
@@ -2427,26 +2430,26 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 	 * then the system would be called "TRACE_SYSTEM".
 	 */
 	if (strcmp(call->class->system, TRACE_SYSTEM) != 0) {
-		d_events = event_subsystem_dir(tr, call->class->system, file, parent);
-		if (!d_events)
+		ef_subsystem = event_subsystem_dir(tr, call->class->system, file, parent);
+		if (!ef_subsystem)
 			return -ENOMEM;
 	} else
 		d_events = parent;
 
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
@@ -2462,27 +2465,27 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
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
 
@@ -3635,21 +3638,22 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
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
@@ -3662,11 +3666,11 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
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
 
@@ -3754,7 +3758,7 @@ int event_trace_del_tracer(struct trace_array *tr)
 
 	down_write(&trace_event_sem);
 	__trace_remove_event_dirs(tr);
-	tracefs_remove(tr->event_dir);
+	eventfs_remove_events_dir(tr->event_dir);
 	up_write(&trace_event_sem);
 
 	tr->event_dir = NULL;
-- 
2.39.0


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334EE751FFD
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 13:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjGMLeQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 07:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbjGMLeL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 07:34:11 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013000.outbound.protection.outlook.com [52.101.54.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCAA2700;
        Thu, 13 Jul 2023 04:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDwEiqroHZ6PDoWoeAM2Cop4Osc8bvMcbl7x56yEGrB3IHb7q4+nwHCyKGREQc2Op+E6oe1IMGjs0vgyGWGIYuxo52pLcTyrbz5JWegtal/+boNsPlEWxk2bma1L8EmPpP4gv6dL1NqBKeGlLyTdA1UoAcCPG0LZ7VwJbvuz/7nQTYO/up17gvJurMwfWr7RCi6l357NpV1HGPvdFVHONfnaah73HYT1B7U8QVNbYY8A1CgNSoluPT1YACr86AS3ZZWEOsk6P9/Huyw+6ubtIc4N/yRJGy/RwpsJ0bf4wYDS659FpFISHylo4U+m3qjQtYjwklfsU9iJjs+M+FNEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSHFHeqQzYuFLfiobbSC0DLv66Cvpm38ftXy5EyG7HY=;
 b=cjViEEtzpkG6vO3ZAZmL8IF0nbN+QgDEdcKF2NgQ3ao6sX8VmIHhSxP2RJnJFXT7tn03JgRcu5Gc1N/k0ysre7sITuRqyBBqJk8uYV+wN58tknTJC38zA+uGvbj0906rCBFrpd8SprLuOOSV2k9qMamlukItzVInBd7oqs2WiT5Wh6zb9rjtbtVog1ZgSbGl6s3JRoOzy6iKQ4j7I9z4Tyjnoqm3HrAG9I1LhdrNOm8qgvjASxMsx+7YzGTu1bI3HrhayUCkP/S9STAB9dQZIF5yi1qmyab48FOuPXYGKKmqgmOt20PIQwIwIYsuWa17FcITKzPToydO9Fn7t/pYAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSHFHeqQzYuFLfiobbSC0DLv66Cvpm38ftXy5EyG7HY=;
 b=qIsE3uGnwguagesFhX9abD4HoUo92Xhqs0Pomk8pKfAHpxm4O6ZlqXAUN5VJhD6ibO2UaevHT8G0nt0SrmmtrMkqcEBTmjWFii3gh/t+TOAiuYYvj6bchI5zWfhfAu3AWWDFLWxIDV6W26EGfRBrfd+57W2Vmfspc+FBy8VBm+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by SA0PR05MB7452.namprd05.prod.outlook.com (2603:10b6:806:c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 11:34:05 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 11:34:05 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v4 09/10] eventfs: Move tracing/events to eventfs
Date:   Thu, 13 Jul 2023 17:03:23 +0530
Message-Id: <1689248004-8158-10-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689248004-8158-1-git-send-email-akaher@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|SA0PR05MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 68435f1f-9ead-4bcd-5f84-08db839510a3
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w/Nh3CYNlt4SabFiXdWJYVgoR6DFgEBTapUi4MXShHVqP2OpmBCN60cpxTjs0V7jrRK1bDmy7eliKP+DCks3p8krVzG/UbHf3GbBRG0U6/E49aWVuEbWfjaSPlu3OfbfxtQZBakqR6yV/VNvC0YroR5DMXY5QwcHfatFVabAXAyYAE+Lbdmwwpxmf+YmBDb55KishN0vDScr3SZla8LAQVRHvxuSMfkcAUD7Pl/jUqUBr8FVXN/dHGaV/FckOexusMQ/a/8xjCoxiZJIBSFk39+C5LSOOxbIA4ImpITzbXP9rqdc/bT6Dn9HjMnB7ex9+mMJ1L+0kgN/JOXefXQj4TjoF0DbYo5O1HjMx3kA0r4xfv8OT7rOmQkEcTuRs05yF1SiUT0XF6JzGScp3OXXfSc8H1hg1UEswJxfAatOJBr5DOZHVDuu9TkBpONOT3I0dhTJr/T8haC38/rVqM/a42pmCc25h0H4GXsQLgIW1ySRBTYJOaYVFKsFIg8qxvWkF4BaAh1U/eqfrsrIZ2riuR3Fufoojvcil4uPEB10TJpbITTtGIbO27EXDZ2xWC9BfG5ZkyHbRSA9eDO0XOvtXdGD/DhaO1ZS4kdAUQ0mqV9c6I0I3oPoM9qMSm5/wGOOsA6nfG11d3dd6lMqr8G0NVjBqWxwmASUL0hStOAf0Lk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199021)(6486002)(6666004)(52116002)(478600001)(8676002)(5660300002)(2906002)(36756003)(7416002)(8936002)(86362001)(316002)(4326008)(66946007)(66556008)(38100700002)(66476007)(38350700002)(41300700001)(6506007)(107886003)(26005)(83380400001)(186003)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S501ralJtwaTE8xRXyu0ARb2+HVzQb2mU1LCNMf1Mpf8DSLVkfbJLrHHEHzj?=
 =?us-ascii?Q?BAVHK3glZaOdjZ6bni4J+npZipq7NBROhaDNIKD6Dz0x18baK08Y6LF8Lp2v?=
 =?us-ascii?Q?TS5KR00/KJh2LoAKnv2lDQAhaRBKREq5IvpaKmXldTIeFBXe2awdokKMlGTa?=
 =?us-ascii?Q?gzKroxj0EAExHSpSpVtSl2zLKvY7Uz/OHW05iOoDDFn0h/UmQosgb7Cza8Um?=
 =?us-ascii?Q?pIWQgOJqH+jF9V0Jx5YxIpnZWkmtD3BJX4eilvcrlaVsN2eam8YwRTzedEPO?=
 =?us-ascii?Q?6gaYce26Fn2SBoGGkJnENGjnoYgTGFhZ+odGVpH9TPzQTJg+IXX29OUQ55LL?=
 =?us-ascii?Q?Vaa5MtSDpLCSQgGn8at5ljHA5CrEGsUaHT6VKmPW9TZMlg6yW/cYHgYv1X/s?=
 =?us-ascii?Q?O1FUUQD3nUjAn8kyX500os9EC7M+OzEzNbo7PrPp6Z4rL5cExUbME2z5bk0q?=
 =?us-ascii?Q?bNfp+LXhmwuLMh5TSUDpYNra8WH8Fq45K2j6mJrs8Jg7/r4mWda+wbItELdv?=
 =?us-ascii?Q?uuiCh8rBjGnnuFym/ZyHtAe4x5oemTxfHpqFYVuWyLdKUsBFQawSXUjbb2mk?=
 =?us-ascii?Q?eF8wNbxIj95aHeo1TQWzG+omoo0tcoFZGUHvSVmuAPB3M3J7A/ghhtbUC71/?=
 =?us-ascii?Q?Cj7JXN2X5tCmxLzbjfmEw+TaXbrQdrbrkT86weS3OOG7t3Zh88pa31lNerfG?=
 =?us-ascii?Q?feyDzMWHYkFyH39nUzf7QWVEyJ9RUk8IFyW+Wd8ouAYizjImiITI0AOInOg1?=
 =?us-ascii?Q?7txJq0oyBZg4WpaVlxNSsQtSt2HvymgLiuHJoEZHC+YLC8ukudAWZ2QsKyB/?=
 =?us-ascii?Q?5iXWtLi7JIAKzKuqFdEja466DNg7pzIo0iyYlSvsyrAWUKtRXuhUdBCS2d7+?=
 =?us-ascii?Q?pAzGRPcAgviJjTYYliK6+po4BnvCv2RwVlUi940/rUuqT3c4aof7JBcVP80R?=
 =?us-ascii?Q?VqyseJHVBUgPJrbp8ftBvhfZhJffmgBsU+SHWOBmFSNqeRIP/DO1baKiinQj?=
 =?us-ascii?Q?JX6fSFWbDK/xu4jTudQkP2ZbQQLTicZ/PW1p2aRg/pJMqd/FhRzkO4BUaMld?=
 =?us-ascii?Q?DtyqOyFyevu2kGRGjiQiqdaEdTVcWZws0C7hlVE3aCafcVezn4x7c6zAJt67?=
 =?us-ascii?Q?rfOicQ4BG81ATmqNzUAlRNGf33FBL7ATo6RsppBweilybNHEj15hn1QALYsg?=
 =?us-ascii?Q?q9KdhP5v8hS/+HmyWypPV0SdK5qr3MDVoA9PhhTwvdoueJaWVSgwp+HdioYY?=
 =?us-ascii?Q?HOHfPN06sfgm0/YEpAykrO/PxAiY5pSJcNzJ6t9XIKDrOz7ecXyxmMGw9Qxk?=
 =?us-ascii?Q?Bc0pJA7WgjFbvgCel8TEst8MfWsKzDQ8TPGRFJl8akFowTRhflnk40Gt0/2z?=
 =?us-ascii?Q?d1wWzatD2mo2RiQu7AJpYVsNN2qZZingpwRyEl45d7XCi9Bz2989zkMGfGk6?=
 =?us-ascii?Q?csIS/zdcWX78bzeFVj73CbXR+vE+PCs/rYmuk3zL3YXgg55ZtjqPkWTIl/Fj?=
 =?us-ascii?Q?NRG62vCaLrG2PqUjv+lwUAIZiG4gH+jku2OcC5MUWFjf6uwyuX9Y5wx7amDj?=
 =?us-ascii?Q?r12Fmgrmryk+qHtQN0JizgsTe7BQwsTi+3Ril6Cu?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68435f1f-9ead-4bcd-5f84-08db839510a3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 11:34:05.6966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAOKfSDuSl9I9LuN/CK7tnUEo2/5DKTdhGD1+ybvQym0XbJrqGP+Mi6pcga0MabQKkjlcQRtQ8oJHcicG15uvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR05MB7452
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 76820d3e97eb..a098d7153498 100644
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
index 7c4a0b72334e..c6bb74cccea3 100644
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
index 79bdefe9261b..d9a0ec2b918e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1309,7 +1309,7 @@ struct trace_subsystem_dir {
 	struct list_head		list;
 	struct event_subsystem		*subsystem;
 	struct trace_array		*tr;
-	struct dentry			*entry;
+	struct eventfs_file             *ef;
 	int				ref_count;
 	int				nr_events;
 };
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 12ed71428939..4058178de682 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -990,7 +990,8 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
 		return;
 
 	if (!--dir->nr_events) {
-		tracefs_remove(dir->entry);
+		if (dir->ef)
+			eventfs_remove(dir->ef);
 		list_del(&dir->list);
 		__put_system_dir(dir);
 	}
@@ -1011,7 +1012,8 @@ static void remove_event_file_dir(struct trace_event_file *file)
 
 		tracefs_remove(dir);
 	}
-
+	if (file->ef)
+		eventfs_remove(file->ef);
 	list_del(&file->list);
 	remove_subsystem(file->system);
 	free_event_filter(file->filter);
@@ -2297,13 +2299,13 @@ create_new_subsystem(const char *name)
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
@@ -2311,7 +2313,7 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 		if (strcmp(system->name, name) == 0) {
 			dir->nr_events++;
 			file->system = dir;
-			return dir->entry;
+			return dir->ef;
 		}
 	}
 
@@ -2335,8 +2337,8 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	} else
 		__get_system(system);
 
-	dir->entry = tracefs_create_dir(name, parent);
-	if (!dir->entry) {
+	dir->ef = eventfs_add_subsystem_dir(name, parent);
+	if (IS_ERR(dir->ef)) {
 		pr_warn("Failed to create system directory %s\n", name);
 		__put_system(system);
 		goto out_free;
@@ -2351,22 +2353,22 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
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
@@ -2420,7 +2422,7 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 {
 	struct trace_event_call *call = file->event_call;
 	struct trace_array *tr = file->tr;
-	struct dentry *d_events;
+	struct eventfs_file *ef_subsystem = NULL;
 	const char *name;
 	int ret;
 
@@ -2432,24 +2434,24 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
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
+	file->ef = eventfs_add_dir(name, ef_subsystem);
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
@@ -2465,27 +2467,27 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
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
 
@@ -3638,21 +3640,22 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
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
+	d_events = eventfs_create_events_dir("events", parent);
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
@@ -3665,11 +3668,11 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
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
 
@@ -3757,7 +3760,7 @@ int event_trace_del_tracer(struct trace_array *tr)
 
 	down_write(&trace_event_sem);
 	__trace_remove_event_dirs(tr);
-	tracefs_remove(tr->event_dir);
+	eventfs_remove_events_dir(tr->event_dir);
 	up_write(&trace_event_sem);
 
 	tr->event_dir = NULL;
-- 
2.39.0


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8BB767476
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 20:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbjG1SVu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 14:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbjG1SVq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 14:21:46 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012003.outbound.protection.outlook.com [40.93.200.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCC54491;
        Fri, 28 Jul 2023 11:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJKFMh/azdeoUlNJ2+NSFC9yYYuH9E8TgdRWhHudTSgUQhZ03E8Xu3A8v/Hd/8UtJ5Hw4mxp9cuD79u1QfZE9XotsK8SuZoAN87+ORzhpFgNtagUkWN50t6ONhRAecjqNXJzRIQ9n1egjvZPm9W22YZ/eFhbs6DvYQ+vcNZ9kyj2xr4qD64tlje0y7AfmF6YEPZS06NGcv6aTknnk0uAFpOCi6ON6qLQPElR6L2q7FYdEjPGEuPDskpXHHbws8Jrmv8uA0Mpb1K7Z6B3BSMmR/8Whk3WIfX0m/tPFuGCeXT+ZkRpWTmbSNXwJ4jkaPG6frK1NpcstAb3JVEJj4+saA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3F1k+N2gh2hEJw/eY1SUF6bR19C9iVwStsiERKKGwM4=;
 b=WkITUuEYpAI4LLDtivCf7R+kjhAMCkPONhr2aA/FI6EZxM03uPAREbs7exEG2+NTNhPhgf1IovF7eIWrEUXRqn//Vo0w6WbosGjdisbePq84hOFJyh7aQb8SfDXvBnVsJoqSlZYmEYVncTr1fyWO2iJY5EcanHVWvC1Nkk/Wzdmsz5/nBdlTpSrH2sfa6UgydomABPQIv/tGCA5tyrIu2nsar8cemTAEcg5jMrOXf4/oBP4WcfnEMw7WwB4VKSHqYoTn7M2IrypaePmF3kl/tDpwk0O/F0jVkQOPTzGGoB5F0L2rLFonJQsq/aP5BFpH+BE9S2LWTaiWBcaBy5lJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3F1k+N2gh2hEJw/eY1SUF6bR19C9iVwStsiERKKGwM4=;
 b=Uz2DbC2KRdqDTz8+CIayxdsV8ScDgkntkiiS8POQIcxSleMDpZy3Co8Vwm8rfmDLvzh6sO3S7GirDXoOA6lQBSVRVGjS0oIbG+MbYDU7EwFSQSr+vW9LpIMYtueh55P2Qq2Fn7r9yk/tPzhsMVXxDTezsLNmV2z1apipmvmddjg=
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
 18:21:26 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v6 09/10] eventfs: Move tracing/events to eventfs
Date:   Fri, 28 Jul 2023 23:50:51 +0530
Message-Id: <1690568452-46553-10-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8021568f-5e65-4a07-1ea0-08db8f9774a9
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yn4qhChBKeFr6a1iglvIq7DBfeeeOWblO1uMfF9jwh6BAxO+K4H9/EeRQO+bio4jcpvbVks7ONhWtlGYnAFB2MLUSMeseTf/PgyWtLXKrMznM11q/YKtlWuET/W8DulRN2yEV49vV4EATABWcljz2ohwE8VSrTX8+00+An9coIgDWPccf4VD5Wmwzme2fdZB8/dDZQgphNg3IAYFjw5aJ1VizhSaUm4WvhNY9sgMgVTgGKgw48b0TkIwkhgI6xLBQC1CIoucK1w8A1MUPm8gHIDxstXAndtvH8RyZMKYP6PVTlAVyFLhhOo3P/Te13q0tVrshW4I7QBO0EK5VieXI2O+5P99wx3ZhgRaYjlr223xRp0VbVtQ6+jQVm2BiWPbFEVceq/YxxzLoZNHw4uN3WGNh5erLX521LYoNVcx8f4Oeha5u+Guh4eV4JqgmcujWzAPA3l6gPQUuvjSwxpOW1dUui27IropsmDJVgDHsxruaXA00vNLzAqmRql51WLXsK8zLMEgONwYeU+fmfgMkFtnRNKKr924ImVi5+dy6KoT7LuxezFAUsbcV7DgfmnxDm69xHlIPIhSwpq4P4W8dm/k7Ob8noxU9iqX1iFogdDDn7yP/pArh7ivmsBR19uuB9CBL4QYXqznT/Cv2g0xpQ1Nrt3uxECg9g48+iWgZ6Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(83380400001)(66476007)(4326008)(316002)(6486002)(52116002)(6512007)(38350700002)(478600001)(38100700002)(66556008)(2616005)(8936002)(8676002)(66946007)(41300700001)(5660300002)(186003)(6506007)(107886003)(6666004)(26005)(86362001)(7416002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4QB6SANws7/cjBfeatxTDFuZu7LoNyUxidCTd2CV92NKxfiP21rQ+Cimp/Rk?=
 =?us-ascii?Q?k+agOHsb5z95kR7cxd9rps6TUDDWzxKpb3Q7j2U5+wsTu4uisWiy0M/BW9Iq?=
 =?us-ascii?Q?MoSBlWwr+IsX8KiD4DaQ4JqA9fSIQgIZcfdhGSmHvHkk2GbyJxaJcEG1EBRe?=
 =?us-ascii?Q?27UGQQ35hvbE1qKrL8yXO/4LQy0oQ1UR/yjTj1VHiHcNpatsuDVKkbGNLaWQ?=
 =?us-ascii?Q?EFGH1PacR0QJqx6d2zTxoENYD9vOomXk+yZzfNCtyG4NAcSktegKs+j6Elo/?=
 =?us-ascii?Q?+Itn0RkhIX6uc9PQ5oT1ZHqcBTfZqOq3Orv6Hu5DCmP6cta44Tnwzue7oPTc?=
 =?us-ascii?Q?UO5XwLtSBjOVe5d0fVrTJ1LzNGHba4yYDqYkGxk3RrF2tXc9e2s9g5Ds/mIz?=
 =?us-ascii?Q?FbMKtlyHmt55KfRiGogzXh698n4nZaPqMRouVImo6fQMapsU0G9dhsk1foM7?=
 =?us-ascii?Q?jYt/T0BPvJSDppIb8KzbLdJC4Bc/xukcmE+hay9KUeMPW6asBlR+6yTCTqoE?=
 =?us-ascii?Q?eUT2khNObsb3zBYfd3S683XPipzUPpS5NyeRYFAJtKFohLfuzvfKeaDt4USc?=
 =?us-ascii?Q?ORA9mEWggKcM/cNwjsUP3qQvHsdZ/3bVqgnSGkqpQhugV6whZZLPzKDoS5Q+?=
 =?us-ascii?Q?Hkch45mdMpYuD2RIlWy3elOSdjwVioPaTWgjJ8Df8t7eBa+SzAJrB8nI91t2?=
 =?us-ascii?Q?eFHZl+hqIbrFihVau0ta3Mwm8sH5Wzgxu5XYl5OlLWJwkqvqwv59KseDp6gw?=
 =?us-ascii?Q?H1W6+OWvqzIkc3VAlMGYMkI2VXwjadmnAdU+8a9nFTPDJEp9nCkiccYcBLfe?=
 =?us-ascii?Q?u8H6l90zq4Ts/xAJCVXwYkaIpoTKUzLhzaYDjukTm9KPecoH1syWSMpKoVxn?=
 =?us-ascii?Q?Si9BEI3wfNHk/qjFXqjYLGmkARvw8HPHr7oqXQmXc/D8eYFVOFpX2f4qs1ts?=
 =?us-ascii?Q?XQ2lBtpLABh5ErPTuJ5b1Sa48CuW6Hw52PY2cpKo686X4AL70otWWYnUdxWA?=
 =?us-ascii?Q?nu/XZm16fdg/PouAkYNi9rS+kS2rq921kz0dPGo6gX7prF9VqJA9L4d4H/Z6?=
 =?us-ascii?Q?6zIj8vEZtjU5EB3yxu0Ktpzaqs2VlQe8Xo3D6OdGvcfQfaF8wvcJA2JD/e+Q?=
 =?us-ascii?Q?xk+wSde9/CrAZ5SORW0NN4wFzNWLpOYXonSmK/1ML4MBCvVcqHcduJfn4JwV?=
 =?us-ascii?Q?zK/vxOzK39RBSq30MmcJGcx6ZU/e0nlr6HMF7Isd37XA7p25NYDp6d+iIilv?=
 =?us-ascii?Q?inENWakQ4uOyvsXJi1svzhUKYQxTy0d/3FTdmUElE8S8oKsge4Dzf0IY4xQ+?=
 =?us-ascii?Q?pLQtCqpDDmt/5rjSX2CD2MzppmfdsqDPxZpvtJjgNCU+f/Q6A+MZr7pQdYPg?=
 =?us-ascii?Q?mpQPVYuOp/yzFamL1Hv8tQbG2unI89APU2Hhta+tz/ZqyGFe+UEd+7Rjgpjs?=
 =?us-ascii?Q?0Aia0C6NE5W3bmxYVz1dZv0jVCdSZQQdi5g/+eNuSJ10rO/QtVwA0icJ8WoB?=
 =?us-ascii?Q?KOBH96vHd01L5gvozlWqap4XBPYUXeWrRwyx33tSuz73H2shX4cEouyiZI3a?=
 =?us-ascii?Q?Uudy5D1cWrCHIlLDXJkFqZ0w/+DB0Qi++BjMUn7P?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8021568f-5e65-4a07-1ea0-08db8f9774a9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:21:26.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzLbZZ9W7RWPVXUqu7JLmjPoAFRxfODDUXnWGtRjoqFoU+lwMEoPp4O5BpEFph1jcEcSDJNELAGUysjFL8NluQ==
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

Up until now, /sys/kernel/tracing/events was no different than any other
part of tracefs. The files and directories within the events directory was
created when the tracefs was mounted, and also created for the instances in
/sys/kernel/tracing/instances/<instance>/events. Most of these files and
directories will never be referenced. Since there are thousands of these
files and directories they spend their time wasting precious memory
resources.

Move the "events" directory to the new eventfs. The eventfs will take the
meta data of the events that they represent and store that. When the files
in the events directory are referenced, the dentry and inodes to represent
them are then created. When the files are no longer referenced, they are
freed. This saves the precious memory resources that were wasted on these
seldom referenced dentries and inodes.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/inode.c           | 18 ++++++++++
 include/linux/trace_events.h |  1 +
 kernel/trace/trace.h         |  2 +-
 kernel/trace/trace_events.c  | 65 ++++++++++++++++++------------------
 4 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index d9273066f25f..bb6de89eb446 100644
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
index 3930e676436c..c17623c78029 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -638,6 +638,7 @@ struct trace_event_file {
 	struct list_head		list;
 	struct trace_event_call		*event_call;
 	struct event_filter __rcu	*filter;
+	struct eventfs_file             *ef;
 	struct dentry			*dir;
 	struct trace_array		*tr;
 	struct trace_subsystem_dir	*system;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index e1edc2197fc8..956938357774 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1324,7 +1324,7 @@ struct trace_subsystem_dir {
 	struct list_head		list;
 	struct event_subsystem		*subsystem;
 	struct trace_array		*tr;
-	struct dentry			*entry;
+	struct eventfs_file             *ef;
 	int				ref_count;
 	int				nr_events;
 };
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a284171d5c74..85f9a99bb506 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -990,7 +990,7 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
 		return;
 
 	if (!--dir->nr_events) {
-		tracefs_remove(dir->entry);
+		eventfs_remove(dir->ef);
 		list_del(&dir->list);
 		__put_system_dir(dir);
 	}
@@ -1011,7 +1011,7 @@ static void remove_event_file_dir(struct trace_event_file *file)
 
 		tracefs_remove(dir);
 	}
-
+	eventfs_remove(file->ef);
 	list_del(&file->list);
 	remove_subsystem(file->system);
 	free_event_filter(file->filter);
@@ -2297,13 +2297,13 @@ create_new_subsystem(const char *name)
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
@@ -2311,7 +2311,7 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 		if (strcmp(system->name, name) == 0) {
 			dir->nr_events++;
 			file->system = dir;
-			return dir->entry;
+			return dir->ef;
 		}
 	}
 
@@ -2335,8 +2335,8 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	} else
 		__get_system(system);
 
-	dir->entry = tracefs_create_dir(name, parent);
-	if (!dir->entry) {
+	dir->ef = eventfs_add_subsystem_dir(name, parent);
+	if (IS_ERR(dir->ef)) {
 		pr_warn("Failed to create system directory %s\n", name);
 		__put_system(system);
 		goto out_free;
@@ -2351,22 +2351,22 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
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
@@ -2419,8 +2419,8 @@ static int
 event_create_dir(struct dentry *parent, struct trace_event_file *file)
 {
 	struct trace_event_call *call = file->event_call;
+	struct eventfs_file *ef_subsystem = NULL;
 	struct trace_array *tr = file->tr;
-	struct dentry *d_events;
 	const char *name;
 	int ret;
 
@@ -2432,24 +2432,24 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
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
@@ -2465,27 +2465,27 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
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
 
@@ -3638,21 +3638,22 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
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
+	error = eventfs_add_events_file("enable", TRACE_MODE_WRITE, d_events,
 				  tr, &ftrace_tr_enable_fops);
-	if (!entry)
+	if (error)
 		return -ENOMEM;
 
 	/* There are not as crucial, just warn if they are not created */
@@ -3665,11 +3666,11 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 			  &ftrace_set_event_notrace_pid_fops);
 
 	/* ring buffer internal formats */
-	trace_create_file("header_page", TRACE_MODE_READ, d_events,
+	eventfs_add_events_file("header_page", TRACE_MODE_READ, d_events,
 				  ring_buffer_print_page_header,
 				  &ftrace_show_header_fops);
 
-	trace_create_file("header_event", TRACE_MODE_READ, d_events,
+	eventfs_add_events_file("header_event", TRACE_MODE_READ, d_events,
 				  ring_buffer_print_entry_header,
 				  &ftrace_show_header_fops);
 
@@ -3757,7 +3758,7 @@ int event_trace_del_tracer(struct trace_array *tr)
 
 	down_write(&trace_event_sem);
 	__trace_remove_event_dirs(tr);
-	tracefs_remove(tr->event_dir);
+	eventfs_remove_events_dir(tr->event_dir);
 	up_write(&trace_event_sem);
 
 	tr->event_dir = NULL;
-- 
2.39.0


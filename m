Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A0975DE57
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 21:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjGVTix (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 15:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjGVTi0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 15:38:26 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011013.outbound.protection.outlook.com [40.93.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225EEE79;
        Sat, 22 Jul 2023 12:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oX1JeRb7augG5XO7TjKZIIBeTNoS9ttvBSS0kFWuT7AFiRxaIQv0E2XE9C/IhtxRcbL4RlXKiC+N6cLwazsM6EB/hqNNsE0bCnGhhhMMxmz1nsr0t+hkrOWIpR4HxEnV0Pz2LQQkXfEJq5sBIaSNT722F3vlOxNf//knQXVOQhYBedMmk/xzqWSbR735rif3d/Daj3QiFf6PCR5F3+8HujvUzZgZvIXgu5PLkl94Sar+vYOvLyAGUKOzxKL/6iF8ec1p+0F7649E0xebHh1NN4K5MjebNGfS0UY7RcKxvCL26bO8C+ezAdV81wND4ZB0V9cw0I5nmIUDOwqz1ceVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3F1k+N2gh2hEJw/eY1SUF6bR19C9iVwStsiERKKGwM4=;
 b=AmMBWqwKRkZVKdiDLSMq9tSTPL+T0FX/AOyMdqNLoiyPFJESHE82trmbjHnTkH53N84P3WwBt5R0QZ08nac2U2rYF6zMTfPxKtljliSWAL7Xr6SPaBa+Y6iGA63DhAikrhia05SuYm8fN+CigRANrJ5sokCZGILh47BQ8q7oI57ZG3u1aB8PdlfML+vq80fP6dGi++TAKdd0Vfd+qk7rG9pqxeCfBkxo9Rvy3i1WHnXc9BmYcv+NsouH2LnIa/FOnm7s9jRCjittaHdcA5TErQz3xjG+NkQK06k6PJgs8Fyt8x5wPKhziRBNVL89p7bQYhj48Dsex9kLA/LdMgurTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3F1k+N2gh2hEJw/eY1SUF6bR19C9iVwStsiERKKGwM4=;
 b=o3ylPn8LHPp46x8Ze7OdW5iRlLIZmY/DO8F44nrEhgwbfBbI1BkT5Wam93vTcVivffRllobcJNbMkk655QnY8chj+8WBHGixoz4hQ/B3GQKtxUUYoHOzTnc0r2iWhtmMyk5lnMnqKoJjmBW8zSQEO9WOEdJaB/8VAhYaydqQFS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MN0PR05MB9005.namprd05.prod.outlook.com (2603:10b6:208:3cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sat, 22 Jul
 2023 19:38:16 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 19:38:16 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v5 09/10] eventfs: Move tracing/events to eventfs
Date:   Sun, 23 Jul 2023 01:07:04 +0530
Message-Id: <1690054625-31939-10-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2d83a1d3-f8ab-4c54-9ff2-08db8aeb31c8
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oy8xO1cDDqdaQVys6cLYu5YszdtvT9Ef94oJ586NIokvD/lyuYbOEuj7teeXBLts85lFcd/F1tl22sjrl+T/ZTM4AoHvT1IQLv965W4MWYlVtRV/CDFypL03KT4x3P5T8KwJuU69tQcXW7+AtaT/7UvmrT9PTwOe7nrwkZNWE/RsIFvTdym3p915zQjTkNhgMo6yaNDWIbJZD8QD9sZlS9N0PgGr+kRwlQZOoEZoR3nArprlXOlwKlH7vv6kMTOlxm4t+Zsdm2vDidaSocR0+CXUgRjEZyeK45Se8ey2WI05XsJvV82b7mjdymT/pR3ClqcHOv7OgcAbQ4+WiHQpUOZPff8VKCLx4Yp+8ApkxFQw1QvAyj4AGbON9wcPOvl8XCdz2EwADbJVRSSXwq4KBxLTxsWnGY8BQegzyZH9OQ3wbPi2USeao/ShIrn16BzuSnjYLfbWvhCv34NVUu5Z6m/fqnaoc22kmDdcniQ18ARcurk9JHu20+elLXaSoTiFxqPQF+t1hFo6F1CNfssrWP9dAuzJlnaYJBmR7y8Kth5k7DqWSQ22boz/ES+lew7CfJ3pPf0TRZzm3rUgVt5Z+Gz64RySPTGTik8od/vDv1bNmdrJovr4iUGJTdGUJhWUPhhrqBhHKaNwx2BP/Yh3DWjqxbpQfbtEpk3xsYA7t+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(6666004)(52116002)(6486002)(6512007)(478600001)(186003)(2616005)(6506007)(26005)(107886003)(2906002)(316002)(41300700001)(66946007)(66556008)(66476007)(4326008)(5660300002)(7416002)(8676002)(8936002)(38350700002)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e4JrxSVaER4Vba8zeyg4mz0PV0TDjYNwfIrVdOxxadL0KpuAaG2VwceHuESZ?=
 =?us-ascii?Q?KIKpV87fdy2QfL/orIRiVh1XP6FIFTJLyL1eCZft/vUl20N+DIzvGM7rVpot?=
 =?us-ascii?Q?qVB7rXkMtzNTK1+by0eAFopWQjmpFiGn2tzt9/nDtrbu6DE1jHI6eDoyWMyj?=
 =?us-ascii?Q?iI68tmfaTcUMKBK8JCWYcuEYKSNgStPBVKg+TgLfuad1Gndd2WvKU1OB7viA?=
 =?us-ascii?Q?ygRNxuwLafiKkN6M/6e5wlaE0qYpv+LPnvffSxjESMZglMzYnqb7Gr/UScXo?=
 =?us-ascii?Q?TmJz/UmpuS6+ju/BdJjzm/V6yqx49n29nPaRJQZTiHVbsxvYLaaNT9hk9dXS?=
 =?us-ascii?Q?Hxwfmbz4PSVSq4oc7mpjQ8SoTFaJZRWJMCt+NGs6MQeKLnazCIA4wiQ2Gyf4?=
 =?us-ascii?Q?/aXmHhmFDh2HcH5sjaxh++Ab1JChZuv7YMOiPztIT8UpDByxLRMT2P9aOCtY?=
 =?us-ascii?Q?5fzLUqxndE9oGPrr2tUz4WdimVocZrRPjA3wJfucv/ckUl5ECg8p8whDvAvk?=
 =?us-ascii?Q?XprQzVXtAJ9ptvRd17MK24vJTTNj2lcwAge9IItjXDshghgLJy4yjCwk9K5e?=
 =?us-ascii?Q?AYdiX00AbKaLcpgWx/3BkrMvhErOSplAF590oZA81KJ0GLgiF50E9rtjt5lv?=
 =?us-ascii?Q?4LwPFencRu2QTkfJaeymo83VesPcnzyWCja0h8g3IWDDDXnH3htgTFqVIvsW?=
 =?us-ascii?Q?dMJTNEQZD08c3/7geofuXav9dOOcVwTcEAu026bnLvyGo2HCo4KfiQuZEEvs?=
 =?us-ascii?Q?zwXQZotE2KDyivHF7FN77EIlV+0oemcv+hb34Eyi8ASIjlPttjZIOVrzcRy8?=
 =?us-ascii?Q?OPdtoZk6Td7hQ7+k7WDUN3YQQTyGXvPJ9vWP8snj90SBD8AFCvPozWftD0/s?=
 =?us-ascii?Q?fnmuZgzLsoNQQuFN3ys7Qj3ORwfcRiX/4fYhRL/0/a0IRj5AIE0zJIcsXAU/?=
 =?us-ascii?Q?HBEyg+olbc/rm55bTOUxBpopXIYUAb7OtRCaJxoQ//4rdJQKPs8+qoCm6t1z?=
 =?us-ascii?Q?mFE/TRDztqsFvcRx7PXaXsDjucodr1OfgW+4CNLMogLKA54hRPcGXNbD3t4b?=
 =?us-ascii?Q?m323c7uap6AIE6rLcKsk3Hqb1PLeYAMayHMeLM1/2Sgm1UeOn31eKy3dOtwj?=
 =?us-ascii?Q?H7XD92+hHFaxRVBiXub3/NDR20VHsIWAwS1yYaRZjgQkNPmwyQydqJ1HX1Fl?=
 =?us-ascii?Q?5eB8KZn5rtlAYX9ibXLbinq9OgGSzE+Bv/SfO0O+54gIcizbjWr+GHg2QcUb?=
 =?us-ascii?Q?VHR1IyWwCA7L/qD/8A9gnvWHa6QYzPMR9HwAmieYJG+BoxQkzsP53Hoa4iTc?=
 =?us-ascii?Q?T0O8CuVmRJ+oQWd/b23R3Yl1GF6d66TkG4kgo+6APyEjX2n4GJIZM5LLtgT4?=
 =?us-ascii?Q?ByE7jSp2ofay0KWy2K62rrcqdZ3ff0sgxISQJjjCAv34/mpGg6WzWvXgnDXf?=
 =?us-ascii?Q?d29Jbuyh9ddOTkUZi8c5wJo25iV6Stl97D5GGoH9/efIeLgzOcHaBrjVoVJM?=
 =?us-ascii?Q?sMgR1+TvUAU1udOoLMxgKZ7kmOiTKTXxk41O5WEXRWzJPVYYzINssXQa1BwM?=
 =?us-ascii?Q?5hg8AdHDDVEeLR7WHGoCSHQRa8qk0ZGQRmaUuSsZ?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d83a1d3-f8ab-4c54-9ff2-08db8aeb31c8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 19:38:16.2250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMsIIXpGL2d2u+2juIRpC7QpiQc297vSwNlSjsQdRBYhB5gnGedObIIyL0ewQt4gBypTTDX9c5cMbjxU4MvSYQ==
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


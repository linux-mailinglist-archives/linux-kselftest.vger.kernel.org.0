Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C67719637
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 11:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjFAJBX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 05:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbjFAJBW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 05:01:22 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013010.outbound.protection.outlook.com [52.101.64.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C0313E;
        Thu,  1 Jun 2023 02:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiOy7XiUkYNMYv8q9t2390swVr/GPFtsJe9tDbjyA1nrJp3xC8znb48hKRfJgGYU0SfhZDmIRCABNU4BCrOnSdFy20v+HvhvG/2zZdF6SXGeq9Z/jW/qVQg89BW5LgKOjFdQ+fh4nZ+PTZcZjTi+9/Be5qa+7Jq4NlpfL1yKhEVaJ+a6dcG7iC2qOC4JD0/TntgnhytjjaGYEyM6HBmxLYAnS5F4+FXbAPvA+tU7TXVGp6b9jxrPVww/LyCahog3YSMGjyo9Z48N/y4br4a6vCS7BylUlrbQ+joe8ew8w65sJ+SYnQHFVwl7rXpGyZgbMNEpQ9WXGYwULZHKiPRSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJd11CAc5dheYgkR3ktRnnrrHtK+8Ah9gcB1WzL+714=;
 b=l5MpVT/H7jDDg1ES9lpAAlirQf4st/H5iQeFggbAMkzjoYKeK2zrEg2JYMR+Fx7wWqVRNCiNvUBSdZ/SVortQ+dFbLCBcnayx0STy1EoZt9CTQyQPCCX/pYej07MRU1HXJxruvXzC2o/owk53iEkaZMq8kqU2/WGRWt8TZRFFwTWVUIgxnQwGIHDoxWXQTlxTksz8AKQ94jJ38z/NjVO5Kcefo8/ZGXRcoMRtthPXXCioKuUCoPz9fBrDKDRvhfQwQA1bDGpqP5c/e0GMJTQQoDBnHlczN32YkEj60pSqK/VSsioYfkDfcIkHFLvgHK4bpqEc+R3DE1LhU2qgYyw7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJd11CAc5dheYgkR3ktRnnrrHtK+8Ah9gcB1WzL+714=;
 b=ZAkQVMIXV92l2zwqOdlSLyC2mMd5yYRz7vizvpBEE/N3qsflg+Kc0oZrWk/mB1fJAgWzuhuvFg5lv8Ug6ViqDSeDgxIRNIm0oWxu3BoFANnJMZ7DN3be7lFJHnNbTfAabY3upbtRBVm1fq8RkGTlaQ71eDJM7jCGINre0KMmyvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB8617.namprd05.prod.outlook.com (2603:10b6:303:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 09:01:07 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 09:01:07 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v3 03/10] eventfs: adding eventfs dir add functions
Date:   Thu,  1 Jun 2023 14:30:06 +0530
Message-Id: <1685610013-33478-4-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11bc62d2-f35f-4ce4-e418-08db627ebcac
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CB78mF8vG5vRqOm7CXzp5XO6ccKb5yXKCSv8vMyKr2ip+lL8qp1bh0XMO4ExhQ9Z46kfkWooePX0XB5xAoF6bgLqPN1ivdCuLzLPdegOqVhxEIENPcUjpuF8wShVds2KpbKnCQmqOdc+sExM/bn3A2aKn0KYYo8LnT8HRmJ40cliTNtN8FOTWpdMtbETt87sYla/bhbvXWsALdXhEFMY0Rawc5bHxsUqjoB+HVg6nHm3VRhLjI/OXz9O0aqSKT1+48rb7IoOQO8aZekTmo/wRknlezTsPsylTYzbGocvtycbPo90uZfaFv0+FAVON+aheSE1MnlDF70qWOX15XTo7AURzCq7QkwdQSDhqLvgJaRpGu1aof4TL2g1iwz6aDEP0IF3jhMHjYnMM+W2HZ7ifZxbQy8ERzvwFqm8fyzUpVj/8fNqdu0FWJJsi3flAPUH+6MQeJfRTJ7IHlzHTLiNaShw+GqzGrs6gF8MPj6hjYHKoVTA2HoRB/dt9PbY46PfYP2fXglKdhM805KemKRq+xa1ZYNZnfojzNHRVxCyiWzrEiM84ruG+Vxx7Wpye0XBCGk3zVlANxAbcsYLko/txcJkwgzG9+zu44M2qdhuV3DFmjHvlPhYP71+GEf/82eLCP6ubFAjEvFoCF8QcB5cIGutEVHPyKYkvOQey8CHac=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(52116002)(6486002)(186003)(5660300002)(41300700001)(107886003)(36756003)(8676002)(38100700002)(8936002)(26005)(6506007)(38350700002)(966005)(83380400001)(4326008)(66946007)(30864003)(2906002)(66556008)(478600001)(66476007)(2616005)(6512007)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cR1D4IIeVKLPAgK+FVZtBvkWLKc1pVh+DK2icgJ77m7OhYXy2VdvqoBMGVpr?=
 =?us-ascii?Q?jSl9NaMnjvZTNjoVFgUlciGtS0VekbyviwBZ+H0C+DWPKfI4yqWSYSitVCv9?=
 =?us-ascii?Q?+UOvZnosB74NFVVn5HMsgIPY8E5AuX2UaVQ3focLAo66nmsRvX8uWscJvd/x?=
 =?us-ascii?Q?bvsRG4cwGmX/1SFZ7Fa2JkUWsyJF7Cy6PnWjJRBLQCkhq9zbVYLbFSEXOB4N?=
 =?us-ascii?Q?kSPzWcUN/s2Db+FEwEww84XoQptEX7g7yVaAKARRjgNj58gyWoNbjTuRu8CY?=
 =?us-ascii?Q?pC0vWUEtUcJ39PmKeEOQ74Z8DgB3wPJY1FpXroamn1k5YWXwg5rgujo663dS?=
 =?us-ascii?Q?27/nJe1Q5XNlh/bwJVc8jGcXonvCI/JecjkpBPAlZ6SvXj1vwBQk94ReFgfy?=
 =?us-ascii?Q?Jbnkh5sDj5BPCXEQCNW24DUqSqHeAlU9SfCML5i7bJdiMQI6yJBhofx8FN8m?=
 =?us-ascii?Q?Y86lGgKlLjwCsN4/xSuR0gThWebobV0ozvcDnUGhseJKVEFkl5M6cIRcH06/?=
 =?us-ascii?Q?yj/BR2ERarYAntTCWPPtfFJpDCCGWu2PvqRSm8E5oHPWkb2jBsGNOtkUNTqW?=
 =?us-ascii?Q?3l9k8zOJiSzCCt5TTsU5DAsTw4nudEZOTOgrkECO5bl2xvnjiKp0ZzvfOuIF?=
 =?us-ascii?Q?na2Bp/pR/qTOcrrqEO5se98Qp1c4Hfxuo3ZM3ZtqGjtC7N5/FzTrxOT7+b/f?=
 =?us-ascii?Q?oHG45hgOxVQbLq750Lwv1OC28w2YVp13wEwbc9dBMttvCAiXIlhzgEOtR5F9?=
 =?us-ascii?Q?Mhm2+AYovyDwiN5E+ry6+Qi6evP6bzamZxn7TIrzKPQ8pE68ekKitr0iJj7w?=
 =?us-ascii?Q?aLDjkSnOxhfRKxAHETtqnb/FWUBxcbMCKdb0ITCc5Ab5V3DjS0nKLX/wRGBU?=
 =?us-ascii?Q?6OsO2HmJF1Dir7tLLbRuYUQLk223KNRAWQDSk1KNryuMSQaN/FG9H5Bqk2vd?=
 =?us-ascii?Q?S9yD8C3UeJMbe7OvljB1L511oaVcd48ANppI29EvkBx6D13zKcGFEdMVjfpj?=
 =?us-ascii?Q?dt2XsCaPD16bSvDxNCrk385gW2wrjZs5blQ3weNA6BUJRqlRuI7ReRpglT0v?=
 =?us-ascii?Q?uBfIu4gwald6sLY9nihWNvl/HbqJTekkV7DJG9VOMFn7zOrqaenpVbRiD/Qu?=
 =?us-ascii?Q?Ep1mIDXCZOPH/Gb9BCRH4nNKhpho7wdDeedNaOy7rEXMHTaiy9fDUi7EH8EN?=
 =?us-ascii?Q?rIoWQAdZUbHcobHCa0HJ1qstv6EdpOBtJREEhlvu+88ptesFD+AbZsAug2il?=
 =?us-ascii?Q?R/Df66Y+T2/tfOYNJu5fSOYf9M1iJkB8Ii2HqG4d9UAicuV/RBwiGdtEdvGu?=
 =?us-ascii?Q?8iaIgEN3DiPLl60NS9NjFt4Wip+XpJCe6NBD0QQgW76ZdSw9/x4TuzQlclxs?=
 =?us-ascii?Q?uK5GNs1Xo5WbpKgCp5ESylbWNWLID0WPx1/waNyvz3e1irCD1T+0LwzyN/Wl?=
 =?us-ascii?Q?kY0xIh29AN/WDJzhmpCoIt0K/oVVeIdofOcYiUxScJP8TrflYmBzpub2eOUN?=
 =?us-ascii?Q?hHCCYtpq3XM/18vHNm6UOw/HdSIlzqGqKcPCN+Ccupv5bapTOWSX9jiTpkWP?=
 =?us-ascii?Q?l74Vk9qot4BNafmVEzzXpmHiK8q2cm52flRzvIl3?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bc62d2-f35f-4ce4-e418-08db627ebcac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 09:01:07.6305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBMT6FQM2bYaxPWkQdFxQyqX1MvBLNOq6fq6vazEp4R7uOBedSI2Dm6ittMoV8KbP5j6QzFn5Apj8yWwTTu7ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8617
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adding eventfs_file structure which will hold properties of file or dir.

Adding following functions to add dir in eventfs:

eventfs_create_events_dir() directly creates events dir with-in
tracing folder.

eventfs_add_subsystem_dir() adds the information of subsystem_dir to
eventfs and dynamically creates subsystem_dir as and when requires.

eventfs_add_dir() adds the information of dir (which is with-in
subsystem_dir) to eventfs and dynamically creates these dir as
and when requires.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-lkp/202305051619.9a469a9a-yujie.liu@intel.com
---
 fs/tracefs/Makefile      |   1 +
 fs/tracefs/event_inode.c | 272 +++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |  29 +++++
 kernel/trace/trace.h     |   1 +
 4 files changed, 303 insertions(+)
 create mode 100644 fs/tracefs/event_inode.c

diff --git a/fs/tracefs/Makefile b/fs/tracefs/Makefile
index 7c35a282b..73c56da8e 100644
--- a/fs/tracefs/Makefile
+++ b/fs/tracefs/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 tracefs-objs	:= inode.o
+tracefs-objs	+= event_inode.o
 
 obj-$(CONFIG_TRACING)	+= tracefs.o
 
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
new file mode 100644
index 000000000..a48ce23c0
--- /dev/null
+++ b/fs/tracefs/event_inode.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  event_inode.c - part of tracefs, a pseudo file system for activating tracing
+ *
+ *  Copyright (C) 2020-22 VMware Inc, author: Steven Rostedt (VMware) <rostedt@goodmis.org>
+ *  Copyright (C) 2020-22 VMware Inc, author: Ajay Kaher <akaher@vmware.com>
+ *
+ *  eventfs is used to show trace events with one set of dentries
+ *
+ *  eventfs stores meta-data of files/dirs and skip to create object of
+ *  inodes/dentries. As and when requires, eventfs will create the
+ *  inodes/dentries for only required files/directories. Also eventfs
+ *  would delete the inodes/dentries once no more requires but preserve
+ *  the meta data.
+ */
+#include <linux/fsnotify.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/security.h>
+#include <linux/tracefs.h>
+#include <linux/kref.h>
+#include <linux/delay.h>
+#include "internal.h"
+
+/**
+ * eventfs_dentry_to_rwsem - Return corresponding eventfs_rwsem
+ * @dentry: a pointer to dentry
+ *
+ * helper function to return crossponding eventfs_rwsem for given dentry
+ */
+static struct rw_semaphore *eventfs_dentry_to_rwsem(struct dentry *dentry)
+{
+	if (S_ISDIR(dentry->d_inode->i_mode))
+		return (struct rw_semaphore *)dentry->d_inode->i_private;
+	else
+		return (struct rw_semaphore *)dentry->d_parent->d_inode->i_private;
+}
+
+/**
+ * eventfs_down_read - acquire read lock function
+ * @eventfs_rwsem: a pointer to rw_semaphore
+ *
+ * helper function to perform read lock. Nested locking requires because
+ * lookup(), release() requires read lock, these could be called directly
+ * or from open(), remove() which already hold the read/write lock.
+ */
+static void eventfs_down_read(struct rw_semaphore *eventfs_rwsem)
+{
+	down_read_nested(eventfs_rwsem, SINGLE_DEPTH_NESTING);
+}
+
+/**
+ * eventfs_up_read - release read lock function
+ * @eventfs_rwsem: a pointer to rw_semaphore
+ *
+ * helper function to release eventfs_rwsem lock if locked
+ */
+static void eventfs_up_read(struct rw_semaphore *eventfs_rwsem)
+{
+	up_read(eventfs_rwsem);
+}
+
+/**
+ * eventfs_down_write - acquire write lock function
+ * @eventfs_rwsem: a pointer to rw_semaphore
+ *
+ * helper function to perform write lock on eventfs_rwsem
+ */
+static void eventfs_down_write(struct rw_semaphore *eventfs_rwsem)
+{
+	while (!down_write_trylock(eventfs_rwsem))
+		msleep(10);
+}
+
+/**
+ * eventfs_up_write - release write lock function
+ * @eventfs_rwsem: a pointer to rw_semaphore
+ *
+ * helper function to perform write lock on eventfs_rwsem
+ */
+static void eventfs_up_write(struct rw_semaphore *eventfs_rwsem)
+{
+	up_write(eventfs_rwsem);
+}
+
+static const struct file_operations eventfs_file_operations = {
+};
+
+static const struct inode_operations eventfs_root_dir_inode_operations = {
+};
+
+/**
+ * eventfs_prepare_ef - helper function to prepare eventfs_file
+ * @name: a pointer to a string containing the name of the file/directory
+ *        to create.
+ * @mode: the permission that the file should have.
+ * @fop: a pointer to a struct file_operations that should be used for
+ *        this file/directory.
+ * @iop: a pointer to a struct inode_operations that should be used for
+ *        this file/directory.
+ * @data: a pointer to something that the caller will want to get to later
+ *        on.  The inode.i_private pointer will point to this value on
+ *        the open() call.
+ *
+ * This function allocate the fill eventfs_file structure.
+ */
+static struct eventfs_file *eventfs_prepare_ef(const char *name, umode_t mode,
+					const struct file_operations *fop,
+					const struct inode_operations *iop,
+					void *data)
+{
+	struct eventfs_file *ef;
+
+	ef = kzalloc(sizeof(*ef), GFP_KERNEL);
+	if (!ef)
+		return ERR_PTR(-ENOMEM);
+
+	ef->name = kstrdup(name, GFP_KERNEL);
+	if (!ef->name) {
+		kfree(ef);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	if (S_ISDIR(mode)) {
+		ef->ei = kzalloc(sizeof(*ef->ei), GFP_KERNEL);
+		if (!ef->ei) {
+			kfree(ef->name);
+			kfree(ef);
+			return ERR_PTR(-ENOMEM);
+		}
+		INIT_LIST_HEAD(&ef->ei->e_top_files);
+	} else {
+		ef->ei = NULL;
+	}
+
+	ef->iop = iop;
+	ef->fop = fop;
+	ef->mode = mode;
+	ef->data = data;
+	ef->dentry = NULL;
+	ef->d_parent = NULL;
+	ef->created = false;
+	return ef;
+}
+
+/**
+ * eventfs_create_events_dir - create the trace event structure
+ * @name: a pointer to a string containing the name of the directory to
+ *        create.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is NULL, then the
+ *          directory will be created in the root of the tracefs filesystem.
+ * @eventfs_rwsem: a pointer to rw_semaphore
+ *
+ * This function creates the top of the trace event directory.
+ */
+struct dentry *eventfs_create_events_dir(const char *name,
+					 struct dentry *parent,
+					 struct rw_semaphore *eventfs_rwsem)
+{
+	struct dentry *dentry = tracefs_start_creating(name, parent);
+	struct eventfs_inode *ei;
+	struct tracefs_inode *ti;
+	struct inode *inode;
+
+	if (IS_ERR(dentry))
+		return dentry;
+
+	ei = kzalloc(sizeof(*ei), GFP_KERNEL);
+	if (!ei)
+		return ERR_PTR(-ENOMEM);
+	inode = tracefs_get_inode(dentry->d_sb);
+	if (unlikely(!inode)) {
+		kfree(ei);
+		tracefs_failed_creating(dentry);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	init_rwsem(eventfs_rwsem);
+	INIT_LIST_HEAD(&ei->e_top_files);
+
+	ti = get_tracefs(inode);
+	ti->flags |= TRACEFS_EVENT_INODE;
+	ti->private = ei;
+
+	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	inode->i_op = &eventfs_root_dir_inode_operations;
+	inode->i_fop = &eventfs_file_operations;
+	inode->i_private = eventfs_rwsem;
+
+	/* directory inodes start off with i_nlink == 2 (for "." entry) */
+	inc_nlink(inode);
+	d_instantiate(dentry, inode);
+	inc_nlink(dentry->d_parent->d_inode);
+	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
+	return tracefs_end_creating(dentry);
+}
+
+/**
+ * eventfs_add_subsystem_dir - add eventfs subsystem_dir to list to create later
+ * @name: a pointer to a string containing the name of the file to create.
+ * @parent: a pointer to the parent dentry for this dir.
+ * @eventfs_rwsem: a pointer to rw_semaphore
+ *
+ * This function adds eventfs subsystem dir to list.
+ * And all these dirs are created on the fly when they are looked up,
+ * and the dentry and inodes will be removed when they are done.
+ */
+struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
+					       struct dentry *parent,
+					       struct rw_semaphore *eventfs_rwsem)
+{
+	struct tracefs_inode *ti_parent;
+	struct eventfs_inode *ei_parent;
+	struct eventfs_file *ef;
+
+	if (!parent)
+		return ERR_PTR(-EINVAL);
+
+	ti_parent = get_tracefs(parent->d_inode);
+	ei_parent = ti_parent->private;
+
+	ef = eventfs_prepare_ef(name,
+		S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
+		&eventfs_file_operations,
+		&eventfs_root_dir_inode_operations,
+		(void *) eventfs_rwsem);
+
+	if (IS_ERR(ef))
+		return ef;
+
+	eventfs_down_write(eventfs_rwsem);
+	list_add_tail(&ef->list, &ei_parent->e_top_files);
+	ef->d_parent = parent;
+	eventfs_up_write(eventfs_rwsem);
+	return ef;
+}
+
+/**
+ * eventfs_add_dir - add eventfs dir to list to create later
+ * @name: a pointer to a string containing the name of the file to create.
+ * @ef_parent: a pointer to the parent eventfs_file for this dir.
+ * @eventfs_rwsem: a pointer to rw_semaphore
+ *
+ * This function adds eventfs dir to list.
+ * And all these dirs are created on the fly when they are looked up,
+ * and the dentry and inodes will be removed when they are done.
+ */
+struct eventfs_file *eventfs_add_dir(const char *name,
+				     struct eventfs_file *ef_parent,
+				     struct rw_semaphore *eventfs_rwsem)
+{
+	struct eventfs_file *ef;
+
+	if (!ef_parent)
+		return ERR_PTR(-EINVAL);
+
+	ef = eventfs_prepare_ef(name,
+		S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
+		&eventfs_file_operations,
+		&eventfs_root_dir_inode_operations,
+		(void *) eventfs_rwsem);
+
+	if (IS_ERR(ef))
+		return ef;
+
+	eventfs_down_write(eventfs_rwsem);
+	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
+	ef->d_parent = ef_parent->dentry;
+	eventfs_up_write(eventfs_rwsem);
+	return ef;
+}
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 999124459..aeca6761f 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -21,6 +21,35 @@ struct file_operations;
 
 #ifdef CONFIG_TRACING
 
+struct eventfs_inode {
+	struct list_head		e_top_files;
+};
+
+struct eventfs_file {
+	const char                      *name;
+	struct dentry                   *d_parent;
+	struct dentry                   *dentry;
+	struct list_head                list;
+	struct eventfs_inode            *ei;
+	const struct file_operations    *fop;
+	const struct inode_operations   *iop;
+	void                            *data;
+	umode_t                         mode;
+	bool                            created;
+};
+
+struct dentry *eventfs_create_events_dir(const char *name,
+					 struct dentry *parent,
+					 struct rw_semaphore *eventfs_rwsem);
+
+struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
+					       struct dentry *parent,
+					       struct rw_semaphore *eventfs_rwsem);
+
+struct eventfs_file *eventfs_add_dir(const char *name,
+				     struct eventfs_file *ef_parent,
+				     struct rw_semaphore *eventfs_rwsem);
+
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 79bdefe92..b895c3346 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -359,6 +359,7 @@ struct trace_array {
 	struct dentry		*options;
 	struct dentry		*percpu_dir;
 	struct dentry		*event_dir;
+	struct rw_semaphore     eventfs_rwsem;
 	struct trace_options	*topts;
 	struct list_head	systems;
 	struct list_head	events;
-- 
2.40.0


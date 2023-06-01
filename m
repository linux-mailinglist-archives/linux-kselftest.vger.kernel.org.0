Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D293271963A
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 11:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjFAJBo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 05:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjFAJBl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 05:01:41 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013010.outbound.protection.outlook.com [52.101.64.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642B6129;
        Thu,  1 Jun 2023 02:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChreMwsM1mAKDoSy4HQvX+hGWKyK/sWugxNMg3w6lnaQVQndWoFrAlSTVXQ89t40oneWXwTwnYiVrlsFqOipYrFxP6AsxQnLzc4DjsURyBJSIZwoFtbfuYCDV1dnftMhNwyn6T2PpXdz/D85F0OjuY8sISdehZx7uItcouB426tk6rGjnfoiuBIOh/haOP6gi9R4zaUlqg+ZsDYQ7oLzVLcS4DCXSiCwNH+TtWhE11tG9UvTEKxHMlxGkrxeFRlQe59eplW8D/Syh+KC3X5+Hr0Cg6vIwPH9rITMzZs0djrZTweyDp434PQKsuc92yorm2wxOMDBb4NwGn2wzEDH5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKQ39MLJrYfw3rrOHuty+6vC4CA9YsPn8r5/EP5y9V8=;
 b=dGccKH6pdLAdLZnAtOn1LlXEBB8J5SNSI0jjoklAnDgGNgdP4mqNn7rFTehQmdsmmU2nSR6ZgIi8qkJqhmoG/kt7S7iyGZqkKy2tO/1BJLwjzDuhzOSEFgnPJsyJ05V16jwyBneF5xUy7+B8NdykZVGCoNjmF135863Xxgywyd5JrwgaEJV5AZXm9E1qoaGpd4e4X9tv6tx8IysYhbNe/dbaecK2pb0dSA+mDx0MIkmwAFwcGExjzaG3WRdkgcuKOip5G+sjgt+VV9/CssedpbfQrdDhHSiu7Pc7vVTPnd0BPJLJPzQgGi6SeKlNoPdhwfYeil+rjl2pJqjJ0kcw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKQ39MLJrYfw3rrOHuty+6vC4CA9YsPn8r5/EP5y9V8=;
 b=I2KsqTBtzLgXej5cKIUYCQKgn9r/fSSHtG9M9ugJNuMQs1FWWgW2VyEegCBfLmHKnSxMnH+LFHXV/UKBo1H4+wsCQCTwgZi9GWskk9Hmi3r3ACUcVh4u+xvkJJvaQq/reIBeIU4o1kM0cGAGNkWehVovMBHeLpfK/r4TQ9sG5NE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB8617.namprd05.prod.outlook.com (2603:10b6:303:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 09:01:10 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 09:01:09 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v3 05/10] eventfs: adding eventfs file, directory remove function
Date:   Thu,  1 Jun 2023 14:30:08 +0530
Message-Id: <1685610013-33478-6-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: a8bde3f0-1f5f-4217-2960-08db627ebde5
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXf8Q5wI63j3XCVnJMLa5z+1MGKh7Tdz6JkXwM8OXol6GpIgr6MvjEaKlAboTgi+f2XKGAAbsfSWGzsoVVX1TJpmHPlXVrrfAzqHpzMoUuFY8LUWF/TWaanK41bbwuaNay2CV7LCLr/gpbR8lXFZg1w6mai0faH5HVr7JJ7Xp3j5ltbuJWRXQGUMAxJhrfRtH57KsFToOGJqd/shlD3IiWUdfwyJwIzcbTwB1Xj8h4kVH+sVFI3mUZWQmq2RXmzU3T+q7cdVB6eqYGhmbdBeMqInhKUqyFHer4+4uEWMvv4T57cXKmMP8xNfgOz7AbhllUAKnmKAO3RqdWdtENMRUNICcnxgg55OMDDXsxpTBX1KpMyhcSLhBPsw5jyTAxPacF3kuR56uMf1D97xF3mqG7D7RbdtN6LbOexXFUdHrQ8xj3ds82sYjBnguIg72ReCCSfTRLdE+4dcd/zglgqva2z/Koo/yq03pJ+MNceDADFdhuydsplpJzpGNg/Uix6CNtMgWBaTOMVASVgLw9v3O7W8N1anDqp9A7eZ9WWvnuy7e4/6TH26hckfYxc+vtyMpOSWZA7dQoxyqtZIoscIHmsDM5qHim/CQYgKD2RV944vdpQOezri1hAkIDXw1i9RhnzCUXi7Sb+XHD+Hn/TNjPLWmc7+wjcVzBrljZRua6c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(52116002)(6486002)(186003)(5660300002)(41300700001)(107886003)(36756003)(8676002)(38100700002)(8936002)(26005)(6506007)(38350700002)(966005)(83380400001)(4326008)(66946007)(2906002)(66556008)(478600001)(66476007)(2616005)(6512007)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FlsSsJnKDRnQIqLwcHM38euJaU/6gWUzOPtv4/Kw5Vqp59BsVUE5ADP9YwoC?=
 =?us-ascii?Q?U81TnfeFJAOvFBxV+mh1yvAqYjgb+YDIfojMAwsT+4/it1bdKwisDI7GoLmw?=
 =?us-ascii?Q?jg8cK9FUAKbkuZw5DqQoVfORtR0DuWmfO40rAYNdeXGuFUIpS0HLqWrUgdGT?=
 =?us-ascii?Q?PMgRQQ4PS7y/Pg0kdQ/EcCjdQjHLDfAB3CrApYxprTEEftTRs6kvq3ZF8A3o?=
 =?us-ascii?Q?oAjklpOnfIDtdonfaPOLHjeGR75LG0pOTEEEeycQtPIoLWivEZAt3T+7KNmX?=
 =?us-ascii?Q?Hc45dGXRv+Y0sb8IdRJk+IPGT5Ta+Furf0U2zK+ZTxBAPyPKCC+8zN4YN1Th?=
 =?us-ascii?Q?toZBhKmZvbME6jAGBB5skEQpxI8jCCWDnyzK//2GUPeeQ3utqgW/4fEduUrp?=
 =?us-ascii?Q?8cEjkDBY/cZYcBYyRrc3w7n1bHeyRtVsfY8dywlaybFR/eGvAvOyzaMXXgYO?=
 =?us-ascii?Q?B5JlU0hzewvybuI4CRFj2HtYm4F3ZCdm+27FfFVTzS3JYEQG3/UywVzX1VP1?=
 =?us-ascii?Q?NpcczhGkwUiRMe4sdKo008AT1nSfXuQmuexyD6GrdqUUuFokb0BR8dwW5BON?=
 =?us-ascii?Q?VvqYNj3jISaF2nUAEYA/vttvJ2hyKPA8S+bUDiAZ9r85Mae0LYwgI3krAVML?=
 =?us-ascii?Q?/2zPOstPZuzKSI7pAx0ceUeJ2W+hXmBCdCwXLG5XpaSyhslWGnih0GQeVd3P?=
 =?us-ascii?Q?iJLKPsi6CnwhH3TUl1i4+zEbSZkB1v6lCI6GgWd1CMtNLkE8k6jq/4kL7HK9?=
 =?us-ascii?Q?dRsntPLo41d11ibw+WnpE7tSksHWtoCVCRopDuncZS+GnSR8LfsDn6U1qV6T?=
 =?us-ascii?Q?82Ot4NoSZ1POqWfxPXZaQzMw7bIV3uaWO2HfVyhswddZOwKLN36b8Azu0bKj?=
 =?us-ascii?Q?4HR+kcn6lsm9HWpec006gWwwAP9n1bZnb2ZbpKc0ehT8n3v27LY+iqsAcIe3?=
 =?us-ascii?Q?in9/90zo077I4TiwYM2Km2AvXp59AM4TneEcdHrURrKw6WTB3lpZv3qrMO5z?=
 =?us-ascii?Q?t6HEnQYyDXEgeUq1owaA7h6iN4jXiuM12kdZ2tcNYcEuN81TcGcA7XzryJ3e?=
 =?us-ascii?Q?9B5BpgEiKVuxvxxQGWPiE0ak+DGaVhetauPWws/S9+1oAW/WVN8iXxODFpla?=
 =?us-ascii?Q?HFB0POek0zxRfHZrt0H8T9+BXYpNo4rLV7MfDEJyWKHe3reWJHxnPa6IjZCp?=
 =?us-ascii?Q?02dhdMNaQfkM3LFILqKcb82Ct3bT93kKumAdWYt240NkXgh983+NYdTQQUhr?=
 =?us-ascii?Q?GHn9K8HA3bY80caIO3ZCxWrphatMRfpbySDJouZQcxAdHtP4eRpMsskkgGIY?=
 =?us-ascii?Q?csOV8pY2DdkkIyel9FxD7XYcGW2giGQA58IzxmBvhmQCrrsfhF7jJM/kTOtz?=
 =?us-ascii?Q?N+3VtCCpzN8LAPirP6+Ikn8un1oJUE1zfb0AUZtcHHrsxSsRd38oI3qAYmdM?=
 =?us-ascii?Q?AKrNu4P65mrhEZTtfqrJ+qeuQfoIvnAh0hMJBaDQ18MdMBE6NPOTdy2T469h?=
 =?us-ascii?Q?6TH+yCsuSwMEbAZSeByY2hnwjVMARsaZRzN57FgNmYdDJRt6ixkoYP63QjRI?=
 =?us-ascii?Q?W8kbPSTSwoCOJyBpX5i6j3i91DhQ4Dde2fMJJwOO?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bde3f0-1f5f-4217-2960-08db627ebde5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 09:01:09.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kncdd5r/GlqhjAnLbt68O9MxfEk8w0Wqihmby8oB3enroWx5Yh3jkeA97h6suPppMqndOXPWIiufgaM1E+Benw==
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

Adding eventfs_remove(), this function will recursively remove
dir or file info from eventfs.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202305030611.Kas747Ev-lkp@intel.com/
---
 fs/tracefs/event_inode.c | 78 ++++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |  4 +++
 2 files changed, 82 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 17afb7476..874ef88bd 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -364,3 +364,81 @@ int eventfs_add_file(const char *name, umode_t mode,
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
+static void eventfs_remove_rec(struct eventfs_file *ef)
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
2.40.0


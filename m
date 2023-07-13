Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2493B752006
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 13:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbjGMLef (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 07:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbjGMLeN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 07:34:13 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011008.outbound.protection.outlook.com [40.93.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182022708;
        Thu, 13 Jul 2023 04:34:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WviolpG7ZwHQXWkdO8fmLTtpAxdGMPHX3YQiM95HzBDsqDDjl0h9LkjmOeAefkh9m8jn2nqo2EX2VCwjKmRESO2TEOO01sw9Pl26IDEyDNg/qpm48EZZFOe1swFWvYzYt4mcGVLflS4igQEEngAZ4UqXzWuvd9EW22W3R8ZSMpM6PaiMB3G/mNtk7F7Ba4m9WYlTlB2r2OLZp4iDOIk+kxXd38el+zjLtLR0SjROqeyvrcpa/AU41qkTbzK8sp+wlILAxgN5U+59Ji65+ZEu6+aNIMRnWUDQQco/KmcasBXH1IgCAGNWHGmMCyVRPxZxW9hy8gBGoCX2Sx6eRMIN1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jF4ddOV8P7X8cZLqZkc3fjyRoWlHKUCdIT9oKCt7tcs=;
 b=jiiKIFrFD6HCW/RKVxFtkrEwB9cHLxfJtmp1gaQHz9TH0w15LLlHYCovwhaDlH+jpZNis81hKL705n3caxuABDLGwbx+OpNuUcP2x9QNU0ELOlaPfHQ47oeXWbkyBr72S0CzQSs3v+84e/3rf9L2p+dU6+tAbhBYW/iPzHVItJ0OHvd+a+IOUs4/RUZ8HuS8KO0Qii914spo7gv0Pa70zsAL9WwQ5NMZv/uvVZPiyLDb4n97OLGsDYN/Yk0uJ3C/bioplg3VHxfvJuu+rC7Rj+Arlaz54nWAP37yEJJr1jHc8orPCDXPMdbSAxFQ7fzwdY1IsEi+6DkzHTY1Z0xtqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF4ddOV8P7X8cZLqZkc3fjyRoWlHKUCdIT9oKCt7tcs=;
 b=sOa7m7oyYMVuQy0GCX+Dg6+dStnx6/gT8govpfP/gRri25F1tZVNy9ojaGccE+kuWCGx98iwL4WXWAph84gBAcs7iI4r5zuFRzSgoK2cK8jvSJSS4t4Gyh0e/DVriNLQrg+r9MFzlNNBZmgOH7GiU5fFUHR7zu1ToEZND6pyozQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by PH0PR05MB8719.namprd05.prod.outlook.com (2603:10b6:510:b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 11:34:03 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 11:34:03 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v4 07/10] eventfs: Implement eventfs lookup, read, open functions
Date:   Thu, 13 Jul 2023 17:03:21 +0530
Message-Id: <1689248004-8158-8-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689248004-8158-1-git-send-email-akaher@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|PH0PR05MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c96c418-0deb-4c92-69fd-08db83950f5a
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: koyu4XqB4F6ShWPZwA3lUj3V+P/DNCQ5by/yb3nLjNP+c9Boy66F1AWI67q4iNVBypBMO3lZ7q6xNqsx+pxAerDkUNrufj69+Y+3fgiRrMf6wFOMV4o0fObSoWPhLCflAipNCZ2sqfymVvyXe4BqN6ToWEaY+gl7Os9km/uqFlwpdm/X7uvJ9n/CrPcA4NEDBr1Wm3eiCI3zMyI4FivIr9olrGdbHHIeUrU65CgruW0+mjQfae4mTWO6SCLDzEI+KcQ5fUutxpljfwZ2Yir9n8Ckay3Rhx09SBDM4J53sC/lUtnXioGCQ4q/orpZJX4vTDHRL/5XBahmz/8y+ho3up7dTOC4mF1lR8vKPit3UXLCGdUaLKXDKzraqBi45O5sjVrsddHPbLzlv9t1DeMaandRlplOEHibzz5F+JDREL8gNuZDW1dzssoaKoEj5elB1fNt96/JNsqappVJK05SEKBxD+4EQbe8M5LazuQFXJTlIAGIXyNvWa1NY+l4XQblcuKt4Hraesfes+l+Oa9jBrJGsYCzqFBrVQGb4SG1baQCd2P9trhZtKJv+IVAG7TzyFA3T3mRfQ7X+BqpaNkbcgp7fworBgzY7oIms3mwZ5edsQWoeq2PUR+mUGHqTqjt8N4fESXSj9wXBtb6/nMxPGRrW11ZVYWA/j4vyW+R+tc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(41300700001)(2616005)(83380400001)(7416002)(2906002)(186003)(36756003)(5660300002)(26005)(38350700002)(8676002)(8936002)(107886003)(316002)(6506007)(66556008)(66476007)(38100700002)(4326008)(66946007)(52116002)(6486002)(86362001)(6512007)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l/0aMV4ksZwTSup8uonv1lIycBbMH8wBBLgbpZLcRWS3eBgKkfXDGuihooeU?=
 =?us-ascii?Q?UzrMd1FoMG1ebxOv4Y+RI/ufwmWNdRLS7XYSQQ2/GSoe9lwD+Y/FTtw1A3QK?=
 =?us-ascii?Q?NcMfdUrZU1wjFOWz63f4u6eQaKwffVqBaud+T9dcZ+p+nz0pAoxjYfdZysfV?=
 =?us-ascii?Q?Xa6k2VDpJIefsBK7mv+OPFEDZKGVA4N2gt6np0xNUwhgT/Mw822WhuyfCStd?=
 =?us-ascii?Q?i66/EKsjYpDcdkigtVB3l4eEjj+h+xhFicYvBx37DrYAhGgd4nP+mu2lPgb9?=
 =?us-ascii?Q?R+kifH4bwS7NbjXURkkI9PRVviJ2tThnpbVHCbxj4FQDmtalOI5Oj4N7Q2t3?=
 =?us-ascii?Q?UhVL/QzONexD7Aw5UFFp6wppOqFm2QYNKzX/nAWafEOlXmU/BsMS0ygvjNYc?=
 =?us-ascii?Q?8svhaUQllBygedi4neXMFAB7C75UQjV186IyZ/wXekyWPfV1PgBBELhy0AF9?=
 =?us-ascii?Q?h8UPVRarTXXp2FoHw4PHYmGwa/j0LKax2tgJ+HYaxpVkEm174ZXPSjkXOccc?=
 =?us-ascii?Q?sJYxwgjJkrmkW0eoeck06VarhzbQMQp9tYyxaoxX4YHTfB9JyJeH/cuFzYr0?=
 =?us-ascii?Q?Od/CLIR/HtBKyJw92LNb679DgnVQz0ImI/VtINk56Dnrf70q7C9mpX6WrptO?=
 =?us-ascii?Q?JgpjrYxD+VZsfo2plRDtroEMHvNchotbLoG7iNjvXkW/ylt26vCpvne+JiK5?=
 =?us-ascii?Q?bkw5ljGcKi+Vxq/ZpGpdnuaPUOPmOne1akSzJyOmJs8TEg9LprViBR+QbDHH?=
 =?us-ascii?Q?RgWkJvM6dPU0o3zFUbbePDdMiB+r+tYpKvcAQpIlBWm8+AtutAGNCW+5PYO1?=
 =?us-ascii?Q?PaK5+T4ogSezVGGJWPNCowxY1zWFeRDOYIK03CGryVZcwzNr4ai9MMSxRS4E?=
 =?us-ascii?Q?IK8fsUFN2xHBdervMkXp6sV09Y8vaf/CQTFuw+re43f0tmfimzC0TJCjkxsA?=
 =?us-ascii?Q?j0VuuPensD8hQ3cQZPji6j2REDHHFoyqn8MBJe5Yko/Xfsz1eoWFknIAUJ/u?=
 =?us-ascii?Q?KcpqymhCg6CJOHOdmQDCM0FVahigmAufXTH5XtZLDcgCSKCMAXHGYFiioVmo?=
 =?us-ascii?Q?TljSPsF/Moe+kjFASKom6PrpBkkAhZKH8KnXP2pE26oUKXJiDKBIce/m5ugT?=
 =?us-ascii?Q?YhZgOBHK00S1QL1j0M3pIzHVmag1lIvlCxR+XeGd7qeBKoq+rx+K3DPLcKIa?=
 =?us-ascii?Q?dIoYDfH8KOxx2FL4m1ugDXnWkiT9dewex6LmUg9y3zHWM0bUX9SSOmdKgRQr?=
 =?us-ascii?Q?RkyZsXkgWi6fWGECpUnh03dB34C4/PqS7c+HJ6Lx5MHSLrbbYV1WavfyPbfK?=
 =?us-ascii?Q?2cpwSEd+6aG07ZueEygooXK74kNHSJp6yCzn3vc2yUcDJcW5XsT6FQ8M3Bt0?=
 =?us-ascii?Q?kZxdO1aSRRTbk5UBxslKV0nAC18flkMVdywSV5mbazF06Tq360vGjG2Byxdj?=
 =?us-ascii?Q?005Wmez6UOHLFnqtiYrwyIoXk4gXbCyGxs75XF4MaX00TCVxaL7d1/26ksAu?=
 =?us-ascii?Q?K9MKG6hV7yAtTGy14+9wX1d1cJMS/wm3b++bHBoI2u5p0R7GP1c5SdapXcHT?=
 =?us-ascii?Q?xhKGjQjYzs3u/AakQWwWJvvZ2Cal48oDsjigLEtM?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c96c418-0deb-4c92-69fd-08db83950f5a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 11:34:03.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RF3yz4WENlRVIOH48DbkH/rtOHJEhug3AzxdIyh2Ox5tM9Q1INb5ol0VW0VIbhHMMBMzMBj+CRWUx0waMirvZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8719
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adding following inode_operations, file_operations and helper functions to
eventfs:
dcache_dir_open_wrapper()
eventfs_root_lookup()
eventfs_release()
eventfs_set_ef_status_free()
eventfs_post_create_dir()

inode_operations, file_operations will be called from vfs.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/event_inode.c | 194 ++++++++++++++++++++++++++++++++++++++-
 include/linux/tracefs.h  |   2 +
 2 files changed, 194 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 34b5d3d8005b..7167340ac29e 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -67,7 +67,7 @@ DEFINE_STATIC_SRCU(eventfs_srcu);
  * If tracefs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
  */
-struct dentry *create_file(const char *name, umode_t mode,
+static struct dentry *create_file(const char *name, umode_t mode,
 				  struct dentry *parent, void *data,
 				  const struct file_operations *fop)
 {
@@ -123,7 +123,7 @@ struct dentry *create_file(const char *name, umode_t mode,
  * If tracefs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
  */
-struct dentry *create_dir(const char *name, umode_t mode,
+static struct dentry *create_dir(const char *name, umode_t mode,
 				 struct dentry *parent, void *data,
 				 const struct file_operations *fop,
 				 const struct inode_operations *iop)
@@ -157,10 +157,200 @@ struct dentry *create_dir(const char *name, umode_t mode,
 	return eventfs_end_creating(dentry);
 }
 
+/**
+ * eventfs_set_ef_status_free - set the ef->status to free
+ * @dentry: dentry who's status to be freed
+ *
+ * eventfs_set_ef_status_free will be called if no more
+ * reference remains
+ */
+void eventfs_set_ef_status_free(struct dentry *dentry)
+{
+	struct tracefs_inode *ti_parent;
+	struct eventfs_file *ef;
+
+	ti_parent = get_tracefs(dentry->d_parent->d_inode);
+	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
+		return;
+
+	ef = dentry->d_fsdata;
+	if (!ef)
+		return;
+	ef->created = false;
+	ef->dentry = NULL;
+}
+
+/**
+ * eventfs_post_create_dir - post create dir routine
+ * @ef: eventfs_file of recently created dir
+ *
+ * Files with-in eventfs dir should know dentry of parent dir
+ */
+static void eventfs_post_create_dir(struct eventfs_file *ef)
+{
+	struct eventfs_file *ef_child;
+	struct tracefs_inode *ti;
+
+	/* srcu lock already held */
+	/* fill parent-child relation */
+	list_for_each_entry_srcu(ef_child, &ef->ei->e_top_files, list,
+				 srcu_read_lock_held(&eventfs_srcu)) {
+		ef_child->d_parent = ef->dentry;
+	}
+
+	ti = get_tracefs(ef->dentry->d_inode);
+	ti->private = ef->ei;
+}
+
+/**
+ * eventfs_root_lookup - lookup routine to create file/dir
+ * @dir: directory in which lookup to be done
+ * @dentry: file/dir dentry
+ * @flags:
+ *
+ * Used to create dynamic file/dir with-in @dir, search with-in ei
+ * list, if @dentry found go ahead and create the file/dir
+ */
+
+static struct dentry *eventfs_root_lookup(struct inode *dir,
+					  struct dentry *dentry,
+					  unsigned int flags)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+	struct dentry *ret = NULL;
+	int idx;
+
+	ti = get_tracefs(dir);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return NULL;
+
+	ei = ti->private;
+	idx = srcu_read_lock(&eventfs_srcu);
+	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
+				 srcu_read_lock_held(&eventfs_srcu)) {
+		if (strcmp(ef->name, dentry->d_name.name))
+			continue;
+		ret = simple_lookup(dir, dentry, flags);
+		if (ef->created)
+			continue;
+		mutex_lock(&eventfs_mutex);
+		ef->created = true;
+		if (ef->ei)
+			ef->dentry = create_dir(ef->name, ef->mode, ef->d_parent,
+						ef->data, ef->fop, ef->iop);
+		else
+			ef->dentry = create_file(ef->name, ef->mode, ef->d_parent,
+						 ef->data, ef->fop);
+
+		if (IS_ERR_OR_NULL(ef->dentry)) {
+			ef->created = false;
+			mutex_unlock(&eventfs_mutex);
+		} else {
+			if (ef->ei)
+				eventfs_post_create_dir(ef);
+			ef->dentry->d_fsdata = ef;
+			mutex_unlock(&eventfs_mutex);
+			dput(ef->dentry);
+		}
+		break;
+	}
+	srcu_read_unlock(&eventfs_srcu, idx);
+	return ret;
+}
+
+/**
+ * eventfs_release - called to release eventfs file/dir
+ * @inode: inode to be released
+ * @file: file to be released (not used)
+ */
+static int eventfs_release(struct inode *inode, struct file *file)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+	int idx;
+
+	ti = get_tracefs(inode);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return -EINVAL;
+
+	ei = ti->private;
+	idx = srcu_read_lock(&eventfs_srcu);
+	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
+				 srcu_read_lock_held(&eventfs_srcu)) {
+		if (ef->created)
+			dput(ef->dentry);
+	}
+	srcu_read_unlock(&eventfs_srcu, idx);
+	return dcache_dir_close(inode, file);
+}
+
+/**
+ * dcache_dir_open_wrapper - eventfs open wrapper
+ * @inode: not used
+ * @file: dir to be opened (to create it's child)
+ *
+ * Used to dynamic create file/dir with-in @file, all the
+ * file/dir will be created. If already created then reference
+ * will be increased
+ */
+static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+	struct dentry *dentry = file_dentry(file);
+	struct inode *f_inode = file_inode(file);
+	int idx;
+
+	ti = get_tracefs(f_inode);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return -EINVAL;
+
+	ei = ti->private;
+	idx = srcu_read_lock(&eventfs_srcu);
+	list_for_each_entry_rcu(ef, &ei->e_top_files, list) {
+		if (ef->created) {
+			dget(ef->dentry);
+			continue;
+		}
+		mutex_lock(&eventfs_mutex);
+		ef->created = true;
+
+		inode_lock(dentry->d_inode);
+		if (ef->ei)
+			ef->dentry = create_dir(ef->name, ef->mode, dentry,
+						ef->data, ef->fop, ef->iop);
+		else
+			ef->dentry = create_file(ef->name, ef->mode, dentry,
+						 ef->data, ef->fop);
+		inode_unlock(dentry->d_inode);
+
+		if (IS_ERR_OR_NULL(ef->dentry)) {
+			ef->created = false;
+		} else {
+			if (ef->ei)
+				eventfs_post_create_dir(ef);
+			ef->dentry->d_fsdata = ef;
+		}
+		mutex_unlock(&eventfs_mutex);
+	}
+	srcu_read_unlock(&eventfs_srcu, idx);
+	return dcache_dir_open(inode, file);
+}
+
 static const struct file_operations eventfs_file_operations = {
+	.open           = dcache_dir_open_wrapper,
+	.read		= generic_read_dir,
+	.iterate_shared	= dcache_readdir,
+	.llseek		= generic_file_llseek,
+	.release        = eventfs_release,
 };
 
 static const struct inode_operations eventfs_root_dir_inode_operations = {
+	.lookup		= eventfs_root_lookup,
 };
 
 /**
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 47c1b4d21735..4d30b0cafc5f 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -51,6 +51,8 @@ void eventfs_remove(struct eventfs_file *ef);
 
 void eventfs_remove_events_dir(struct dentry *dentry);
 
+void eventfs_set_ef_status_free(struct dentry *dentry);
+
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
-- 
2.39.0


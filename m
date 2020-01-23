Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAAB146BB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 15:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAWOrr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 09:47:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47592 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgAWOrp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 09:47:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NERrZD081837;
        Thu, 23 Jan 2020 14:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=LJyhLcWaqg+AjjFHhdMbMnMRBxEYPQZdjfXc+Qw6vfk=;
 b=DT/WpeL3WeKaYkrSqvO6A8EGHtyz7FYQ7mBtMLB7VHltuH+tqr2Aemr/C3bJnP2OTNDk
 EhPGl2fRCBYwLSOQQhrpZwoFxR4O2t0o3WAZ/bTJFUFQR74H/HaInuIdVrpYwjC1GNQV
 KMYQ6AH3V3ZXOwKhItBwMAvCkqrQlcxOHhQNSovNi5OqZReOjdc96PPYCRCI9BUpHR/y
 PAlUj7aXpio1z9Wqe4eFNcYCh4ZmCPppyAHOV+/LCjlO78+Hv4P+oVK8ULai7ZWYDU7P
 ydgEUfxsKRL20vpp3WJiGkNyn9S/9pa8moKNo8l0wIQsISPh1fE4Oqw35YoU4Bgy790A yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xksyqjpt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 14:47:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NESfVZ097430;
        Thu, 23 Jan 2020 14:47:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2xppq7665j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 14:47:40 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00NElc8b007935;
        Thu, 23 Jan 2020 14:47:38 GMT
Received: from dhcp-10-175-173-105.vpn.oracle.com (/10.175.173.105)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jan 2020 06:47:37 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH kunit 2/3] kunit: add "run" debugfs file to run suites, display results
Date:   Thu, 23 Jan 2020 14:47:19 +0000
Message-Id: <1579790840-27009-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579790840-27009-1-git-send-email-alan.maguire@oracle.com>
References: <1579790840-27009-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=5 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001230124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001230124
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add /sys/kernel/debug/kunit/<suite>/run file which will run the
specified suite and show results.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 lib/kunit/debugfs.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 5994f32..4881261 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -15,6 +15,7 @@
 
 #define KUNIT_DEBUGFS_ROOT             "kunit"
 #define KUNIT_DEBUGFS_RESULTS          "results"
+#define KUNIT_DEBUGFS_RUN		"run"
 
 /*
  * Create a debugfs representation of test suites:
@@ -23,6 +24,8 @@
  * /sys/kernel/debug/kunit/<testsuite>/results	Show results of last run for
  *						testsuite
  *
+ * /sys/kernel/debug/kunit/<testsuite>/run	Run testsuite and show results
+ *
  */
 
 static struct dentry *debugfs_rootdir;
@@ -72,6 +75,18 @@ static int debugfs_print_results(struct seq_file *seq, void *v)
 	return 0;
 }
 
+/*
+ * /sys/kernel/debug/kunit/<testsuite>/run (re)runs suite and shows all results.
+ */
+static int debugfs_run_print_results(struct seq_file *seq, void *v)
+{
+	struct kunit_suite *suite = (struct kunit_suite *)seq->private;
+
+	kunit_run_tests(suite);
+
+	return debugfs_print_results(seq, v);
+}
+
 static int debugfs_release(struct inode *inode, struct file *file)
 {
 	return single_release(inode, file);
@@ -93,6 +108,22 @@ static int debugfs_results_open(struct inode *inode, struct file *file)
 	.release = debugfs_release,
 };
 
+static int debugfs_run_open(struct inode *inode, struct file *file)
+{
+	struct kunit_suite *suite;
+
+	suite = (struct kunit_suite *)inode->i_private;
+
+	return single_open(file, debugfs_run_print_results, suite);
+}
+
+static const struct file_operations debugfs_run_fops = {
+	.open = debugfs_run_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = debugfs_release,
+};
+
 void debugfs_create_suite(struct kunit_suite *suite)
 {
 	/* First add /sys/kernel/debug/kunit/<testsuite> */
@@ -103,6 +134,9 @@ void debugfs_create_suite(struct kunit_suite *suite)
 	debugfs_create_file(KUNIT_DEBUGFS_RESULTS, S_IFREG | 0444,
 			    suite->debugfs,
 			    suite, &debugfs_results_fops);
+	debugfs_create_file(KUNIT_DEBUGFS_RUN, S_IFREG | 0444,
+			    suite->debugfs,
+			    suite, &debugfs_run_fops);
 }
 
 void debugfs_destroy_suite(struct kunit_suite *suite)
-- 
1.8.3.1


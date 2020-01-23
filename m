Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE49414710E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 19:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgAWSr1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 13:47:27 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48922 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgAWSr0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 13:47:26 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NINnbE142657;
        Thu, 23 Jan 2020 18:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=zCmwbs0RQnBkVZeCuaBCKRaVQ8oEp7ixH2yl+2KYsZM=;
 b=RySU4MuNcelYf0UWQXfcJwIrK8Jy4hHjbGZEFTONMXj+m4dUG1Ah3mSrEGLaUhfigcP2
 ornDhH6QNuzJkhMBdwCZW1iect/Ln3VFh9j16YAMWHH+K+324S5T7/M7M2OPtuZ+FkAO
 92EZfXb1SejLK8ROm5OkteaCUsS2WAhg3OW708/KnONdWWxdXTZbRTkNK27aJzNxBgh2
 vHb2B0qWEVX0wA0ezyMJDZtJLCytKBwPQiM3Udtw8TBf3xrSLh+qHP9sWckVTMcEddQS
 767TAq/TxlpBNTV48s4YCazSrH057W8qBViF9tj/CMvvQo3QzEF5pPfvEMwNmwTIwLx7 1A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xkseuvdkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 18:47:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NIOVHQ027791;
        Thu, 23 Jan 2020 18:47:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2xppq8gy8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 18:47:21 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00NIlKlu016281;
        Thu, 23 Jan 2020 18:47:20 GMT
Received: from dhcp-10-175-166-237.vpn.oracle.com (/10.175.166.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jan 2020 10:47:20 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, gregkh@linuxfoundation.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 kunit-next 2/3] kunit: add "run" debugfs file to run suites, display results
Date:   Thu, 23 Jan 2020 18:47:00 +0000
Message-Id: <1579805221-31905-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579805221-31905-1-git-send-email-alan.maguire@oracle.com>
References: <1579805221-31905-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001230141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001230141
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add /sys/kernel/debug/kunit/<suite>/run file which will run the
specified suite and show results.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 lib/kunit/debugfs.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 578843c..1ea3fbc 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -13,6 +13,7 @@
 
 #define KUNIT_DEBUGFS_ROOT             "kunit"
 #define KUNIT_DEBUGFS_RESULTS          "results"
+#define KUNIT_DEBUGFS_RUN		"run"
 
 /*
  * Create a debugfs representation of test suites:
@@ -20,6 +21,7 @@
  * Path						Semantics
  * /sys/kernel/debug/kunit/<testsuite>/results	Show results of last run for
  *						testsuite
+ * /sys/kernel/debug/kunit/<testsuite>/run	Run testsuite and show results
  *
  */
 
@@ -67,6 +69,18 @@ static int debugfs_print_results(struct seq_file *seq, void *v)
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
@@ -88,6 +102,22 @@ static int debugfs_results_open(struct inode *inode, struct file *file)
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
 void kunit_debugfs_create_suite(struct kunit_suite *suite)
 {
 	/* First add /sys/kernel/debug/kunit/<testsuite> */
@@ -96,6 +126,9 @@ void kunit_debugfs_create_suite(struct kunit_suite *suite)
 	debugfs_create_file(KUNIT_DEBUGFS_RESULTS, S_IFREG | 0444,
 			    suite->debugfs,
 			    suite, &debugfs_results_fops);
+	debugfs_create_file(KUNIT_DEBUGFS_RUN, S_IFREG | 0444,
+			    suite->debugfs,
+			    suite, &debugfs_run_fops);
 }
 
 void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
-- 
1.8.3.1


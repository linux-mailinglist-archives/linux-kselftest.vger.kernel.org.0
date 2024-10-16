Return-Path: <linux-kselftest+bounces-19889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4762A9A15A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 00:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB03282458
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 22:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BC51D45FC;
	Wed, 16 Oct 2024 22:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Aoey1an4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145AF1D358B;
	Wed, 16 Oct 2024 22:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116458; cv=none; b=chrg9mfsG9YlS7iKUk8iOcZypjrwASnCqNpFT4gYh1K1B9nqCgy+h99fjZS1Y5/sLIUNX2uyf1efrZfZyNb68QZ6uVbluo9EAZGGqw0gMOt0NPUefp7WhnxybSRiwCnvyYEZm3PHq75QX293/tiqMzSUf2AD1SqVduBJpLtWJ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116458; c=relaxed/simple;
	bh=FULtIxNemo828fX5nPSMMbu2d3H3UhqT46zLu+XKGPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTXio0Ie+ufAhcjPms1nGzgTyKPg0fDMxhy+w+fW8kGC1TGJJdspInQ2AMNQ2oRo7cdqZcZejJ2tEZ+uiwINgzExhinpibrPiaxyaG3SqfTA1lrjsqSHZ25ktM76nuM04+rfzzk0TV8n8mFsJhhkDLG/Gmk75qgFaIrm+VzYsgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Aoey1an4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GKtflX001493;
	Wed, 16 Oct 2024 22:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=CpD7A
	cjzi3OfCU0r+0Fhe7vw78OCoPDl51Kyut2pWfU=; b=Aoey1an4f4jZHBSqIUQHH
	VyquyLlfcVwWqvpVoK8G5wLS5x3hB2le6n88EwgN+RkSbz0l4tGKzltvcOsXrsSF
	jtXmJ0/a3GbBkB/5u8x7jZ8GvCp2v09D8AkjmYw9IpZXohuEQW9u4tDcO9y3DEox
	T9Hg2f/rkZ4fK6LmuHVyHxebXUNW4o3QlwfLtdKfkOw9MLnIjdXrNlOwi6Ens7G/
	GltafVDJApCN4o/Wga0re5CqFBpIYHtwrNRyf17egKqbmRN1dEJfwIqruFJ0GiDG
	ETGxvulOsVp8bNVuTNYsOy3L+viusebqVkbtsVI12Y+eLY+9oD3RQMOJqXFFBGfN
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntd12r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 22:06:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GK2Igx011002;
	Wed, 16 Oct 2024 22:06:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjfrmdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 22:06:43 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49GM6bGw027856;
	Wed, 16 Oct 2024 22:06:42 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 427fjfrmap-3;
	Wed, 16 Oct 2024 22:06:42 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: davem@davemloft.net, Liam.Howlett@Oracle.com
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, jiri@resnulli.us, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, akpm@linux-foundation.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, anjali.k.kulkarni@oracle.com,
        peili.io@oracle.com
Subject: [PATCH net-next v3 2/3] connector/cn_proc: Kunit tests for threads hash table
Date: Wed, 16 Oct 2024 15:06:33 -0700
Message-ID: <20241016220634.1469153-3-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241016220634.1469153-1-anjali.k.kulkarni@oracle.com>
References: <20241016220634.1469153-1-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_17,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410160140
X-Proofpoint-ORIG-GUID: xspeNgYUmEAmfmueHOhmeRsLQkw-pi31
X-Proofpoint-GUID: xspeNgYUmEAmfmueHOhmeRsLQkw-pi31

Kunit tests to test hash table add, delete, duplicate add and delete.
Add following configs and compile kernel code:

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
CONFIG_NET=y
CONFIG_KUNIT=m
CONFIG_CN_HASH_KUNIT_TEST=m

To run kunit tests:
sudo modprobe cn_hash_test

Output of kunit tests and hash table contents are displayed in
/var/log/messages (at KERN_DEBUG level).

Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
---
 drivers/connector/cn_hash.c   |  40 ++++++++
 drivers/connector/connector.c |  12 +++
 include/linux/connector.h     |   4 +
 lib/Kconfig.debug             |  17 ++++
 lib/Makefile                  |   1 +
 lib/cn_hash_test.c            | 167 ++++++++++++++++++++++++++++++++++
 lib/cn_hash_test.h            |  10 ++
 7 files changed, 251 insertions(+)
 create mode 100644 lib/cn_hash_test.c
 create mode 100644 lib/cn_hash_test.h

diff --git a/drivers/connector/cn_hash.c b/drivers/connector/cn_hash.c
index a079e9bcea6d..40099b5908ac 100644
--- a/drivers/connector/cn_hash.c
+++ b/drivers/connector/cn_hash.c
@@ -170,6 +170,46 @@ int cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid)
 	return -EINVAL;
 }
 
+int cn_hash_display_hlist(struct cn_hash_dev *hdev, pid_t pid, int max_len,
+				int *hkey, int *key_display)
+{
+	struct uexit_pid_hnode *hnode;
+	int key, count = 0;
+
+	mutex_lock(&hdev->uexit_hash_lock);
+	key = hash_min(pid, HASH_BITS(hdev->uexit_pid_htable));
+	pr_debug("Bucket: %d\n", key);
+
+	hlist_for_each_entry(hnode,
+			&hdev->uexit_pid_htable[key],
+			uexit_pid_hlist) {
+		if (key_display[key] != 1) {
+			if (hnode->uexit_pid_hlist.next == NULL)
+				pr_debug("pid %d ", hnode->pid);
+			else
+				pr_debug("pid %d --> ", hnode->pid);
+		}
+		count++;
+	}
+
+	mutex_unlock(&hdev->uexit_hash_lock);
+
+	if ((key_display[key] != 1) && !count)
+		pr_debug("(empty)\n");
+
+	pr_debug("\n");
+
+	*hkey = key;
+
+	if (count > max_len) {
+		pr_err("%d entries in hlist for key %d, expected %d\n",
+				count, key, max_len);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 bool cn_hash_table_empty(struct cn_hash_dev *hdev)
 {
 	bool is_empty;
diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
index c1c0dcec53c0..2be2fe1adc12 100644
--- a/drivers/connector/connector.c
+++ b/drivers/connector/connector.c
@@ -304,6 +304,18 @@ int cn_get_exval(pid_t pid)
 }
 EXPORT_SYMBOL_GPL(cn_get_exval);
 
+int cn_display_hlist(pid_t pid, int max_len, int *hkey, int *key_display)
+{
+	struct cn_dev *dev = &cdev;
+
+	if (!cn_already_initialized)
+		return 0;
+
+	return cn_hash_display_hlist(dev->hdev, pid, max_len,
+					hkey, key_display);
+}
+EXPORT_SYMBOL_GPL(cn_display_hlist);
+
 bool cn_table_empty(void)
 {
 	struct cn_dev *dev = &cdev;
diff --git a/include/linux/connector.h b/include/linux/connector.h
index 5384e4bb98e8..a75c3fcf182a 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -168,4 +168,8 @@ int cn_get_exval(pid_t pid);
 bool cn_table_empty(void);
 bool cn_hash_table_empty(struct cn_hash_dev *hdev);
 
+int cn_display_hlist(pid_t pid, int max_len, int *hkey, int *key_display);
+int cn_hash_display_hlist(struct cn_hash_dev *hdev, pid_t pid, int max_len,
+				int *hkey, int *key_display);
+
 #endif				/* __CONNECTOR_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7315f643817a..23599beb9bec 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2705,6 +2705,23 @@ config HASHTABLE_KUNIT_TEST
 
 	  If unsure, say N.
 
+config CONFIG_CN_HASH_KUNIT_TEST
+	tristate "KUnit Test for connector hashtable code" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the hashtable KUnit test suite.
+	  It tests the basic functionality of the API defined in
+	  drivers/connector/cn_hash.c.
+	  CONFIG_CONNECTOR=y, CONFIG_PROC_EVENTS=y as well as CONFIG_NET=y
+	  needs to be enabled along with CONFIG_CN_HASH_KUNIT_TEST=m and
+	  CONFIG_KUNIT=m in .config file to compile and then test as a kernel
+	  module with "modprobe cn_hash_test".
+	  For more information on KUnit and unit tests in general please
+	  refer to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config LINEAR_RANGES_TEST
 	tristate "KUnit test for linear_ranges"
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index 811ba12c8cd0..2c59c82b0b18 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -379,6 +379,7 @@ obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
 obj-$(CONFIG_SLUB_KUNIT_TEST) += slub_kunit.o
 obj-$(CONFIG_MEMCPY_KUNIT_TEST) += memcpy_kunit.o
 obj-$(CONFIG_IS_SIGNED_TYPE_KUNIT_TEST) += is_signed_type_kunit.o
+obj-$(CONFIG_CN_HASH_KUNIT_TEST) += cn_hash_test.o
 CFLAGS_overflow_kunit.o = $(call cc-disable-warning, tautological-constant-out-of-range-compare)
 obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
 CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
diff --git a/lib/cn_hash_test.c b/lib/cn_hash_test.c
new file mode 100644
index 000000000000..78c39c0a0997
--- /dev/null
+++ b/lib/cn_hash_test.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for the connector threads hashtable code.
+ *
+ * Copyright (c) 2024 Oracle and/or its affiliates.
+ * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
+ */
+#include <kunit/test.h>
+
+#include "cn_hash_test.h"
+
+#define ARR_SIZE	4
+#define HASH_TABLE_LEN	1024
+
+struct add_data {
+	pid_t pid;
+	int exit_val;
+	int key;
+};
+
+static struct add_data adata[ARR_SIZE];
+static int key_display[HASH_TABLE_LEN];
+
+static int cn_hash_init(struct kunit *test)
+{
+	for (int i = 0; i < HASH_TABLE_LEN; i++)
+		key_display[i] = 0;
+
+	return 0;
+}
+
+static void cn_display_htable(struct kunit *test, int len)
+{
+	int i, err;
+
+	cn_hash_init(test);
+
+	pr_debug("\n");
+	pr_debug("Displaying hash table:\n");
+
+	for (i = 0; i < len; i++) {
+		err = cn_display_hlist(adata[i].pid, len, &adata[i].key,
+					key_display);
+		key_display[adata[i].key] = 1;
+		KUNIT_EXPECT_EQ(test, err, 0);
+	}
+}
+
+static void cn_hash_test_add(struct kunit *test)
+{
+	int err, i;
+	int exit_val;
+
+	adata[0].pid = 1;
+	adata[0].exit_val = 45;
+
+	adata[1].pid = 2;
+	adata[1].exit_val = 13;
+
+	adata[2].pid = 1024;
+	adata[2].exit_val = 16;
+
+	adata[3].pid = 1023;
+	adata[3].exit_val = 71;
+
+	for (i = 0; i < ARRAY_SIZE(adata); i++) {
+		err = cn_add_elem(adata[i].exit_val, adata[i].pid);
+		KUNIT_EXPECT_EQ_MSG(test, 0, err,
+				"Adding pid %d returned err %d",
+				adata[i].pid, err);
+
+		exit_val = cn_get_exval(adata[i].pid);
+		KUNIT_EXPECT_EQ(test, adata[i].exit_val, exit_val);
+	}
+
+	cn_display_htable(test, ARRAY_SIZE(adata));
+}
+
+static void cn_hash_test_del(struct kunit *test)
+{
+	int i, err;
+	int exit_val;
+
+	for (i = 0; i < ARRAY_SIZE(adata); i++) {
+		err = cn_del_elem(adata[i].pid);
+		KUNIT_EXPECT_EQ_MSG(test, 0, err,
+				"Deleting pid %d returned err %d",
+				adata[i].pid, err);
+
+		exit_val = cn_get_exval(adata[i].pid);
+		KUNIT_EXPECT_EQ(test, -EINVAL, exit_val);
+	}
+
+	cn_display_htable(test, ARRAY_SIZE(adata));
+	KUNIT_EXPECT_TRUE(test, cn_table_empty());
+}
+
+static void cn_hash_test_del_get_exval(struct kunit *test)
+{
+	int i, exval;
+
+	for (i = 0; i < ARRAY_SIZE(adata); i++) {
+		exval = cn_del_get_exval(adata[i].pid);
+		KUNIT_EXPECT_EQ(test, adata[i].exit_val, exval);
+
+		cn_display_htable(test, ARRAY_SIZE(adata));
+	}
+
+	KUNIT_EXPECT_TRUE(test, cn_table_empty());
+}
+static void cn_hash_test_dup_add(struct kunit *test)
+{
+	int err, exit_val;
+
+	adata[0].pid = 10;
+	adata[0].exit_val = 21;
+
+	err = cn_add_elem(adata[0].exit_val, adata[0].pid);
+	KUNIT_EXPECT_EQ(test, 0, err);
+
+	exit_val = cn_get_exval(adata[0].pid);
+	KUNIT_EXPECT_EQ(test, 21, exit_val);
+
+	adata[1].pid = 10;
+	adata[1].exit_val = 12;
+
+	err = cn_add_elem(adata[1].exit_val, adata[1].pid);
+	KUNIT_EXPECT_EQ(test, -EEXIST, err);
+
+	exit_val = cn_get_exval(adata[1].pid);
+	KUNIT_EXPECT_EQ(test, 21, exit_val);
+
+	cn_display_htable(test, 1);
+}
+
+static void cn_hash_test_dup_del(struct kunit *test)
+{
+	int err;
+
+	err = cn_del_elem(adata[0].pid);
+	KUNIT_EXPECT_EQ(test, 0, err);
+
+	err = cn_del_elem(adata[0].pid);
+	KUNIT_EXPECT_EQ(test, -EINVAL, err);
+
+	KUNIT_EXPECT_TRUE(test, cn_table_empty());
+}
+
+static struct kunit_case cn_hashtable_test_cases[] = {
+	KUNIT_CASE(cn_hash_test_add),
+	KUNIT_CASE(cn_hash_test_del),
+	KUNIT_CASE(cn_hash_test_dup_add),
+	KUNIT_CASE(cn_hash_test_dup_del),
+	KUNIT_CASE(cn_hash_test_add),
+	KUNIT_CASE(cn_hash_test_del_get_exval),
+	{},
+};
+
+static struct kunit_suite cn_hashtable_test_module = {
+	.name = "cn_hashtable",
+	.init = cn_hash_init,
+	.test_cases = cn_hashtable_test_cases,
+};
+kunit_test_suite(cn_hashtable_test_module);
+
+MODULE_DESCRIPTION("KUnit test for the connector threads hashtable code");
+MODULE_LICENSE("GPL");
diff --git a/lib/cn_hash_test.h b/lib/cn_hash_test.h
new file mode 100644
index 000000000000..b25033feab09
--- /dev/null
+++ b/lib/cn_hash_test.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 Oracle and/or its affiliates.
+ * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
+ */
+int cn_display_hlist(pid_t pid, int max_len, int *hkey, int *key_display);
+int cn_add_elem(__u32 uexit_code, pid_t pid);
+int cn_del_get_exval(pid_t pid);
+int cn_get_exval(pid_t pid);
+bool cn_table_empty(void);
-- 
2.46.0



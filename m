Return-Path: <linux-kselftest+bounces-19582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7020099AFB8
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 02:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B02F285E53
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 00:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3724E14F90;
	Sat, 12 Oct 2024 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N7khvugg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B994DDC3;
	Sat, 12 Oct 2024 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728693968; cv=none; b=EhEGMESbplPQK/W+XxMvJHb4Xkq6lCftaQoGEeAGBU2NY8iewg3bMVJc6kkR2tegzReDSI4TA9wn6BlojC537vatFLnawBs2/d4bB+qN8TIQdIl+Nw22gvy82dAQwUVM6xPTPYbR/WvADxWEsNp4/e7wiS7zLaBu3UwulPY3wtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728693968; c=relaxed/simple;
	bh=2DYqiDfzsRa6gS5bwHwxVYQK68M/n/FpKZGuuKLE/oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/xI6A5VoYzsOxeOUCf0j7/UOAkisUxBVqs79HLgxWL4hW8rdZwDnJWtmf4aC/70PR5OLUCfNKCOFDZY0fSrSMGxYnQxF0Jflz0UTLllBBx/D25l9Ki3dHq/z1/OOjh5uPAu8kEokvFfq/JHtd58TIgNOqdZvrUwd199rWrgO2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N7khvugg; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BKFlqB010409;
	Sat, 12 Oct 2024 00:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=O5YX3
	5j3ycbUpxKuhZvDxAlb5nJuT7nKLwJPQo4GPQI=; b=N7khvugg4W2PH1YOt28Uf
	b+coMmmw7jUBxV7QSYuMSgZe56KKsjuTLNaigBW8s9bgeeOlrgAIArPVo6nCD4lU
	ek7iuKbx8wpnANcNn4/bt+Xf9Eeo7X1kuv/Oy3e7gqgbD3O0ovMCj7EFvuXOgKLH
	H3WGyC1a0MbwDJ9NoIODStRlyotyJfn/sqUU4oLIGf7HA5/0WpUpghQ46RVHQeL6
	sq1EurFd1FQHlF1LSxagEh13b8CBbyEtP3djQSU7k+Fdg/gBpmcWilOmdxibsKjG
	11gwTeihjM9n4P9IdFrp+LZ9uVbRjYp8hpbJVCBGQ2T05hvA2xo4aOK20fohTLS1
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063wxkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Oct 2024 00:45:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49C03uOl005862;
	Sat, 12 Oct 2024 00:45:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwbvtd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Oct 2024 00:45:45 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49C0jbP5017077;
	Sat, 12 Oct 2024 00:45:44 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422uwbvtat-3;
	Sat, 12 Oct 2024 00:45:44 +0000
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
Subject: [PATCH net-next 2/3] connector/cn_proc: Kunit tests for threads hash table
Date: Fri, 11 Oct 2024 17:45:31 -0700
Message-ID: <20241012004532.2071738-3-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241012004532.2071738-1-anjali.k.kulkarni@oracle.com>
References: <20241012004532.2071738-1-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_21,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410120004
X-Proofpoint-ORIG-GUID: TH9tA5_5SJ2JjleS1jMgPCVfVu27_TC6
X-Proofpoint-GUID: TH9tA5_5SJ2JjleS1jMgPCVfVu27_TC6

Kunit tests to test hash table add, delete, duplicate add and delete.
Add following configs and compile kernel code:

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
CONFIG_NET=y
CONFIG_KUNIT=m/y
CONFIG_CN_HASH_KUNIT_TEST=m/y

To run kunit tests:
sudo modprobe cn_hash_test

Output of kunit tests and hash table contents are displayed in
/var/log/messages (at KERN_DEBUG level).

Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
---
 drivers/connector/cn_hash.c   |  49 +++++++++-
 drivers/connector/connector.c |  15 ++-
 include/linux/connector.h     |   8 +-
 lib/Kconfig.debug             |  17 ++++
 lib/Makefile                  |   1 +
 lib/cn_hash_test.c            | 167 ++++++++++++++++++++++++++++++++++
 lib/cn_hash_test.h            |  12 +++
 7 files changed, 264 insertions(+), 5 deletions(-)
 create mode 100644 lib/cn_hash_test.c
 create mode 100644 lib/cn_hash_test.h

diff --git a/drivers/connector/cn_hash.c b/drivers/connector/cn_hash.c
index a0211cd99132..8f0eb6acb158 100644
--- a/drivers/connector/cn_hash.c
+++ b/drivers/connector/cn_hash.c
@@ -166,7 +166,7 @@ __u32 cn_hash_del_get_exval(struct cn_hash_dev *hdev, pid_t pid)
 	return 0;
 }
 
-__u32 cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid)
+int cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid)
 {
 	struct uexit_pid_hnode *hnode;
 	__u32 excde;
@@ -189,7 +189,52 @@ __u32 cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid)
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
-	return hash_empty(hdev->uexit_pid_htable);
+	bool is_empty;
+
+	is_empty = hash_empty(hdev->uexit_pid_htable);
+	pr_debug("Hash table is %s\n", (is_empty ? "empty" : "not empty"));
+
+	return is_empty;
 }
diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
index 506e3cbedf85..28e60c8b0fdf 100644
--- a/drivers/connector/connector.c
+++ b/drivers/connector/connector.c
@@ -308,7 +308,7 @@ int cn_add_elem(__u32 uexit_code, pid_t pid)
 }
 EXPORT_SYMBOL_GPL(cn_add_elem);
 
-__u32 cn_get_exval(pid_t pid)
+int cn_get_exval(pid_t pid)
 {
 	struct cn_dev *dev = &cdev;
 	__u32 exval;
@@ -321,6 +321,19 @@ __u32 cn_get_exval(pid_t pid)
 }
 EXPORT_SYMBOL_GPL(cn_get_exval);
 
+int cn_display_hlist(pid_t pid, int max_len, int *hkey,
+			int *key_display)
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
index 094e1730a4f6..af801c5005e8 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -165,7 +165,7 @@ __u32 cn_hash_del_get_exval(struct cn_hash_dev *hdev, pid_t pid);
 int cn_add_elem(__u32 uexit_code, pid_t pid);
 int cn_del_elem(pid_t pid);
 __u32 cn_del_get_exval(pid_t pid);
-__u32 cn_get_exval(pid_t pid);
+int cn_get_exval(pid_t pid);
 
 struct cn_hash_dev *cn_hash_alloc_dev(const char *name);
 void cn_hash_free_dev(struct cn_hash_dev *hdev);
@@ -175,9 +175,13 @@ void cn_hash_free_elem(struct uexit_pid_hnode *elem);
 int cn_hash_add_elem(struct cn_hash_dev *hdev, __u32 uexit_code, pid_t pid);
 int cn_hash_del_elem(struct cn_hash_dev *hdev, pid_t pid);
 __u32 cn_hash_del_get_exval(struct cn_hash_dev *hdev, pid_t pid);
-__u32 cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid);
+int cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid);
 
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
index 000000000000..2687492864ed
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
+struct add_data adata[ARR_SIZE];
+int key_display[HASH_TABLE_LEN];
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
index 000000000000..46fcda31b25c
--- /dev/null
+++ b/lib/cn_hash_test.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 Oracle and/or its affiliates.
+ * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
+ */
+extern int cn_display_hlist(pid_t pid, int max_len, int *hkey,
+				int *key_display);
+extern int cn_del_elem(pid_t pid);
+extern int cn_add_elem(__u32 uexit_code, pid_t pid);
+extern __u32 cn_del_get_exval(pid_t pid);
+extern int cn_get_exval(pid_t pid);
+extern bool cn_table_empty(void);
-- 
2.46.0



Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E74348AF91
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 08:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfHMGMM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 02:12:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60114 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfHMGMM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 02:12:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68qHL039286;
        Tue, 13 Aug 2019 06:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=pIx9k7V10F3qq6zstYwjlNx3ARnd/lV+BoLCek/UQ8Y=;
 b=qU30W5Z9X04wZ/zVw94pIo1qqti7CZ3UDM5I98fqGb1n9n+cUfoyHUFCFWNO0u7JLzN6
 iCXmAXGMgz7Nl22ud4CNWcl3dsaB55ntu9bLCPgNXv0F3PDJgWrcWfCshmO3IwPYdbMF
 j0aKiMKj/7311DVnVnyCUDFyvWQcStUGctyUf76eaU+vasQM4BVBXxrnXrf+BnuwbkEN
 AaYZQt2aVjzteBbUdGR7v5YtsEi9+Bm2zQQeDaSD+vz6+ZtLn4B28Zl4HabpIwI5Uhn8
 M4VON0H+rDmuATneRFXI8DCUTgw/K67r/6fFzbBaPqabham/7jvHNBYqemj0tRuvYV6e VA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=pIx9k7V10F3qq6zstYwjlNx3ARnd/lV+BoLCek/UQ8Y=;
 b=Fd3rlzZ/3eBRkijPsQacD86/FW+A5HYeXchqDqVq7i1BtbHAo1knoUhH77UPKYel0eJq
 F0OxEExtqW4wO6kQA0khzl+ELqO1eLaaHCxwVDthXbnrfH/pSOzobvtblsSdy+whFHYW
 8FZWiKdTgvubYTQaJv9sGGcZjm8+akQdkY3AyNSV8caQL2bTZcc0uS+9zF1veHXcsyOA
 b9H/c5geQWNt487Y/aawpHT/EHEecf8X8B+OjOShL57AP1PcRoRjHpoiP1Yo+Q+ertAw
 vMsoGZgUMwqX1Bmap7H1tzHjRw+owzodWBSdyGNTIrfm7kWYEzekJsWAoejB4ypf0MZ6 Qw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2u9nvp41n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D67Qx2096547;
        Tue, 13 Aug 2019 06:11:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2u9m0ayefx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:49 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7D6Bm70026524;
        Tue, 13 Aug 2019 06:11:48 GMT
Received: from abi.no.oracle.com (/10.172.144.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Aug 2019 23:11:47 -0700
From:   Knut Omang <knut.omang@oracle.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Subject: [RFC 15/19] ktf: Some simple examples
Date:   Tue, 13 Aug 2019 08:09:30 +0200
Message-Id: <930ceefe7f08e47c66cc43404d6e67b310cbec60.1565676440.git-series.knut.omang@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130067
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A few simple examples, and example of other test modules
to make it easier to get started with ktf.

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 tools/testing/selftests/ktf/examples/Makefile | 17 ++++-
 tools/testing/selftests/ktf/examples/h2.c     | 45 +++++++++++-
 tools/testing/selftests/ktf/examples/h3.c     | 84 ++++++++++++++++++++-
 tools/testing/selftests/ktf/examples/h4.c     | 62 +++++++++++++++-
 tools/testing/selftests/ktf/examples/hello.c  | 38 +++++++++-
 tools/testing/selftests/ktf/examples/kgdemo.c | 61 +++++++++++++++-
 6 files changed, 307 insertions(+)
 create mode 100644 tools/testing/selftests/ktf/examples/Makefile
 create mode 100644 tools/testing/selftests/ktf/examples/h2.c
 create mode 100644 tools/testing/selftests/ktf/examples/h3.c
 create mode 100644 tools/testing/selftests/ktf/examples/h4.c
 create mode 100644 tools/testing/selftests/ktf/examples/hello.c
 create mode 100644 tools/testing/selftests/ktf/examples/kgdemo.c

diff --git a/tools/testing/selftests/ktf/examples/Makefile b/tools/testing/selftests/ktf/examples/Makefile
new file mode 100644
index 0000000..f3cfcc9
--- /dev/null
+++ b/tools/testing/selftests/ktf/examples/Makefile
@@ -0,0 +1,17 @@
+# Copyright (c) 2016, 2018, Oracle and/or its affiliates. All rights reserved.
+#
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel module implementing a few simple examples of KTF tests
+#
+
+include $(srctree)/$(src)/../scripts/ktf_syms.mk
+
+ccflags-y += -I$(srctree)/$(src)/../kernel -I$(src)
+
+obj-m := hello.o h2.o h3.o h4.o
+
+ifdef CONFIG_KGDB
+obj-m += kgdemo.o
+endif
+
diff --git a/tools/testing/selftests/ktf/examples/h2.c b/tools/testing/selftests/ktf/examples/h2.c
new file mode 100644
index 0000000..37a6fbb
--- /dev/null
+++ b/tools/testing/selftests/ktf/examples/h2.c
@@ -0,0 +1,45 @@
+#include <linux/module.h>
+#include "ktf.h"
+
+MODULE_LICENSE("GPL");
+
+KTF_INIT();
+
+#define MAX_CNT 3
+
+struct hello_ctx {
+	struct ktf_context k;
+	int value[MAX_CNT];
+};
+
+static struct hello_ctx myctx = { .value = { 0, 1, 4 } };
+
+TEST(examples, cmp)
+{
+	struct hello_ctx *hctx = KTF_CONTEXT_GET("value", struct hello_ctx);
+
+	EXPECT_INT_EQ(_i, hctx->value[_i]);
+}
+
+static void add_tests(void)
+{
+	ADD_LOOP_TEST(cmp, 0, MAX_CNT);
+}
+
+static int __init hello_init(void)
+{
+	KTF_CONTEXT_ADD(&myctx.k, "value");
+	add_tests();
+	return 0;
+}
+
+static void __exit hello_exit(void)
+{
+	struct ktf_context *kctx = KTF_CONTEXT_FIND("value");
+
+	KTF_CONTEXT_REMOVE(kctx);
+	KTF_CLEANUP();
+}
+
+module_init(hello_init);
+module_exit(hello_exit);
diff --git a/tools/testing/selftests/ktf/examples/h3.c b/tools/testing/selftests/ktf/examples/h3.c
new file mode 100644
index 0000000..a6aca98
--- /dev/null
+++ b/tools/testing/selftests/ktf/examples/h3.c
@@ -0,0 +1,84 @@
+#include <linux/module.h>
+#include "ktf.h"
+
+MODULE_LICENSE("GPL");
+
+KTF_INIT();
+
+DECLARE_F(hello_fixture)
+	struct list_head head;
+};
+
+struct my_element {
+	struct list_head list;
+	int value;
+};
+
+SETUP_F(hello_fixture, hello_setup)
+{
+	int i;
+
+	INIT_LIST_HEAD(&hello_fixture->head);
+	for (i = 0; i < 10; i++) {
+		struct my_element *e = kzalloc(sizeof(*e), GFP_KERNEL);
+
+		e->value = i;
+		list_add_tail(&e->list, &hello_fixture->head);
+	}
+	hello_fixture->ok = true;
+}
+
+TEARDOWN_F(hello_fixture, hello_teardown)
+{
+	struct list_head *p, *next_p;
+
+	/* Just cleanup whatever is left after the test */
+	list_for_each_safe(p, next_p, &hello_fixture->head) {
+		struct my_element *e = list_entry(p, struct my_element, list);
+
+		list_del(&e->list);
+		kfree(e);
+	}
+	EXPECT_TRUE(list_empty(&hello_fixture->head));
+}
+
+INIT_F(hello_fixture, hello_setup, hello_teardown);
+
+TEST_F(hello_fixture, examples, hello_del)
+{
+	int cnt = 0;
+	int cnt_ones = 0;
+	struct my_element *e = kzalloc(sizeof(*e), GFP_KERNEL);
+
+	e->value = 1;
+	list_add(&e->list, &ctx->head);
+
+	list_for_each_entry(e, &ctx->head, list) {
+		if (e->value == 1)
+			cnt_ones++;
+		cnt++;
+	}
+	EXPECT_INT_EQ(11, cnt);
+	EXPECT_INT_EQ(2, cnt_ones);
+}
+
+static void add_tests(void)
+{
+	ADD_TEST(hello_del);
+}
+
+static int __init hello_init(void)
+{
+	add_tests();
+	tlog(T_INFO, "hello: loaded");
+	return 0;
+}
+
+static void __exit hello_exit(void)
+{
+	KTF_CLEANUP();
+	tlog(T_INFO, "hello: unloaded");
+}
+
+module_init(hello_init);
+module_exit(hello_exit);
diff --git a/tools/testing/selftests/ktf/examples/h4.c b/tools/testing/selftests/ktf/examples/h4.c
new file mode 100644
index 0000000..3e85fef
--- /dev/null
+++ b/tools/testing/selftests/ktf/examples/h4.c
@@ -0,0 +1,62 @@
+#include <linux/module.h>
+#include "ktf.h"
+
+MODULE_LICENSE("GPL");
+
+KTF_INIT();
+
+static int count;
+static int ret;
+
+KTF_ENTRY_PROBE(printk, printkhandler)
+{
+	count++;
+
+	KTF_ENTRY_PROBE_RETURN(0);
+}
+
+TEST(examples, entrycheck)
+{
+	count = 0;
+	ASSERT_INT_EQ_GOTO(KTF_REGISTER_ENTRY_PROBE(printk, printkhandler),
+			   0, done);
+	printk(KERN_INFO "Testing kprobe entry...");
+	ASSERT_INT_GT_GOTO(count, 0, done);
+done:
+	KTF_UNREGISTER_ENTRY_PROBE(printk, printkhandler);
+}
+
+KTF_RETURN_PROBE(printk, printkrethandler)
+{
+	ret = KTF_RETURN_VALUE();
+
+	return 0;
+}
+
+TEST(examples, returncheck)
+{
+	char *teststr = "Testing kprobe return...";
+
+	ret = -1;
+	ASSERT_INT_EQ_GOTO(KTF_REGISTER_RETURN_PROBE(printk, printkrethandler),
+			   0, done);
+	printk(KERN_INFO "%s", teststr);
+	ASSERT_INT_EQ_GOTO(ret, strlen(teststr), done);
+done:
+	KTF_UNREGISTER_RETURN_PROBE(printk, printkrethandler);
+}
+
+static int __init hello_init(void)
+{
+	ADD_TEST(entrycheck);
+	ADD_TEST(returncheck);
+	return 0;
+}
+
+static void __exit hello_exit(void)
+{
+	KTF_CLEANUP();
+}
+
+module_init(hello_init);
+module_exit(hello_exit);
diff --git a/tools/testing/selftests/ktf/examples/hello.c b/tools/testing/selftests/ktf/examples/hello.c
new file mode 100644
index 0000000..9c4713f
--- /dev/null
+++ b/tools/testing/selftests/ktf/examples/hello.c
@@ -0,0 +1,38 @@
+#include <linux/module.h>
+#include "ktf.h"
+
+MODULE_LICENSE("GPL");
+
+KTF_INIT();
+
+TEST(examples, hello_ok)
+{
+	EXPECT_TRUE(true);
+}
+
+TEST(examples, hello_fail)
+{
+	EXPECT_TRUE(false);
+}
+
+static void add_tests(void)
+{
+	ADD_TEST(hello_ok);
+	ADD_TEST(hello_fail);
+}
+
+static int __init hello_init(void)
+{
+	add_tests();
+	tlog(T_INFO, "hello: loaded");
+	return 0;
+}
+
+static void __exit hello_exit(void)
+{
+	KTF_CLEANUP();
+	tlog(T_INFO, "hello: unloaded");
+}
+
+module_init(hello_init);
+module_exit(hello_exit);
diff --git a/tools/testing/selftests/ktf/examples/kgdemo.c b/tools/testing/selftests/ktf/examples/kgdemo.c
new file mode 100644
index 0000000..9ce19ff
--- /dev/null
+++ b/tools/testing/selftests/ktf/examples/kgdemo.c
@@ -0,0 +1,61 @@
+#include <linux/module.h>
+#include "ktf.h"
+
+/*
+ * A trivial and somewhat rough example used by the author
+ * for pedagogical purposes, to demonstrate
+ * interactive debugging with kgdb.
+ *
+ * Requires a kernel built with CONFIG_KGDB
+ *
+ * Note: these test breaks into kgdb and/or creates a NULL
+ *       pointer exception and corresponding stack dump, so
+ *       try out in a test environment only!
+ */
+
+MODULE_LICENSE("GPL");
+
+KTF_INIT();
+
+#define MAX_CNT 3
+#include <linux/kgdb.h>
+
+static int kgdemo_cnt;
+static int *bogus_ref;
+
+TEST(kgdb, breakpoint)
+{
+	kgdemo_cnt = 0;
+	printk(KERN_INFO "** Please set kgdemo_cnt = 1 **\n");
+	kgdb_breakpoint();
+	EXPECT_INT_EQ(1, kgdemo_cnt);
+}
+
+TEST(kgdb, nullpointer)
+{
+	int pre = kgdemo_cnt;
+
+	int b = *bogus_ref++;
+
+	EXPECT_INT_EQ(pre + 1, b);
+}
+
+static void add_tests(void)
+{
+	ADD_TEST(breakpoint);
+	ADD_TEST(nullpointer);
+}
+
+static int __init kgdemo_init(void)
+{
+	add_tests();
+	return 0;
+}
+
+static void __exit kgdemo_exit(void)
+{
+	KTF_CLEANUP();
+}
+
+module_init(kgdemo_init);
+module_exit(kgdemo_exit);
-- 
git-series 0.9.1

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D68898AF83
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 08:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfHMGL7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 02:11:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60640 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfHMGL6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 02:11:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D693sm011117;
        Tue, 13 Aug 2019 06:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=qpt6s5f2ZMaRIgJiplhgON8Bp1uiCExpeX8yfJisRo0=;
 b=RIvpVm8o8LO7TiFDQSKpSMjoPd96rRCcbOYvoTM6hGDerfSraoVTsssN1c71EYbIkf5D
 w+Wd5MM1frqreAWrhbQ7tU1Cwe1jYUp43lkDUMwnBIIA8v/FYUl+7DGbmPBZWbwthTPp
 svqSZj8Wk7ajsd7Y/b+8MEuW26iluj5Yb9aQWR6Sqwx74dUQ9sjLYv+eEx++53qfnck7
 cICnj29SRq6J+okWyi5AQbDY1T5xwnmY2ooiQjGgYm/Rt4Pi1shrMhdDwfd0RLOf8LbD
 oF+sEHEn8qPgS4mM1MlZ6FZRrF8fyFqmpvVZcJ/601qe7R88zTPsiQOllwsJkkpf/KRx ew== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=qpt6s5f2ZMaRIgJiplhgON8Bp1uiCExpeX8yfJisRo0=;
 b=OBswWIC+orkFZ8bCLW/oOxXhUnAvhETNpobsidoTyF7lAwlj5AlRJFd1Gr5zZ6KibMxd
 2zVaB/zVCQoGw+Ynyw8JDRnlW4lpHZ4pTdI3bA1+0GELDIIEjK78PlgXg3v6eQ/UQ/Mm
 /bizjXp+mes44tevw3dppI3Tf4CPNpZHfYL20BBLHLBHxFMAz4GKn//aME+WkwdKJqF0
 8xkt6UmIn+OZFC3mmFlKzuYKVdVvTSHw07ahNRfkAV2jeJ6GL6vOThPoDR8EcX84Enn+
 wRDvBFUeLmCxuqmnXpFTi/hkfcNAsur+nOvF6U98asuLCQtBgPZqmiSUSZFKrjYBAQ3J tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2u9nbtc12u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D67TTd157170;
        Tue, 13 Aug 2019 06:11:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2u9nrenm99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:11:35 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7D6BXm4011235;
        Tue, 13 Aug 2019 06:11:33 GMT
Received: from abi.no.oracle.com (/10.172.144.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Aug 2019 23:11:32 -0700
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
Subject: [RFC 11/19] ktf: Add a small test suite with a few tests to test KTF itself
Date:   Tue, 13 Aug 2019 08:09:26 +0200
Message-Id: <f799b8bdcdaa843e6202ca73ecc73366cdf5ecd6.1565676440.git-series.knut.omang@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9347 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130067
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

context.c:       Parameterized context test case, kernel side:
context.h:       Parameterized context test case, kernel side.
context_self.h:  The data structure passed between user level and kernel for the
hybrid.c:        Hybrid (combined user level and kernel) self tests,
hybrid.h:        Hybrid (combined user level and kernel) self tests,
hybrid_self.h:   The data structure passed between user level and kernel for the
self.c:          Some simple self tests for KTF

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 tools/testing/selftests/ktf/selftest/Makefile       |  17 +-
 tools/testing/selftests/ktf/selftest/context.c      | 149 +++-
 tools/testing/selftests/ktf/selftest/context.h      |  15 +-
 tools/testing/selftests/ktf/selftest/context_self.h |  34 +-
 tools/testing/selftests/ktf/selftest/hybrid.c       |  35 +-
 tools/testing/selftests/ktf/selftest/hybrid.h       |  24 +-
 tools/testing/selftests/ktf/selftest/hybrid_self.h  |  27 +-
 tools/testing/selftests/ktf/selftest/ktf_syms.txt   |  17 +-
 tools/testing/selftests/ktf/selftest/self.c         | 661 +++++++++++++-
 9 files changed, 979 insertions(+)
 create mode 100644 tools/testing/selftests/ktf/selftest/Makefile
 create mode 100644 tools/testing/selftests/ktf/selftest/context.c
 create mode 100644 tools/testing/selftests/ktf/selftest/context.h
 create mode 100644 tools/testing/selftests/ktf/selftest/context_self.h
 create mode 100644 tools/testing/selftests/ktf/selftest/hybrid.c
 create mode 100644 tools/testing/selftests/ktf/selftest/hybrid.h
 create mode 100644 tools/testing/selftests/ktf/selftest/hybrid_self.h
 create mode 100644 tools/testing/selftests/ktf/selftest/ktf_syms.txt
 create mode 100644 tools/testing/selftests/ktf/selftest/self.c

diff --git a/tools/testing/selftests/ktf/selftest/Makefile b/tools/testing/selftests/ktf/selftest/Makefile
new file mode 100644
index 0000000..8737bf4
--- /dev/null
+++ b/tools/testing/selftests/ktf/selftest/Makefile
@@ -0,0 +1,17 @@
+# Copyright (c) 2017, 2018, Oracle and/or its affiliates. All rights reserved.
+#
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel module implementing a test suite for testing KTF itself
+#
+
+ccflags-y += -Wno-vla
+
+ccflags-y += -I$(srctree)/$(src)/../kernel -I$(src)
+
+obj-m := selftest.o
+
+include $(srctree)/$(src)/../scripts/ktf_syms.mk
+
+selftest-y := self.o hybrid.o context.o
+
diff --git a/tools/testing/selftests/ktf/selftest/context.c b/tools/testing/selftests/ktf/selftest/context.c
new file mode 100644
index 0000000..9129b5b
--- /dev/null
+++ b/tools/testing/selftests/ktf/selftest/context.c
@@ -0,0 +1,149 @@
+/* Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * context.c: Parameterized context test case, kernel side:
+ */
+
+#include "ktf.h"
+#include "context.h"
+
+/* Declare a specific handle for this test to avoid interfering with the
+ * other tests:
+ */
+static KTF_HANDLE_INIT(ct_handle);
+
+struct param_test_ctx {
+	struct ktf_context k;
+	struct test_parameter_block p;
+};
+
+struct param_test_ctx param_ctx[2];
+
+#define MYVALUE 0xdabadaba
+
+/* Declare the callback that accepts a parameter block */
+static int param_ctx_cb(struct ktf_context *ctx, const void *data, size_t data_sz)
+{
+	struct param_test_ctx *px = container_of(ctx, struct param_test_ctx, k);
+	struct test_parameter_block *pb = (struct test_parameter_block *)data;
+	long orig_myvalue;
+
+	if (data_sz != sizeof(*pb))
+		return -EINVAL;
+	/* check data validity here, if possible.. */
+	orig_myvalue = px->p.myvalue;
+	memcpy(&px->p, pb, data_sz);
+	/* Enforce "policies" */
+	px->p.myvalue = orig_myvalue;
+	return 0;
+}
+
+TEST(selftest, param)
+{
+	struct param_test_ctx *px = container_of(ctx, struct param_test_ctx, k);
+
+	/* Now, here we can fail (using ASSERT) or ignore by silently return
+	 * depending on what's most useful, if a test hasn't been configured.
+	 * For this selftest we just use EXPECT so we can have the actual current
+	 * parameter values reported as well.
+	 *
+	 * Notice that these parameters are
+	 * persistent throughout the instance 'life' of the kernel test module,
+	 * so if one user program has configured them, then
+	 * programs ignorant of the parameters may still end up
+	 * executing the tests with previously configured parameters:
+	 *
+	 * This simplified example uses the same configuration struct for both
+	 * context type IDs, but the idea is that they can be completely different.
+	 */
+	EXPECT_INT_EQ(ctx->config_errno, 0);
+	if (KTF_CONTEXT_CFG_OK(ctx)) {
+		switch (ctx->type->name[13]) {
+		case '1':
+			EXPECT_LONG_EQ(px->p.magic, CONTEXT_MAGIC1);
+			break;
+		case '2':
+			EXPECT_LONG_EQ(px->p.magic, CONTEXT_MAGIC2);
+			break;
+		case '3':
+			EXPECT_LONG_EQ(px->p.magic, CONTEXT_MAGIC3);
+			EXPECT_LONG_EQ(px->p.myvalue, MYVALUE);
+			break;
+		}
+		EXPECT_STREQ(px->p.s, CONTEXT_MSG);
+	} else {
+		EXPECT_LONG_EQ(px->p.magic, 0);
+		EXPECT_STREQ(px->p.s, "");
+	}
+}
+
+struct param_test_type {
+	struct ktf_context_type kt;
+	/* space for cfg data (such as constraints) for the context type */
+	long myvalue;
+};
+
+static struct ktf_context *type3_alloc(struct ktf_context_type *ct)
+{
+	struct param_test_type *pct = container_of(ct, struct param_test_type, kt);
+	struct param_test_ctx *ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+
+	ctx->p.myvalue = pct->myvalue;
+	return &ctx->k;
+}
+
+static void type3_cleanup(struct ktf_context *ctx)
+{
+	struct param_test_ctx *px = container_of(ctx, struct param_test_ctx, k);
+
+	kfree(px);
+}
+
+TEST(selftest, dupltype)
+{
+	/* Verify that we cannot add the same context type twice */
+
+	static struct param_test_type dupltype = {
+		.myvalue = 0,
+		.kt.alloc = type3_alloc,
+		.kt.config_cb = param_ctx_cb,
+		.kt.cleanup = type3_cleanup,
+		.kt.name = "context_type_3"
+	};
+
+	ASSERT_INT_EQ(-EEXIST, ktf_handle_add_ctx_type(&ct_handle, &dupltype.kt));
+}
+
+void add_context_tests(void)
+{
+	int ret = KTF_CONTEXT_ADD_TO_CFG(ct_handle, &param_ctx[0].k, "context1",
+					 param_ctx_cb, "context_type_1");
+
+	if (ret)
+		return;
+
+	ret = KTF_CONTEXT_ADD_TO_CFG(ct_handle, &param_ctx[1].k, "context2",
+				     param_ctx_cb, "context_type_2");
+	if (ret)
+		return;
+
+	{
+		static struct param_test_type ctx_type3 = {
+			.myvalue = MYVALUE,
+			.kt.alloc = type3_alloc,
+			.kt.config_cb = param_ctx_cb,
+			.kt.cleanup = type3_cleanup,
+			.kt.name = "context_type_3"
+		};
+		ret = ktf_handle_add_ctx_type(&ct_handle, &ctx_type3.kt);
+	}
+
+	ADD_TEST_TO(ct_handle, param);
+	ADD_TEST(dupltype);
+}
+
+void context_tests_cleanup(void)
+{
+	KTF_HANDLE_CLEANUP(ct_handle);
+}
diff --git a/tools/testing/selftests/ktf/selftest/context.h b/tools/testing/selftests/ktf/selftest/context.h
new file mode 100644
index 0000000..69b970a
--- /dev/null
+++ b/tools/testing/selftests/ktf/selftest/context.h
@@ -0,0 +1,15 @@
+/* Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * context.h: Parameterized context test case, kernel side.
+ */
+#ifndef _CONTEXT_H
+#define _CONTEXT_H
+
+#include "context_self.h"
+
+void add_context_tests(void);
+void context_tests_cleanup(void);
+
+#endif
diff --git a/tools/testing/selftests/ktf/selftest/context_self.h b/tools/testing/selftests/ktf/selftest/context_self.h
new file mode 100644
index 0000000..3939559
--- /dev/null
+++ b/tools/testing/selftests/ktf/selftest/context_self.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * context_self.h: The data structure passed between user level and kernel for the
+ *  hybrid self tests. Included both from user space and kernel space and
+ *  needs to be a C struct.
+ */
+
+#ifndef KTF_CONTEXT_SELF_H
+#define KTF_CONTEXT_SELF_H
+
+#define CONTEXT_SELF_MAX_TEXT 30
+
+/* A simple example parameter block:
+ * For verification purposes it can be useful to have a field
+ * like 'magic' below, which serves for the purpose of
+ * a sanity check that the parameters sent by the user program
+ * actually corresponds to what the kernel expects:
+ */
+struct test_parameter_block {
+	long magic;
+	long myvalue;
+	char s[CONTEXT_SELF_MAX_TEXT+1];
+};
+
+/* Constants for the selftest.param_context test: */
+#define CONTEXT_MSG "from user to kernel"
+#define CONTEXT_MAGIC1 0xfaaa1234UL
+#define CONTEXT_MAGIC2 0xaabbccUL
+#define CONTEXT_MAGIC3 0x123456UL
+
+#endif
diff --git a/tools/testing/selftests/ktf/selftest/hybrid.c b/tools/testing/selftests/ktf/selftest/hybrid.c
new file mode 100644
index 0000000..999a7d8
--- /dev/null
+++ b/tools/testing/selftests/ktf/selftest/hybrid.c
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2011, 2018, Oracle and/or its affiliates. All rights reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * hybrid.c: Hybrid (combined user level and kernel) self tests,
+ *  kernel side:
+ */
+
+#include "ktf.h"
+#include "hybrid.h"
+
+/* First a simple message passing test that just verifies that we receive
+ * "out-of-band" data from user space:
+ */
+
+TEST(selftest, msg)
+{
+	/* Accept data of type 'struct hybrid_self_params' (defined in hybrid_self.h)
+	 * from user mode. This functionality is to allow user mode to test something,
+	 * for instance that a certain parameter is handled in a specific way in the kernel.
+	 * The user then has the option to provide data to the kernel out-of-band to
+	 * tell the kernel side what to expect.
+	 * In this test, just verify that data has been transmitted correctly:
+	 */
+	KTF_USERDATA(self, hybrid_self_params, data);
+
+	EXPECT_STREQ(data->text_val, HYBRID_MSG);
+	EXPECT_LONG_EQ(data->val, HYBRID_MSG_VAL);
+}
+
+void add_hybrid_tests(void)
+{
+	ADD_TEST(msg);
+}
diff --git a/tools/testing/selftests/ktf/selftest/hybrid.h b/tools/testing/selftests/ktf/selftest/hybrid.h
new file mode 100644
index 0000000..0ba6f72
--- /dev/null
+++ b/tools/testing/selftests/ktf/selftest/hybrid.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (c) 2011, 2018, Oracle and/or its affiliates. All rights reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * hybrid.h: Hybrid (combined user level and kernel) self tests,
+ *  kernel side, internal interface:
+ */
+
+#ifndef KTF_HYBRID_H
+#define KTF_HYBRID_H
+
+#include "hybrid_self.h"
+
+/* The kernel part of hybrid tests must be added to KTFs set of tests like any other tests,
+ * in fact from KTF's kernel perspective it is like any other test, except that it likely will
+ * fail if called without the context provided from the user space side.
+ *
+ * This function adds the tests declared in hybrid.c
+ */
+void add_hybrid_tests(void);
+
+
+#endif
diff --git a/tools/testing/selftests/ktf/selftest/hybrid_self.h b/tools/testing/selftests/ktf/selftest/hybrid_self.h
new file mode 100644
index 0000000..21c6c92
--- /dev/null
+++ b/tools/testing/selftests/ktf/selftest/hybrid_self.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (c) 2011, 2018, Oracle and/or its affiliates. All rights reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * hybrid_self.h: The data structure passed between user level and kernel for the
+ *  hybrid self tests. Included both from user space and kernel space and
+ *  needs to be a C struct.
+ */
+
+#ifndef KTF_HYBRID_SELF_H
+#define KTF_HYBRID_SELF_H
+
+#define HYBRID_SELF_MAX_TEXT 127
+
+struct hybrid_self_params
+{
+	char text_val[HYBRID_SELF_MAX_TEXT+1];
+	unsigned long val;
+};
+
+
+/* Constants for the selftest.msg test: */
+#define HYBRID_MSG "a little test string"
+#define HYBRID_MSG_VAL  0xffUL
+
+#endif
diff --git a/tools/testing/selftests/ktf/selftest/ktf_syms.txt b/tools/testing/selftests/ktf/selftest/ktf_syms.txt
new file mode 100644
index 0000000..721ae98
--- /dev/null
+++ b/tools/testing/selftests/ktf/selftest/ktf_syms.txt
@@ -0,0 +1,17 @@
+#module ktf
+#header ktf_map.h
+ktf_map_init
+ktf_map_elem_init
+ktf_map_insert
+ktf_map_find
+ktf_map_find_first
+ktf_map_remove
+ktf_map_elem_get
+ktf_map_elem_put
+ktf_map_find_next
+ktf_map_delete_all
+#header ktf_cov.h
+ktf_cov_entry_find
+ktf_cov_entry_put
+ktf_cov_enable
+ktf_cov_disable
diff --git a/tools/testing/selftests/ktf/selftest/self.c b/tools/testing/selftests/ktf/selftest/self.c
new file mode 100644
index 0000000..8b7a582
--- /dev/null
+++ b/tools/testing/selftests/ktf/selftest/self.c
@@ -0,0 +1,661 @@
+/*
+ * Copyright (c) 2011, 2017, Oracle and/or its affiliates. All rights reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * self.c: Some simple self tests for KTF
+ */
+#include <linux/module.h>
+#include <linux/mm_types.h>
+#include <linux/slab.h>
+#include <linux/slab_def.h>
+
+#include "ktf.h"
+#include "ktf_map.h"
+#include "ktf_cov.h"
+#include "ktf_syms.h"
+
+#include "hybrid.h"
+#include "context.h"
+
+MODULE_LICENSE("GPL");
+
+struct map_test_ctx {
+	struct ktf_context k;
+};
+
+static struct map_test_ctx s_mctx[4];
+
+/* Declare a simple handle with no contexts for simple (unparameterized) tests: */
+KTF_INIT();
+
+/* For tests that defines multiple test cases
+ * (e.g. if the test scope requires application of each test on several devices or
+ *  other abstract contexts, definable by the test module)
+ */
+static KTF_HANDLE_INIT(dual_handle);
+static KTF_HANDLE_INIT(single_handle);
+static KTF_HANDLE_INIT(no_handle);
+static KTF_HANDLE_INIT_VERSION(wrongversion_handle, 0, false);
+
+static struct map_test_ctx *to_mctx(struct ktf_context *ctx)
+{
+	return container_of(ctx, struct map_test_ctx, k);
+}
+
+struct myelem {
+	struct ktf_map_elem foo;
+	int freed;
+	int order;
+};
+
+/* --- Simple insertion and removal test --- */
+
+TEST(selftest, simplemap)
+{
+	int i;
+	const int nelems = 3;
+	struct map_test_ctx *mctx = to_mctx(ctx);
+	struct ktf_map tm;
+	struct myelem e[nelems];
+
+	if (mctx)
+		tlog(T_DEBUG, "ctx %s", mctx->k.elem.key);
+	else
+		tlog(T_DEBUG, "ctx <none>");
+
+	ktf_map_init(&tm, NULL, NULL);
+	EXPECT_INT_EQ(0, ktf_map_elem_init(&e[0].foo, "foo"));
+	EXPECT_INT_EQ(0, ktf_map_elem_init(&e[1].foo, "bar"));
+	EXPECT_INT_EQ(0, ktf_map_elem_init(&e[2].foo, "zax"));
+
+	for (i = 0; i < nelems; i++) {
+		EXPECT_LONG_EQ(i, ktf_map_size(&tm));
+		EXPECT_INT_EQ(0, ktf_map_insert(&tm, &e[i].foo));
+	}
+	EXPECT_LONG_EQ(i, ktf_map_size(&tm));
+
+	/* Should be sorted alphabetically so we get 'bar' back: */
+	EXPECT_ADDR_EQ(&e[1].foo, ktf_map_find_first(&tm));
+
+	for (i = 0; i < nelems; i++) {
+		EXPECT_LONG_EQ(nelems - i, ktf_map_size(&tm));
+		EXPECT_ADDR_EQ(&e[i].foo, ktf_map_remove(&tm, e[i].foo.key));
+	}
+	EXPECT_LONG_EQ(0, ktf_map_size(&tm));
+}
+
+/* --- Reference counting test --- */
+
+/* should be called when refcount is 0. */
+static void myelem_free(struct ktf_map_elem *elem)
+{
+	struct myelem *myelem = container_of(elem, struct myelem, foo);
+
+	myelem->freed = 1;
+}
+
+TEST(selftest, mapref)
+{
+	int i;
+	const int nelems = 3;
+	struct myelem e[nelems], *ep;
+	struct ktf_map tm;
+	struct ktf_map_elem *elem;
+
+	ktf_map_init(&tm, NULL, myelem_free);
+	/* Init map elems with "foo" "bar" "zax" */
+	EXPECT_INT_EQ(0, ktf_map_elem_init(&e[0].foo, "foo"));
+	EXPECT_INT_EQ(0, ktf_map_elem_init(&e[1].foo, "bar"));
+	EXPECT_INT_EQ(0, ktf_map_elem_init(&e[2].foo, "zax"));
+
+	/* Insert elems and drop our refcounts (map still holds ref) */
+	for (i = 0; i < nelems; i++) {
+		EXPECT_INT_EQ(0, ktf_map_insert(&tm, &e[i].foo));
+		ktf_map_elem_put(&e[i].foo);
+	}
+
+	/* This macro takes (and drops) refcount for each elem */
+	ktf_map_for_each_entry(ep, &tm, foo)
+		ep->freed = 0;
+
+	for (i = 0; i < nelems; i++) {
+		elem = ktf_map_remove(&tm, e[i].foo.key);
+		EXPECT_INT_EQ(0, e[i].freed);
+		/* free our ref, now free function should be called. */
+		ktf_map_elem_put(elem);
+		EXPECT_INT_EQ(1, e[i].freed);
+	}
+
+	ktf_map_delete_all(&tm);
+	EXPECT_LONG_EQ(0, ktf_map_size(&tm));
+}
+
+/* --- Test that the expect macros work as if-then-else single statement */
+TEST(selftest, statements)
+{
+	char c;
+	char *cp = &c;
+	/* These are mostly intended as compilation syntax tests */
+	if (_i)
+		EXPECT_TRUE(true);
+	else
+		EXPECT_FALSE(false);
+	if (_i)
+		ASSERT_TRUE(true);
+	else
+		ASSERT_FALSE(false);
+	if (_i)
+		ASSERT_OK_ADDR(cp);
+	else
+		ASSERT_OK_ADDR_GOTO(cp, out);
+	if (_i)
+		ASSERT_OK_ADDR_BREAK(cp);
+out:
+	EXPECT_TRUE(true);
+}
+
+/* --- Compare function test --- */
+
+/* key comparison function */
+static int myelem_cmp(const char *key1, const char *key2)
+{
+	int i1 = *((int *)key1);
+	int i2 = *((int *)key2);
+
+	if (i1 < i2)
+		return -1;
+	else if (i1 > i2)
+		return 1;
+	return 0;
+}
+
+TEST(selftest, mapcmpfunc)
+{
+	int i;
+	const int nelems = 3;
+	struct myelem e[nelems], *ep;
+	struct ktf_map tm;
+
+	ktf_map_init(&tm, myelem_cmp, NULL);
+	/* Init map elems with keys "foo" "bar" "zax" */
+	EXPECT_INT_EQ(0, ktf_map_elem_init(&e[0].foo, "foo"));
+	EXPECT_INT_EQ(0, ktf_map_elem_init(&e[1].foo, "bar"));
+	EXPECT_INT_EQ(0, ktf_map_elem_init(&e[2].foo, "zax"));
+
+	/* Insert elems with order values 3, 2, 1. Ensure we see order
+	 * 1, 2, 3 on retrieval.
+	 */
+	for (i = 0; i < nelems; i++) {
+		e[i].order = nelems - i;
+		EXPECT_INT_EQ(0, ktf_map_elem_init(&e[i].foo,
+						   (char *)&e[i].order));
+		EXPECT_INT_EQ(0, ktf_map_insert(&tm, &e[i].foo));
+	}
+	i = 1;
+	/* Ensure ordering via compare function is respected */
+	ktf_map_for_each_entry(ep, &tm, foo)
+		EXPECT_INT_EQ(ep->order, i++);
+
+	ktf_map_delete_all(&tm);
+	EXPECT_LONG_EQ(0, ktf_map_size(&tm));
+}
+
+/* --- Verify that key name is truncated at KTF_MAX_NAME length --- */
+
+TEST(selftest, map_keyoverflow)
+{
+	struct myelem e;
+	struct ktf_map tm;
+	char jumbokey[KTF_MAX_NAME + 2];
+	char jumbokey_truncated[KTF_MAX_NAME + 1];
+
+	ktf_map_init(&tm, NULL, NULL);
+	memset(jumbokey, 'x', KTF_MAX_NAME + 1);
+	memset(jumbokey_truncated, 'x', KTF_MAX_NAME);
+	jumbokey_truncated[KTF_MAX_NAME] = '\0';
+	EXPECT_INT_EQ(0, ktf_map_elem_init(&e.foo, jumbokey));
+	EXPECT_TRUE(strcmp(e.foo.key, jumbokey_truncated) == 0);
+}
+
+struct mykey {
+	unsigned long address;
+	unsigned long size;
+};
+
+/* Comparison here is to check if k1's address falls in range
+ * [k2->address, k2->address + k2->size].  Similar compare used in
+ * ktf_cov to figure out if a function address lies within the function
+ * code.
+ */
+static int custom_compare(const char *key1, const char *key2)
+{
+	struct mykey *k1 = (struct mykey *)key1;
+	struct mykey *k2 = (struct mykey *)key2;
+
+	if (k1->address < k2->address)
+		return -1;
+	if (k1->address >= (k2->address + k2->size))
+		return 1;
+	return 0;
+}
+
+/* --- Verify that opaque keys with custom compare function work --- */
+
+TEST(selftest, map_customkey)
+{
+	const int nelems = 3;
+	int baseaddr = 1024;
+	struct ktf_map cm;
+	struct mykey keys[nelems], search;
+	struct myelem elems[nelems];
+	int i, j;
+
+	ktf_map_init(&cm, custom_compare, NULL);
+
+	/* Ensure we can add entries and then retrieve them via search key. */
+	for (i = 0; i < nelems; i++) {
+		baseaddr += (i << 2);
+		keys[i].address = baseaddr;
+		keys[i].size = (i + 1) << 2;
+		ASSERT_INT_EQ_GOTO(ktf_map_elem_init(&elems[i].foo,
+						     (char *)&keys[i]),
+				   0, done);
+		ASSERT_INT_EQ_GOTO(ktf_map_insert(&cm, &elems[i].foo), 0, done);
+	}
+
+	baseaddr = 1024;
+
+	/* Ensure all search addresses within range of [base address, size]
+	 * find appropriate entries.
+	 */
+	for (i = 0; i < nelems; i++) {
+		baseaddr += (i << 2);
+		for (j = 0; j < (i + 1) << 2; j++) {
+			search.address = baseaddr + j;
+			search.size = 0;
+			ASSERT_ADDR_EQ_GOTO(ktf_map_find_entry(&cm,
+							       (char *)&search,
+							       struct myelem,
+							       foo),
+					    &elems[i], done);
+		}
+	}
+
+done:
+	ktf_map_delete_all(&cm);
+}
+
+TEST(selftest, dummy)
+{
+	/* The default handle does not have any contexts in this test set */
+	ASSERT_FALSE(ctx);
+}
+
+TEST(selftest, wrongversion)
+{
+	tlog(T_INFO, "This test should never have run - wrong version\n!!!");
+	EXPECT_TRUE(false);
+}
+
+static void add_map_tests(void)
+{
+	ADD_TEST(dummy);
+	ADD_LOOP_TEST(statements, 0, 2);
+	ADD_TEST_TO(dual_handle, simplemap);
+	ADD_TEST_TO(dual_handle, mapref);
+	ADD_TEST_TO(dual_handle, mapcmpfunc);
+	ADD_TEST(map_keyoverflow);
+	ADD_TEST(map_customkey);
+
+	terr("-- version check test: --");
+	/* This should fail */
+	ADD_TEST_TO(wrongversion_handle, wrongversion);
+}
+
+static int probecount;
+static int proberet;
+
+KTF_ENTRY_PROBE(printk, printkhandler)
+{
+	probecount++;
+
+	KTF_ENTRY_PROBE_RETURN(0);
+}
+
+static int entryarg0, entryarg1;
+
+KTF_ENTRY_PROBE(probeargtest, probeargtesthandler)
+{
+	entryarg0 = (int)KTF_ENTRY_PROBE_ARG0;
+	entryarg1 = (int)KTF_ENTRY_PROBE_ARG1;
+	KTF_ENTRY_PROBE_RETURN(0);
+}
+
+noinline void probeargtest(int arg0, int arg1)
+{
+	tlog(T_INFO, "got args %d, %d\n", arg0, arg1);
+}
+
+TEST(selftest, probeentry)
+{
+	probecount = 0;
+	ASSERT_INT_EQ(KTF_REGISTER_ENTRY_PROBE(printk, printkhandler), 0);
+	/* Need T_WARN for unconditional printk() */
+	twarn("Testing kprobe entry...");
+	ASSERT_INT_GT_GOTO(probecount, 0, done);
+	ASSERT_INT_EQ_GOTO(KTF_REGISTER_ENTRY_PROBE(probeargtest,
+						    probeargtesthandler),
+			   0, done);
+	probeargtest(1, 2);
+	ASSERT_INT_EQ_GOTO(entryarg0, 1, done);
+	ASSERT_INT_EQ_GOTO(entryarg1, 2, done);
+done:
+	KTF_UNREGISTER_ENTRY_PROBE(probeargtest, probeargtesthandler);
+	KTF_UNREGISTER_ENTRY_PROBE(printk, printkhandler);
+}
+
+static int override_failed;
+
+noinline int myfunc(int i)
+{
+	override_failed = 1;
+	return i;
+}
+
+KTF_OVERRIDE(myfunc, myfunc_override)
+{
+	KTF_SET_RETURN_VALUE(0);
+	KTF_OVERRIDE_RETURN;
+}
+
+TEST(selftest, override)
+{
+	override_failed = 0;
+
+	ASSERT_INT_EQ(KTF_REGISTER_OVERRIDE(myfunc, myfunc_override), 0);
+
+	(void)myfunc(0);
+
+	/* Verify override function runs instead. */
+	ASSERT_TRUE_GOTO(override_failed == 0, done);
+
+	/* Verify override function modifies return value. */
+	ASSERT_INT_EQ_GOTO(myfunc(100), 0, done);
+	ASSERT_TRUE_GOTO(override_failed == 0, done);
+done:
+	KTF_UNREGISTER_OVERRIDE(myfunc, myfunc_override);
+}
+
+noinline int probesum(int a, int b)
+{
+	tlog(T_INFO, "Adding %d + %d", a, b);
+	return a + b;
+}
+
+KTF_RETURN_PROBE(probesum, probesumhandler)
+{
+	tlog(T_DEBUG, "return value before modifying %ld",
+	     regs_return_value(regs));
+	KTF_SET_RETURN_VALUE(-1);
+	tlog(T_DEBUG, "return value after modifying %ld",
+	     regs_return_value(regs));
+	return 0;
+}
+
+KTF_RETURN_PROBE(printk, printkrethandler)
+{
+	proberet = KTF_RETURN_VALUE();
+
+	return 0;
+}
+
+TEST(selftest, probereturn)
+{
+	char *teststr = "Testing kprobe return...";
+
+	proberet = -1;
+	ASSERT_INT_EQ_GOTO(KTF_REGISTER_RETURN_PROBE(printk, printkrethandler),
+			   0, done);
+	printk(KERN_INFO "%s", teststr);
+	ASSERT_INT_EQ_GOTO(proberet, strlen(teststr), done);
+
+	/* Now test modification of return value */
+	ASSERT_INT_EQ_GOTO(probesum(1, 1), 2, done);
+	ASSERT_INT_EQ_GOTO(KTF_REGISTER_RETURN_PROBE(probesum, probesumhandler),
+			   0, done);
+	ASSERT_INT_EQ_GOTO(probesum(1, 1), -1, done);
+done:
+	KTF_UNREGISTER_RETURN_PROBE(printk, printkrethandler);
+	KTF_UNREGISTER_RETURN_PROBE(probesum, probesumhandler);
+}
+
+static void add_probe_tests(void)
+{
+	ADD_TEST(probeentry);
+	ADD_TEST(probereturn);
+	ADD_TEST(override);
+}
+
+noinline void cov_counted(void)
+{
+	tlog(T_INFO, "got called!");
+}
+
+noinline void *doalloc(struct kmem_cache *c, size_t sz)
+{
+	if (c)
+		return kmem_cache_alloc(c, GFP_KERNEL);
+	return kmalloc(sz, GFP_KERNEL);
+}
+
+TEST(selftest, acov)
+{
+	/* A very basic test just to enable and disable the coverage support,
+	 * without the memory tracking option and without making use of it:
+	 */
+	ASSERT_INT_EQ(0, ktf_cov_enable((THIS_MODULE)->name, 0));
+	ktf_cov_disable((THIS_MODULE)->name);
+}
+
+TEST(selftest, cov)
+{
+	int foundp1 = 0, foundp2 = 0, foundp3 = 0, foundp4 = 0;
+	struct ktf_cov_entry *e;
+	struct ktf_cov_mem *m;
+	char *p1 = NULL, *p2 = NULL, *p3 = NULL, *p4 = NULL;
+	struct kmem_cache *c = NULL;
+	int oldcount;
+
+	c = kmem_cache_create("selftest_cov_cache",
+			      32, 0,
+			     SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL);
+
+	ASSERT_ADDR_NE(NULL, c);
+
+	tlog(T_INFO, "Allocated cache %p : %s %u\n", c, c->name, c->object_size);
+	ASSERT_INT_EQ(0, ktf_cov_enable((THIS_MODULE)->name, KTF_COV_OPT_MEM));
+
+	e = ktf_cov_entry_find((unsigned long)cov_counted, 0);
+	ASSERT_ADDR_NE_GOTO(e, NULL, done);
+	oldcount = e->count;
+	ktf_cov_entry_put(e);
+	cov_counted();
+	e = ktf_cov_entry_find((unsigned long)cov_counted, 0);
+	ASSERT_ADDR_NE_GOTO(e, NULL, done);
+	if (e) {
+		ASSERT_INT_EQ(e->count, oldcount + 1);
+		ktf_cov_entry_put(e);
+	}
+
+	/* Need to call a noinline fn to do allocs since this test function
+	 * will be inlined; and to track allocations they need to come
+	 * from this module.  Don't need to do the same for kfree since
+	 * we check every kfree() to see if it is freeing a tracked allocation.
+	 */
+	p1 = doalloc(NULL, 8);
+	ASSERT_ADDR_NE_GOTO(p1, NULL, done);
+	p2 = doalloc(NULL, 16);
+	ASSERT_ADDR_NE_GOTO(p2, NULL, done);
+	p3 = doalloc(c, 0);
+	ASSERT_ADDR_NE_GOTO(p3, NULL, done);
+	p4 = doalloc(c, 0);
+	ASSERT_ADDR_NE_GOTO(p4, NULL, done);
+
+	ktf_for_each_cov_mem(m) {
+		if (m->key.address == (unsigned long)p1)
+			foundp1 = 1;
+		if (m->key.address == (unsigned long)p2 && m->key.size == 16)
+			foundp2 = 1;
+		if (m->key.address == (unsigned long)p3 && m->key.size == 32)
+			foundp3 = 1;
+		if (m->key.address == (unsigned long)p4)
+			foundp4 = 1;
+	}
+	ASSERT_INT_EQ_GOTO(foundp1, 1, done);
+	ASSERT_INT_EQ_GOTO(foundp2, 1, done);
+	ASSERT_INT_EQ_GOTO(foundp3, 1, done);
+	ASSERT_INT_EQ_GOTO(foundp4, 1, done);
+	kfree(p1);
+	kmem_cache_free(c, p4);
+	/* Didn't free p2/p3 - should still be on our cov_mem list */
+	foundp1 = 0;
+	foundp2 = 0;
+	foundp3 = 0;
+	foundp4 = 0;
+	ktf_for_each_cov_mem(m) {
+		if (m->key.address == (unsigned long)p1)
+			foundp1 = 1;
+		if (m->key.address == (unsigned long)p2)
+			foundp2 = 1;
+		if (m->key.address == (unsigned long)p3)
+			foundp3 = 1;
+		if (m->key.address == (unsigned long)p4)
+			foundp4 = 1;
+	}
+	ASSERT_INT_EQ_GOTO(foundp2, 1, done);
+	ASSERT_INT_EQ_GOTO(foundp3, 1, done);
+	ASSERT_INT_EQ_GOTO(foundp1, 0, done);
+	ASSERT_INT_EQ_GOTO(foundp4, 0, done);
+done:
+	kfree(p2);
+	if (p3)
+		kmem_cache_free(c, p3);
+	ktf_cov_disable((THIS_MODULE)->name);
+	kmem_cache_destroy(c);
+}
+
+static void add_cov_tests(void)
+{
+	ADD_TEST(acov);
+	/* We still seem to have some subtle issues with the memory coverage test feature,
+	 * as sometimes allocations made by the coverage framework itself,
+	 * for this particular test survives the cleanup function.
+	 * Whether it is our attempt to test ourselves or a more generic problem
+	 * is not fully understood yet, so disable this test for now:
+	 */
+	/* ADD_TEST(cov); */
+}
+
+KTF_THREAD(test_thread)
+{
+	/* ensure assertions can work in thread context */
+	ASSERT_INT_EQ(1, 1);
+}
+
+#define NUM_TEST_THREADS 20
+
+static struct ktf_thread test_threads[NUM_TEST_THREADS];
+
+TEST(selftest, thread)
+{
+	int assertions, i;
+
+	for (i = 0; i < NUM_TEST_THREADS; i++) {
+		KTF_THREAD_INIT(test_thread, &test_threads[i]);
+		KTF_THREAD_RUN(&test_threads[i]);
+	}
+	for (i = 0; i < NUM_TEST_THREADS; i++)
+		KTF_THREAD_WAIT_COMPLETED(&test_threads[i]);
+
+	assertions = (int)ktf_get_assertion_count();
+
+	/* Verify assertion in thread */
+	ASSERT_INT_EQ(assertions, NUM_TEST_THREADS);
+}
+
+static void add_thread_tests(void)
+{
+	ADD_TEST(thread);
+}
+
+static int selftest_module_var;
+
+/*
+ * Test that ktf_find_symbol works both for module symbols and
+ * core kernel symbols:
+ */
+TEST(selftest, symbol)
+{
+	/* Verify finding kernel-internal symbol works. */
+	ASSERT_ADDR_NE(ktf_find_symbol(NULL, "skbuff_head_cache"), NULL);
+
+	/* Verify finding module symbols works, both when we specify the
+	 * module name and when we don't.
+	 */
+	ASSERT_ADDR_EQ(ktf_find_symbol(NULL, "selftest_module_var"),
+		       &selftest_module_var);
+
+	ASSERT_ADDR_EQ(ktf_find_symbol("selftest", "selftest_module_var"),
+		       &selftest_module_var);
+}
+
+static void add_symbol_tests(void)
+{
+	ADD_TEST(symbol);
+}
+
+static int __init selftest_init(void)
+{
+	int ret = KTF_CONTEXT_ADD_TO(dual_handle, &s_mctx[1].k, "map1");
+
+	tlog(T_DEBUG, "map1 gets %d", ret);
+	if (ret)
+		return ret;
+
+	ret = KTF_CONTEXT_ADD_TO(dual_handle, &s_mctx[2].k, "map2");
+	if (ret)
+		goto fail;
+
+	ret = KTF_CONTEXT_ADD_TO(single_handle, &s_mctx[3].k, "map3");
+	if (ret)
+		goto fail;
+
+	ktf_resolve_symbols();
+
+	add_map_tests();
+	add_probe_tests();
+	add_cov_tests();
+	add_thread_tests();
+	add_hybrid_tests();
+	add_context_tests();
+	add_symbol_tests();
+	tlog(T_INFO, "selftest: loaded");
+	return 0;
+fail:
+	KTF_CLEANUP();
+	return ret;
+}
+
+static void __exit selftest_exit(void)
+{
+	context_tests_cleanup();
+	KTF_HANDLE_CLEANUP(single_handle);
+	KTF_HANDLE_CLEANUP(dual_handle);
+	KTF_HANDLE_CLEANUP(no_handle);
+	KTF_CLEANUP();
+	tlog(T_INFO, "selftest: unloaded");
+}
+
+module_init(selftest_init);
+module_exit(selftest_exit);
-- 
git-series 0.9.1

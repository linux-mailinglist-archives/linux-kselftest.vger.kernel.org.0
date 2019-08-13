Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8AAD8AFAE
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 08:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfHMGNa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 02:13:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40398 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfHMGN3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 02:13:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D68uMw021972;
        Tue, 13 Aug 2019 06:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=qbLLhu1JxazjsK8NdQnvn6HpeQ0btTaiQUzkaqX9Wv0=;
 b=bFGrM9LqXGC3jCaPl+YPfhMSZUBF2MQ1rAzk7OujN5Mi3KQdqwRxd/ih73YEYfo7We4c
 1ESplTRoEp7E3BjEPzWRkEBePVqYyr6pSOCkECDmm4MbyzRCo1QZWnZUGcrK8b5ngAzD
 SRhlgsDewVEax0YN8hs41R10IZb9ydxWU7bxcrRB1JvZKsDch3JfB+rWPu4EcuQpBFFy
 FOZba/S0nJ7y324qxN4Jt46nO+tqHGh8GdfN1G9sdJJu9vOVY3as0mks1UZz4HFb989U
 DzBHG2mK1xvelbUAAtgFlRQGQdCB73foBze8JbOT+YNuWhIjbngqhTf34l41ty6EHqyw 7w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=qbLLhu1JxazjsK8NdQnvn6HpeQ0btTaiQUzkaqX9Wv0=;
 b=FrQS4HHJi8i4jyN8dpYz68G7+wsvM+CCO9l2Q5nr5xaub04oazcejYPrT8D8x98pEKuF
 bniCka7HqLBplR4kJomgV3f1lT/U7eikpbosc0tmdHr/46JTnrJuLhrFFnCtKC6fGDOP
 YZCBAtt0hIF5I+JzvXdWYDK/qMWwkPClU6hQVPC0JKHuwX8XObHyroqOAG8CjVvZTjL8
 1vmm8j+CnbgqCEHW0l1w2lqv9pbUPfvoTg4cC9uGBPXQ8vu0h9zr4knurjGnys0ul7+9
 zm+tADGByHw2QMtG1DYwT1AcjbpvfPb4kOC3rwWMfT7clAPakE/6FVPpj9cM6eZLu57y Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2u9pjqbw2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:13:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7D67Spc157066;
        Tue, 13 Aug 2019 06:10:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2u9nrenkb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 06:10:59 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7D6AwUK013181;
        Tue, 13 Aug 2019 06:10:58 GMT
Received: from abi.no.oracle.com (/10.172.144.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Aug 2019 23:10:58 -0700
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
Subject: [RFC 02/19] ktf: Introduce the main part of the kernel side of ktf
Date:   Tue, 13 Aug 2019 08:09:17 +0200
Message-Id: <524b4e062500c6a240d4d7c0e1d0a2996800cc0a.1565676440.git-series.knut.omang@oracle.com>
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

The ktf module itself and basic data structures for management
of test cases and tests and contexts for tests.
Also contains the top level include file for kernel clients
in ktf.h.

More elaborate documentation follows towards the end of the
patch set.

This patch set contains both user level and kernel code,
we'll provide the full implementation of ktf on the kernel side in
this and forthcoming patches, then the user space code to execute
tests within the kernel and report results, then documentation
before introducing a small self test suite of tests to test ktf
itself, and some very simple additional example tests.

ktf.h:           Defines the KTF user API for kernel clients
ktf_test.c:      Kernel side code for tracking and reporting ktf test results

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 tools/testing/selftests/ktf/kernel/Makefile      |  15 +-
 tools/testing/selftests/ktf/kernel/ktf.h         | 604 ++++++++++++++++-
 tools/testing/selftests/ktf/kernel/ktf_context.c | 409 +++++++++++-
 tools/testing/selftests/ktf/kernel/ktf_test.c    | 397 +++++++++++-
 tools/testing/selftests/ktf/kernel/ktf_test.h    | 381 ++++++++++-
 5 files changed, 1806 insertions(+)
 create mode 100644 tools/testing/selftests/ktf/kernel/Makefile
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf.h
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_context.c
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_test.c
 create mode 100644 tools/testing/selftests/ktf/kernel/ktf_test.h

diff --git a/tools/testing/selftests/ktf/kernel/Makefile b/tools/testing/selftests/ktf/kernel/Makefile
new file mode 100644
index 0000000..0897ae2
--- /dev/null
+++ b/tools/testing/selftests/ktf/kernel/Makefile
@@ -0,0 +1,15 @@
+# Copyright (c) 2011, 2018, Oracle and/or its affiliates. All rights reserved.
+#
+# SPDX-License-Identifier: GPL-2.0
+#
+# Implementation of the kernel part of Kernel Test Framework (KTF),
+# a framework for running unit test like tests within the kernel.
+#
+
+obj-m := ktf.o
+
+include $(srctree)/$(src)/../scripts/ktf_syms.mk
+
+ktf-y := ktf_context.o ktf_nl.o ktf_map.o ktf_test.o ktf_debugfs.o ktf_cov.o \
+	 ktf_override.o ktf_netctx.o
+
diff --git a/tools/testing/selftests/ktf/kernel/ktf.h b/tools/testing/selftests/ktf/kernel/ktf.h
new file mode 100644
index 0000000..ea270e7
--- /dev/null
+++ b/tools/testing/selftests/ktf/kernel/ktf.h
@@ -0,0 +1,604 @@
+/*
+ * Copyright (c) 2018, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Knut Omang <knut.omang@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * ktf.h: Defines the KTF user API for kernel clients
+ */
+#ifndef _KTF_H
+#define _KTF_H
+
+#include <linux/completion.h>
+#include <linux/kprobes.h>
+#include <linux/kthread.h>
+#include <linux/ptrace.h>
+#include "ktf_test.h"
+#include "ktf_override.h"
+#include "ktf_map.h"
+#include "ktf_unlproto.h"
+
+#define	KTF_MAX_LOG			2048
+
+/* Type for an optional configuration callback for contexts.
+ * Implementations should copy and store data into their private
+ * extensions of the context structure. The data pointer is
+ * only valid inside the callback:
+ */
+typedef int (*ktf_config_cb)(struct ktf_context *ctx, const void* data, size_t data_sz);
+typedef void (*ktf_context_cb)(struct ktf_context *ctx);
+
+struct ktf_context_type;
+
+struct ktf_context {
+	struct ktf_map_elem elem;  /* Linkage for ctx_map in handle */
+	char name[KTF_MAX_KEY];	   /* Context name used in map */
+	struct ktf_handle *handle; /* Owner of this context */
+	ktf_config_cb config_cb;   /* Optional configuration callback */
+	ktf_context_cb cleanup;	   /* Optional callback upon context release */
+	int config_errno;	   /* If config_cb set: state of configuration */
+	struct ktf_context_type *type; /* Associated type, must be set */
+};
+
+typedef struct ktf_context* (*ktf_context_alloc)(struct ktf_context_type *ct);
+
+struct ktf_context_type {
+	struct ktf_map_elem elem;  /* Linkage for map in handle */
+	char name[KTF_MAX_KEY];	   /* Context type name */
+	struct ktf_handle *handle; /* Owner of this context type */
+	ktf_context_alloc alloc;   /* Allocate a new context of this type */
+	ktf_config_cb config_cb;   /* Configuration callback */
+	ktf_context_cb cleanup;	   /* Optional callback upon context release */
+};
+
+#include "ktf_netctx.h"
+
+/* type for a test function */
+struct ktf_test;
+
+/* state of running test, used to pass to threads spawned by test. */
+struct ktf_test_state;
+
+struct ktf_thread {
+	int (*func)(void *);
+	const char *name;
+	struct task_struct *task;
+	struct ktf_test_state state;
+	struct completion started;
+	struct completion completed;
+};
+
+typedef void (*ktf_test_adder)(void);
+
+/* Generic setup function for client modules */
+void ktf_add_tests(ktf_test_adder f);
+int ktf_context_add(struct ktf_handle *handle, struct ktf_context* ctx,
+		    const char* name, ktf_config_cb cfg_cb, const char *type);
+struct ktf_context *ktf_context_add_from(struct ktf_handle *handle, const char *name,
+					 struct ktf_context_type *ct);
+const char *ktf_context_name(struct ktf_context *ctx);
+struct ktf_context* ktf_find_context(struct ktf_handle *handle, const char* name);
+struct ktf_context *ktf_find_first_context(struct ktf_handle *handle);
+struct ktf_context *ktf_find_next_context(struct ktf_context* ctx);
+void ktf_context_remove(struct ktf_context *ctx);
+size_t ktf_has_contexts(struct ktf_handle *handle);
+void ktf_context_remove_all(struct ktf_handle *handle);
+
+/* Called by framework when a configuration is supplied,
+ * returns the return value of the configuration callback.
+ */
+int ktf_context_set_config(struct ktf_context *ctx, const void* data, size_t data_sz);
+
+struct ktf_context *ktf_find_create_context(struct ktf_handle *handle, const char *name,
+					    const char *type_name);
+int ktf_handle_add_ctx_type(struct ktf_handle *handle, struct ktf_context_type *ct);
+struct ktf_context_type *ktf_handle_get_ctx_type(struct ktf_handle *handle,
+						 const char *type_name);
+
+/* Declare the implicit __test_handle as extern for .c files that use it
+ * when adding tests with ADD_TEST but where definition is in another .c file:
+ */
+extern struct ktf_handle __test_handle;
+
+/* Add/remove/find a context to/from the default handle */
+#define KTF_CONTEXT_ADD(__context, name) \
+	ktf_context_add(&__test_handle, __context, name, NULL, "default")
+#define KTF_CONTEXT_ADD_CFG(__context, name, __cb, __type_name)  \
+	ktf_context_add(&__test_handle, __context, name, __cb, __type_name)
+#define KTF_CONTEXT_FIND(name) ktf_find_context(&__test_handle, name)
+#define KTF_CONTEXT_GET(name, type) \
+	container_of(KTF_CONTEXT_FIND(name), type, k)
+
+/* Add/remove/find a context to/from a given handle */
+#define KTF_CONTEXT_ADD_TO(__handle, __context, name)		\
+	ktf_context_add(&__handle, __context, name, NULL, "default")
+#define KTF_CONTEXT_ADD_TO_CFG(__handle, __context, name, __cb, __type_name) \
+	ktf_context_add(&__handle, __context, name, __cb, __type_name)
+#define KTF_CONTEXT_FIND_IN(__handle, name) ktf_find_context(&__handle, name)
+#define KTF_CONTEXT_GET_IN(__handle, name, type) \
+	container_of(KTF_CONTEXT_FIND_IN(__handle, name), type, k)
+
+/* check if a context has been configured (if needed) */
+#define KTF_CONTEXT_CFG_OK(__context) \
+	(__context->config_cb && !__context->config_errno)
+#define KTF_CONTEXT_REMOVE(__context) ktf_context_remove(__context)
+
+/* Part of KTF support for hybrid tests: Safe get the out-of-band user data
+ * Silently return (ignoring the test) if no data is available.
+ * This is to avoid failing if a generic user program without
+ * specific support for the hybrid test attempts to run the test.
+ * Fail if an object of an unexpected size is provided.
+ */
+#define KTF_USERDATA(__kt_ptr, __priv_datatype, __priv_data)			\
+	struct __priv_datatype *__priv_data = (struct __priv_datatype *)__kt_ptr->data; \
+	if (!__priv_data) return; \
+	ASSERT_LONG_EQ(__kt_ptr->data_sz, sizeof(struct __priv_datatype))
+
+/* KTF support for entry/return probes (via kprobes kretprobes).  We use
+ * kretprobes as they support entry/return and do not induce panics when
+ * mixed with gkdb usage.
+ */
+
+#if (defined(CONFIG_KPROBES) && defined(CONFIG_KRETPROBES) && \
+    (defined(CONFIG_X86_64) || defined(CONFIG_ARM) || \
+     defined(CONFIG_ARM64) || defined(CONFIG_SPARC)))
+#define KTF_PROBE_SUPPORT
+#else
+static inline int ktf_no_probe_support(void)
+{
+	twarn("No support for k[ret]probes, or platform not supported.")
+	return -ENOTSUPP);
+}
+#endif
+
+/* Entry/return probe - type is handler type (entry_handler for entry,
+ * handler for return), func is function to be probed; probehandler is name
+ * of probe handling function we will invoke on entry/return.
+ */
+#define KTF_PROBE(type, func, probehandler) \
+	static int probehandler(struct kretprobe_instance *, struct pt_regs *);\
+	static struct kretprobe __ktf_##type##_##probehandler = { \
+		.type = probehandler, \
+		.data_size = 0, \
+		.maxactive = 0, \
+		.kp = { \
+			.symbol_name    = #func, \
+		}, \
+	}; \
+	static int probehandler(struct kretprobe_instance *ri, \
+				struct pt_regs *regs)
+
+#ifdef KTF_PROBE_SUPPORT
+#define KTF_REGISTER_PROBE(type, func, probehandler) \
+	register_kretprobe(&__ktf_##type##_##probehandler)
+#else
+#define	KTF_REGISTER_PROBE(type, func, probehandler) \
+	ktf_no_probe_support()
+#endif
+
+/* Note on the complexity below - to re-use a statically-defined kretprobe for
+ * registration, we need to clean up state in the struct kretprobe.  Hence
+ * we zero out the kretprobe and re-set the symbol name/handler.  Not doing
+ * this means that re-registering fails with -EINVAL.
+ */
+#define KTF_UNREGISTER_PROBE(type, func, probehandler) \
+	do { \
+		unregister_kretprobe(&__ktf_##type##_##probehandler); \
+		memset(&__ktf_##type##_##probehandler, 0, \
+		       sizeof(struct kretprobe)); \
+		__ktf_##type##_##probehandler.kp.symbol_name = #func; \
+		__ktf_##type##_##probehandler.type = probehandler; \
+	} while (0)
+
+#define KTF_ENTRY_PROBE(func, probehandler)     \
+	KTF_PROBE(entry_handler, func, probehandler)
+
+#define KTF_REGISTER_ENTRY_PROBE(func, probehandler) \
+	KTF_REGISTER_PROBE(entry_handler, func, probehandler)
+
+/* arch-specific calling conventions for kretprobes entry handlers.  Define
+ * more args/architectures if needed.
+ */
+#ifdef KTF_PROBE_SUPPORT
+#ifdef CONFIG_X86_64
+#define	KTF_ENTRY_PROBE_ARG0		(regs->di)
+#define	KTF_ENTRY_PROBE_ARG1		(regs->si)
+#endif /* CONFIG_X86_64 */
+#ifdef CONFIG_ARM
+#define	KTF_ENTRY_PROBE_ARG0		(regs->regs[0])
+#define	KTF_ENTRY_PROBE_ARG1		(regs->regs[1])
+#endif /* CONFIG_ARM */
+#ifdef CONFIG_ARM64
+#define	KTF_ENTRY_PROBE_ARG0		(regs->regs[0])
+#define	KTF_ENTRY_PROBE_ARG1		(regs->regs[1])
+#endif /* CONFIG_ARM64 */
+#ifdef CONFIG_SPARC
+#define	KTF_ENTRY_PROBE_ARG0		(regs->u_regs[UREG_I0])
+#define	KTF_ENTRY_PROBE_ARG1		(regs->u_regs[UREG_I1])
+#endif /* CONFIG_SPARC */
+#endif /* KTF_PROBE_SUPPORT */
+
+/* For unsupported platforms. */
+#ifndef KTF_ENTRY_PROBE_ARG0
+#define	KTF_ENTRY_PROBE_ARG0		(0)
+#define	KTF_ENTRY_PROBE_ARG1		(1)
+#endif
+
+#define KTF_ENTRY_PROBE_RETURN(retval) \
+	do { \
+		return retval; \
+	} while (0)
+
+#define	KTF_UNREGISTER_ENTRY_PROBE(func, probehandler) \
+	KTF_UNREGISTER_PROBE(entry_handler, func, probehandler)
+
+/* KTF support for return probes (via kprobes kretprobes) */
+#define	KTF_RETURN_PROBE(func, probehandler)	\
+	KTF_PROBE(handler, func, probehandler)
+
+#define	KTF_REGISTER_RETURN_PROBE(func, probehandler) \
+	KTF_REGISTER_PROBE(handler, func, probehandler)
+
+/* KTF_*RETURN_VALUE() definitions for use within KTF_RETURN_PROBE() {} only. */
+
+#define KTF_RETURN_VALUE()	regs_return_value(regs)
+
+#ifdef KTF_PROBE_SUPPORT
+#ifdef CONFIG_X86_64
+#define KTF_SET_RETURN_VALUE(value)     regs->ax = (value)
+#endif /* CONFIG_X86_64 */
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+#define	KTF_SET_RETURN_VALUE(value)	regs->regs[0] = (value)
+#endif /* CONFIG_ARM[64] */
+#if defined(CONFIG_SPARC)
+#define	KTF_SET_RETURN_VALUE(value)	regs->u_regs[UREG_I0] = (value)
+#endif /* CONFIG_SPARC */
+#endif /* KTF_PROBE_SUPPORT */
+
+/* For unsupported platforms. */
+#ifndef KTF_PROBE_SUPPORT
+#define	KTF_SET_RETURN_VALUE(value)	do { } while (0)
+#endif /* KTF_PROBE_SUPPORT */
+
+#define KTF_UNREGISTER_RETURN_PROBE(func, probehandler) \
+	KTF_UNREGISTER_PROBE(handler, func, probehandler)
+
+#define	KTF_OVERRIDE(func, probehandler) \
+	static int probehandler(struct kprobe *, struct pt_regs *);\
+	static struct kprobe __ktf_override_##probehandler = { \
+		.symbol_name = #func, \
+		.pre_handler = probehandler, \
+		.post_handler = ktf_post_handler, \
+		.fault_handler = NULL, \
+		.flags = 0, \
+        }; \
+        static int probehandler(struct kprobe *kp, struct pt_regs *regs)
+
+#ifdef KTF_PROBE_SUPPORT
+#define	KTF_REGISTER_OVERRIDE(func, probehandler) \
+	ktf_register_override(&__ktf_override_##probehandler)
+#else
+#define	KTF_REGISTER_OVERRIDE(func, probehandler) \
+	ktf_no_probe_support()
+#endif
+
+#define	KTF_UNREGISTER_OVERRIDE(func, probehandler) \
+	do { \
+		unregister_kprobe(&__ktf_override_##probehandler); \
+		memset(&__ktf_override_##probehandler, 0, \
+		       sizeof(struct kprobe)); \
+		__ktf_override_##probehandler.symbol_name = #func; \
+		__ktf_override_##probehandler.pre_handler = probehandler; \
+		__ktf_override_##probehandler.post_handler = ktf_post_handler; \
+	} while (0)
+
+
+#define	KTF_OVERRIDE_RETURN \
+	do { \
+		ktf_override_function_with_return(regs); \
+		return 1; \
+	} while (0)
+
+#ifdef KTF_PROBE_SUPPORT
+#define	KTF_SET_INSTRUCTION_POINTER(regs, value) \
+	instruction_pointer_set(regs, (value))
+#else
+#define	KTF_SET_INSTRUCTION_POINTER(regs, value)	do { } while (0)
+#endif
+
+/* Interfaces for creating kthreads in tests. */
+#define	KTF_THREAD_INIT(threadname, t) \
+	do { \
+		(t)->func = threadname; \
+		(t)->name = #threadname; \
+		(t)->state.self = self; \
+		(t)->state.ctx = ctx; \
+		(t)->state.iter = _i; \
+		(t)->state.value = _value; \
+		init_completion(&((t)->started)); \
+		init_completion(&((t)->completed)); \
+	} while (0)
+
+#define	KTF_THREAD_RUN(t) \
+	((t)->task = kthread_run((t)->func, t, (t)->name))
+
+#define KTF_THREAD_STOP(t) \
+	do { \
+		if ((t)->task) \
+			kthread_stop((t)->task); \
+	} while (0)
+
+/* Wraps thread execution to supply same variables as test case - this allows
+ * us to define assertions etc in thread context.
+ */
+#define	KTF_THREAD(name) \
+	static void __##name(struct ktf_thread *thread, struct ktf_test *self, \
+			     struct ktf_context *ctx, int _i, u32 _value); \
+	static int name(void *data) \
+	{ \
+		struct ktf_thread *t = data; \
+		complete(&t->started); \
+		__##name(t, t->state.self, t->state.ctx, t->state.iter, \
+			 t->state.value); \
+		complete(&t->completed); \
+		return 0; \
+	} \
+	static void __##name(struct ktf_thread *_thread, struct ktf_test *self,\
+			     struct ktf_context *ctx, int _i, u32 _value)
+
+#define	KTF_THREAD_WAIT_STARTED(t)	(wait_for_completion(&((t)->started)))
+#define	KTF_THREAD_WAIT_COMPLETED(t)	(wait_for_completion(&((t)->completed)))
+
+u32 ktf_get_assertion_count(void);
+
+/**
+ * ASSERT_TRUE() - fail and return if @C evaluates to false
+ * @C: Boolean expression to evaluate
+ *
+ */
+#define ASSERT_TRUE(C) do { \
+		if (!ktf_assert((C))) return;	\
+	} while (0)
+
+/**
+ * ASSERT_FALSE() - fail and return if @C evaluates to true
+ * @C: Boolean expression to evaluate
+ */
+#define ASSERT_FALSE(C) do { \
+		if (!ktf_assert(!(C))) return;	\
+	} while (0)
+
+/**
+ * ASSERT_TRUE_GOTO() - fail and jump to @_lbl if @C evaluates to false
+ * @C: Boolean expression to evaluate
+ * @_lbl: Label to jump to in case of failure
+ */
+#define ASSERT_TRUE_GOTO(C,_lbl) {		\
+	if (!ktf_assert((C))) goto _lbl;\
+}
+
+/**
+ * ASSERT_FALSE_GOTO() - fail and jump to @_lbl if @C evaluates to true
+ * @C: Boolean expression to evaluate
+ * @_lbl: Label to jump to in case of failure
+ */
+#define ASSERT_FALSE_GOTO(C,_lbl) {		\
+	if (!ktf_assert(!(C))) goto _lbl;\
+}
+
+/**
+ * ASSERT_TRUE_RETVAL() - fail and return @V if @C evaluates to false
+ * @C: Boolean expression to evaluate
+ * @V: Value to return on failure
+ */
+#define ASSERT_TRUE_RETVAL(C, V) do { \
+	if (!ktf_assert((C))) return V;	\
+} while (0)
+
+/**
+ * ASSERT_FALSE() - fail and return @V if @C evaluates to true
+ * @C: Boolean expression to evaluate
+ * @V: Value to return on failure
+ */
+#define ASSERT_FALSE_RETVAL(C, V) do { \
+	if (!ktf_assert(!(C))) return V;	\
+} while (0)
+
+/**
+ * ASSERT_TRUE_CONT() - fail and continue if @C evaluates to false
+ * @C: Boolean expression to evaluate
+ */
+#define ASSERT_TRUE_CONT(C) { \
+	if (!ktf_assert((C))) continue; \
+}
+
+/**
+ * ASSERT_FALSE_CONT() - fail and continue if @C evaluates to true
+ * @C: Boolean expression to evaluate
+ */
+#define ASSERT_FALSE_CONT(C) { \
+	if (!ktf_assert(!(C))) continue; \
+}
+
+/**
+ * ASSERT_TRUE_BREAK() - fail and break if @C evaluates to false
+ * @C: Boolean expression to evaluate
+ */
+#define ASSERT_TRUE_BREAK(C) { \
+	if (!ktf_assert((C))) break; \
+}
+
+/**
+ * ASSERT_FALSE_BREAK() - fail and break if @C evaluates to true
+ * @C: Boolean expression to evaluate
+ */
+#define ASSERT_FALSE_BREAK(C) { \
+	if (!ktf_assert(!(C))) break; \
+}
+
+/**
+ * ASSERT_LONG_EQ() - compare two longs, fail and return if @X != @Y
+ * @X: Expected value
+ * @Y: Actual value
+ */
+#define ASSERT_LONG_EQ(X, Y) \
+	ktf_assert_long_ret(X, ==, Y);
+
+#define ASSERT_LONG_NE(X, Y) \
+	ktf_assert_long_ret(X, !=, Y);
+
+#define ASSERT_ADDR_EQ(X, Y) \
+	ktf_assert_long_ret((u64)(X), ==, (u64)(Y));
+
+#define ASSERT_ADDR_NE(X, Y) \
+	ktf_assert_long_ret((u64)(X), !=, (u64)(Y));
+
+#define ASSERT_INT_EQ(X, Y) \
+	ktf_assert_int_ret(X, ==, Y);
+
+#define ASSERT_INT_GT(X, Y) \
+	ktf_assert_int_ret(X, >, Y);
+
+/**
+ * ASSERT_LONG_EQ() - compare two longs, jump to @_lbl if @X != @Y
+ * @X: Expected value
+ * @Y: Actual value
+ * @_lbl: Label to jump to in case of failure
+ */
+#define ASSERT_LONG_EQ_GOTO(X, Y, _lbl) \
+	ktf_assert_long_goto(X, ==, Y, _lbl)
+
+#define ASSERT_LONG_NE_GOTO(X, Y, _lbl) \
+	ktf_assert_long_goto(X, !=, Y, _lbl)
+
+#define ASSERT_ADDR_EQ_GOTO(X, Y, _lbl) \
+	ktf_assert_long_goto((u64)(X), ==, (u64)(Y), _lbl)
+
+#define ASSERT_ADDR_NE_GOTO(X, Y, _lbl) \
+	ktf_assert_long_goto((u64)(X), !=, (u64)(Y), _lbl)
+
+#define ASSERT_INT_EQ_GOTO(X, Y, _lbl) \
+	ktf_assert_int_goto(X, ==, Y, _lbl)
+
+#define ASSERT_INT_GE_GOTO(X, Y, _lbl) \
+	ktf_assert_int_goto(X, >=, Y, _lbl)
+
+#define ASSERT_INT_GT_GOTO(X, Y, _lbl) \
+	ktf_assert_int_goto(X, >, Y, _lbl)
+
+#define ASSERT_INT_LT_GOTO(X, Y, _lbl) \
+	ktf_assert_int_goto(X, <, Y, _lbl)
+
+#define ASSERT_INT_NE(X,Y) \
+	ktf_assert_int_ret(X, !=, Y);
+
+#define ASSERT_INT_NE_GOTO(X,Y,_lbl) \
+	ktf_assert_int_goto(X, !=, Y, _lbl);
+
+/**
+ * EXPECT_TRUE() - fail if @C evaluates to false but allow test to continue
+ * @C: Boolean expression to evaluate
+ *
+ */
+#define EXPECT_TRUE(C) ktf_assert(C)
+#define EXPECT_FALSE(C) ktf_assert(!(C))
+
+#define OK_ADDR(X) (X && !IS_ERR(X))
+
+/* Valid kernel address check */
+#define EXPECT_OK_ADDR(X) \
+	ktf_assert_msg(OK_ADDR(X), "Invalid pointer '"#X"' - was 0x%Lx", (X))
+
+#define ASSERT_OK_ADDR(X) do { \
+		if (!ktf_assert_msg(OK_ADDR(X), "Invalid pointer '"#X"' - value 0x%Lx", (X))) \
+			return;						\
+	} while (0)
+#define ASSERT_OK_ADDR_GOTO(X,_lbl) do { \
+		if (!ktf_assert_msg(OK_ADDR(X), "Invalid pointer '"#X"' - was 0x%Lx", (X))) \
+			goto _lbl;					\
+	} while (0)
+
+#define ASSERT_OK_ADDR_BREAK(X) do { \
+	if (!ktf_assert_msg(OK_ADDR(X), "Invalid pointer '"#X"' - was 0x%Lx", (X))) \
+		break; \
+	} while (0)
+
+#define EXPECT_INT_EQ(X,Y) ktf_assert_int(X, ==, Y)
+#define EXPECT_INT_GT(X,Y) ktf_assert_int(X, >, Y)
+#define EXPECT_INT_GE(X,Y) ktf_assert_int(X, >=, Y)
+#define EXPECT_INT_LE(X,Y) ktf_assert_int(X, <=, Y)
+#define EXPECT_INT_LT(X,Y) ktf_assert_int(X, <, Y)
+#define EXPECT_INT_NE(X,Y) ktf_assert_int(X, !=, Y)
+
+#define EXPECT_LONG_EQ(X, Y) ktf_assert_long(X, ==, Y)
+#define EXPECT_LONG_NE(X, Y) ktf_assert_long(X, !=, Y)
+#define EXPECT_ADDR_EQ(X, Y) ktf_assert_long((u64)(X), ==, (u64)(Y))
+#define EXPECT_ADDR_NE(X, Y) ktf_assert_long((u64)(X), !=, (u64)(Y))
+#define EXPECT_LONG_GT(X, Y) ktf_assert_long(X, >, Y)
+#define EXPECT_LONG_GE(X, Y) ktf_assert_long(X, >=, Y)
+#define EXPECT_LONG_LE(X, Y) ktf_assert_long(X, <=, Y)
+#define EXPECT_LONG_LT(X, Y) ktf_assert_long(X, <, Y)
+
+#define EXPECT_STREQ(X, Y) ktf_assert_str_eq(X, Y)
+#define EXPECT_STRNE(X, Y) ktf_assert_str_ne(X, Y)
+
+extern ulong ktf_debug_mask;
+
+/* Defined debug bits - higher values should represent more
+ * verbose categories:
+ */
+#define T_INFO		0x1
+#define T_LIST		0x2
+#define T_INTR	      0x200
+#define T_INFO_V      0x800
+#define T_DEBUG	     0x1000
+#define T_MCAST	     0x2000
+#define T_TRACE	   0x100000
+#define T_DEBUG_V  0x200000
+
+#define tlog(class, format, arg...)	\
+	do { \
+		if (unlikely((ktf_debug_mask) & (class)))	\
+			printk(KERN_INFO \
+				   "ktf pid [%d] " "%s: " format "\n", \
+				   current->pid, __func__, \
+				   ## arg); \
+	} while (0)
+#define twarn(format, arg...)	\
+	do { \
+		printk(KERN_WARNING				       \
+		       "ktf pid [%d] " "%s: " format "\n",	       \
+		       current->pid, __func__,			       \
+		       ## arg);				       \
+	} while (0)
+#define terr(format, arg...)	\
+	do { \
+		printk(KERN_ERR				       \
+		       "ktf pid [%d] " "%s: " format "\n",	       \
+		       current->pid, __func__,			       \
+		       ## arg);				       \
+	} while (0)
+#define tlogs(class, stmt_list) \
+	do { \
+		if (unlikely((ktf_debug_mask) & (class))) { \
+			stmt_list;\
+		} \
+	} while (0)
+
+
+/* Look up the current address of a potentially local symbol - to allow testing
+ * against it. NB! This is a hack for unit testing internal unexposed interfaces and
+ * violates the module boundaries and has no fw/bw comp gauarantees, but are
+ * still very useful for detailed unit testing complex logic:
+ */
+void* ktf_find_symbol(const char *mod, const char *sym);
+
+unsigned long ktf_symbol_size(unsigned long addr);
+
+#define ktf_resolve_symbol(mname, sname) \
+	do { \
+		sname = ktf_find_symbol(#mname, #sname);	\
+		if (!sname) \
+			return -ENOENT; \
+	} while (0)
+#endif
diff --git a/tools/testing/selftests/ktf/kernel/ktf_context.c b/tools/testing/selftests/ktf/kernel/ktf_context.c
new file mode 100644
index 0000000..5ff57a9
--- /dev/null
+++ b/tools/testing/selftests/ktf/kernel/ktf_context.c
@@ -0,0 +1,409 @@
+/*
+ * Copyright (c) 2009, 2017, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Knut Omang <knut.omang@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * kft_context.c: Main part of ktf kernel module that implements a generic
+ *   unit test framework for tests written in kernel code, with support for
+ *   gtest (googletest) user space tools for invocation and reporting.
+ */
+
+#include <linux/module.h>
+#include <linux/kallsyms.h>
+#include <rdma/ib_verbs.h>
+#include "ktf.h"
+#include "ktf_test.h"
+#include "ktf_debugfs.h"
+#include "ktf_nl.h"
+
+MODULE_LICENSE("GPL");
+
+ulong ktf_debug_mask = T_INFO;
+EXPORT_SYMBOL(ktf_debug_mask);
+
+static unsigned int ktf_context_maxid;
+
+/* The role of context_lock is to synchronize modifications to
+ * the global list of context handles (handles that have contexts
+ * associated with them) and the context map.
+ * The map object has it's own locking, but must be kept in sync
+ * with changes to the global context list:
+ */
+static DEFINE_SPINLOCK(context_lock);
+
+/* global linked list of all ktf_handle objects that have contexts */
+LIST_HEAD(context_handles);
+
+module_param_named(debug_mask, ktf_debug_mask, ulong, 0644);
+
+static int __ktf_handle_add_ctx_type(struct ktf_handle *handle,
+				     struct ktf_context_type *ct,
+				     bool generic)
+{
+	unsigned long flags;
+	int ret;
+
+	if (generic && !(ct->alloc && ct->config_cb)) {
+		terr("Mandatory configuration callbacks or values missing!");
+		return -EINVAL;
+	}
+
+	ct->handle = handle;
+	ktf_map_elem_init(&ct->elem, ct->name);
+
+	spin_lock_irqsave(&context_lock, flags);
+	ret = ktf_map_insert(&handle->ctx_type_map, &ct->elem);
+	spin_unlock_irqrestore(&context_lock, flags);
+	return ret;
+}
+
+static int __ktf_context_add(struct ktf_handle *handle, struct ktf_context *ctx,
+			     const char *name, ktf_config_cb cfg_cb,
+			     struct ktf_context_type *ct)
+{
+	unsigned long flags;
+	int ret;
+
+	ktf_map_elem_init(&ctx->elem, name);
+	strncpy(ctx->name, name, KTF_MAX_NAME);
+	ctx->config_cb = cfg_cb;
+	ctx->config_errno = ENOENT; /* 0 here means configuration is ok */
+	ctx->type = ct;
+	ctx->cleanup = ct->cleanup;
+
+	spin_lock_irqsave(&context_lock, flags);
+	ret = ktf_map_insert(&handle->ctx_map, &ctx->elem);
+	if (!ret) {
+		ctx->handle = handle;
+		if (ktf_map_size(&handle->ctx_map) == 1) {
+			handle->id = ++ktf_context_maxid;
+			INIT_LIST_HEAD(&handle->handle_list);
+			list_add(&handle->handle_list, &context_handles);
+		}
+	}
+	spin_unlock_irqrestore(&context_lock, flags);
+	if (!ret)
+		tlog(T_DEBUG, "added %scontext %s with type %s",
+		     (cfg_cb ? "configurable " : ""), name, ct->name);
+	return ret;
+}
+
+int ktf_context_add(struct ktf_handle *handle, struct ktf_context *ctx,
+		    const char *name, ktf_config_cb cfg_cb,
+		    const char *type_name)
+{
+	struct ktf_context_type *ct = ktf_handle_get_ctx_type(handle, type_name);
+	int ret;
+
+	if (!ct) {
+		ct = kzalloc(sizeof(*ct), GFP_KERNEL);
+		if (!ct)
+			return -ENOMEM;
+		strncpy(ct->name, type_name, KTF_MAX_KEY);
+		ret = __ktf_handle_add_ctx_type(handle, ct, false);
+		if (ret) {
+			kfree(ct);
+			return ret;
+		}
+	}
+	return __ktf_context_add(handle, ctx, name, cfg_cb, ct);
+}
+EXPORT_SYMBOL(ktf_context_add);
+
+struct ktf_context *ktf_context_add_from(struct ktf_handle *handle, const char *name,
+					 struct ktf_context_type *ct)
+{
+	struct ktf_context *ctx;
+	int ret;
+
+	if (!ct->alloc) {
+		terr("No alloc function supplied!");
+		return NULL;
+	}
+	ctx = ct->alloc(ct);
+	if (!ctx)
+		return NULL;
+	ret = __ktf_context_add(handle, ctx, name, ct->config_cb, ct);
+	if (ret)
+		goto fail;
+
+	ctx->cleanup = ct->cleanup;
+	return ctx;
+fail:
+	kfree(ctx);
+	return NULL;
+}
+EXPORT_SYMBOL(ktf_context_add_from);
+
+int ktf_context_set_config(struct ktf_context *ctx, const void *data, size_t data_sz)
+{
+	int ret;
+
+	if (ctx->config_cb) {
+		ret = ctx->config_cb(ctx, data, data_sz);
+		ctx->config_errno = ret;
+	}
+	return ctx->config_errno;
+}
+EXPORT_SYMBOL(ktf_context_set_config);
+
+const char *ktf_context_name(struct ktf_context *ctx)
+{
+	return ctx->elem.key;
+}
+EXPORT_SYMBOL(ktf_context_name);
+
+void ktf_context_remove(struct ktf_context *ctx)
+{
+	struct ktf_handle *handle;
+	unsigned long flags = 0;
+
+	if (!ctx) {
+		terr("A test case tried to remove an invalid context!");
+		return;
+	}
+	handle = ctx->handle;
+
+	spin_lock_irqsave(&context_lock, flags);
+	ktf_map_remove(&handle->ctx_map, ctx->elem.key);
+	if (!ktf_has_contexts(handle))
+		list_del(&handle->handle_list);
+	spin_unlock_irqrestore(&context_lock, flags);
+
+	tlog(T_DEBUG, "removed context %s at %p", ctx->elem.key, ctx);
+
+	if (ctx->cleanup)
+		ctx->cleanup(ctx);
+	/* Note: ctx may be freed here! */
+}
+EXPORT_SYMBOL(ktf_context_remove);
+
+struct ktf_context *ktf_find_first_context(struct ktf_handle *handle)
+{
+	struct ktf_map_elem *elem = ktf_map_find_first(&handle->ctx_map);
+
+	if (elem)
+		return container_of(elem, struct ktf_context, elem);
+	return NULL;
+}
+
+struct ktf_context *ktf_find_context(struct ktf_handle *handle, const char *name)
+{
+	struct ktf_map_elem *elem;
+
+	if (!name)
+		return NULL;
+	elem = ktf_map_find(&handle->ctx_map, name);
+	if (!elem)
+		return NULL;
+	return container_of(elem, struct ktf_context, elem);
+}
+EXPORT_SYMBOL(ktf_find_context);
+
+struct ktf_context *ktf_find_create_context(struct ktf_handle *handle, const char *name,
+					    const char *type_name)
+{
+	struct ktf_context *ctx = ktf_find_context(handle, name);
+
+	if (!ctx) {
+		struct ktf_context_type *ct = ktf_handle_get_ctx_type(handle, type_name);
+
+		tlog(T_DEBUG, "type = %s, ct = %p", type_name, ct);
+		if (ct)
+			ctx = ktf_context_add_from(handle, name, ct);
+	}
+	return ctx;
+}
+
+struct ktf_context *ktf_find_next_context(struct ktf_context *ctx)
+{
+	struct ktf_map_elem *elem = ktf_map_find_next(&ctx->elem);
+
+	return container_of(elem, struct ktf_context, elem);
+}
+
+size_t ktf_has_contexts(struct ktf_handle *handle)
+{
+	return ktf_map_size(&handle->ctx_map) > 0;
+}
+EXPORT_SYMBOL(ktf_has_contexts);
+
+void ktf_context_remove_all(struct ktf_handle *handle)
+{
+	struct ktf_context *curr;
+
+	if (!ktf_has_contexts(handle))
+		return;
+
+	for (;;) {
+		curr = ktf_find_first_context(handle);
+		if (!curr)
+			break;
+		ktf_context_remove(curr);
+	}
+}
+EXPORT_SYMBOL(ktf_context_remove_all);
+
+/* Find the handle associated with handle id hid */
+struct ktf_handle *ktf_handle_find(int hid)
+{
+	struct ktf_handle *handle = NULL;
+
+	list_for_each_entry(handle, &context_handles, handle_list) {
+		if (handle->id == hid)
+			break;
+	}
+	return handle;
+}
+
+/* Allow user space to create new contexts of certain types
+ * based on configuration types. This allocates a new, uniquely named
+ * context type to enable it for user space usage. Caller must allocate and populate
+ * @ct with appropriate callbacks and value for the context type.
+ */
+
+int ktf_handle_add_ctx_type(struct ktf_handle *handle,
+			    struct ktf_context_type *ct)
+{
+	return __ktf_handle_add_ctx_type(handle, ct, true);
+}
+EXPORT_SYMBOL(ktf_handle_add_ctx_type);
+
+struct ktf_context_type *ktf_handle_get_ctx_type(struct ktf_handle *handle,
+						 const char *type_name)
+{
+	struct ktf_map_elem *elem = ktf_map_find(&handle->ctx_type_map, type_name);
+
+	tlog(T_DEBUG, "Lookup %s in map size %lu = %p\n", type_name,
+	     ktf_map_size(&handle->ctx_type_map), elem);
+	if (!elem)
+		return NULL;
+	return container_of(elem, struct ktf_context_type, elem);
+}
+
+void ktf_handle_cleanup_check(struct ktf_handle *handle)
+{
+	struct ktf_context *curr;
+	unsigned long flags;
+
+	if (!ktf_has_contexts(handle))
+		return;
+
+	spin_lock_irqsave(&context_lock, flags);
+
+	for (curr = ktf_find_first_context(handle);
+	     curr;
+	     curr = ktf_find_next_context(curr)) {
+		twarn("context %s found during handle %p cleanup", curr->elem.key, handle);
+	}
+	spin_unlock_irqrestore(&context_lock, flags);
+}
+EXPORT_SYMBOL(ktf_handle_cleanup_check);
+
+struct ktf_kernel_internals {
+	/* From module.h: Look up a module symbol - supports syntax module:name */
+	unsigned long (*module_kallsyms_lookup_name)(const char *name);
+	/* From kallsyms.h: Look up a symbol w/size and offset */
+	unsigned long (*kallsyms_lookup_size_offset)(unsigned long addr,
+						     unsigned long *symbolsize,
+						     unsigned long *offset);
+};
+
+static struct ktf_kernel_internals ki;
+
+static int __init ktf_init(void)
+{
+	int ret;
+	char *ks = "module_kallsyms_lookup_name";
+
+	/* We rely on being able to resolve this symbol for looking up module
+	 * specific internal symbols (multiple modules may define the same symbol):
+	 */
+	ki.module_kallsyms_lookup_name = (void *)kallsyms_lookup_name(ks);
+	if (!ki.module_kallsyms_lookup_name) {
+		terr("Unable to look up \"%s\" in kallsyms - maybe interface has changed?",
+		     ks);
+		return -EINVAL;
+	}
+	ks = "kallsyms_lookup_size_offset";
+	ki.kallsyms_lookup_size_offset = (void *)kallsyms_lookup_name(ks);
+	if (!ki.kallsyms_lookup_size_offset) {
+		terr("Unable to look up \"%s\" in kallsyms - maybe interface has changed?",
+		     ks);
+		return -EINVAL;
+	}
+
+	ktf_debugfs_init();
+	ret = ktf_nl_register();
+	if (ret) {
+		terr("Unable to register protocol with netlink");
+		ktf_debugfs_cleanup();
+		goto failure;
+	}
+
+	return 0;
+failure:
+	return ret;
+}
+
+static void __exit ktf_exit(void)
+{
+	ktf_nl_unregister();
+	ktf_cleanup();
+}
+
+/* Generic setup function for client modules */
+void ktf_add_tests(ktf_test_adder f)
+{
+	f();
+}
+EXPORT_SYMBOL(ktf_add_tests);
+
+/* Support for looking up kernel/module internal symbols to enable testing.
+ * A NULL mod means either we want the kernel-internal symbol or don't care
+ * which module the symbol is in.
+ */
+void *ktf_find_symbol(const char *mod, const char *sym)
+{
+	char sm[200];
+	const char *symref;
+	unsigned long addr = 0;
+
+	if (mod) {
+		sprintf(sm, "%s:%s", mod, sym);
+		symref = sm;
+	} else {
+		/* Try for kernel-internal symbol first; fall back to modules
+		 * if that fails.
+		 */
+		symref = sym;
+		addr = kallsyms_lookup_name(symref);
+	}
+	if (!addr)
+		addr = ki.module_kallsyms_lookup_name(symref);
+	if (addr) {
+		tlog(T_DEBUG, "Found %s at %0lx\n", sym, addr);
+	} else {
+#ifndef CONFIG_KALLSYMS_ALL
+		twarn("CONFIG_KALLSYMS_ALL is not set, so non-exported symbols are not available\n");
+#endif
+		tlog(T_INFO, "Fatal error: %s not found\n", sym);
+		return NULL;
+	}
+	return (void *)addr;
+}
+EXPORT_SYMBOL(ktf_find_symbol);
+
+unsigned long ktf_symbol_size(unsigned long addr)
+{
+	unsigned long size = 0;
+
+	(void)ki.kallsyms_lookup_size_offset(addr, &size, NULL);
+
+	return size;
+}
+EXPORT_SYMBOL(ktf_symbol_size);
+
+module_init(ktf_init);
+module_exit(ktf_exit);
diff --git a/tools/testing/selftests/ktf/kernel/ktf_test.c b/tools/testing/selftests/ktf/kernel/ktf_test.c
new file mode 100644
index 0000000..1e287d0
--- /dev/null
+++ b/tools/testing/selftests/ktf/kernel/ktf_test.c
@@ -0,0 +1,397 @@
+/*
+ * Copyright (c) 2009, 2017, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Knut Omang <knut.omang@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * ktf_test.c: Kernel side code for tracking and reporting ktf test results
+ */
+#include <linux/module.h>
+#include <linux/time.h>
+#include "ktf_test.h"
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "ktf_nl.h"
+#include "ktf_unlproto.h"
+#include "ktf.h"
+#include "ktf_cov.h"
+#include "ktf_debugfs.h"
+
+#define MAX_PRINTF 4096
+
+/* Versioning check:
+ * For MAJOR or MINOR changes, both sides are required to
+ * have the same version.
+ * If MICRO has changed, some new functionality may have been added, but the
+ * old functionality should work as before.
+ * With only BUILD changes, the two versions are still compatible,
+ * but one might have bug fixes or minor enhancements.
+ */
+int ktf_version_check(u64 version)
+{
+	if (version != KTF_VERSION_LATEST) {
+		if (KTF_VERSION(MAJOR, version) == KTF_VERSION(MAJOR, KTF_VERSION_LATEST) &&
+		    KTF_VERSION(MINOR, version) == KTF_VERSION(MINOR, KTF_VERSION_LATEST))
+			return 0;
+		terr("KTF version mismatch - expected %llu.%llu.%llu.%llu, got %llu.%llu.%llu.%llu",
+		     KTF_VERSION(MAJOR, KTF_VERSION_LATEST),
+		     KTF_VERSION(MINOR, KTF_VERSION_LATEST),
+		     KTF_VERSION(MICRO, KTF_VERSION_LATEST),
+		     KTF_VERSION(BUILD, KTF_VERSION_LATEST),
+		     KTF_VERSION(MAJOR, version),
+		     KTF_VERSION(MINOR, version),
+		     KTF_VERSION(MICRO, version),
+		     KTF_VERSION(BUILD, version));
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int ktf_handle_version_check(struct ktf_handle *th)
+{
+	return ktf_version_check(th->version);
+}
+
+/* Function called when global references to test case reach 0. */
+static void ktf_case_free(struct ktf_map_elem *elem)
+{
+	struct ktf_case *tc = container_of(elem, struct ktf_case, kmap);
+
+	kfree(tc);
+}
+
+void ktf_case_get(struct ktf_case *tc)
+{
+	ktf_map_elem_get(&tc->kmap);
+}
+
+void ktf_case_put(struct ktf_case *tc)
+{
+	ktf_map_elem_put(&tc->kmap);
+}
+
+/* The global map from name to ktf_case */
+DEFINE_KTF_MAP(test_cases, NULL, ktf_case_free);
+
+/* a lock to protect this datastructure */
+static DEFINE_MUTEX(tc_lock);
+
+/* Current total number of test cases defined */
+size_t ktf_case_count(void)
+{
+	return ktf_map_size(&test_cases);
+}
+
+const char *ktf_case_name(struct ktf_case *tc)
+{
+	return tc->kmap.key;
+}
+
+static size_t ktf_case_test_count(struct ktf_case *tc)
+{
+	return ktf_map_size(&tc->tests);
+}
+
+/* Called when test refcount reaches 0. */
+static void ktf_test_free(struct ktf_map_elem *elem)
+{
+	struct ktf_test *t = container_of(elem, struct ktf_test, kmap);
+
+	kfree(t->log);
+	kfree(t);
+}
+
+void ktf_test_get(struct ktf_test *t)
+{
+	ktf_map_elem_get(&t->kmap);
+}
+
+void ktf_test_put(struct ktf_test *t)
+{
+	ktf_map_elem_put(&t->kmap);
+}
+
+static struct ktf_case *ktf_case_create(const char *name)
+{
+	struct ktf_case *tc = kmalloc(sizeof(*tc), GFP_KERNEL);
+	int ret;
+
+	if (!tc)
+		return tc;
+
+	/* Initialize test case map of tests. */
+	ktf_map_init(&tc->tests, NULL, ktf_test_free);
+	ret = ktf_map_elem_init(&tc->kmap, name);
+	if (ret) {
+		kfree(tc);
+		return NULL;
+	}
+	ktf_debugfs_create_testset(tc);
+	tlog(T_DEBUG, "ktf: Added test set %s\n", name);
+	return tc;
+}
+
+struct ktf_case *ktf_case_find(const char *name)
+{
+	return ktf_map_find_entry(&test_cases, name, struct ktf_case, kmap);
+}
+
+/* Returns with case refcount increased.  Called with tc_lock held. */
+static struct ktf_case *ktf_case_find_create(const char *name)
+{
+	struct ktf_case *tc;
+	int ret = 0;
+
+	tc = ktf_case_find(name);
+	if (!tc) {
+		tc = ktf_case_create(name);
+		if (tc) {
+			ret = ktf_map_insert(&test_cases, &tc->kmap);
+			if (ret) {
+				kfree(tc);
+				tc = NULL;
+			}
+		}
+	}
+	return tc;
+}
+
+static atomic_t assert_cnt = ATOMIC_INIT(0);
+
+void flush_assert_cnt(struct ktf_test *self)
+{
+	if (atomic_read(&assert_cnt)) {
+		tlog(T_DEBUG, "update: %d asserts", atomic_read(&assert_cnt));
+		if (self->skb)
+			nla_put_u32(self->skb, KTF_A_STAT, atomic_read(&assert_cnt));
+		atomic_set(&assert_cnt, 0);
+	}
+}
+
+u32 ktf_get_assertion_count(void)
+{
+	return atomic_read(&assert_cnt);
+}
+EXPORT_SYMBOL(ktf_get_assertion_count);
+
+static DEFINE_SPINLOCK(assert_lock);
+
+long _ktf_assert(struct ktf_test *self, int result, const char *file,
+		 int line, const char *fmt, ...)
+{
+	int len;
+	va_list ap;
+	char *buf;
+	char bufprefix[256];
+	unsigned long flags;
+
+	if (result) {
+		atomic_inc(&assert_cnt);
+	} else {
+		flush_assert_cnt(self);
+		buf = kmalloc(MAX_PRINTF, GFP_KERNEL);
+		if (!buf) {
+			terr("file %s line %d: Unable to allocate memory for the error report!",
+			     file, line);
+			goto out;
+		}
+		va_start(ap, fmt);
+		len = vsnprintf(buf, MAX_PRINTF - 1, fmt, ap);
+		buf[len] = 0;
+		va_end(ap);
+		if (self->skb) {
+			nla_put_u32(self->skb, KTF_A_STAT, result);
+			nla_put_string(self->skb, KTF_A_FILE, file);
+			nla_put_u32(self->skb, KTF_A_NUM, line);
+			nla_put_string(self->skb, KTF_A_STR, buf);
+		}
+		(void)snprintf(bufprefix, sizeof(bufprefix) - 1,
+				"file %s line %d: result %d: ", file, line,
+				result);
+		terr("%s%s", bufprefix, buf);
+
+		/* Multiple threads may try to update log */
+		spin_lock_irqsave(&assert_lock, flags);
+		(void)strncat(self->log, bufprefix, KTF_MAX_LOG);
+		(void)strncat(self->log, buf, KTF_MAX_LOG);
+		spin_unlock_irqrestore(&assert_lock, flags);
+		kfree(buf);
+	}
+out:
+	return result;
+}
+EXPORT_SYMBOL(_ktf_assert);
+
+/* Add a test to a testcase:
+ * Tests are represented by ktf_test objects that are linked into
+ * a per-test case map TCase:tests map.
+ */
+void  _ktf_add_test(struct __test_desc td, struct ktf_handle *th,
+		    int _signal, int allowed_exit_value,
+		    int start, int end)
+{
+	struct ktf_case *tc = NULL;
+	struct ktf_test *t;
+	char *log;
+
+	if (ktf_handle_version_check(th))
+		return;
+
+	log = kzalloc(KTF_MAX_LOG, GFP_KERNEL);
+	if (!log)
+		return;
+
+	t = kzalloc(sizeof(*t), GFP_KERNEL);
+	if (!t) {
+		kfree(log);
+		return;
+	}
+	t->tclass = td.tclass;
+	t->name = td.name;
+	t->fun = td.fun;
+	t->start = start;
+	t->end = end;
+	t->handle = th;
+	t->log = log;
+
+	mutex_lock(&tc_lock);
+	tc = ktf_case_find_create(td.tclass);
+	if (!tc || ktf_map_elem_init(&t->kmap, td.name) ||
+	    ktf_map_insert(&tc->tests, &t->kmap)) {
+		terr("Failed to add test %s from %s to test case \"%s\"",
+		     td.name, td.file, td.tclass);
+		if (tc)
+			ktf_case_put(tc);
+		mutex_unlock(&tc_lock);
+		kfree(log);
+		kfree(t);
+		return;
+	}
+
+	ktf_debugfs_create_test(t);
+
+	tlog(T_LIST, "Added test \"%s.%s\" start = %d, end = %d\n",
+	     td.tclass, td.name, start, end);
+
+	/* Now since we no longer reference tc/t outside of global map of test
+	 * cases and per-testcase map of tests, drop their refcounts.  This
+	 * is safe to do as refcounts are > 0 due to references for map
+	 * storage and debugfs.
+	 */
+	ktf_test_put(t);
+	ktf_case_put(tc);
+	mutex_unlock(&tc_lock);
+}
+EXPORT_SYMBOL(_ktf_add_test);
+
+void ktf_run_hook(struct sk_buff *skb, struct ktf_context *ctx,
+		  struct ktf_test *t, u32 value,
+		void *oob_data, size_t oob_data_sz)
+{
+	int i;
+
+	t->log[0] = '\0';
+	t->skb = skb;
+	t->data = oob_data;
+	t->data_sz = oob_data_sz;
+	for (i = t->start; i < t->end; i++) {
+		if (!ctx && t->handle->require_context) {
+			terr("Test %s.%s requires a context, but none configured!",
+			     t->tclass, t->name);
+			continue;
+		}
+		/* No need to bump refcnt, this is just for debugging.  Nothing
+		 * should reference the testcase via the handle's current test
+		 * pointer.
+		 */
+		t->handle->current_test = t;
+		tlogs(T_DEBUG,
+		      printk(KERN_INFO "Running test %s.%s", t->tclass, t->name);
+			if (ctx)
+				printk("_%s", ktf_context_name(ctx));
+			printk("[%d:%d]\n", t->start, t->end);
+		);
+		getnstimeofday(&t->lastrun);
+		t->fun(t, ctx, i, value);
+		flush_assert_cnt(t);
+	}
+	t->handle->current_test = NULL;
+}
+
+/* Clean up all tests associated with a ktf_handle */
+
+void ktf_test_cleanup(struct ktf_handle *th)
+{
+	struct ktf_test *t;
+	struct ktf_case *tc;
+
+	/* Clean up tests which are associated with this handle.
+	 * It's possible multiple modules contribute tests to a test case,
+	 * so we can't just do this on a per-testcase basis.
+	 */
+	mutex_lock(&tc_lock);
+
+	tc = ktf_map_first_entry(&test_cases, struct ktf_case, kmap);
+	while (tc) {
+		/* FIXME - this is inefficient. */
+		t = ktf_map_first_entry(&tc->tests, struct ktf_test, kmap);
+		while (t) {
+			if (t->handle == th) {
+				tlog(T_DEBUG, "ktf: delete test %s.%s",
+				     t->tclass, t->name);
+				/* removes ref for debugfs */
+				ktf_debugfs_destroy_test(t);
+				/* removes ref for testset map of tests */
+				ktf_map_remove_elem(&tc->tests, &t->kmap);
+				/* now remove our reference which we get
+				 * from ktf_map_[first|next]_entry().
+				 * This final reference should result in
+				 * the test being freed.
+				 */
+				ktf_test_put(t);
+				/* Need to reset to root */
+				t = ktf_map_first_entry(&tc->tests,
+							struct ktf_test, kmap);
+			} else {
+				t = ktf_map_next_entry(t, kmap);
+			}
+		}
+		/* If no modules have tests for this test case, we can
+		 * free resources safely.
+		 */
+		if (ktf_case_test_count(tc) == 0) {
+			ktf_debugfs_destroy_testset(tc);
+			ktf_map_remove_elem(&test_cases, &tc->kmap);
+			ktf_case_put(tc);
+			tc = ktf_map_first_entry(&test_cases, struct ktf_case,
+						 kmap);
+		} else {
+			tc = ktf_map_next_entry(tc, kmap);
+		}
+	}
+	mutex_unlock(&tc_lock);
+}
+EXPORT_SYMBOL(ktf_test_cleanup);
+
+int ktf_cleanup(void)
+{
+	struct ktf_test *t;
+	struct ktf_case *tc;
+
+	ktf_cov_cleanup();
+
+	/* Unloading of dependencies means we should have no testcases/tests. */
+	mutex_lock(&tc_lock);
+	ktf_for_each_testcase(tc) {
+		twarn("(memory leak) test set %s still active at unload!", ktf_case_name(tc));
+		ktf_testcase_for_each_test(t, tc) {
+			twarn("(memory leak) test set %s still active with test %s at unload!",
+			      ktf_case_name(tc), t->name);
+		}
+		return -EBUSY;
+	}
+	ktf_debugfs_cleanup();
+	mutex_unlock(&tc_lock);
+	return 0;
+}
diff --git a/tools/testing/selftests/ktf/kernel/ktf_test.h b/tools/testing/selftests/ktf/kernel/ktf_test.h
new file mode 100644
index 0000000..9769664
--- /dev/null
+++ b/tools/testing/selftests/ktf/kernel/ktf_test.h
@@ -0,0 +1,381 @@
+/*
+ * Copyright (C) 2001, 2002, Arien Malec
+ * Copyright (C) 2011, 2017, Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.1
+ *
+ * This file originates from check.h from the Check C unit test
+ * framework, adapted by Knut Omang to build with the linux kernel.
+ */
+
+#ifndef KTF_TEST_H
+#define KTF_TEST_H
+
+#include <net/netlink.h>
+#include <linux/version.h>
+#include "ktf_map.h"
+#include "ktf_unlproto.h"
+
+/* A test context is an extendable object that a test client module
+ * can supply, and that all tests will be invoked with as an implicit
+ * 'ctx' argument:
+ */
+struct ktf_context;
+
+struct ktf_test;
+
+typedef void (*ktf_test_fun) (struct ktf_test *, struct ktf_context* tdev, int, u32);
+
+struct ktf_debugfs {
+        struct dentry *debugfs_results_testset;
+        struct dentry *debugfs_results_test;
+        struct dentry *debugfs_run_testset;
+        struct dentry *debugfs_run_test;
+};
+
+struct ktf_test {
+	struct ktf_map_elem kmap; /* linkage for test case list */
+	const char* tclass; /* test class name */
+	const char* name; /* Name of the test */
+	ktf_test_fun fun;
+	int start; /* Start and end value to argument to fun */
+	int end;   /* Defines number of iterations */
+	struct sk_buff *skb; /* sk_buff for recording assertion results */
+	char *log; /* per-test log */
+	void *data; /* Test specific out-of-band data */
+	size_t data_sz; /* Size of the data element, if set */
+	struct timespec lastrun; /* last time test was run */
+	struct ktf_debugfs debugfs; /* debugfs info for test */
+	struct ktf_handle *handle; /* Handler for owning module */
+};
+
+struct ktf_case {
+	struct ktf_map_elem kmap; /* Linkage for ktf_map */
+	struct ktf_map tests; /* List of tests to run */
+	struct ktf_debugfs debugfs; /* debugfs handles for testset */
+};
+
+/* Used for tests that spawn kthreads to pass state.  We should probably
+ * look at passing data to tests like this to make things more extensible,
+ * but will defer for now as this would disrupt KTF consumers.
+ */
+struct ktf_test_state {
+	struct ktf_test *self;
+	struct ktf_context *ctx;
+	int iter;
+	u32 value;
+};
+
+extern struct ktf_map test_cases;
+
+/* Current total number of test cases defined */
+size_t ktf_case_count(void);
+const char *ktf_case_name(struct ktf_case *);
+/* Manage test case refcount. */
+void ktf_case_get(struct ktf_case *);
+void ktf_case_put(struct ktf_case *);
+
+int ktf_version_check(u64 version);
+
+void ktf_run_hook(struct sk_buff *skb, struct ktf_context *ctx,
+		struct ktf_test *t, u32 value,
+		void *oob_data, size_t oob_data_sz);
+void flush_assert_cnt(struct ktf_test *self);
+
+/* Representation of a test case (a group of tests) */
+struct ktf_case;
+
+struct ktf_case *ktf_case_find(const char *name);
+
+/* Each module client of the test framework is required to
+ * declare at least one ktf_handle via the macro
+ * DECLARE_KTF_HANDLE (below)
+ * If the module require extra data of some sorts, that
+ * can be embedded within the handle
+ */
+struct ktf_handle;
+
+/* Find the handle associated with handle id hid */
+struct ktf_handle *ktf_handle_find(int hid);
+
+/* Called upon ktf unload to clean up test cases */
+int ktf_cleanup(void);
+
+/* The list of handles that have contexts associated with them */
+extern struct list_head context_handles;
+
+struct __test_desc
+{
+	const char* tclass; /* Test class name */
+	const char* name;   /* Test name */
+	const char* file;   /* File that implements test */
+	ktf_test_fun fun;
+};
+
+/* Manage refcount for tests. */
+void ktf_test_get(struct ktf_test *t);
+void ktf_test_put(struct ktf_test *t);
+
+/* Add a test function to a test case for a given handle (macro version) */
+#define ktf_add_test_to(td, __test_handle)					\
+	_ktf_add_test(td##_setup, &__test_handle, 0, 0, 0, 1)
+
+/* Add a test function to a test case (macro version) */
+#define ktf_add_test(td) \
+	_ktf_add_test(td##_setup, &__test_handle, 0, 0, 0, 1)
+
+/* Add a looping test function to a test case (macro version)
+
+   The test will be called in a for(i = s; i < e; i++) loop with each
+   iteration being executed in a new context. The loop variable 'i' is
+   available in the test.
+ */
+#define ktf_add_loop_test(td,s,e)				\
+	_ktf_add_test(td##_setup, &__test_handle, 0,0,(s),(e))
+
+/* Add a test function to a test case
+  (function version -- use this when the macro won't work
+*/
+void _ktf_add_test(struct __test_desc td, struct ktf_handle *th,
+		int _signal, int allowed_exit_value, int start, int end);
+
+/* Internal function to mark the start of a test function */
+void ktf_fn_start (const char *fname, const char *file, int line);
+
+/* Add a test previously created with TEST() or TEST_F() */
+#define ADD_TEST(__testname)\
+	ktf_add_test(__testname)
+
+#define ADD_TEST_TO(__handle, __testname) \
+	ktf_add_test_to(__testname, __handle)
+
+#define ADD_LOOP_TEST(__testname, from, to)			\
+	ktf_add_loop_test(__testname, from, to)
+
+/* Remove a test previously added with ADD_TEST */
+#define DEL_TEST(__testname)\
+	ktf_del_test(__testname)
+
+/* Iterate over all test cases.  Implicitly bumps refcount for pos and
+ * decreases it after we iterate past it.
+ */
+#define ktf_for_each_testcase(pos)	\
+	ktf_map_for_each_entry(pos, &test_cases, kmap)
+
+/* Iterate over all tests for testcases.  Implicitly bumps refcount for pos
+ * and decreases it again after we iterate past it.
+ */
+#define ktf_testcase_for_each_test(pos, tc)	\
+	ktf_map_for_each_entry(pos, &tc->tests, kmap)
+
+#define KTF_GEN_TYPEID_MAX 3
+
+/* A test_handle identifies the calling module:
+ * Declare one in the module global scope using
+ *  KTF_INIT() or KTF_HANDLE_INIT()
+ *  and call KTF_CLEANUP() or KTF_HANDLE_CLEANUP() upon unload
+ */
+
+struct ktf_handle {
+	struct list_head handle_list; /* Linkage for the global list of all handles with context */
+	struct ktf_map ctx_type_map; /* a map from type_id to ktf_context_type (see ktf_context.c) */
+	struct ktf_map ctx_map;     /* a (possibly empty) map from name to context for this handle */
+	unsigned int id; 	      /* A unique nonzero ID for this handle, set iff contexts */
+	bool require_context;	      /* If set, tests are only valid if a context is provided */
+	u64 version;		      /* version assoc. with handle */
+	struct ktf_test *current_test;/* Current test running */
+};
+
+void ktf_test_cleanup(struct ktf_handle *th);
+void ktf_handle_cleanup_check(struct ktf_handle *handle);
+void ktf_cleanup_check(void);
+
+#define KTF_HANDLE_INIT_VERSION(__test_handle, __version, __need_ctx)	\
+	struct ktf_handle __test_handle = { \
+		.handle_list = LIST_HEAD_INIT(__test_handle.handle_list), \
+		.ctx_type_map = __KTF_MAP_INITIALIZER(__test_handle, NULL, NULL), \
+		.ctx_map = __KTF_MAP_INITIALIZER(__test_handle, NULL, NULL), \
+		.id = 0, \
+		.require_context = __need_ctx, \
+		.version = __version, \
+	};
+
+#define	KTF_HANDLE_INIT(__test_handle)	\
+	KTF_HANDLE_INIT_VERSION(__test_handle, KTF_VERSION_LATEST, false)
+
+#define KTF_INIT() KTF_HANDLE_INIT(__test_handle)
+
+#define	KTF_HANDLE_CTX_INIT(__test_handle)	\
+	KTF_HANDLE_INIT_VERSION(__test_handle, KTF_VERSION_LATEST, true)
+
+#define KTF_CTX_INIT() KTF_HANDLE_CTX_INIT(__test_handle)
+
+#define KTF_HANDLE_CLEANUP(__test_handle)	\
+	do { \
+		ktf_context_remove_all(&__test_handle); \
+		ktf_test_cleanup(&__test_handle); \
+	} while (0)
+
+#define KTF_CLEANUP() KTF_HANDLE_CLEANUP(__test_handle)
+
+/* Start a unit test with TEST(suite_name,unit_name)
+*/
+#define TEST(__testsuite, __testname)\
+	static void __testname(struct ktf_test *self, struct ktf_context *ctx, \
+			int _i, u32 _value);		    \
+	struct __test_desc __testname##_setup =			\
+        { .tclass = "" # __testsuite "", .name = "" # __testname "",\
+	  .fun = __testname, .file = __FILE__ };    \
+	\
+	static void __testname(struct ktf_test *self, struct ktf_context* ctx, \
+			int _i, u32 _value)
+
+/* Start a unit test using a fixture
+ * NB! Note the intentionally missing start parenthesis on DECLARE_F!
+ *
+ *   Prep:
+ *      DECLARE_F(fixture_name)
+ *            <attributes>
+ *      };
+ *      INIT_F(fixture_name,setup,teardown);
+ *
+ *   Usage:
+ *      SETUP_F(fixture_name,setup)
+ *      {
+ *             <setup code, set fixture_name->ok to true to have the test executed>
+ *      }
+ *      TEARDOWN_F(fixture_name,teardown)
+ *      {
+ *             <teardown code>
+ *      }
+ *      TEST_F(fixture_name,suite_name,test_name)
+ *      {
+ *             <test code>
+ *      }
+ *
+ *   setup must set ctx->ok to true to have the test itself executed
+ */
+#define DECLARE_F(__fixture) \
+	struct __fixture { \
+		void (*setup) (struct ktf_test *, struct ktf_context *, struct __fixture *); \
+		void (*teardown) (struct ktf_test *, struct __fixture *); \
+		bool ok;
+
+#define INIT_F(__fixture,__setup,__teardown) \
+	void __setup(struct ktf_test *, struct ktf_context *, struct __fixture *); \
+	void __teardown(struct ktf_test *, struct __fixture *); \
+	static struct __fixture __fixture##_template = {\
+		.setup = __setup, \
+		.teardown = __teardown, \
+		.ok = false,\
+	}
+
+#define	SETUP_F(__fixture, __setup) \
+	void __setup(struct ktf_test *self, struct ktf_context *ctx, \
+		     struct __fixture *__fixture)
+
+#define	TEARDOWN_F(__fixture, __teardown) \
+	void __teardown(struct ktf_test *self, struct __fixture *__fixture)
+
+#define TEST_F(__fixture, __testsuite, __testname) \
+	static void __testname##_body(struct ktf_test *, struct __fixture *, \
+				      int, u32); \
+	static void __testname(struct ktf_test *, struct ktf_context *, int, \
+			       u32); \
+	struct __test_desc __testname##_setup = \
+        { .tclass = "" # __testsuite "", .name = "" # __testname "", \
+	  .fun = __testname }; \
+	\
+	static void __testname(struct ktf_test *self, struct ktf_context* ctx, \
+		int _i, u32 _value) \
+	{ \
+		struct __fixture f_ctx = __fixture##_template; \
+		f_ctx.ok = false; \
+		f_ctx.setup(self, ctx, &f_ctx); \
+		if (!f_ctx.ok) return; \
+		__testname##_body(self, &f_ctx, _i, _value); \
+		f_ctx.teardown(self,&f_ctx); \
+	} \
+	static void __testname##_body(struct ktf_test *self, struct __fixture *ctx, \
+			int _i, u32 _value)
+
+/* Fail the test case unless expr is true */
+/* The space before the comma sign before ## is essential to be compatible
+   with gcc 2.95.3 and earlier.
+*/
+#define ktf_assert_msg(expr, format, ...)			\
+	_ktf_assert(self, expr, __FILE__, __LINE__,		\
+        format , ## __VA_ARGS__, NULL)
+
+#define ktf_assert(expr, ...)\
+	_ktf_assert(self, expr, __FILE__, __LINE__,		\
+        "Failure '"#expr"' occurred " , ## __VA_ARGS__, NULL)
+
+/* Always fail */
+#define ktf_fail(...) _ktf_assert(self, 0, __FILE__, __LINE__, "Failed" , ## __VA_ARGS__, NULL)
+
+/* Non-macro version of ktf_assert, with more complicated interface
+ * returns nonzero if ok, 0 otherwise
+ */
+long _ktf_assert (struct ktf_test *self, int result, const char *file,
+		int line, const char *expr, ...);
+
+/* Integer comparsion macros with improved output compared to ktf_assert(). */
+/* O may be any comparion operator. */
+#define ktf_assert_int_goto(X, O, Y, _lbl)		\
+	do { int x = (X); int y = (Y);\
+		if (!ktf_assert_msg(x O y,					\
+			"Assertion '"#X#O#Y"' failed: "#X"==0x%x, "#Y"==0x%x", x, y)) \
+			goto _lbl;\
+	} while (0)
+
+#define ktf_assert_int(X, O, Y) \
+	do { int x = (X); int y = (Y);\
+		ktf_assert_msg(x O y,\
+		  "Assertion '"#X#O#Y"' failed: "#X"==0x%x, "#Y"==0x%x", x, y);\
+	} while (0)
+
+#define ktf_assert_int_ret(X, O, Y)\
+	do { int x = (X); int y = (Y);\
+		if (!ktf_assert_msg(x O y,					\
+			"Assertion '"#X#O#Y"' failed: "#X"==0x%lx, "#Y"==0x%lx", x, y))	\
+			 return;\
+	} while (0)
+
+#define ktf_assert_long_goto(X, O, Y, _lbl)		\
+	do { long x = (X); long y = (Y);\
+		if (!ktf_assert_msg(x O y,					\
+			"Assertion '"#X#O#Y"' failed: "#X"==0x%lx, "#Y"==0x%lx", x, y))	\
+			 goto _lbl;\
+	} while (0)
+
+#define ktf_assert_long_ret(X, O, Y)\
+	do { long x = (X); long y = (Y);\
+		if (!ktf_assert_msg(x O y,					\
+			"Assertion '"#X#O#Y"' failed: "#X"==0x%lx, "#Y"==0x%lx", x, y))	\
+			 return;\
+	} while (0)
+
+/* O may be any comparion operator. */
+#define ktf_assert_long(X, O, Y) \
+	do { long x = (X); long y = (Y);\
+		ktf_assert_msg(x O y,\
+		  "Assertion '"#X#O#Y"' failed: "#X"==0x%lx, "#Y"==0x%lx", x, y);\
+	} while (0)
+
+/* String comparsion macros with improved output compared to ktf_assert() */
+#define ktf_assert_str_eq(X, Y)	\
+	do { const char* x = (X); const char* y = (Y);\
+		ktf_assert_msg(strcmp(x,y) == 0,\
+		  "Assertion '"#X"=="#Y"' failed: "#X"==\"%s\", "#Y"==\"%s\"",\
+		  x, y);\
+	} while (0)
+
+#define ktf_assert_str_ne(X, Y)				\
+	do { const char* x = (X); const char* y = (Y);\
+		ktf_assert_msg(strcmp(x,y) != 0,\
+		  "Assertion '"#X"!="#Y"' failed: "#X"==\"%s\", "#Y"==\"%s\"",\
+		  x, y);\
+	} while (0)
+
+#endif /* KTF_TEST_H */
-- 
git-series 0.9.1

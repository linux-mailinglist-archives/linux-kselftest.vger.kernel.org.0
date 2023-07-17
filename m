Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE26756360
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 14:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjGQMz2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 08:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjGQMz1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 08:55:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7A7E4C;
        Mon, 17 Jul 2023 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689598526; x=1721134526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/GbUJlxD6B4ZMSBm1ruFiwzehTQGXiEYVbSNTGBn/Ao=;
  b=CRlxjRW3T6GtHZn0QYyfdWzvN1TseGEP+hJizju8ySbE+5aiVqIPomKJ
   kdaEdq9La9thKblQqcKNzfY5tKjSe+JNVKKfmtpp1RcegvNqeW0FfSwD+
   yo8GOUoN/JRPlPgRAV8JrDyJVL1qdePft1+RQL7ykRdsnQp0wsmarJRrR
   2Im0Xm5xdIO4NVGeEK9UFXAHxxmcrxmmk6TstUdtHqWwfUl2gGAHHddtS
   JBEWlNGuWBzre/l4UX5YimdHzOGCZNLv9H+ju60iIZWEKYu7zLB/dhF1e
   AlI3EA7NXlOecFzmbBAscuno6T4AC9SADYRp2a7QrQuqWuVeMxWlGCu3z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="452295038"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="452295038"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 05:55:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="752886765"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="752886765"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 17 Jul 2023 05:55:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D070624F; Mon, 17 Jul 2023 15:55:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 1/4] kernel.h: Split out COUNT_ARGS() and CONCATENATE() to args.h
Date:   Mon, 17 Jul 2023 15:55:18 +0300
Message-Id: <20230717125521.43176-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230717125521.43176-1-andriy.shevchenko@linux.intel.com>
References: <20230717125521.43176-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kernel.h is being used as a dump for all kinds of stuff for a long time.
The COUNT_ARGS() and CONCATENATE() macros may be used in some places
without need of the full kernel.h dependency train with it.

Here is the attempt on cleaning it up by splitting out these macros().

While at it, include new header where it's being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/kunit/test.h      |  1 +
 include/linux/args.h      | 28 ++++++++++++++++++++++++++++
 include/linux/kernel.h    |  7 -------
 include/linux/pci.h       |  2 +-
 include/trace/bpf_probe.h |  2 ++
 5 files changed, 32 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/args.h

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 23120d50499e..107c81431634 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -12,6 +12,7 @@
 #include <kunit/assert.h>
 #include <kunit/try-catch.h>
 
+#include <linux/args.h>
 #include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/err.h>
diff --git a/include/linux/args.h b/include/linux/args.h
new file mode 100644
index 000000000000..8ff60a54eb7d
--- /dev/null
+++ b/include/linux/args.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_ARGS_H
+#define _LINUX_ARGS_H
+
+/*
+ * How do these macros work?
+ *
+ * In __COUNT_ARGS() _0 to _12 are just placeholders from the start
+ * in order to make sure _n is positioned over the correct number
+ * from 12 to 0 (depending on X, which is a variadic argument list).
+ * They serve no purpose other than occupying a position. Since each
+ * macro parameter must have a distinct identifier, those identifiers
+ * are as good as any.
+ *
+ * In COUNT_ARGS() we use actual integers, so __COUNT_ARGS() returns
+ * that as _n.
+ */
+
+/* This counts to 12. Any more, it will return 13th argument. */
+#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _n, X...) _n
+#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
+
+/* Concatenate two parameters, but allow them to be expanded beforehand. */
+#define __CONCAT(a, b) a ## b
+#define CONCATENATE(a, b) __CONCAT(a, b)
+
+#endif	/* _LINUX_ARGS_H */
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 0b00e1aef33d..15d9496db169 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -419,13 +419,6 @@ ftrace_vprintk(const char *fmt, va_list ap)
 static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 #endif /* CONFIG_TRACING */
 
-/* This counts to 12. Any more, it will return 13th argument. */
-#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _n, X...) _n
-#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
-
-#define __CONCAT(a, b) a ## b
-#define CONCATENATE(a, b) __CONCAT(a, b)
-
 /* Rebuild everything on CONFIG_FTRACE_MCOUNT_RECORD */
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 # define REBUILD_DUE_TO_FTRACE_MCOUNT_RECORD
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0ff7500772e6..eeb2e6f6130f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -23,7 +23,7 @@
 #ifndef LINUX_PCI_H
 #define LINUX_PCI_H
 
-
+#include <linux/args.h>
 #include <linux/mod_devicetable.h>
 
 #include <linux/types.h>
diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 1f7fc1fc590c..e609cd7da47e 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -12,6 +12,8 @@
 #undef __perf_task
 #define __perf_task(t)	(t)
 
+#include <linux/args.h>
+
 /* cast any integer, pointer, or small struct to u64 */
 #define UINTTYPE(size) \
 	__typeof__(__builtin_choose_expr(size == 1,  (u8)1, \
-- 
2.40.0.1.gaa8946217a0b


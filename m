Return-Path: <linux-kselftest+bounces-33376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CFDABD1E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 10:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A763AC396
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 08:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B02676D5;
	Tue, 20 May 2025 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ky4A4Ctf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5AF2673B9;
	Tue, 20 May 2025 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729530; cv=none; b=K+5LciKd5DJr4zcZ/NQBlKelA38EYI3iF5wEt1mCuYsqhklQ+miL4u9yUNuS4nBQsHfAwADKzbT1VBMdEjLTAFzCLm3MPmcv9nvb/6Dm1VaiAzU9YpmUSzb09kOZaNd3QF/srvwwc2/eUaNanaB91M5T2nySIhLEuCm8Je2/FuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729530; c=relaxed/simple;
	bh=VwHSk8MoYaaONWTt5aKNb+9EuN0bahyPpgTUvEZBz4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVV+mOIy+o+dVI0w6x1bMAAAbhcnTCpqb/jjbzDr8YdfoIUNqxWjsepoPCmtNfN79YTepKkvSHqzD08XdZIa4qzg8x00pCPq7ZeODqUnQurkJgQczDVa0gv4mNKHbP5vaN+LbSiqrXmfG2ksYU8gIdNlbKtcvaJq5VW0nI56lVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ky4A4Ctf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38962C4CEEF;
	Tue, 20 May 2025 08:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747729529;
	bh=VwHSk8MoYaaONWTt5aKNb+9EuN0bahyPpgTUvEZBz4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ky4A4CtfyytMm4EZKwN2pFBoplenp40uWUZDqWIy7EcQ5KzsNaYiCR0ckq8ErOuGo
	 7L7IT5edJPSP5J6klwgsm84DozTjGie09nRTocSDERuVrZOYOFDsfaWIQ/th5pC7Ag
	 5SIwxcH9fwJYRHcRzGRWauzMii7PhmgHYiFyQz6I87hVX3P5g6QnPmch8LEHkOjyY6
	 mqgEisTw4WDaTON+DA5WO5xovqS17uMADZ5UvdgISTeugnDqGtyOsEFjqOkNTH6rT+
	 E3p6niRgfbfhOWz/bfzmXvavojmk15ji2/DO2TPPFXG6hxLZ/PoihrZmfN6DcgOIpp
	 rJD54ndJ63T5A==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: bleung@chromium.org,
	brendan.higgins@linux.dev,
	davidgow@google.com
Cc: tzungbi@kernel.org,
	rmoar@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	naveen@kernel.org,
	anil.s.keshavamurthy@intel.com,
	davem@davemloft.net,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/7] kunit: Expose 'kprobes stub' API to redirect functions
Date: Tue, 20 May 2025 08:24:33 +0000
Message-ID: <20250520082435.2255639-7-tzungbi@kernel.org>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
In-Reply-To: <20250520082435.2255639-1-tzungbi@kernel.org>
References: <20250520082435.2255639-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add function redirection API based on Kprobes.

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 include/kunit/kprobes_stub.h |  19 ++++++
 lib/kunit/Kconfig            |   7 +++
 lib/kunit/Makefile           |   4 ++
 lib/kunit/kprobes_stub.c     | 113 +++++++++++++++++++++++++++++++++++
 4 files changed, 143 insertions(+)
 create mode 100644 include/kunit/kprobes_stub.h
 create mode 100644 lib/kunit/kprobes_stub.c

diff --git a/include/kunit/kprobes_stub.h b/include/kunit/kprobes_stub.h
new file mode 100644
index 000000000000..af77c86fe48e
--- /dev/null
+++ b/include/kunit/kprobes_stub.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KUNIT_KPROBES_STUB_H
+#define _KUNIT_KPROBES_STUB_H
+
+struct kunit;
+
+#define kunit_activate_kprobes_stub(test, func, replacement) do { \
+	typecheck_fn(typeof(&func), replacement); \
+	__kunit_activate_kprobes_stub(test, #func, func, replacement); \
+} while (0)
+
+void __kunit_activate_kprobes_stub(struct kunit *test,
+				  const char *name,
+				  void *real_fn_addr,
+				  void *replacement_addr);
+
+void kunit_deactivate_kprobes_stub(struct kunit *test, void *real_fn_addr);
+
+#endif  /* _KUNIT_KPROBES_STUB_H */
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 933fda1df5c3..13fdd3471060 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -104,4 +104,11 @@ config KUNIT_FTRACE_STUBS
 	  NOTE: this does not work on all architectures (like UML, arm64) and
 	  relies on a lot of magic (see the dependencies list).
 
+config KUNIT_KPROBES_STUBS
+	bool "Support for stubbing out functions in KUnit tests with kprobes"
+	depends on KPROBES
+	help
+	  Builds support for stubbing out functions for the duration of KUnit
+	  test cases or suites using kprobes.
+
 endif # KUNIT
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 0ecb255576e2..727ce86eb61f 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -33,3 +33,7 @@ obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	kunit-example-test.o
 ifeq ($(CONFIG_KUNIT_FTRACE_STUBS),y)
 kunit-objs +=				ftrace_stub.o
 endif
+
+ifeq ($(CONFIG_KUNIT_KPROBES_STUBS),y)
+kunit-objs +=				kprobes_stub.o
+endif
diff --git a/lib/kunit/kprobes_stub.c b/lib/kunit/kprobes_stub.c
new file mode 100644
index 000000000000..95f1dcba346b
--- /dev/null
+++ b/lib/kunit/kprobes_stub.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit function redirection (kprobes stubbing) API.
+ */
+
+#include <kunit/test.h>
+#include <kunit/kprobes_stub.h>
+
+#include <linux/kprobes.h>
+
+struct kunit_kprobes_stub_ctx {
+	unsigned long real_fn_addr;
+	unsigned long replacement_addr;
+	struct kprobe kp;
+};
+
+static void __kunit_kprobes_stub_resource_free(struct kunit_resource *res)
+{
+	struct kunit_kprobes_stub_ctx *ctx = res->data;
+
+	unregister_kprobe(&ctx->kp);
+	kfree(ctx);
+}
+
+static int kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
+{
+	struct kunit_kprobes_stub_ctx *ctx = container_of(kp, struct kunit_kprobes_stub_ctx, kp);
+
+	instruction_pointer_set(regs, ctx->replacement_addr);
+	return 1;
+}
+
+/* Matching function for kunit_find_resource().  match_data is real_fn_addr. */
+static bool __kunit_kprobes_stub_resource_match(struct kunit *test,
+						struct kunit_resource *res,
+						void *match_real_fn_addr)
+{
+	struct kunit_kprobes_stub_ctx *ctx = res->data;
+
+	/* Make sure the resource is a kprobes stub resource. */
+	if (res->free != &__kunit_kprobes_stub_resource_free)
+		return false;
+
+	return ctx->real_fn_addr == (unsigned long)match_real_fn_addr;
+}
+
+void __kunit_activate_kprobes_stub(struct kunit *test,
+				   const char *name,
+				   void *real_fn_addr,
+				   void *replacement_addr)
+{
+	struct kunit_kprobes_stub_ctx *ctx;
+	struct kunit_resource *res;
+
+	KUNIT_ASSERT_PTR_NE_MSG(test, real_fn_addr, NULL,
+				"Tried to activate a stub for function NULL");
+
+	/* If the replacement address is NULL, deactivate the stub. */
+	if (!replacement_addr) {
+		kunit_deactivate_kprobes_stub(test, real_fn_addr);
+		return;
+	}
+
+	/* Look up any existing stubs for this function, and replace them. */
+	res = kunit_find_resource(test,
+				  __kunit_kprobes_stub_resource_match,
+				  real_fn_addr);
+	if (res) {
+		ctx = res->data;
+		ctx->replacement_addr = (unsigned long)replacement_addr;
+
+		/* We got an extra reference from find_resource(), so put it. */
+		kunit_put_resource(res);
+	} else {
+		ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ctx, "Failed to allocate kunit stub for %s",
+						 name);
+
+		ctx->real_fn_addr = (unsigned long)real_fn_addr;
+		ctx->replacement_addr = (unsigned long)replacement_addr;
+
+		ctx->kp.addr = real_fn_addr;
+		ctx->kp.pre_handler = kprobe_handler;
+		KUNIT_ASSERT_EQ_MSG(test, register_kprobe(&ctx->kp), 0,
+				    "Failed to allocate kunit stub for %s", name);
+
+		kunit_alloc_resource(test, NULL,
+				     __kunit_kprobes_stub_resource_free,
+				     GFP_KERNEL, ctx);
+	}
+}
+EXPORT_SYMBOL_GPL(__kunit_activate_kprobes_stub);
+
+void kunit_deactivate_kprobes_stub(struct kunit *test, void *real_fn_addr)
+{
+	struct kunit_resource *res;
+
+	KUNIT_ASSERT_PTR_NE_MSG(test, real_fn_addr, NULL, "Tried to deactivate a NULL stub.");
+
+	res = kunit_find_resource(test,
+				  __kunit_kprobes_stub_resource_match,
+				  real_fn_addr);
+	KUNIT_ASSERT_PTR_NE_MSG(test, res, NULL,
+				"Tried to deactivate a nonexistent stub.");
+
+	/*
+	 * Free the stub. We 'put' twice, as we got a reference
+	 * from kunit_find_resource()
+	 */
+	kunit_remove_resource(test, res);
+	kunit_put_resource(res);
+}
+EXPORT_SYMBOL_GPL(kunit_deactivate_kprobes_stub);
-- 
2.49.0.1101.gccaa498523-goog



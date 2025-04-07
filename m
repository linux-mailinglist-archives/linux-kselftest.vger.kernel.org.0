Return-Path: <linux-kselftest+bounces-30230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85409A7D696
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 09:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007FF1897872
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 07:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E09B22A7FA;
	Mon,  7 Apr 2025 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tsZImF8I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x+RwxxsW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B92F22839A;
	Mon,  7 Apr 2025 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011786; cv=none; b=jxSFNaa5/Mu9fZK7mbgVsGQH9/SGHOnuooJ7S+534/sxhocc9znl3M1JmBYQGyGqLNpnqaXR2EcLCsBT/Gpkk4DUiMVx3I0Mn1ED7r2E5BlDDNWot0v5QW1QLnoYmB+uK/E+qjWOWbgN2wY7wTP4bhM8oDn0huKqaAD+KUPAlOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011786; c=relaxed/simple;
	bh=JuaIjS9/HyTR39eTJxdj9heG3qdGFyt4hvgxTOmYfHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ow18ouU9le4LTIqBSTc+V4M1Uc02Gj5kO60FYqudc18U8in4RjCGKSoE9uMElHFgMkZ5hl+X8ccua9EX3z2ZpcTjPES3ZZhonpE/2FGITxKnBYw10s8Aqrcnf+2IvjMQ4jJgc5c4USp0zUfm4wLxN7L8J8SpFQP6IdxnbPl8fjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tsZImF8I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x+RwxxsW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744011782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlhQKzkZM6Jr36iAYSy0CT5G2SSQr4FADfY/xCw8dbo=;
	b=tsZImF8IKRFZs9LynGUEysPNfC/cknXyNJce05iqbVB3g/Ee8NQoEt/F4a3SpKL2qnVa/c
	vEpmRoj9yws4jNTxf4CH+AYvONrIjQNxMQekdsYe4hR35mj4rD+4crf8KSN7JSzL4Fdb+0
	X26ziTNBc3EBYKHo+f6QwN7e61ia8GIzcyDjFA9qbCHj+NNJjPqGJWus8mBrWkL2xBK6qx
	HJklh8aOsuboYT/vyE7i5yF/r1S8N5MQoZTv01PWoWnnrJqYjJk2TiEW7s8HbvxcQskyvX
	O5XtF2YdmOfmrWJDYRruhrOUPOcPDIzRvPVRzcaIPvJ6D6Drtzy5mtBe6ER3/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744011782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlhQKzkZM6Jr36iAYSy0CT5G2SSQr4FADfY/xCw8dbo=;
	b=x+RwxxsWDYfiJ/iTSGu6N6jGVesB6Fat4uppuHmFT0p4wx+Z0A6HsJxvhj03ktcEaAQaM8
	ZFANoWpGsiwe1/CA==
Date: Mon, 07 Apr 2025 09:42:46 +0200
Subject: [PATCH v2 09/11] kunit: uapi: Add example for UAPI tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-kunit-kselftests-v2-9-454114e287fd@linutronix.de>
References: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
In-Reply-To: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744011776; l=3632;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=JuaIjS9/HyTR39eTJxdj9heG3qdGFyt4hvgxTOmYfHs=;
 b=pQmTBghv8NpE4tuvPIF6Q2FgZ5AQGkatdQ4Q38jAFbpCj6aPC6lSE+zpN3nem/WABJQCcGUHd
 dU9UOjM9Y6iDkbZ8xStr3Mr961j2CbU5FEbM/PnPAxZRxvN21Kn36MT
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Extend the example to show how to run a userspace executable.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/kunit/.kunitconfig         |  2 ++
 lib/kunit/Makefile             |  9 ++++++++-
 lib/kunit/kunit-example-test.c | 15 +++++++++++++++
 lib/kunit/kunit-example-uapi.c | 22 ++++++++++++++++++++++
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/.kunitconfig b/lib/kunit/.kunitconfig
index 9235b7d42d389d2c7bf912546c7bb084eae99235..b7433e691563a3a8442db69874dea88f3b607332 100644
--- a/lib/kunit/.kunitconfig
+++ b/lib/kunit/.kunitconfig
@@ -1,3 +1,5 @@
 CONFIG_KUNIT=y
+CONFIG_SHMEM=y
+CONFIG_TMPFS=y
 CONFIG_KUNIT_TEST=y
 CONFIG_KUNIT_EXAMPLE_TEST=y
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 989933dab9ad2267f376db470b876ce2a88711b4..1b6be12676f89cafa34f0093d8136b36f4cf5532 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -30,4 +30,11 @@ obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
 obj-$(CONFIG_KUNIT_TEST) +=		assert_test.o
 endif
 
-obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	kunit-example-test.o
+userprogs +=				kunit-example-uapi
+kunit-example-uapi-userccflags :=	-static
+kunit-example-uapi-nolibc :=		$(CONFIG_ARCH_HAS_NOLIBC)
+blobs +=				kunit-example-uapi.blob.o
+
+obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	kunit-example-mod.o
+kunit-example-mod-y +=			kunit-example-test.o
+kunit-example-mod-$(CONFIG_KUNIT_UAPI) += kunit-example-uapi.blob.o
diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 3056d6bc705d0a8f196f0f4412e679dbb0e03114..b2681a6e047dfd6fea4a7cca60e81651d09c2eae 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -6,8 +6,11 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
+#include <linux/blob.h>
+
 #include <kunit/test.h>
 #include <kunit/static_stub.h>
+#include <kunit/uapi.h>
 
 /*
  * This is the most fundamental element of KUnit, the test case. A test case
@@ -277,6 +280,17 @@ static void example_slow_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 1 + 1, 2);
 }
 
+/*
+ * This test shows the usage of UAPI tests.
+ */
+static void example_uapi_test(struct kunit *test)
+{
+	if (IS_ENABLED(CONFIG_KUNIT_UAPI))
+		kunit_uapi_run_kselftest(test, BLOB(kunit_example_uapi));
+	else
+		kunit_skip(test, "CONFIG_KUNIT_UAPI is not enabled");
+}
+
 /*
  * Here we make a list of all the test cases we want to add to the test suite
  * below.
@@ -297,6 +311,7 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_priv_test),
 	KUNIT_CASE_PARAM(example_params_test, example_gen_params),
 	KUNIT_CASE_SLOW(example_slow_test),
+	KUNIT_CASE(example_uapi_test),
 	{}
 };
 
diff --git a/lib/kunit/kunit-example-uapi.c b/lib/kunit/kunit-example-uapi.c
new file mode 100644
index 0000000000000000000000000000000000000000..4ce657050dd4a576632a41ca0309c4cb5134ce14
--- /dev/null
+++ b/lib/kunit/kunit-example-uapi.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit Userspace example test.
+ *
+ * Copyright (C) 2025, Linutronix GmbH.
+ * Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ *
+ * This is *userspace* code.
+ */
+
+#include "../../tools/testing/selftests/kselftest.h"
+
+int main(void)
+{
+	ksft_print_header();
+	ksft_set_plan(4);
+	ksft_test_result_pass("userspace test 1\n");
+	ksft_test_result_pass("userspace test 2\n");
+	ksft_test_result_skip("userspace test 3: some reason\n");
+	ksft_test_result_pass("userspace test 4\n");
+	ksft_finished();
+}

-- 
2.49.0



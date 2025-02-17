Return-Path: <linux-kselftest+bounces-26771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 953EFA38136
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 12:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0CD5162BE4
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 11:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D252A21ADC9;
	Mon, 17 Feb 2025 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ldd+9zt9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4sm6gbL8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECBD219A99;
	Mon, 17 Feb 2025 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790044; cv=none; b=EM5oCXpndsff6IUD6seg9euXgp9cdFEDpoM5oVVokZJsUoU3XMlnW3lKzu+HYrphB1+AyKEgvOWKdIMR4QbCzarShSCS2GFBw2xNiEf1wSSINbtyviDjcWFL76IwIrqkpDZZtWkGTyYbolwkZfFlvZbBiCgSIH0gyHONOb88zvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790044; c=relaxed/simple;
	bh=DbWBS4iAgx14/WPjqsLMmarpz0SuT0mGiZYf8mBVqhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AvXSeEk4jJ4yf5XCncVjW0u4xF4yOr0Hy2yQPA+Mos2V8IotZNxNQbz4+0GyKIqJb8UXndidV18K1PEXDVC3VxomwZz/0MXC3ZpglLyxpvakvuD0G3INi4VkuzKNRjhHRk7k2ZDKdxUWmGOGG1FjZBwF1sMA8z8YwszQxuWPkgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ldd+9zt9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4sm6gbL8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739790041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p6J/q2UBParY1fmd6WOqMsTt/aNnKl9MDGkOwxkh+MM=;
	b=Ldd+9zt98JHivrEV8+R/YlthmDCL9iDNihl++l80V6fGIVMFWBXVdZ56jvMAFeB2UfDQ5q
	6dOjsi0PBbwGkl7JMmbOSrdUcxO0bOctl5lncziM46SBNUgfmufX4ULd0QC0rhjhKR8EI9
	MgnTh0UczpPfJy/ba5U82vN4HZfPC77q6Y8IwEq21YWiKjY8NfC68Wlc6KRszamcU8fb6z
	wXwaR5VTUtq3zByXwM5Qr9siFpoR7bocLr26Yhg8DFPITNbIL5YqFVr3e/82Gt0XvOKnIe
	odQXMCy88KIH9SE5tEtAdEEQcmixlwJy5ewJcegDM4mrtTPPvjmCwYgHaQOlXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739790041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p6J/q2UBParY1fmd6WOqMsTt/aNnKl9MDGkOwxkh+MM=;
	b=4sm6gbL8740exSdi0tB3xyOuVtFFda5UljT8HsQm4vUdI7z1tm+1+pzSLVQvU/++cnilqP
	ZADRqIf0DYtaneCA==
Date: Mon, 17 Feb 2025 11:59:30 +0100
Subject: [PATCH 10/12] kunit: uapi: Add example for UAPI tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-kunit-kselftests-v1-10-42b4524c3b0a@linutronix.de>
References: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
In-Reply-To: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739790034; l=3260;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=DbWBS4iAgx14/WPjqsLMmarpz0SuT0mGiZYf8mBVqhs=;
 b=vsFz67tjcaj/tbebMI1fbfCttAQSq/b0lNdayg4y97RoXEx2pzZoLAFHgcFLYmLSWAEo50e0l
 TCT8S4ZQigCCtf2xaUsVtqEtji7eIOY0aaV6scquMgjUQWP+OL8mQYC
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Extend the example to show how to run a userspace executable.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/kunit/Makefile             |  8 +++++++-
 lib/kunit/kunit-example-test.c | 17 +++++++++++++++++
 lib/kunit/kunit-uapi-example.c | 20 ++++++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 2b68f9bd20137edb705dcd8cb2dc145f9684cf73..0d89b666fcad12a542d3e2ffacedd26b122c5449 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -30,4 +30,10 @@ obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
 obj-$(CONFIG_KUNIT_TEST) +=		assert_test.o
 endif
 
-obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	kunit-example-test.o
+userprogs +=				kunit-uapi-example
+kunit-uapi-example-userccflags :=	-static
+kunit-uapi-example-nolibc :=		$(CONFIG_ARCH_HAS_NOLIBC)
+blobs +=				kunit-uapi-example.blob.o
+obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	kunit-example-test-mod.o
+kunit-example-test-mod-y +=		kunit-example-test.o
+kunit-example-test-mod-$(CONFIG_KUNIT_UAPI) += kunit-uapi-example.blob.o
diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 3056d6bc705d0a8f196f0f4412e679dbb0e03114..c5b8b308ed7b10c6ec4f475965205f2ccc4b4ec5 100644
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
@@ -277,6 +280,19 @@ static void example_slow_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 1 + 1, 2);
 }
 
+/*
+ * This test shows the usage of UAPI tests.
+ */
+static void example_uapi_test(struct kunit *test)
+{
+	DECLARE_BLOB(kunit_uapi_example);
+
+	if (IS_ENABLED(CONFIG_KUNIT_UAPI))
+		kunit_uapi_run_executable(test, &kunit_uapi_example);
+	else
+		kunit_skip(test, "CONFIG_KUNIT_UAPI not enabled");
+}
+
 /*
  * Here we make a list of all the test cases we want to add to the test suite
  * below.
@@ -297,6 +313,7 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_priv_test),
 	KUNIT_CASE_PARAM(example_params_test, example_gen_params),
 	KUNIT_CASE_SLOW(example_slow_test),
+	KUNIT_CASE(example_uapi_test),
 	{}
 };
 
diff --git a/lib/kunit/kunit-uapi-example.c b/lib/kunit/kunit-uapi-example.c
new file mode 100644
index 0000000000000000000000000000000000000000..4ec4b924f29b089cce9ca5b2b08a6ee0117b8ae9
--- /dev/null
+++ b/lib/kunit/kunit-uapi-example.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit Userspace example test.
+ *
+ * Copyright (C) 2025, Linuxtronix GmbH.
+ * Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
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
2.48.1



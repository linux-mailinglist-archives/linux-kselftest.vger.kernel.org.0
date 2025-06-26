Return-Path: <linux-kselftest+bounces-35828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B193AE95F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F374A4164
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 06:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DB7267721;
	Thu, 26 Jun 2025 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gY8jN+8R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hCSJ6sJl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E91925E460;
	Thu, 26 Jun 2025 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918231; cv=none; b=bO6E+6WvfMFHlAUGEGcTM9Ki+VmOJlDvdIK9RJU/wsJeNooIUXogcPKWsbGbbaJuk9SljH7GQeygmkM6+hJGJKgPyzspnK+f87Pd3ElODwPNxTxUcXnRd4buATo9dQ0U3VW0z6vvsLHHnVSVybX2DjGZh6XXOp8wrp+bLGHzm60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918231; c=relaxed/simple;
	bh=zCRVPNHdhdMqDLsoVDpwaBJ7JHwfC8tITyvaL9KjOKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o2D036RiU54UStAXUiPuVCnFvvJCE21BXcP6RPKzb/MwnKrRjA/rvhfsR320ozxMJ9qtvDf1kDFWEm10kVJ004WDeyRFlHOL4NOyT8uJfmndjygHQlCWzTNhwl3Ppe4rDwWogZGjUfXBkpFCZJxXnI6ze3i377QUdAz7mPM1CAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gY8jN+8R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hCSJ6sJl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750918227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsDPyS4cN8Rd+7R9ZMNq8bORyKscl6GSeHz3Gu4ppW4=;
	b=gY8jN+8RXLn1jaHGimp1PswlVRey7Klv8sMfoJrl+TqnQ41sXMrP1RicMOdexINW/jqc7z
	mrxJNNu6SYt7uy48EfRPVCFurmhrvw2eYUkBe2FAGAWpUU3r4uCfoWVNPTagUes68P0URA
	nQGqF2O/+6KvLwtd9UGBWCsEyNo91/h0uszmaPm8b1UgILjgICFTmzUo0kRk5kYwIUTQRv
	LPdl3PxyI+0lQRCjk38oRHv/ZC5C6VqwLqJnDXkFLNoOxWd/UERlinziQIv0+hmKyS+RbX
	SbB4aRXfmwFGegV26+eBKTVtioQtIrrgFrzTFYjxpWspzVwJtbUgDNlx/RU10Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750918227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsDPyS4cN8Rd+7R9ZMNq8bORyKscl6GSeHz3Gu4ppW4=;
	b=hCSJ6sJl8sJV+/mE7pW9mxFfvBLIgzvPWfLlWB7Bt6zJikK2LSMMsBbWfrnIt1P2C0DVfP
	IDDG9iIYsX2OybBQ==
Date: Thu, 26 Jun 2025 08:10:21 +0200
Subject: [PATCH v4 13/15] kunit: uapi: Add example for UAPI tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-kunit-kselftests-v4-13-48760534fef5@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
In-Reply-To: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
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
 linux-doc@vger.kernel.org, workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750918216; l=3685;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=zCRVPNHdhdMqDLsoVDpwaBJ7JHwfC8tITyvaL9KjOKo=;
 b=lz7WNMY7LoBnGCOQrPEp40isJXr8If4yxjNl2RgIm6KXLISeG71v0I05vjauZ34o9D1EiLDBD
 1Wq/NVvT3YBD4xMTfwbIS++v48xIMlR5Hbl85XGvZv9NGHhxATqABdd
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Extend the example to show how to run a userspace executable.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
---
 MAINTAINERS                    |  1 +
 lib/kunit/Makefile             |  9 +++++++++
 lib/kunit/kunit-example-test.c | 15 +++++++++++++++
 lib/kunit/kunit-example-uapi.c | 22 ++++++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f60501c6de570723123b24eb930d15f1bd956eb..b1405f0a0e638d1654d9dc9e51d784ddc838cf5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13544,6 +13544,7 @@ KUNIT UAPI TESTING FRAMEWORK (in addition to KERNEL UNIT TESTING FRAMEWORK)
 M:	Thomas Weißschuh <thomas.weissschuh@linutronix.de>
 S:	Maintained
 F:	include/kunit/uapi.h
+F:	lib/kunit/kunit-example-uapi.c
 F:	lib/kunit/kunit-uapi.c
 
 KVM PARAVIRT (KVM/paravirt)
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 6059621a2d32c8e7384acda59793f05826af8c81..1bba7965613e36e26939d6b31e1d65acf5bad0dc 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -1,3 +1,5 @@
+include $(srctree)/init/Makefile.nolibc
+
 obj-$(CONFIG_KUNIT) +=			kunit.o
 
 kunit-objs +=				test.o \
@@ -31,3 +33,10 @@ obj-$(CONFIG_KUNIT_TEST) +=		assert_test.o
 endif
 
 obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	kunit-example-test.o
+
+userprogs +=				kunit-example-uapi
+kunit-example-uapi-userccflags :=	-static $(NOLIBC_USERCFLAGS)
+
+ifdef CONFIG_KUNIT_UAPI
+$(obj)/kunit-example-test.o: $(obj)/kunit-example-uapi
+endif
diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 3056d6bc705d0a8f196f0f4412e679dbb0e03114..0c5e1e59f9358b84aee2621e342d824a2f99f9aa 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -8,6 +8,7 @@
 
 #include <kunit/test.h>
 #include <kunit/static_stub.h>
+#include <kunit/uapi.h>
 
 /*
  * This is the most fundamental element of KUnit, the test case. A test case
@@ -277,6 +278,19 @@ static void example_slow_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 1 + 1, 2);
 }
 
+/*
+ * This test shows the usage of UAPI tests.
+ */
+static void example_uapi_test(struct kunit *test)
+{
+	KUNIT_UAPI_EMBED_BLOB(kunit_example_uapi, "kunit-example-uapi");
+
+	if (IS_ENABLED(CONFIG_KUNIT_UAPI))
+		kunit_uapi_run_kselftest(test, &kunit_example_uapi);
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
2.50.0



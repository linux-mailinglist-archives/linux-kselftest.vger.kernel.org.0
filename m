Return-Path: <linux-kselftest+bounces-35830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78202AE95F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B111C40511
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 06:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC5F273D6A;
	Thu, 26 Jun 2025 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GopqWVnX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hvv9muUm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE1125E461;
	Thu, 26 Jun 2025 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918234; cv=none; b=nNitNmTiqQzNHaRuEu4e3Tv2IkR8yoop0knE+NAxie2FAk3E+VdkKiaMc7rV9vpflGXYDDD1eWAdUILYiP0gNx8IWR6i8kjdt8eRgAKiIx+lcy77NzrGJPJqMl6MzQKUM0vxh2HtrT4iXrRzrK5IXuFEoENiOkZNL5vaud7K5zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918234; c=relaxed/simple;
	bh=/QnMka8GtzcWlJyc1k0qKztnRSdiplVDLyPIydh5NqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mMGG43JQbFfVdyXcGLhlBMwcOAfcPWRZWFXAMX2oMmAT+6+tXP1EybxPw0Jfef8k61IO/A8Bj44WYgj0uzcwlpYLnUUBhBnYRbl951Pe8RrXDhxfGpcc4aDs3wS9yLUVgBtVmknm2glkPasY4dmItB58Y83alK2yauCp4uQVRXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GopqWVnX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hvv9muUm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750918229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wcd1PIYjhMZuamuSudKPI/n6bo0/ENxSUBBB9QoiuyI=;
	b=GopqWVnX6xFlQ7Kx9LSfHAgcfO1bXVmMzglHMjTN5SiIw7UlhYURTvAEuSuT+AxPq3k4oU
	3JFfGoVPS4m6RQjL3VjsmLrrBcx2WLx9xgWrxZyEotk36T9mgYsf56JWIoNVRQhe0MKi6i
	eZCJr7kiNonUUR1AOAj81Z9eKsvG9/VKh7hVXelMamD/4VusIN2JS31i3aaYuGmgYs1ZLn
	7xeUp1R9K3fzzyYp/OQ+luAEGlQunqtPK9tO+C+UVBoHHiASArPOAnTjE1fUrM0tb1ZFqx
	zvAuCYrZdXVVpvp4qvUq/j4AgT3cGr8HB6e+ac2KAvB0IytDj77RMe83pHaMKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750918229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wcd1PIYjhMZuamuSudKPI/n6bo0/ENxSUBBB9QoiuyI=;
	b=hvv9muUmMjT3RoOZ2ahvBTns7AYlFJQVgiBCUCOxaASmznc+IOeTQZZwURS4JcQ1mKrAr7
	RlqvovE88eiPVdDA==
Date: Thu, 26 Jun 2025 08:10:23 +0200
Subject: [PATCH v4 15/15] kunit: uapi: Validate usability of /proc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-kunit-kselftests-v4-15-48760534fef5@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750918216; l=4198;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=/QnMka8GtzcWlJyc1k0qKztnRSdiplVDLyPIydh5NqE=;
 b=xB7u5Cp2e4wdBmPvNIDKeczWzFIIV/jDR6yOyqYbQ1SH8M4HoZCTC+imqTH8D829DAdmzvkAY
 mXqCdf6nCfYABbD4IU+hZPge6uh7tTqbdBktUUvhy/GR2tq5/hV3xZ/
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Show that the selftests are executed from a fairly "normal"
userspace context.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 MAINTAINERS                 |  1 +
 lib/kunit/Makefile          |  8 +++++++
 lib/kunit/kunit-test-uapi.c | 51 +++++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/kunit-test.c      | 23 +++++++++++++++++++-
 4 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e81dfa180ab374ef91c7a45e546e6e9a8f454fa7..d86e8e0bfee75acecfeb9569d53ea8ea99727985 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13545,6 +13545,7 @@ M:	Thomas Weißschuh <thomas.weissschuh@linutronix.de>
 S:	Maintained
 F:	include/kunit/uapi.h
 F:	lib/kunit/kunit-example-uapi.c
+F:	lib/kunit/kunit-test-uapi.c
 F:	lib/kunit/kunit-uapi.c
 F:	lib/kunit/uapi-preinit.c
 
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index b50f3bc8bc7f3ade03be4900d9163d7a0d96863c..25384e5c3c4cd1f92e4ec2c3830e0be1c6732ac1 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -30,6 +30,14 @@ endif
 obj-$(if $(CONFIG_KUNIT),y) +=		hooks.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
+
+userprogs +=				kunit-test-uapi
+kunit-test-uapi-userccflags :=		-static $(NOLIBC_USERCFLAGS)
+
+ifdef CONFIG_KUNIT_UAPI
+$(obj)/kunit-test.o: $(obj)/kunit-test-uapi
+endif
+
 obj-$(CONFIG_KUNIT_TEST) +=		platform-test.o
 
 # string-stream-test compiles built-in only.
diff --git a/lib/kunit/kunit-test-uapi.c b/lib/kunit/kunit-test-uapi.c
new file mode 100644
index 0000000000000000000000000000000000000000..ec5395d809ee2a4bd3c47a573a576e2f98ef5c1b
--- /dev/null
+++ b/lib/kunit/kunit-test-uapi.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit Userspace selftest.
+ *
+ * Copyright (C) 2025, Linutronix GmbH.
+ * Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ *
+ * This is *userspace* code.
+ */
+
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+
+#include "../../tools/testing/selftests/kselftest.h"
+
+static void test_procfs(void)
+{
+	char buf[256];
+	ssize_t r;
+	int fd;
+
+	fd = open("/proc/self/comm", O_RDONLY);
+	if (fd == -1) {
+		ksft_test_result_fail("procfs: open() failed: %s\n", strerror(errno));
+		return;
+	}
+
+	r = read(fd, buf, sizeof(buf));
+	close(fd);
+
+	if (r == -1) {
+		ksft_test_result_fail("procfs: read() failed: %s\n", strerror(errno));
+		return;
+	}
+
+	if (r != 16 || strncmp("kunit-test-uapi\n", buf, 16) != 0) {
+		ksft_test_result_fail("procfs: incorrect comm\n");
+		return;
+	}
+
+	ksft_test_result_pass("procfs\n");
+}
+
+int main(void)
+{
+	ksft_print_header();
+	ksft_set_plan(1);
+	test_procfs();
+	ksft_finished();
+}
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index d9c781c859fde1f3623eb71b6829e82aa4803762..03972a3cb172d4af61bec17be800ddfb4bbd7268 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -8,6 +8,7 @@
 #include "linux/gfp_types.h"
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
+#include <kunit/uapi.h>
 
 #include <linux/device.h>
 #include <kunit/device.h>
@@ -868,10 +869,30 @@ static struct kunit_suite kunit_current_test_suite = {
 	.test_cases = kunit_current_test_cases,
 };
 
+static void kunit_uapi_test(struct kunit *test)
+{
+	KUNIT_UAPI_EMBED_BLOB(kunit_test_uapi, "kunit-test-uapi");
+
+	if (IS_ENABLED(CONFIG_KUNIT_UAPI))
+		kunit_uapi_run_kselftest(test, &kunit_test_uapi);
+	else
+		kunit_skip(test, "CONFIG_KUNIT_UAPI is not enabled");
+}
+
+static struct kunit_case kunit_uapi_test_cases[] = {
+	KUNIT_CASE(kunit_uapi_test),
+	{}
+};
+
+static struct kunit_suite kunit_uapi_test_suite = {
+	.name = "kunit_uapi",
+	.test_cases = kunit_uapi_test_cases,
+};
+
 kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
 		  &kunit_log_test_suite, &kunit_status_test_suite,
 		  &kunit_current_test_suite, &kunit_device_test_suite,
-		  &kunit_fault_test_suite);
+		  &kunit_fault_test_suite, &kunit_uapi_test_suite);
 
 MODULE_DESCRIPTION("KUnit test for core test infrastructure");
 MODULE_LICENSE("GPL v2");

-- 
2.50.0



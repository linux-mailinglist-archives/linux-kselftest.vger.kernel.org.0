Return-Path: <linux-kselftest+bounces-34658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD2EAD4D47
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81CAE7AD18B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F190248869;
	Wed, 11 Jun 2025 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T5bmVhlo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PT0tliqc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA64623F42A;
	Wed, 11 Jun 2025 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627522; cv=none; b=dYG5/ZSxOCgtsbVdeyhLGE1/D8Bg5+eogArcYNxP++Co0pbN/sYdhKcYrwK9lrEir/QIG+VdNqbUqLEAc27t+Nf2Ecf43JscwYoJ7gY1arlJI60dY4RU7RIFbNLCQpQ+8GRHAxMmzLFjfssq6Fl9+xP63Gw4ZB4RlBqURW7Xdv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627522; c=relaxed/simple;
	bh=NFNt7Qlaqk+bPAFRhwXBhyWH+aNFky6f4VGa4UdOsxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DsPoyCzu7pYOfLwzu2tNGFYB3IZuLgpC07HVkuh5i+JOI0RXUZzlw/h5QxuDsfuFaOQsDMGCWyz3tThG9+T5alVkR4Qart9TjZ5TOxZYMObLGKqsOX403qW3yZVIaCPM/+e5gqpVWNFuFYU+FH7jXtrx2uskv1++IZm8xZYVfXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T5bmVhlo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PT0tliqc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749627517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1R7jll6gJht8nkDymGrhmtxvxJqq0Loxw0lV05Szcc=;
	b=T5bmVhlomsZwAcdU/X7j6dy3T7WarXxEZYR1CXiMRKk+CU796SQVVyAHTS6PQFRQ5gVs5x
	Wese/kbbKWAUJ1dxki/bt88X7jLaSJNauxKYq9ibR2X0O0SIlouvxE03fugjgFxMW2e1re
	QHPyTRCoWkZ5HbuNoM3tqPsMrOlHN1YiO3AwWSkjH70wa17Syf4SzgzL81mR0zZExQC4sf
	w+aeOdFDtewCxLPJgslSZwt3j3EA8BzAcHyUjLdVADvKEOgBa3JwbMtP/GC3IuOppVUyvw
	cuYoHpm/eWKm4gc5hcOp2gQqZi9yH7UsfeAbkenAK3IxK5oIj1aMmQ+lOU1JzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749627517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1R7jll6gJht8nkDymGrhmtxvxJqq0Loxw0lV05Szcc=;
	b=PT0tliqc5evsvvZ4i67OWnTDNH/6Ac0eDMwC7CU/FIay95ZcIy8xl/gMJFV+k2UBU07+Dd
	bDgtv0inwB1/MGAA==
Date: Wed, 11 Jun 2025 09:38:20 +0200
Subject: [PATCH v3 14/16] kunit: uapi: Add example for UAPI tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-kunit-kselftests-v3-14-55e3d148cbc6@linutronix.de>
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
In-Reply-To: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749627510; l=3252;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=NFNt7Qlaqk+bPAFRhwXBhyWH+aNFky6f4VGa4UdOsxk=;
 b=spGlc8yDjyRQUfz/VdgRBAAb7qkA9L7+W1fZOkmv4Jim/pNIBkdQvlRNJtXN+DGP8/r7zzMFs
 TCgUpuwUjiSALsSPVj1aILfRC0X4jvrUyT19wM8nT+07D/0Yz3jB93d
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Extend the example to show how to run a userspace executable.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/kunit/Makefile             |  9 ++++++++-
 lib/kunit/kunit-example-test.c | 15 +++++++++++++++
 lib/kunit/kunit-example-uapi.c | 22 ++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index dafa09bd4241c24d31c4c19edecb67bf724127d7..e406a31df1df834a87961663de0b7921b59481c2 100644
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



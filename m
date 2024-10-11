Return-Path: <linux-kselftest+bounces-19521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67BD999DF3
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 09:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17F84B22D99
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 07:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97F320A5F2;
	Fri, 11 Oct 2024 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MmdFR+wS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DBC20A5E7
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631867; cv=none; b=O4gjVuGRVxFxWQ5zyqPSPAWyqJkQdQwIo4EYJEfxPVKHBEXLr47KqGDsmvcPVmFtFKZi5Xepjv+aqn5mb0Huc6rEjwOaOlsWg7NBbYt/4k7xVBrypnf6iU3uFRt0Hln2UvmJzm24e8dYV/9/ngzOX1lMVQflBWmGfYSZtBpkhpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631867; c=relaxed/simple;
	bh=4UNA/bzgNeQKZNn+GTcFYWje5KcHYL5lIgLuvQk+bVg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u2eZnDQe6qslo49Npx7Iz5tH5IUOAx2I2CV6dBLOdzb6WpDd1rMiEajlpByxS72mZj6Q1TPwfz8rETMWY+YVw2IWePNRvMB0Vvnq8ZhSLUYLNLFwEp4FXHbWaA1i3GqiIfcE8zWKoF5fgDYgvqTctYNgMTFW1LKyQBcXa8dOuZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MmdFR+wS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28ef71f0d8so2730669276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 00:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728631865; x=1729236665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hyJ4dk3YkG68rGowxEN01juZ4Qxhn4HXMW65oX2xFoY=;
        b=MmdFR+wS7HQcaNGwTgXJZmgqQkWg44FK1z72l+XtzfdsLsKk2j+hPEhPICa0Z13W1X
         /PX9hJGm/av57iTIFO/o8emHKOC4PuXLTva5kcabz8CKKLKIR4SIztYdNGy4s4qjI0AD
         zWiKCJaJsZELx/T7IIQ4zW9XD/Zdc4sIRs//9sU0YGl+eY1ayB8zTSimwBS/M1/IyVUK
         Z2xdMcDLQEZlJSKHMoEtfrVQyYMRP5g59FaOrlRJDbmh5q/2xZWEg+0ndlm1grTwz2qb
         gVbNF2nHQdCp1/sso0cV1woK37JM08m1DHRDQZhpjTBsVhNPgzCg8/Y4Nssz9sonxTxd
         0OqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728631865; x=1729236665;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hyJ4dk3YkG68rGowxEN01juZ4Qxhn4HXMW65oX2xFoY=;
        b=Qeu8Ag4oBX2OfYt3ogW+C7RKUslHgMvG7JJHemO41C/KqwU2xYd8VjMK4ZJRw9e3hB
         RZCrMfEmeWVnARp42ihWeCmzbYE7OQw/rOqTG/y3EwlRsWREbDjI16e3uI306EYLisK/
         Rqv/Ech5lySmqHoJG79ApecK+KjLzFGVf8wa/6sQWcjuuRw1jZSCniojd0f+jKCRnQ7i
         52tpS1o1gXeCHcFw0lSB2ypFOt2cL9HlulnSeQmMzWYqJp6CkotfwCDlyVKF5rbOv7sq
         dbCzkImiul596qOXLUm6s3MQsBeDH7apuRfZXYvJDbdxoRkHazXl4EBwpjMOjTNNLxK1
         8vxw==
X-Gm-Message-State: AOJu0YzYIU+cIzUOTJjhTiM5rsZmtgvrCFhH2MKNf54wAXd5UgMmE452
	oUNQOX1dJnAuxhgE7n8WzfNL2H3YaCIrkftCOnzLZIb1AhH7lbq0K6MkM4FQfcM3Xfrsjqt62Hl
	yAVhWkjOeyg==
X-Google-Smtp-Source: AGHT+IEnt/DrbeHagqIrCVFokOqS9C4siCZ3tDEnNfDLr/bUT6Lkv6eaQ6re5XPXQMlsOouyNX83PB9KAt1ZSw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a25:844c:0:b0:e27:3e6a:345 with SMTP id
 3f1490d57ef6-e2919ff8519mr1303276.10.1728631864951; Fri, 11 Oct 2024 00:31:04
 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:25:06 +0800
In-Reply-To: <20241011072509.3068328-2-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011072509.3068328-2-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011072509.3068328-4-davidgow@google.com>
Subject: [PATCH 2/6] lib/math: Add int_log test suite
From: David Gow <davidgow@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>, 
	Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	"=?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?=" <brunofrancadevsec@gmail.com>, 
	linux-kernel-mentees@lists.linuxfoundation.org, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Bruno Sobreira Fran=C3=A7a <brunofrancadevsec@gmail.com>

This commit introduces KUnit tests for the intlog2 and intlog10
functions, which compute logarithms in base 2 and base 10, respectively.
The tests cover a range of inputs to ensure the correctness of these
functions across common and edge cases.

Signed-off-by: Bruno Sobreira Fran=C3=A7a <brunofrancadevsec@gmail.com>
Reviewed-by: David Gow <davidgow@google.com>
[Rebased on top of mm-nonmm-unstable]
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/Kconfig.debug              | 11 +++++
 lib/math/tests/Makefile        |  1 +
 lib/math/tests/int_log_kunit.c | 75 ++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 lib/math/tests/int_log_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3ed6cf950f04..6571243ac232 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3009,6 +3009,17 @@ config INT_POW_KUNIT_TEST
=20
 	  If unsure, say N
=20
+config INT_LOG_KUNIT_TEST
+        tristate "Integer log (int_log) test" if !KUNIT_ALL_TESTS
+        depends on KUNIT
+        default KUNIT_ALL_TESTS
+        help
+          This option enables the KUnit test suite for the int_log library=
, which
+          provides two functions to compute the integer logarithm in base =
2 and
+          base 10, called respectively as intlog2 and intlog10.
+
+          If unsure, say N
+
 endif # RUNTIME_TESTING_MENU
=20
 config ARCH_USE_MEMTEST
diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
index f9a0a0e6b73a..89a266241e98 100644
--- a/lib/math/tests/Makefile
+++ b/lib/math/tests/Makefile
@@ -2,5 +2,6 @@
=20
 obj-$(CONFIG_DIV64_KUNIT_TEST)    +=3D div64_kunit.o
 obj-$(CONFIG_INT_POW_KUNIT_TEST)  +=3D int_pow_kunit.o
+obj-$(CONFIG_INT_LOG_KUNIT_TEST)  +=3D int_log_kunit.o
 obj-$(CONFIG_MULDIV64_KUNIT_TEST) +=3D mul_u64_u64_div_u64_kunit.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) +=3D rational_kunit.o
diff --git a/lib/math/tests/int_log_kunit.c b/lib/math/tests/int_log_kunit.=
c
new file mode 100644
index 000000000000..d750a1df37c1
--- /dev/null
+++ b/lib/math/tests/int_log_kunit.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <kunit/test.h>
+#include <linux/int_log.h>
+
+struct test_case_params {
+	u32 value;
+	unsigned int expected_result;
+	const char *name;
+};
+
+
+/* The expected result takes into account the log error */
+static const struct test_case_params intlog2_params[] =3D {
+	{0, 0, "Log base 2 of 0"},
+	{1, 0, "Log base 2 of 1"},
+	{2, 16777216, "Log base 2 of 2"},
+	{3, 26591232, "Log base 2 of 3"},
+	{4, 33554432, "Log base 2 of 4"},
+	{8, 50331648, "Log base 2 of 8"},
+	{16, 67108864, "Log base 2 of 16"},
+	{32, 83886080, "Log base 2 of 32"},
+	{U32_MAX, 536870911, "Log base 2 of MAX"},
+};
+
+static const struct test_case_params intlog10_params[] =3D {
+	{0, 0, "Log base 10 of 0"},
+	{1, 0, "Log base 10 of 1"},
+	{6, 13055203, "Log base 10 of 6"},
+	{10, 16777225, "Log base 10 of 10"},
+	{100, 33554450, "Log base 10 of 100"},
+	{1000, 50331675, "Log base 10 of 1000"},
+	{10000, 67108862, "Log base 10 of 10000"},
+	{U32_MAX, 161614247, "Log base 10 of MAX"}
+};
+
+static void get_desc(const struct test_case_params *tc, char *desc)
+{
+	strscpy(desc, tc->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+
+KUNIT_ARRAY_PARAM(intlog2, intlog2_params, get_desc);
+
+static void intlog2_test(struct kunit *test)
+{
+	const struct test_case_params *tc =3D (const struct test_case_params *)te=
st->param_value;
+
+	KUNIT_EXPECT_EQ(test, tc->expected_result, intlog2(tc->value));
+}
+
+KUNIT_ARRAY_PARAM(intlog10, intlog10_params, get_desc);
+
+static void intlog10_test(struct kunit *test)
+{
+	const struct test_case_params *tc =3D (const struct test_case_params *)te=
st->param_value;
+
+	KUNIT_EXPECT_EQ(test, tc->expected_result, intlog10(tc->value));
+}
+
+static struct kunit_case math_int_log_test_cases[] =3D {
+	KUNIT_CASE_PARAM(intlog2_test, intlog2_gen_params),
+	KUNIT_CASE_PARAM(intlog10_test, intlog10_gen_params),
+	{}
+};
+
+static struct kunit_suite int_log_test_suite =3D {
+	.name =3D "math-int_log",
+	.test_cases =3D  math_int_log_test_cases,
+};
+
+kunit_test_suites(&int_log_test_suite);
+
+MODULE_DESCRIPTION("math.int_log KUnit test suite");
+MODULE_LICENSE("GPL");
+
--=20
2.47.0.rc1.288.g06298d1525-goog



Return-Path: <linux-kselftest+bounces-26273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 761A6A2FF1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381153A6CD7
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D31D1ADC68;
	Tue, 11 Feb 2025 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3YlhPnV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDF7524F;
	Tue, 11 Feb 2025 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233897; cv=none; b=B/2puNQ91cjUPlpJKxihYWXCNN5AhHfk85Ia8KOxaBh5q3oB9O6F/aPw9r69hzHY4ff9Zuks//hn+7JIpwdeRFQuLLyPnVd49O5p0MqsCgJ2f2ZQc/DAc/anW5jGSX7JyDsaywBg/+O6csG2+NuX6wVKU0wGYKUhbsYF20T/pHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233897; c=relaxed/simple;
	bh=BmsEnez1b0zRvTS3dQOIzftkHPfoxZVnxcnBemZHVVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ce8IR1v14N60YHSchPWUyVwSnZjkh6yyb4ibfl0AmXv25U0pqsBUwIi41FF2etZc42AqxmN4wsKVcAVf8bUdHm6nEPdkkbp6re2BouxpOVCGffi8yxY5bOj6wPIQC2Ib4Q+3TJccwjrz4LnffVOGJqcjFKln56UHE1G6X9Tufnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3YlhPnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D28C4CEEA;
	Tue, 11 Feb 2025 00:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739233896;
	bh=BmsEnez1b0zRvTS3dQOIzftkHPfoxZVnxcnBemZHVVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B3YlhPnVdOIT4e81h2O1aWlE3y2MmeG1thD9FvvPckVivtVpBOKCDtPqFfyfDiuHK
	 BQ1rhHhZbiiSzUEn9p2FLpkfexdgq0ZhNZPaG8JDJakGSep8mnZ/5LRf6MCjlPrCA6
	 HxQleRDT52ioXdy0zySngNKlpkkXqsATiJk7WZ28frEuN3E+U/2hSWcvKwhdX5/2wK
	 7KhoERUBmq0ifrKX4dFUwFKWoGduvWAG5uoKDz1G5V1VlY9JIkmva2BMOPhoyTf6cE
	 xARr5h+ZIjMCwM/3++8KBYgqjdn1xxVIqXNTedKqkfp6Is6ocePkl2n0Gh6hexJWQF
	 3pAYprgudHv2g==
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?= <brunofrancadevsec@gmail.com>,
	Rae Moar <rmoar@google.com>,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	Nicolas Pitre <npitre@baylibre.com>,
	Pedro Orlando <porlando@lkcamp.dev>,
	Danilo Pereira <dpereira@lkcamp.dev>,
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Diego Vieira <diego.daniel.professional@gmail.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH v2 2/6] lib/math: Add int_log test suite
Date: Mon, 10 Feb 2025 16:31:30 -0800
Message-Id: <20250211003136.2860503-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211002600.it.339-kees@kernel.org>
References: <20250211002600.it.339-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4361; i=kees@kernel.org; h=from:subject; bh=mkouk3rvbOl7z7ij3vA30BSZx3TjW2NkPOI4lLL6SNM=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmrZqWecnqy2iG+/peNzdr9jwNaime/2Lpvho6MxWEx0 /Klr17d6yhlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZiIugzDP02Fiz3bTZRWbBbO r389oVFQ5uTcFSk51jMfFnt+/3SkOoWR4ZC7F9PtpLtl3pHhz+dteL3xwol87xtznqVZXNEUdLO o5wIA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Bruno Sobreira França <brunofrancadevsec@gmail.com>

This commit introduces KUnit tests for the intlog2 and intlog10
functions, which compute logarithms in base 2 and base 10, respectively.
The tests cover a range of inputs to ensure the correctness of these
functions across common and edge cases.

Signed-off-by: Bruno Sobreira França <brunofrancadevsec@gmail.com>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Rae Moar <rmoar@google.com>
Link: https://lore.kernel.org/r/20241202075545.3648096-3-davidgow@google.com
Signed-off-by: Kees Cook <kees@kernel.org>
---
 lib/Kconfig.debug              | 11 +++++
 lib/math/tests/Makefile        |  1 +
 lib/math/tests/int_log_kunit.c | 74 ++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 lib/math/tests/int_log_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index b18dbfc53ca4..f30929ed1a84 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3197,6 +3197,17 @@ config INT_SQRT_KUNIT_TEST
 
 	  If unsure, say N
 
+config INT_LOG_KUNIT_TEST
+        tristate "Integer log (int_log) test" if !KUNIT_ALL_TESTS
+        depends on KUNIT
+        default KUNIT_ALL_TESTS
+        help
+          This option enables the KUnit test suite for the int_log library, which
+          provides two functions to compute the integer logarithm in base 2 and
+          base 10, called respectively as intlog2 and intlog10.
+
+          If unsure, say N
+
 endif # RUNTIME_TESTING_MENU
 
 config ARCH_USE_MEMTEST
diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
index 66b10a7f5a84..f139b73c65cb 100644
--- a/lib/math/tests/Makefile
+++ b/lib/math/tests/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_INT_POW_KUNIT_TEST)  += int_pow_kunit.o
+obj-$(CONFIG_INT_LOG_KUNIT_TEST)  += int_log_kunit.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational_kunit.o
 obj-$(CONFIG_INT_SQRT_KUNIT_TEST) += int_sqrt_kunit.o
diff --git a/lib/math/tests/int_log_kunit.c b/lib/math/tests/int_log_kunit.c
new file mode 100644
index 000000000000..14e854146cb4
--- /dev/null
+++ b/lib/math/tests/int_log_kunit.c
@@ -0,0 +1,74 @@
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
+static const struct test_case_params intlog2_params[] = {
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
+static const struct test_case_params intlog10_params[] = {
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
+	const struct test_case_params *tc = (const struct test_case_params *)test->param_value;
+
+	KUNIT_EXPECT_EQ(test, tc->expected_result, intlog2(tc->value));
+}
+
+KUNIT_ARRAY_PARAM(intlog10, intlog10_params, get_desc);
+
+static void intlog10_test(struct kunit *test)
+{
+	const struct test_case_params *tc = (const struct test_case_params *)test->param_value;
+
+	KUNIT_EXPECT_EQ(test, tc->expected_result, intlog10(tc->value));
+}
+
+static struct kunit_case math_int_log_test_cases[] = {
+	KUNIT_CASE_PARAM(intlog2_test, intlog2_gen_params),
+	KUNIT_CASE_PARAM(intlog10_test, intlog10_gen_params),
+	{}
+};
+
+static struct kunit_suite int_log_test_suite = {
+	.name = "math-int_log",
+	.test_cases =  math_int_log_test_cases,
+};
+
+kunit_test_suites(&int_log_test_suite);
+
+MODULE_DESCRIPTION("math.int_log KUnit test suite");
+MODULE_LICENSE("GPL");
-- 
2.34.1



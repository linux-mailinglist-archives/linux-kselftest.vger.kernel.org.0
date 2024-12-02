Return-Path: <linux-kselftest+bounces-22662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DBB9DFB86
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 08:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F30216376F
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 07:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEB71FA245;
	Mon,  2 Dec 2024 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zDRqynqi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968A61FA14D
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126178; cv=none; b=KvkkQtcxU/Ll5MrpZ6WKnHKp9N3WJ6CRg6ltsX/OczfLsJEPIGBiK2pc7vbT73Zlma2unaAqTwI9BBpZeVQG07lbIIozReAymZSpiOrGlipEFKqofRbpGfrIxPm1z2+fBNwM4QquhZKOQheargiFPGyLKd9YsEgKiin9UzwokBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126178; c=relaxed/simple;
	bh=X2z1f0sAHqGegyT+sOhSfCIw8EwDqHE3HD8Hl7jRbmw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C7K2BfiH0i4ER8CpXanORiS+zDNVnNgN/rtool1ePm3QXXUbFO6RhqBOluQnzo62cZhwxwM95+2H4p38F/qVswI6G9V/+vZLddSS6maNht8HWQHHluiUHbBfp5YG92pXKS84KgrQRf/RvRt/MimECLqShD66z8GNINqt5ozM74o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zDRqynqi; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-3ea4ab005daso2671413b6e.2
        for <linux-kselftest@vger.kernel.org>; Sun, 01 Dec 2024 23:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733126176; x=1733730976; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hCHuCWl6FQYdAHHoa+W8WoG3+FHC82MhYNcazj5rwRo=;
        b=zDRqynqiDB2ERCj7A2/x4gMmPwX48xKxGTeY3dcuDKx9QdjQWp5KFVnZoHe5kU5QUG
         VVlvg1nT5Fhh4U5ErR89RarHxnGEIroTy8i9ESKir+1qQtsQ82dbBgn0MUcxQFruhDU5
         0nYbiX1yLf5jBQEXHjRtP1plzg5fnhN5E/14k7raDuTgWxvS0ODHEhb8ju+Cj5AUOI8U
         S3Q8P5Ra8bC+54XOt5/Yb3fQ172+8Sg+l7SUHISwKqq2m+QA8a0Z7yZHhVAzSjS0pQ5i
         b8nYpSuYo9IROTXBrWljkHAeKpLhpb61UNMq+J2HqnjYI3XdtY+NyhLgKTgLdksc48rT
         VG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733126176; x=1733730976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCHuCWl6FQYdAHHoa+W8WoG3+FHC82MhYNcazj5rwRo=;
        b=Syh3mxUyflunwd3I6+Ncvwea6Me0GOZzTJpAoqsQ54Y5tHs77dST63Kl7OMonJ8fQH
         XNLXbVn5GszU7qXkNU9NkSuUvLq9UzX8IIwLBwS+0kcehQnQWOmMJGywm3ZepBmTwtb1
         R6T/QGfBTv0gnR4ZWuUb2OVucPCq6DSELSmYCN18CrWhzY73EZWez62wJNW1FEimFyKd
         mnqU5rrVYHDoapmnlQ5kGp1BB2QZYLsLnil8kpW+B/IAlgF/DDiD6BJ3BN08UVnnm1kE
         TgnxcEfhBImZ9YrY53SasGAzsJjST4zocS9bEBIlr5gvIpYJzY/Y4HFd0inSy43cNJXf
         +LQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRvG3ZeQ5g6/z4d/DFp1zACJIRzsrhfTfuLCPi0LGe9nZU5XH/SAKEYkSwS4iyU/ZWR65LmrNAchH+LKSatNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMSVsSWymhcr+vxs8t+0ttZ7p5nLWh9RkKPko/Kl/eYBDXk0V+
	Sd4Tq4ipl/DNEzASNE3Kqfk+o8V4jkUkWWArPlap/0QKSB5Jw+cd2z4DCHbiBwhNL/gLtLW86jZ
	mSFI10S6mEQ==
X-Google-Smtp-Source: AGHT+IGZJ1wGhvA1+Yj7lk7qWxVg4KwKq8/ipRlHpGygo6v/PQu1oTbDr4mRHKzQxU+FmbMhWMCAS76oknmg6g==
X-Received: from pfbbw14.prod.google.com ([2002:a05:6a00:408e:b0:720:426b:45fb])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1801:b0:3e6:1a1b:e4dc with SMTP id 5614622812f47-3ea6dbc9d95mr12251176b6e.18.1733126175869;
 Sun, 01 Dec 2024 23:56:15 -0800 (PST)
Date: Mon,  2 Dec 2024 15:55:42 +0800
In-Reply-To: <20241202075545.3648096-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241202075545.3648096-1-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202075545.3648096-6-davidgow@google.com>
Subject: [PATCH v2 5/6] unicode: kunit: refactor selftest to kunit tests
From: David Gow <davidgow@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Rae Moar <rmoar@google.com>, Kees Cook <kees@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Gabriela Bittencourt <gbittencourt@lkcamp.dev>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Andy Shevchenko <andy@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Pedro Orlando <porlando@lkcamp.dev>, 
	Danilo Pereira <dpereira@lkcamp.dev>, David Gow <davidgow@google.com>, 
	Gabriel Krisman Bertazi <krisman@suse.de>
Content-Type: text/plain; charset="UTF-8"

From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>

Refactoring 'test' functions into kunit tests, to test utf-8 support in
unicode subsystem.

This allows the utf8 tests to be run alongside the KUnit test suite
using kunit-tool, quickly compiling and running all desired tests as
part of the KUnit test suite, instead of compiling the selftest module
and loading it.

The refactoring kept the original testing logic intact, while adopting a
testing pattern across different kernel modules and leveraging KUnit's
benefits.

Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
Reviewed-by: David Gow <davidgow@google.com>
Acked-by: Gabriel Krisman Bertazi <krisman@suse.de>
[rebased on top of 6.13-rc1]
Signed-off-by: David Gow <davidgow@google.com>
---
 fs/unicode/.kunitconfig    |   3 +
 fs/unicode/Kconfig         |   5 +-
 fs/unicode/Makefile        |   2 +-
 fs/unicode/utf8-norm.c     |   2 +-
 fs/unicode/utf8-selftest.c | 149 +++++++++++++++++--------------------
 5 files changed, 77 insertions(+), 84 deletions(-)
 create mode 100644 fs/unicode/.kunitconfig

diff --git a/fs/unicode/.kunitconfig b/fs/unicode/.kunitconfig
new file mode 100644
index 000000000000..62dd5c171f9c
--- /dev/null
+++ b/fs/unicode/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_UNICODE=y
+CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST=y
diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
index da786a687fdc..4ad2c36550f1 100644
--- a/fs/unicode/Kconfig
+++ b/fs/unicode/Kconfig
@@ -10,6 +10,7 @@ config UNICODE
 	  be a separate loadable module that gets requested only when a file
 	  system actually use it.
 
-config UNICODE_NORMALIZATION_SELFTEST
+config UNICODE_NORMALIZATION_KUNIT_TEST
 	tristate "Test UTF-8 normalization support"
-	depends on UNICODE
+	depends on UNICODE && KUNIT
+	default KUNIT_ALL_TESTS
diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
index e309afe2b2bb..37bbcbc628a1 100644
--- a/fs/unicode/Makefile
+++ b/fs/unicode/Makefile
@@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
 obj-y			+= unicode.o
 endif
 obj-$(CONFIG_UNICODE)	+= utf8data.o
-obj-$(CONFIG_UNICODE_NORMALIZATION_SELFTEST) += utf8-selftest.o
+obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += utf8-selftest.o
 
 unicode-y := utf8-norm.o utf8-core.o
 
diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
index 768f8ab448b8..7b998c99c88d 100644
--- a/fs/unicode/utf8-norm.c
+++ b/fs/unicode/utf8-norm.c
@@ -586,7 +586,7 @@ int utf8byte(struct utf8cursor *u8c)
 	}
 }
 
-#ifdef CONFIG_UNICODE_NORMALIZATION_SELFTEST_MODULE
+#if IS_MODULE(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST)
 EXPORT_SYMBOL_GPL(utf8version_is_supported);
 EXPORT_SYMBOL_GPL(utf8nlen);
 EXPORT_SYMBOL_GPL(utf8ncursor);
diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
index 5ddaf27b21a6..9476ab012baa 100644
--- a/fs/unicode/utf8-selftest.c
+++ b/fs/unicode/utf8-selftest.c
@@ -1,35 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Kernel module for testing utf-8 support.
+ * KUnit tests for utf-8 support.
  *
  * Copyright 2017 Collabora Ltd.
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/module.h>
-#include <linux/printk.h>
 #include <linux/unicode.h>
-#include <linux/dcache.h>
+#include <kunit/test.h>
 
 #include "utf8n.h"
 
-static unsigned int failed_tests;
-static unsigned int total_tests;
-
-#define _test(cond, func, line, fmt, ...) do {				\
-		total_tests++;						\
-		if (!cond) {						\
-			failed_tests++;					\
-			pr_err("test %s:%d Failed: %s%s",		\
-			       func, line, #cond, (fmt?":":"."));	\
-			if (fmt)					\
-				pr_err(fmt, ##__VA_ARGS__);		\
-		}							\
-	} while (0)
-#define test_f(cond, fmt, ...) _test(cond, __func__, __LINE__, fmt, ##__VA_ARGS__)
-#define test(cond) _test(cond, __func__, __LINE__, "")
-
 static const struct {
 	/* UTF-8 strings in this vector _must_ be NULL-terminated. */
 	unsigned char str[10];
@@ -167,69 +147,74 @@ static int utf8cursor(struct utf8cursor *u8c, const struct unicode_map *um,
 	return utf8ncursor(u8c, um, n, s, (unsigned int)-1);
 }
 
-static void check_utf8_nfdi(struct unicode_map *um)
+static void check_utf8_nfdi(struct kunit *test)
 {
 	int i;
 	struct utf8cursor u8c;
+	struct unicode_map *um = test->priv;
 
 	for (i = 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
 		int len = strlen(nfdi_test_data[i].str);
 		int nlen = strlen(nfdi_test_data[i].dec);
 		int j = 0;
 		unsigned char c;
+		int ret;
+
+		KUNIT_EXPECT_EQ(test, utf8len(um, UTF8_NFDI, nfdi_test_data[i].str), nlen);
+		KUNIT_EXPECT_EQ(test, utf8nlen(um, UTF8_NFDI, nfdi_test_data[i].str, len),
+				nlen);
 
-		test((utf8len(um, UTF8_NFDI, nfdi_test_data[i].str) == nlen));
-		test((utf8nlen(um, UTF8_NFDI, nfdi_test_data[i].str, len) ==
-			nlen));
 
-		if (utf8cursor(&u8c, um, UTF8_NFDI, nfdi_test_data[i].str) < 0)
-			pr_err("can't create cursor\n");
+		ret = utf8cursor(&u8c, um, UTF8_NFDI, nfdi_test_data[i].str);
+		KUNIT_EXPECT_TRUE_MSG(test, ret >= 0, "Can't create cursor\n");
 
 		while ((c = utf8byte(&u8c)) > 0) {
-			test_f((c == nfdi_test_data[i].dec[j]),
-			       "Unexpected byte 0x%x should be 0x%x\n",
-			       c, nfdi_test_data[i].dec[j]);
+			KUNIT_EXPECT_EQ_MSG(test, c, nfdi_test_data[i].dec[j],
+					    "Unexpected byte 0x%x should be 0x%x\n",
+					    c, nfdi_test_data[i].dec[j]);
 			j++;
 		}
 
-		test((j == nlen));
+		KUNIT_EXPECT_EQ(test, j, nlen);
 	}
 }
 
-static void check_utf8_nfdicf(struct unicode_map *um)
+static void check_utf8_nfdicf(struct kunit *test)
 {
 	int i;
 	struct utf8cursor u8c;
+	struct unicode_map *um = test->priv;
 
 	for (i = 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
 		int len = strlen(nfdicf_test_data[i].str);
 		int nlen = strlen(nfdicf_test_data[i].ncf);
 		int j = 0;
+		int ret;
 		unsigned char c;
 
-		test((utf8len(um, UTF8_NFDICF, nfdicf_test_data[i].str) ==
-				nlen));
-		test((utf8nlen(um, UTF8_NFDICF, nfdicf_test_data[i].str, len) ==
-				nlen));
+		KUNIT_EXPECT_EQ(test, utf8len(um, UTF8_NFDICF, nfdicf_test_data[i].str),
+				nlen);
+		KUNIT_EXPECT_EQ(test, utf8nlen(um, UTF8_NFDICF, nfdicf_test_data[i].str, len),
+				nlen);
 
-		if (utf8cursor(&u8c, um, UTF8_NFDICF,
-				nfdicf_test_data[i].str) < 0)
-			pr_err("can't create cursor\n");
+		ret = utf8cursor(&u8c, um, UTF8_NFDICF, nfdicf_test_data[i].str);
+		KUNIT_EXPECT_TRUE_MSG(test, ret >= 0, "Can't create cursor\n");
 
 		while ((c = utf8byte(&u8c)) > 0) {
-			test_f((c == nfdicf_test_data[i].ncf[j]),
-			       "Unexpected byte 0x%x should be 0x%x\n",
-			       c, nfdicf_test_data[i].ncf[j]);
+			KUNIT_EXPECT_EQ_MSG(test, c, nfdicf_test_data[i].ncf[j],
+					    "Unexpected byte 0x%x should be 0x%x\n",
+					    c, nfdicf_test_data[i].ncf[j]);
 			j++;
 		}
 
-		test((j == nlen));
+		KUNIT_EXPECT_EQ(test, j, nlen);
 	}
 }
 
-static void check_utf8_comparisons(struct unicode_map *table)
+static void check_utf8_comparisons(struct kunit *test)
 {
 	int i;
+	struct unicode_map *um = test->priv;
 
 	for (i = 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
 		const struct qstr s1 = {.name = nfdi_test_data[i].str,
@@ -237,8 +222,9 @@ static void check_utf8_comparisons(struct unicode_map *table)
 		const struct qstr s2 = {.name = nfdi_test_data[i].dec,
 					.len = sizeof(nfdi_test_data[i].dec)};
 
-		test_f(!utf8_strncmp(table, &s1, &s2),
-		       "%s %s comparison mismatch\n", s1.name, s2.name);
+		/* strncmp returns 0 when strings are equal */
+		KUNIT_EXPECT_TRUE_MSG(test, utf8_strncmp(um, &s1, &s2) == 0,
+				    "%s %s comparison mismatch\n", s1.name, s2.name);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
@@ -247,62 +233,65 @@ static void check_utf8_comparisons(struct unicode_map *table)
 		const struct qstr s2 = {.name = nfdicf_test_data[i].ncf,
 					.len = sizeof(nfdicf_test_data[i].ncf)};
 
-		test_f(!utf8_strncasecmp(table, &s1, &s2),
-		       "%s %s comparison mismatch\n", s1.name, s2.name);
+		/* strncasecmp returns 0 when strings are equal */
+		KUNIT_EXPECT_TRUE_MSG(test, utf8_strncasecmp(um, &s1, &s2) == 0,
+				    "%s %s comparison mismatch\n", s1.name, s2.name);
 	}
 }
 
-static void check_supported_versions(struct unicode_map *um)
+static void check_supported_versions(struct kunit *test)
 {
+	struct unicode_map *um = test->priv;
 	/* Unicode 7.0.0 should be supported. */
-	test(utf8version_is_supported(um, UNICODE_AGE(7, 0, 0)));
+	KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UNICODE_AGE(7, 0, 0)));
 
 	/* Unicode 9.0.0 should be supported. */
-	test(utf8version_is_supported(um, UNICODE_AGE(9, 0, 0)));
+	KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UNICODE_AGE(9, 0, 0)));
 
 	/* Unicode 1x.0.0 (the latest version) should be supported. */
-	test(utf8version_is_supported(um, UTF8_LATEST));
+	KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UTF8_LATEST));
 
 	/* Next versions don't exist. */
-	test(!utf8version_is_supported(um, UNICODE_AGE(13, 0, 0)));
-	test(!utf8version_is_supported(um, UNICODE_AGE(0, 0, 0)));
-	test(!utf8version_is_supported(um, UNICODE_AGE(-1, -1, -1)));
+	KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(13, 0, 0)));
+	KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(0, 0, 0)));
+	KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(-1, -1, -1)));
 }
 
-static int __init init_test_ucd(void)
+static struct kunit_case unicode_normalization_test_cases[] = {
+	KUNIT_CASE(check_supported_versions),
+	KUNIT_CASE(check_utf8_comparisons),
+	KUNIT_CASE(check_utf8_nfdicf),
+	KUNIT_CASE(check_utf8_nfdi),
+	{}
+};
+
+static int init_test_ucd(struct kunit *test)
 {
-	struct unicode_map *um;
+	struct unicode_map *um = utf8_load(UTF8_LATEST);
 
-	failed_tests = 0;
-	total_tests = 0;
+	test->priv = um;
 
-	um = utf8_load(UTF8_LATEST);
-	if (IS_ERR(um)) {
-		pr_err("%s: Unable to load utf8 table.\n", __func__);
-		return PTR_ERR(um);
-	}
+	KUNIT_EXPECT_EQ_MSG(test, IS_ERR(um), 0,
+			    "%s: Unable to load utf8 table.\n", __func__);
 
-	check_supported_versions(um);
-	check_utf8_nfdi(um);
-	check_utf8_nfdicf(um);
-	check_utf8_comparisons(um);
-
-	if (!failed_tests)
-		pr_info("All %u tests passed\n", total_tests);
-	else
-		pr_err("%u out of %u tests failed\n", failed_tests,
-		       total_tests);
-	utf8_unload(um);
 	return 0;
 }
 
-static void __exit exit_test_ucd(void)
+static void exit_test_ucd(struct kunit *test)
 {
+	utf8_unload(test->priv);
 }
 
-module_init(init_test_ucd);
-module_exit(exit_test_ucd);
+static struct kunit_suite unicode_normalization_test_suite = {
+	.name = "unicode_normalization",
+	.test_cases = unicode_normalization_test_cases,
+	.init = init_test_ucd,
+	.exit = exit_test_ucd,
+};
+
+kunit_test_suite(unicode_normalization_test_suite);
+
 
 MODULE_AUTHOR("Gabriel Krisman Bertazi <krisman@collabora.co.uk>");
-MODULE_DESCRIPTION("Kernel module for testing utf-8 support");
+MODULE_DESCRIPTION("KUnit tests for utf-8 support.");
 MODULE_LICENSE("GPL");
-- 
2.47.0.338.g60cca15819-goog



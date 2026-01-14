Return-Path: <linux-kselftest+bounces-48913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A340ED1D661
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 10:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC00F309C392
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 08:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B48E3803E8;
	Wed, 14 Jan 2026 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SOX5GWwr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2C37FF47
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381182; cv=none; b=YtCW4mDoLkoUaM2B3LEwihlIFKpcW0qTL9/+A4cDX6gl5a9tsOnGJamEZ+lapRLhg5Pei6OJhkIQFYcFkWZt0GbKOg7ePrAMc671Kpi9rXbENOJy0WF53wtSal6+wZqojMFEnIz83PE74GOMS9H/idLDlvGlyiK0lNwiWBGLd5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381182; c=relaxed/simple;
	bh=AXcncB8cVGGHhldgQyoX8ZrEQuko2sGpm2O0f9IUnOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DW2nkDFMk4soAW1EjpIYvLhxmCKgALwSTLI37fqaCb/Dx7Ns2PTmvO3406wZ7c7aVZJPTHo4HSWNY5iuaTK3F+FT1VYJCPth+0grY+OgIFo+7KNARVodARsQ0+YMaoOJA6QHxWjHHAsRe/MLtIGa+e+z6AOen4L9oa1DKp5tbqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SOX5GWwr; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 865EFC1C3AB;
	Wed, 14 Jan 2026 08:59:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2A4876074A;
	Wed, 14 Jan 2026 08:59:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED12F103C8396;
	Wed, 14 Jan 2026 09:59:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768381175; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NcEoWUb5aJwsVAuuDv3WRH6UAsZs2JrlSDjQHU9FbrI=;
	b=SOX5GWwrY+UGf2RNQEqIdd7Uzqc3R+5gGFaB+sM1Vitseb08i2V0goabiyvkt8BANxPmff
	kUwfxTnEXckoqIel3NtTvQf/Z9ry5+W8QjhH5F9f5mWnGPMqhiLHjPFHDPE8FjZDfaP7x4
	LvmeSGZ4SQjhbLQCALKHxiFz2hgVfWlF5cjDCywfkFrlBA4WeVP675JSB5wk3DQSZCaqBD
	bU6HuKx8XFUsri9EUbOME2B7QK7AExv9hPqcM+H1LXUDGJXctYyZ92G4j9tTdBFSKI4pSd
	kAGV01sLIvd1EkVZris3FAkhnUQAB0g9ncKIBBIMPnnHVMFwmMy2rDXkmkTtwQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 14 Jan 2026 09:59:12 +0100
Subject: [PATCH bpf-next 1/4] bpf/selftests: move assert macros into a
 dedicated header
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260114-bpftool-tests-v1-1-cfab1cc9beaf@bootlin.com>
References: <20260114-bpftool-tests-v1-0-cfab1cc9beaf@bootlin.com>
In-Reply-To: <20260114-bpftool-tests-v1-0-cfab1cc9beaf@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The test_progs runner defines a large set of convenient assert macros to
perform all the tests. Writing a new runner involves rewriting some
macros if we want some basic testing features like standardized failure
log.

Export those assert macros from test_progs into a dedicated header so
that we can use those in any test_runner. The sole requirement to be
able to use those macros is to define a test__fail function in the
runner that will be called whenever an assert fails.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/assert_helpers.h | 231 +++++++++++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h     | 226 +-------------------------
 2 files changed, 232 insertions(+), 225 deletions(-)

diff --git a/tools/testing/selftests/bpf/assert_helpers.h b/tools/testing/selftests/bpf/assert_helpers.h
new file mode 100644
index 000000000000..93ab5bf39431
--- /dev/null
+++ b/tools/testing/selftests/bpf/assert_helpers.h
@@ -0,0 +1,231 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#pragma once
+#include <stdio.h>
+#include <errno.h>
+#include <stdbool.h>
+
+#define _CHECK(condition, tag, duration, format...) ({			\
+	int __ret = !!(condition);					\
+	int __save_errno = errno;					\
+	if (__ret) {							\
+		test__fail();						\
+		fprintf(stdout, "%s:FAIL:%s ", __func__, tag);		\
+		fprintf(stdout, ##format);				\
+	} else {							\
+		fprintf(stdout, "%s:PASS:%s %d nsec\n",			\
+		       __func__, tag, duration);			\
+	}								\
+	errno = __save_errno;						\
+	__ret;								\
+})
+
+#define CHECK_FAIL(condition) ({					\
+	int __ret = !!(condition);					\
+	int __save_errno = errno;					\
+	if (__ret) {							\
+		test__fail();						\
+		fprintf(stdout, "%s:FAIL:%d\n", __func__, __LINE__);	\
+	}								\
+	errno = __save_errno;						\
+	__ret;								\
+})
+
+#define CHECK(condition, tag, format...) \
+	_CHECK(condition, tag, duration, format)
+#define CHECK_ATTR(condition, tag, format...) \
+	_CHECK(condition, tag, tattr.duration, format)
+
+#define ASSERT_FAIL(fmt, args...) ({					\
+	static int duration;						\
+	CHECK(false, "", fmt"\n", ##args);				\
+	false;								\
+})
+
+#define ASSERT_TRUE(actual, name) ({					\
+	static int duration;						\
+	bool ___ok = (actual);						\
+	CHECK(!___ok, (name), "unexpected %s: got FALSE\n", (name));	\
+	___ok;								\
+})
+
+#define ASSERT_FALSE(actual, name) ({					\
+	static int duration;						\
+	bool ___ok = !(actual);						\
+	CHECK(!___ok, (name), "unexpected %s: got TRUE\n", (name));	\
+	___ok;								\
+})
+
+#define ASSERT_EQ(actual, expected, name) ({				\
+	static int duration;						\
+	typeof(actual) ___act = (actual);				\
+	typeof(expected) ___exp = (expected);				\
+	bool ___ok = ___act == ___exp;					\
+	CHECK(!___ok, (name),						\
+	      "unexpected %s: actual %lld != expected %lld\n",		\
+	      (name), (long long)(___act), (long long)(___exp));	\
+	___ok;								\
+})
+
+#define ASSERT_NEQ(actual, expected, name) ({				\
+	static int duration;						\
+	typeof(actual) ___act = (actual);				\
+	typeof(expected) ___exp = (expected);				\
+	bool ___ok = ___act != ___exp;					\
+	CHECK(!___ok, (name),						\
+	      "unexpected %s: actual %lld == expected %lld\n",		\
+	      (name), (long long)(___act), (long long)(___exp));	\
+	___ok;								\
+})
+
+#define ASSERT_LT(actual, expected, name) ({				\
+	static int duration;						\
+	typeof(actual) ___act = (actual);				\
+	typeof(expected) ___exp = (expected);				\
+	bool ___ok = ___act < ___exp;					\
+	CHECK(!___ok, (name),						\
+	      "unexpected %s: actual %lld >= expected %lld\n",		\
+	      (name), (long long)(___act), (long long)(___exp));	\
+	___ok;								\
+})
+
+#define ASSERT_LE(actual, expected, name) ({				\
+	static int duration;						\
+	typeof(actual) ___act = (actual);				\
+	typeof(expected) ___exp = (expected);				\
+	bool ___ok = ___act <= ___exp;					\
+	CHECK(!___ok, (name),						\
+	      "unexpected %s: actual %lld > expected %lld\n",		\
+	      (name), (long long)(___act), (long long)(___exp));	\
+	___ok;								\
+})
+
+#define ASSERT_GT(actual, expected, name) ({				\
+	static int duration;						\
+	typeof(actual) ___act = (actual);				\
+	typeof(expected) ___exp = (expected);				\
+	bool ___ok = ___act > ___exp;					\
+	CHECK(!___ok, (name),						\
+	      "unexpected %s: actual %lld <= expected %lld\n",		\
+	      (name), (long long)(___act), (long long)(___exp));	\
+	___ok;								\
+})
+
+#define ASSERT_GE(actual, expected, name) ({				\
+	static int duration;						\
+	typeof(actual) ___act = (actual);				\
+	typeof(expected) ___exp = (expected);				\
+	bool ___ok = ___act >= ___exp;					\
+	CHECK(!___ok, (name),						\
+	      "unexpected %s: actual %lld < expected %lld\n",		\
+	      (name), (long long)(___act), (long long)(___exp));	\
+	___ok;								\
+})
+
+#define ASSERT_STREQ(actual, expected, name) ({				\
+	static int duration;						\
+	const char *___act = actual;					\
+	const char *___exp = expected;					\
+	bool ___ok = strcmp(___act, ___exp) == 0;			\
+	CHECK(!___ok, (name),						\
+	      "unexpected %s: actual '%s' != expected '%s'\n",		\
+	      (name), ___act, ___exp);					\
+	___ok;								\
+})
+
+#define ASSERT_STRNEQ(actual, expected, len, name) ({			\
+	static int duration;						\
+	const char *___act = actual;					\
+	const char *___exp = expected;					\
+	int ___len = len;						\
+	bool ___ok = strncmp(___act, ___exp, ___len) == 0;		\
+	CHECK(!___ok, (name),						\
+	      "unexpected %s: actual '%.*s' != expected '%.*s'\n",	\
+	      (name), ___len, ___act, ___len, ___exp);			\
+	___ok;								\
+})
+
+#define ASSERT_HAS_SUBSTR(str, substr, name) ({				\
+	static int duration;						\
+	const char *___str = str;					\
+	const char *___substr = substr;					\
+	bool ___ok = strstr(___str, ___substr) != NULL;			\
+	CHECK(!___ok, (name),						\
+	      "unexpected %s: '%s' is not a substring of '%s'\n",	\
+	      (name), ___substr, ___str);				\
+	___ok;								\
+})
+
+#define ASSERT_MEMEQ(actual, expected, len, name) ({			\
+	static int duration;						\
+	const void *__act = actual;					\
+	const void *__exp = expected;					\
+	int __len = len;						\
+	bool ___ok = memcmp(__act, __exp, __len) == 0;			\
+	CHECK(!___ok, (name), "unexpected memory mismatch\n");		\
+	fprintf(stdout, "actual:\n");					\
+	hexdump("\t", __act, __len);					\
+	fprintf(stdout, "expected:\n");					\
+	hexdump("\t", __exp, __len);					\
+	___ok;								\
+})
+
+#define ASSERT_OK(res, name) ({						\
+	static int duration;						\
+	long long ___res = (res);					\
+	bool ___ok = ___res == 0;					\
+	CHECK(!___ok, (name), "unexpected error: %lld (errno %d)\n",	\
+	      ___res, errno);						\
+	___ok;								\
+})
+
+#define ASSERT_ERR(res, name) ({					\
+	static int duration;						\
+	long long ___res = (res);					\
+	bool ___ok = ___res < 0;					\
+	CHECK(!___ok, (name), "unexpected success: %lld\n", ___res);	\
+	___ok;								\
+})
+
+#define ASSERT_NULL(ptr, name) ({					\
+	static int duration;						\
+	const void *___res = (ptr);					\
+	bool ___ok = !___res;						\
+	CHECK(!___ok, (name), "unexpected pointer: %p\n", ___res);	\
+	___ok;								\
+})
+
+#define ASSERT_OK_PTR(ptr, name) ({					\
+	static int duration;						\
+	const void *___res = (ptr);					\
+	int ___err = libbpf_get_error(___res);				\
+	bool ___ok = ___err == 0;					\
+	CHECK(!___ok, (name), "unexpected error: %d\n", ___err);	\
+	___ok;								\
+})
+
+#define ASSERT_ERR_PTR(ptr, name) ({					\
+	static int duration;						\
+	const void *___res = (ptr);					\
+	int ___err = libbpf_get_error(___res);				\
+	bool ___ok = ___err != 0;					\
+	CHECK(!___ok, (name), "unexpected pointer: %p\n", ___res);	\
+	___ok;								\
+})
+
+#define ASSERT_OK_FD(fd, name) ({					\
+	static int duration;						\
+	int ___fd = (fd);						\
+	bool ___ok = ___fd >= 0;					\
+	CHECK(!___ok, (name), "unexpected fd: %d (errno %d)\n",		\
+	      ___fd, errno);						\
+	___ok;								\
+})
+
+#define ASSERT_ERR_FD(fd, name) ({					\
+	static int duration;						\
+	int ___fd = (fd);						\
+	bool ___ok = ___fd < 0;						\
+	CHECK(!___ok, (name), "unexpected fd: %d\n", ___fd);		\
+	___ok;								\
+})
+
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index eebfc18cdcd2..bb876d8f6bcc 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -42,6 +42,7 @@ typedef __u16 __sum16;
 #include <bpf/bpf_endian.h>
 #include "trace_helpers.h"
 #include "testing_helpers.h"
+#include "assert_helpers.h"
 
 enum verbosity {
 	VERBOSE_NONE,
@@ -195,231 +196,6 @@ void hexdump(const char *prefix, const void *buf, size_t len);
 		fprintf(stdout, ##format);                                     \
 	})
 
-#define _CHECK(condition, tag, duration, format...) ({			\
-	int __ret = !!(condition);					\
-	int __save_errno = errno;					\
-	if (__ret) {							\
-		test__fail();						\
-		fprintf(stdout, "%s:FAIL:%s ", __func__, tag);		\
-		fprintf(stdout, ##format);				\
-	} else {							\
-		fprintf(stdout, "%s:PASS:%s %d nsec\n",			\
-		       __func__, tag, duration);			\
-	}								\
-	errno = __save_errno;						\
-	__ret;								\
-})
-
-#define CHECK_FAIL(condition) ({					\
-	int __ret = !!(condition);					\
-	int __save_errno = errno;					\
-	if (__ret) {							\
-		test__fail();						\
-		fprintf(stdout, "%s:FAIL:%d\n", __func__, __LINE__);	\
-	}								\
-	errno = __save_errno;						\
-	__ret;								\
-})
-
-#define CHECK(condition, tag, format...) \
-	_CHECK(condition, tag, duration, format)
-#define CHECK_ATTR(condition, tag, format...) \
-	_CHECK(condition, tag, tattr.duration, format)
-
-#define ASSERT_FAIL(fmt, args...) ({					\
-	static int duration = 0;					\
-	CHECK(false, "", fmt"\n", ##args);				\
-	false;								\
-})
-
-#define ASSERT_TRUE(actual, name) ({					\
-	static int duration = 0;					\
-	bool ___ok = (actual);						\
-	CHECK(!___ok, (name), "unexpected %s: got FALSE\n", (name));	\
-	___ok;								\
-})
-
-#define ASSERT_FALSE(actual, name) ({					\
-	static int duration = 0;					\
-	bool ___ok = !(actual);						\
-	CHECK(!___ok, (name), "unexpected %s: got TRUE\n", (name));	\
-	___ok;								\
-})
-
-#define ASSERT_EQ(actual, expected, name) ({				\
-	static int duration = 0;					\
-	typeof(actual) ___act = (actual);				\
-	typeof(expected) ___exp = (expected);				\
-	bool ___ok = ___act == ___exp;					\
-	CHECK(!___ok, (name),						\
-	      "unexpected %s: actual %lld != expected %lld\n",		\
-	      (name), (long long)(___act), (long long)(___exp));	\
-	___ok;								\
-})
-
-#define ASSERT_NEQ(actual, expected, name) ({				\
-	static int duration = 0;					\
-	typeof(actual) ___act = (actual);				\
-	typeof(expected) ___exp = (expected);				\
-	bool ___ok = ___act != ___exp;					\
-	CHECK(!___ok, (name),						\
-	      "unexpected %s: actual %lld == expected %lld\n",		\
-	      (name), (long long)(___act), (long long)(___exp));	\
-	___ok;								\
-})
-
-#define ASSERT_LT(actual, expected, name) ({				\
-	static int duration = 0;					\
-	typeof(actual) ___act = (actual);				\
-	typeof(expected) ___exp = (expected);				\
-	bool ___ok = ___act < ___exp;					\
-	CHECK(!___ok, (name),						\
-	      "unexpected %s: actual %lld >= expected %lld\n",		\
-	      (name), (long long)(___act), (long long)(___exp));	\
-	___ok;								\
-})
-
-#define ASSERT_LE(actual, expected, name) ({				\
-	static int duration = 0;					\
-	typeof(actual) ___act = (actual);				\
-	typeof(expected) ___exp = (expected);				\
-	bool ___ok = ___act <= ___exp;					\
-	CHECK(!___ok, (name),						\
-	      "unexpected %s: actual %lld > expected %lld\n",		\
-	      (name), (long long)(___act), (long long)(___exp));	\
-	___ok;								\
-})
-
-#define ASSERT_GT(actual, expected, name) ({				\
-	static int duration = 0;					\
-	typeof(actual) ___act = (actual);				\
-	typeof(expected) ___exp = (expected);				\
-	bool ___ok = ___act > ___exp;					\
-	CHECK(!___ok, (name),						\
-	      "unexpected %s: actual %lld <= expected %lld\n",		\
-	      (name), (long long)(___act), (long long)(___exp));	\
-	___ok;								\
-})
-
-#define ASSERT_GE(actual, expected, name) ({				\
-	static int duration = 0;					\
-	typeof(actual) ___act = (actual);				\
-	typeof(expected) ___exp = (expected);				\
-	bool ___ok = ___act >= ___exp;					\
-	CHECK(!___ok, (name),						\
-	      "unexpected %s: actual %lld < expected %lld\n",		\
-	      (name), (long long)(___act), (long long)(___exp));	\
-	___ok;								\
-})
-
-#define ASSERT_STREQ(actual, expected, name) ({				\
-	static int duration = 0;					\
-	const char *___act = actual;					\
-	const char *___exp = expected;					\
-	bool ___ok = strcmp(___act, ___exp) == 0;			\
-	CHECK(!___ok, (name),						\
-	      "unexpected %s: actual '%s' != expected '%s'\n",		\
-	      (name), ___act, ___exp);					\
-	___ok;								\
-})
-
-#define ASSERT_STRNEQ(actual, expected, len, name) ({			\
-	static int duration = 0;					\
-	const char *___act = actual;					\
-	const char *___exp = expected;					\
-	int ___len = len;						\
-	bool ___ok = strncmp(___act, ___exp, ___len) == 0;		\
-	CHECK(!___ok, (name),						\
-	      "unexpected %s: actual '%.*s' != expected '%.*s'\n",	\
-	      (name), ___len, ___act, ___len, ___exp);			\
-	___ok;								\
-})
-
-#define ASSERT_HAS_SUBSTR(str, substr, name) ({				\
-	static int duration = 0;					\
-	const char *___str = str;					\
-	const char *___substr = substr;					\
-	bool ___ok = strstr(___str, ___substr) != NULL;			\
-	CHECK(!___ok, (name),						\
-	      "unexpected %s: '%s' is not a substring of '%s'\n",	\
-	      (name), ___substr, ___str);				\
-	___ok;								\
-})
-
-#define ASSERT_MEMEQ(actual, expected, len, name) ({			\
-	static int duration = 0;					\
-	const void *__act = actual;					\
-	const void *__exp = expected;					\
-	int __len = len;						\
-	bool ___ok = memcmp(__act, __exp, __len) == 0;			\
-	CHECK(!___ok, (name), "unexpected memory mismatch\n");		\
-	fprintf(stdout, "actual:\n");					\
-	hexdump("\t", __act, __len);					\
-	fprintf(stdout, "expected:\n");					\
-	hexdump("\t", __exp, __len);					\
-	___ok;								\
-})
-
-#define ASSERT_OK(res, name) ({						\
-	static int duration = 0;					\
-	long long ___res = (res);					\
-	bool ___ok = ___res == 0;					\
-	CHECK(!___ok, (name), "unexpected error: %lld (errno %d)\n",	\
-	      ___res, errno);						\
-	___ok;								\
-})
-
-#define ASSERT_ERR(res, name) ({					\
-	static int duration = 0;					\
-	long long ___res = (res);					\
-	bool ___ok = ___res < 0;					\
-	CHECK(!___ok, (name), "unexpected success: %lld\n", ___res);	\
-	___ok;								\
-})
-
-#define ASSERT_NULL(ptr, name) ({					\
-	static int duration = 0;					\
-	const void *___res = (ptr);					\
-	bool ___ok = !___res;						\
-	CHECK(!___ok, (name), "unexpected pointer: %p\n", ___res);	\
-	___ok;								\
-})
-
-#define ASSERT_OK_PTR(ptr, name) ({					\
-	static int duration = 0;					\
-	const void *___res = (ptr);					\
-	int ___err = libbpf_get_error(___res);				\
-	bool ___ok = ___err == 0;					\
-	CHECK(!___ok, (name), "unexpected error: %d\n", ___err);	\
-	___ok;								\
-})
-
-#define ASSERT_ERR_PTR(ptr, name) ({					\
-	static int duration = 0;					\
-	const void *___res = (ptr);					\
-	int ___err = libbpf_get_error(___res);				\
-	bool ___ok = ___err != 0;					\
-	CHECK(!___ok, (name), "unexpected pointer: %p\n", ___res);	\
-	___ok;								\
-})
-
-#define ASSERT_OK_FD(fd, name) ({					\
-	static int duration = 0;					\
-	int ___fd = (fd);						\
-	bool ___ok = ___fd >= 0;					\
-	CHECK(!___ok, (name), "unexpected fd: %d (errno %d)\n",		\
-	      ___fd, errno);						\
-	___ok;								\
-})
-
-#define ASSERT_ERR_FD(fd, name) ({					\
-	static int duration = 0;					\
-	int ___fd = (fd);						\
-	bool ___ok = ___fd < 0;						\
-	CHECK(!___ok, (name), "unexpected fd: %d\n", ___fd);		\
-	___ok;								\
-})
-
 #define SYS(goto_label, fmt, ...)					\
 	({								\
 		char cmd[1024];						\

-- 
2.52.0



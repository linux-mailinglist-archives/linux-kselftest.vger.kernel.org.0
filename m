Return-Path: <linux-kselftest+bounces-8864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B68B2608
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 18:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162BF283458
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 16:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C679314D280;
	Thu, 25 Apr 2024 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="QG2lSSwQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8982114C59B;
	Thu, 25 Apr 2024 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061399; cv=none; b=AqMVZMgzU05nR5lI5ygM2f7IIYjzz6ZFTIOzlbLpnWL2fdvo/K/QHRsTZ+ajh3knHFenFFPTb/86j2ebqPBWUAcPMDKyRLidMVM+zI8KsELgMX7LlkCqiEt8CxtLhHgGcBJprAtLhnP9BfUKrWQPlfvBkkDb+cxVJwID+PBbSC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061399; c=relaxed/simple;
	bh=3/vMU+KnL383rOtQme6UbwXiHGy/UeFxMMnLRj4gCZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GC0ZmhfOi32wPkuyIrBnIUt9720WxOTDzDIBTc4eOB9VvrxbTvZEDtUW4uL21EWQLEFtdMbPeB11R1QmxZ4YtxZK4jIbooS3pkxi+vTcf8idrIOSc9NU1j3RTNAIHmOeQVztKcn5+6IuXGTtZq4cxD64aiHZ6DV+b02KqE/FNp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=QG2lSSwQ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714061393;
	bh=3/vMU+KnL383rOtQme6UbwXiHGy/UeFxMMnLRj4gCZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QG2lSSwQne7PHdSMNIIVxDuyZgk9baoGv4y9YbmxXMxaYMPvE+fHoijRo4R8Dfhxd
	 JSmNftOOQk8Bxx47d+H/0i6jYSEUtAVMLjdLmNvNpTIi+W6eFHp/+g0qDGtNUuHfKt
	 9mBFrUYQbY8U62deY7cLOJojM9J8ZSF1iuCvfgeo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 25 Apr 2024 18:09:27 +0200
Subject: [PATCH 2/2] tools/nolibc: implement strtol() and friends
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240425-nolibc-strtol-v1-2-bfeef7846902@weissschuh.net>
References: <20240425-nolibc-strtol-v1-0-bfeef7846902@weissschuh.net>
In-Reply-To: <20240425-nolibc-strtol-v1-0-bfeef7846902@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714061393; l=6945;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=3/vMU+KnL383rOtQme6UbwXiHGy/UeFxMMnLRj4gCZE=;
 b=ALKzAWq1VPUd2oO06ghnPQWfc6psbr8i0vEazGC7mOizZd07raUSAQzgpghSdvbxoR7gmfwsY
 GsxifsuwCI1DAJeloXw31irF+df7B/ZqMW++DbY0a/A1+Qg0gHfsUeJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The implementation always works on uintmax_t values.

This is inefficient when only 32bit are needed.
However for all functions this only happens for strtol() on 32bit
platforms.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/stdlib.h                | 109 +++++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  59 +++++++++++++++
 2 files changed, 168 insertions(+)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 5be9d3c7435a..f66870e25389 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -438,6 +438,115 @@ char *u64toa(uint64_t in)
 	return itoa_buffer;
 }
 
+static __attribute__((unused))
+uintmax_t __strtox(const char *nptr, char **endptr, int base, intmax_t lower_limit, uintmax_t upper_limit)
+{
+	const char signed_ = lower_limit != 0;
+	unsigned char neg = 0, overflow = 0;
+	uintmax_t val = 0, limit, old_val;
+	char c;
+
+	if (base < 0 || base > 35) {
+		SET_ERRNO(EINVAL);
+		goto out;
+	}
+
+	while (isspace(*nptr))
+		nptr++;
+
+	if (*nptr == '+') {
+		nptr++;
+	} else if (*nptr == '-') {
+		neg = 1;
+		nptr++;
+	}
+
+	if (signed_ && neg)
+		limit = -(uintmax_t)lower_limit;
+	else
+		limit = upper_limit;
+
+	if ((base == 0 || base == 16) &&
+	    (strncmp(nptr, "0x", 2) == 0 || strncmp(nptr, "0X", 2) == 0)) {
+		base = 16;
+		nptr += 2;
+	} else if (base == 0 && strncmp(nptr, "0", 1) == 0) {
+		base = 8;
+		nptr += 1;
+	} else if (base == 0) {
+		base = 10;
+	}
+
+	while (*nptr) {
+		c = *nptr;
+
+		if (c >= '0' && c <= '9')
+			c -= '0';
+		else if (c >= 'a' && c <= 'z')
+			c = c - 'a' + 10;
+		else if (c >= 'A' && c <= 'Z')
+			c = c - 'A' + 10;
+		else
+			goto out;
+
+		if (c > base)
+			goto out;
+
+		nptr++;
+		old_val = val;
+		val *= base;
+		val += c;
+
+		if (val > limit || val < old_val)
+			overflow = 1;
+	}
+
+out:
+	if (overflow) {
+		SET_ERRNO(ERANGE);
+		val = limit;
+	}
+	if (endptr)
+		*endptr = (char *)nptr;
+	return (neg ? -1 : 1) * val;
+}
+
+static __attribute__((unused))
+long strtol(const char *nptr, char **endptr, int base)
+{
+	return __strtox(nptr, endptr, base, LONG_MIN, LONG_MAX);
+}
+
+static __attribute__((unused))
+unsigned long strtoul(const char *nptr, char **endptr, int base)
+{
+	return __strtox(nptr, endptr, base, 0, ULONG_MAX);
+}
+
+static __attribute__((unused))
+long long strtoll(const char *nptr, char **endptr, int base)
+{
+	return __strtox(nptr, endptr, base, LLONG_MIN, LLONG_MAX);
+}
+
+static __attribute__((unused))
+unsigned long long strtoull(const char *nptr, char **endptr, int base)
+{
+	return __strtox(nptr, endptr, base, 0, ULLONG_MAX);
+}
+
+static __attribute__((unused))
+intmax_t strtoimax(const char *nptr, char **endptr, int base)
+{
+	return __strtox(nptr, endptr, base, INTMAX_MIN, INTMAX_MAX);
+}
+
+static __attribute__((unused))
+uintmax_t strtoumax(const char *nptr, char **endptr, int base)
+{
+	return __strtox(nptr, endptr, base, 0, UINTMAX_MAX);
+}
+
 /* make sure to include all global symbols */
 #include "nolibc.h"
 
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index b9c84d42edbe..6161bd57a0c9 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -621,6 +621,51 @@ int expect_str_buf_eq(size_t expr, const char *buf, size_t val, int llen, const
 	return 0;
 }
 
+#define EXPECT_STRTOX(cond, func, input, base, expected, chars, expected_errno)				\
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_strtox(llen, func, input, base, expected, chars, expected_errno); } while (0)
+
+static __attribute__((unused))
+int expect_strtox(int llen, void *func, const char *input, int base, intmax_t expected, int expected_chars, int expected_errno)
+{
+	char *endptr;
+	int actual_errno, actual_chars;
+	intmax_t r;
+
+	errno = 0;
+	if (func == strtol) {
+		r = strtol(input, &endptr, base);
+	} else if (func == strtoul) {
+		r = strtoul(input, &endptr, base);
+	} else {
+		result(llen, FAIL);
+		return 1;
+	}
+	actual_errno = errno;
+	actual_chars = endptr - input;
+
+	llen += printf(" %lld = %lld", (long long)expected, (long long)r);
+	if (r != expected) {
+		result(llen, FAIL);
+		return 1;
+	}
+	if (expected_chars == -1) {
+		if (*endptr != '\0') {
+			result(llen, FAIL);
+			return 1;
+		}
+	} else if (expected_chars != actual_chars) {
+		result(llen, FAIL);
+		return 1;
+	}
+	if (actual_errno != expected_errno) {
+		result(llen, FAIL);
+		return 1;
+	}
+
+	result(llen, OK);
+	return 0;
+}
+
 /* declare tests based on line numbers. There must be exactly one test per line. */
 #define CASE_TEST(name) \
 	case __LINE__: llen += printf("%d %s", test, #name);
@@ -1143,6 +1188,20 @@ int run_stdlib(int min, int max)
 		CASE_TEST(limit_ptrdiff_min);       EXPECT_EQ(1, PTRDIFF_MIN, sizeof(long) == 8 ? (ptrdiff_t) 0x8000000000000000LL  : (ptrdiff_t) 0x80000000); break;
 		CASE_TEST(limit_ptrdiff_max);       EXPECT_EQ(1, PTRDIFF_MAX, sizeof(long) == 8 ? (ptrdiff_t) 0x7fffffffffffffffLL  : (ptrdiff_t) 0x7fffffff); break;
 		CASE_TEST(limit_size_max);          EXPECT_EQ(1, SIZE_MAX,    sizeof(long) == 8 ? (size_t)    0xffffffffffffffffULL : (size_t)    0xffffffffU); break;
+		CASE_TEST(strtol_simple);           EXPECT_STRTOX(1, strtol, "35", 10, 35, -1, 0); break;
+		CASE_TEST(strtol_positive);         EXPECT_STRTOX(1, strtol, "+35", 10, 35, -1, 0); break;
+		CASE_TEST(strtol_negative);         EXPECT_STRTOX(1, strtol, "-35", 10, -35, -1, 0); break;
+		CASE_TEST(strtol_hex_auto);         EXPECT_STRTOX(1, strtol, "0xFF", 0, 255, -1, 0); break;
+		CASE_TEST(strtol_octal_auto);       EXPECT_STRTOX(1, strtol, "011", 0, 9, -1, 0); break;
+		CASE_TEST(strtol_hex_00);           EXPECT_STRTOX(1, strtol, "0x00", 16, 0, -1, 0); break;
+		CASE_TEST(strtol_hex_FF);           EXPECT_STRTOX(1, strtol, "FF", 16, 255, -1, 0); break;
+		CASE_TEST(strtol_hex_ff);           EXPECT_STRTOX(1, strtol, "ff", 16, 255, -1, 0); break;
+		CASE_TEST(strtol_hex_prefix);       EXPECT_STRTOX(1, strtol, "0xFF", 16, 255, -1, 0); break;
+		CASE_TEST(strtol_trailer);          EXPECT_STRTOX(1, strtol, "35foo", 10, 35, 2, 0); break;
+		CASE_TEST(strtol_overflow);         EXPECT_STRTOX(1, strtol, "0x8000000000000000", 16, LONG_MAX, -1, ERANGE); break;
+		CASE_TEST(strtol_underflow);        EXPECT_STRTOX(1, strtol, "-0x8000000000000001", 16, LONG_MIN, -1, ERANGE); break;
+		CASE_TEST(strtoul_negative);        EXPECT_STRTOX(1, strtoul, "-0x1", 16, ULONG_MAX, 4, 0); break;
+		CASE_TEST(strtoul_overflow);        EXPECT_STRTOX(1, strtoul, "0x10000000000000000", 16, ULONG_MAX, -1, ERANGE); break;
 
 		case __LINE__:
 			return ret; /* must be last */

-- 
2.44.0



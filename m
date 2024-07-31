Return-Path: <linux-kselftest+bounces-14570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB67B9435AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 20:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9774328515E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 18:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496F575809;
	Wed, 31 Jul 2024 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="p/9kJcMx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BD7376F1;
	Wed, 31 Jul 2024 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722450760; cv=none; b=H4spv3XUU4k90/ErbLchYnR4zHQeyk7nQcVqx/Ax/TK9Y2HHNEoT+859+vS1DYvguAuYFhXcZr5oaTJmNurL0oju5BqXxCIOWgQ8a7zrkFj0U/ZI6UCSW8e2N5a7UQlfYDfYzEd5pwXXFW2Gj7oiic+oapdcIcBAaHU6bGSVF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722450760; c=relaxed/simple;
	bh=4M9s9OEh7nIvlxiEHReQEzcVjYytheID7Gh0tJI5QY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AKvoB10nnyNpPN2/2Oy+d5PK7u5YsNWXEloukY/hzhAUabfgKS4pB+Vk1+WGVz7ePmGQdX0OFHEnZ5fgqaLPxPMRZbKXTxjnJSwDHmJyH0UbWdvV3SATRmlPOqj9MMJTtv+4/quedwXEVxZ4LKtAeIOq4ocRdJLO+s6yb5AYQZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=p/9kJcMx; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722450753;
	bh=4M9s9OEh7nIvlxiEHReQEzcVjYytheID7Gh0tJI5QY4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p/9kJcMxLQxNt8HsEiaXyIPhbKM7VB/BGEN+ci/URg2tnOhRL4ZbZO7vH0N68a2ma
	 7P/cGd+3u2LezKJ+kUH0msrtOhl33hy1thIO89DHRGDEYhHrttib8QV8psrjeyvCcB
	 e8RM1jMpnWAnN0R9ng3RhFNF/6WqvcU9SDt53PdQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 31 Jul 2024 20:32:07 +0200
Subject: [PATCH 1/2] tools/nolibc: add support for [v]sscanf()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240731-nolibc-scanf-v1-1-f71bcc4abb9e@weissschuh.net>
References: <20240731-nolibc-scanf-v1-0-f71bcc4abb9e@weissschuh.net>
In-Reply-To: <20240731-nolibc-scanf-v1-0-f71bcc4abb9e@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722450752; l=4543;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4M9s9OEh7nIvlxiEHReQEzcVjYytheID7Gh0tJI5QY4=;
 b=92ALCUV21ClawaK5mx0eDPz91mg1SI/YXhm2pJMHId/NtertpyQXKPTZytzi6Xi9dqlf/sYQJ
 doErh1gDrOnDp+MnbclmhU1q7ZhA7z8sRwIZWcKDM+IKpGqB3r5640Q
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The implementation is limited and only supports numeric arguments.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/stdio.h                 | 93 ++++++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 59 ++++++++++++++++++
 2 files changed, 152 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index c968dbbc4ef8..d63c45c06d8e 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -348,6 +348,99 @@ int printf(const char *fmt, ...)
 	return ret;
 }
 
+static __attribute__((unused))
+int vsscanf(const char *str, const char *format, va_list args)
+{
+	uintmax_t uval;
+	intmax_t ival;
+	int base;
+	char *endptr;
+	int matches;
+	int lpref;
+
+	matches = 0;
+
+	while (1) {
+		if (*format == '%') {
+			lpref = 0;
+			format++;
+
+			if (*format == 'l') {
+				lpref = 1;
+				format++;
+				if (*format == 'l') {
+					lpref = 2;
+					format++;
+				}
+			}
+
+			if (*format == '%') {
+				if ('%' != *str)
+					goto done;
+				str++;
+				format++;
+				continue;
+			} else if (*format == 'd') {
+				ival = strtoll(str, &endptr, 10);
+				if (lpref == 0)
+					*va_arg(args, int *) = ival;
+				else if (lpref == 1)
+					*va_arg(args, long *) = ival;
+				else if (lpref == 2)
+					*va_arg(args, long long *) = ival;
+			} else if (*format == 'u' || *format == 'x' || *format == 'X') {
+				base = *format == 'u' ? 10 : 16;
+				uval = strtoull(str, &endptr, base);
+				if (lpref == 0)
+					*va_arg(args, unsigned int *) = uval;
+				else if (lpref == 1)
+					*va_arg(args, unsigned long *) = uval;
+				else if (lpref == 2)
+					*va_arg(args, unsigned long long *) = uval;
+			} else if (*format == 'p') {
+				*va_arg(args, void **) = (void *)strtoul(str, &endptr, 16);
+			} else {
+				SET_ERRNO(EILSEQ);
+				goto done;
+			}
+
+			format++;
+			str = endptr;
+			matches++;
+
+		} else if (*format == '\0') {
+			goto done;
+		} else if (isspace(*format)) {
+			while (isspace(*format))
+				format++;
+			while (isspace(*str))
+				str++;
+		} else if (*format == *str) {
+			format++;
+			str++;
+		} else {
+			if (!matches)
+				matches = EOF;
+			goto done;
+		}
+	}
+
+done:
+	return matches;
+}
+
+static __attribute__((unused, format(scanf, 2, 3)))
+int sscanf(const char *str, const char *format, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, format);
+	ret = vsscanf(str, format, args);
+	va_end(args);
+	return ret;
+}
+
 static __attribute__((unused))
 void perror(const char *msg)
 {
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 093d0512f4c5..addbceb0b276 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1277,6 +1277,64 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
 	return ret;
 }
 
+static int test_scanf(void)
+{
+	unsigned long long ull;
+	unsigned long ul;
+	unsigned int u;
+	long long ll;
+	long l;
+	void *p;
+	int i;
+
+	if (sscanf("", "foo") != EOF)
+		return 1;
+
+	if (sscanf("foo", "foo") != 0)
+		return 2;
+
+	if (sscanf("123", "%d", &i) != 1)
+		return 3;
+
+	if (i != 123)
+		return 4;
+
+	if (sscanf("a123b456c0x90", "a%db%uc%p", &i, &u, &p) != 3)
+		return 5;
+
+	if (i != 123)
+		return 6;
+
+	if (u != 456)
+		return 7;
+
+	if (p != (void *)0x90)
+		return 8;
+
+	if (sscanf("a    b1", "a b%d", &i) != 1)
+		return 9;
+
+	if (i != 1)
+		return 10;
+
+	if (sscanf("a%1", "a%%%d", &i) != 1)
+		return 11;
+
+	if (i != 1)
+		return 12;
+
+	if (sscanf("1|2|3|4|5|6",
+		   "%d|%ld|%lld|%u|%lu|%llu",
+		   &i, &l, &ll, &u, &ul, &ull) != 6)
+		return 13;
+
+	if (i != 1 || l != 2 || ll != 3 ||
+	    u != 4 || ul != 5 || ull != 6)
+		return 14;
+
+	return 0;
+}
+
 static int run_vfprintf(int min, int max)
 {
 	int test;
@@ -1298,6 +1356,7 @@ static int run_vfprintf(int min, int max)
 		CASE_TEST(char);         EXPECT_VFPRINTF(1, "c", "%c", 'c'); break;
 		CASE_TEST(hex);          EXPECT_VFPRINTF(1, "f", "%x", 0xf); break;
 		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x1", "%p", (void *) 0x1); break;
+		CASE_TEST(scanf);        EXPECT_ZR(1, test_scanf()); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */

-- 
2.46.0



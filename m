Return-Path: <linux-kselftest+bounces-26137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60222A2E072
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 21:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6E43A5FB2
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 20:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFC61E3769;
	Sun,  9 Feb 2025 20:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WpjMvFAy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7B91E283C;
	Sun,  9 Feb 2025 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739132849; cv=none; b=WTSKbdWacmfx/fXm0li/9fsvUAwt6ZpeYFpTZ4CIvgI1UrD9KDJ3IOCc5X+qqGE/H5k4y0LGO6nu7mXs4xRPSTdEul0mkTG+YGJwFuVLe8wqEJs7vlQU/dpyV+jF6BbmZIyjGkerWa9bQH25DL7wxOXoLaJadDFvdkMT5XWe/do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739132849; c=relaxed/simple;
	bh=+QUeG+bKiljNl7Cap2FGBbyuKBrPpyf/B7O4/k1S14s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D3zasbUw+0b4K4Z0AMNz6E17IK49LtBFZGfr65XhJcuqZxURwzSr2oSozBGlUG4DgpFReDo/8FOyHhirE9b3gc3mi7eIdI1WFK70+eupBAg3ww6xNosuXzejQAwtRI/AfRrhbzQt77GrtSyxktBEGjwLw59avV7r1jTL9Ksn8IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WpjMvFAy; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1739132837;
	bh=+QUeG+bKiljNl7Cap2FGBbyuKBrPpyf/B7O4/k1S14s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WpjMvFAy1zmNWCtPzAaFDAWBqiDiuLUcRVKWMgk4Bw7UU/UAg93sl3fzD0CjhhaDe
	 z+bZLSJbq+vtlB5plRFs9r/3FAVuwEz2YCQDv3dc+rOvus416yiWsxWBp0uDJyJpHf
	 J7J+B4sKcT4BEO5KuggZrX+RG3wIIefFaYq+m3w4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 09 Feb 2025 21:27:12 +0100
Subject: [PATCH v2 1/2] tools/nolibc: add support for [v]sscanf()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250209-nolibc-scanf-v2-1-c29dea32f1cd@weissschuh.net>
References: <20250209-nolibc-scanf-v2-0-c29dea32f1cd@weissschuh.net>
In-Reply-To: <20250209-nolibc-scanf-v2-0-c29dea32f1cd@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739132836; l=5306;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=+QUeG+bKiljNl7Cap2FGBbyuKBrPpyf/B7O4/k1S14s=;
 b=/qNf9OS9H7TXvjGCJSGtCMUcZET0S3+z3KO3ntyfjNvcgzhuXZmlXnfpoT6EnobRfBJM4QU5h
 Lcgyc/eOtuQDuDBJeFvarmtryL7WfLFBTVptBNYBKJ1PfRuvDtjlAsr
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

These functions are used often, also in selftests.
sscanf() itself is also used by kselftest.h itself.

The implementation is limited and only supports numeric arguments.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/stdio.h                 | 98 ++++++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 68 +++++++++++++++++++
 2 files changed, 166 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 3892034198dd566d21a5cc0a9f67cf097d428393..a403351dbf6098ac8292b9589ed8a054b4c5669f 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -349,6 +349,104 @@ int printf(const char *fmt, ...)
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
+			/* start of pattern */
+			lpref = 0;
+			format++;
+
+			if (*format == 'l') {
+				/* same as in printf() */
+				lpref = 1;
+				format++;
+				if (*format == 'l') {
+					lpref = 2;
+					format++;
+				}
+			}
+
+			if (*format == '%') {
+				/* literal % */
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
+			/* skip spaces in format and str */
+			while (isspace(*format))
+				format++;
+			while (isspace(*str))
+				str++;
+		} else if (*format == *str) {
+			/* literal match */
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
index 798fbdcd3ff8c36b514feb3fa1c7b8d7701cccd7..81e942c7d1684a7dd59af0b05c8330378532ecc1 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1325,6 +1325,73 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
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
+	/* return __LINE__ to point to the specific failure */
+
+	/* test EOF */
+	if (sscanf("", "foo") != EOF)
+		return __LINE__;
+
+	/* test simple literal without placeholder */
+	if (sscanf("foo", "foo") != 0)
+		return __LINE__;
+
+	/* test single placeholder */
+	if (sscanf("123", "%d", &i) != 1)
+		return __LINE__;
+
+	if (i != 123)
+		return __LINE__;
+
+	/* test multiple place holders and separators */
+	if (sscanf("a123b456c0x90", "a%db%uc%p", &i, &u, &p) != 3)
+		return __LINE__;
+
+	if (i != 123)
+		return __LINE__;
+
+	if (u != 456)
+		return __LINE__;
+
+	if (p != (void *)0x90)
+		return __LINE__;
+
+	/* test space handling */
+	if (sscanf("a    b1", "a b%d", &i) != 1)
+		return __LINE__;
+
+	if (i != 1)
+		return __LINE__;
+
+	/* test literal percent */
+	if (sscanf("a%1", "a%%%d", &i) != 1)
+		return __LINE__;
+
+	if (i != 1)
+		return __LINE__;
+
+	/* test stdint.h types */
+	if (sscanf("1|2|3|4|5|6",
+		   "%d|%ld|%lld|%u|%lu|%llu",
+		   &i, &l, &ll, &u, &ul, &ull) != 6)
+		return __LINE__;
+
+	if (i != 1 || l != 2 || ll != 3 ||
+	    u != 4 || ul != 5 || ull != 6)
+		return __LINE__;
+
+	return 0;
+}
+
 static int run_vfprintf(int min, int max)
 {
 	int test;
@@ -1346,6 +1413,7 @@ static int run_vfprintf(int min, int max)
 		CASE_TEST(char);         EXPECT_VFPRINTF(1, "c", "%c", 'c'); break;
 		CASE_TEST(hex);          EXPECT_VFPRINTF(1, "f", "%x", 0xf); break;
 		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x1", "%p", (void *) 0x1); break;
+		CASE_TEST(scanf);        EXPECT_ZR(1, test_scanf()); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */

-- 
2.48.1



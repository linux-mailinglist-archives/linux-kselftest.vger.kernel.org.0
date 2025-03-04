Return-Path: <linux-kselftest+bounces-28178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37112A4D491
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432F43AE1CB
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618041FF7A9;
	Tue,  4 Mar 2025 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jSeXaQ/G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7U3Qaf+V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAAD1FECA3;
	Tue,  4 Mar 2025 07:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072288; cv=none; b=u8FjvuhuieUkSdtWJ1AXkaXbzW/PN5rAz8kqgvtH19pmW4p0PoU41UjgjToOaxDVrXpJNKXS4wcWBarPwdb/InjelQpxAwQ2EiBMFhRTNkLfyQf/Tz2e0de4345JR6OZiEfCXBfoKSr+JnEn/QUqjgkWeTnbVZq2Xw52aXZufLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072288; c=relaxed/simple;
	bh=LNPAd5j41z7/7wbeh3w+BrEJrXkwXGb0E7Y8U1tP0CI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f+XVNGtmKl7TimzD1PI1fefek+Nz66zzOPwaZsgthpxwKSCviIceSxQWRhwYA6AMSqaChoQex0Tu+0Qx+PGdZoybVq/t+LlwnrMqm9jhY54cuvyd87ne8HppJw77Li8SQMhAmvg7DYgGUJ2U9Ni1G9bDBPGMxHDxfK4PdilFYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jSeXaQ/G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7U3Qaf+V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhuLcuZRPubZ7LHVGGsmkya6pwUURKc40l/u6to7bWM=;
	b=jSeXaQ/GttXEiSCK0ymFabIzTKPyl1yEkiilqffkVyTkVdR5jayYMwneZAhFr+KAajzJDQ
	8fFB4MHMcXuBu2Agr6pjaFH6qYllV4G/SIzCpogSv2CVbqDgDwnx6uzHzyi57NUP2YOQ6I
	lYc0DrE8quWZE24DRr75I/w2DVH7+BDDlzJ1R4OZhgK/8gGGyJmrxkepCP7OQphqmTcz3z
	ksgCvsG3rkGHN5TeG+WHxceE6yB84KVlpcZt5zcuQ3CeeMACU+UsikaRmEvryTyvq2YZrJ
	UZPmnHe5arvk43fFnIZfn8LrUonDAL/q1w3f/iA/l5mvA8vW1HJo4Ma8BWcWBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhuLcuZRPubZ7LHVGGsmkya6pwUURKc40l/u6to7bWM=;
	b=7U3Qaf+VhjwzIy2f4axAKcMZdxVhHJsKr+ULwizD7eG4svAnef29B0hi+oMJH7gR2NCkJj
	j/hzOPHfd/ieMGAw==
Date: Tue, 04 Mar 2025 08:11:01 +0100
Subject: [PATCH 31/32] tools/nolibc: implement width padding in printf()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-31-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=2875;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=LNPAd5j41z7/7wbeh3w+BrEJrXkwXGb0E7Y8U1tP0CI=;
 b=sUdIwUQ8/jSwNj+IrnF7rPKV6tQ4Hf0UIwn+FB7oP7GrkWChIo6R6V8n/Osn2vGc9UwEkMP35
 FT51Dy6SVu9C9f1wSurWzf9LTUSKq9a2VyZhQzS9msF//LE0w+qPuW4
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

printf can pad each argument to a certain width.
Implement this for compatibility with the kselftest harness.
Currently only padding with spaces is supported.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/stdio.h                 | 17 ++++++++++++++++-
 tools/testing/selftests/nolibc/nolibc-test.c |  3 +++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index e9f9cb2e8d9877221b442f9f3757d7ace1a5538c..9258cc1c406879b34f65fff442c0f112ede160fa 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -220,7 +220,7 @@ int _printf(_printf_cb cb, intptr_t state, size_t n, const char *fmt, va_list ar
 {
 	char escape, lpref, c;
 	unsigned long long v;
-	unsigned int written;
+	unsigned int written, width;
 	size_t len, ofs, w;
 	char tmpbuf[21];
 	const char *outstr;
@@ -228,10 +228,20 @@ int _printf(_printf_cb cb, intptr_t state, size_t n, const char *fmt, va_list ar
 	written = ofs = escape = lpref = 0;
 	while (1) {
 		c = fmt[ofs++];
+		width = 0;
 
 		if (escape) {
 			/* we're in an escape sequence, ofs == 1 */
 			escape = 0;
+
+			/* width */
+			while (c >= '0' && c <= '9') {
+				width *= 10;
+				width += c - '0';
+
+				c = fmt[ofs++];
+			}
+
 			if (c == 'c' || c == 'd' || c == 'u' || c == 'x' || c == 'p') {
 				char *out = tmpbuf;
 
@@ -309,6 +319,11 @@ int _printf(_printf_cb cb, intptr_t state, size_t n, const char *fmt, va_list ar
 			if (n) {
 				w = len < n ? len : n;
 				n -= w;
+				while (width-- > w) {
+					if (cb(state, " ", 1) != 0)
+						break;
+					written += 1;
+				}
 				if (cb(state, outstr, w) != 0)
 					break;
 			}
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 0a891c40e2afbb398ae39b43dbe977efdab042e2..b801b611e003a6f3ebd5bdbcd4f70961c1279a4d 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1398,6 +1398,9 @@ static int run_printf(int min, int max)
 		CASE_TEST(uintmax_t);    EXPECT_VFPRINTF(20, "18446744073709551615", "%ju", 0xffffffffffffffffULL); break;
 		CASE_TEST(intmax_t);     EXPECT_VFPRINTF(20, "-9223372036854775807", "%jd", 0x8000000000000001LL); break;
 		CASE_TEST(truncation);   EXPECT_VFPRINTF(25, "01234567890123456789", "%s", "0123456789012345678901234"); break;
+		CASE_TEST(string_width); EXPECT_VFPRINTF(10, "         1", "%10s", "1"); break;
+		CASE_TEST(number_width); EXPECT_VFPRINTF(10, "         1", "%10d", 1); break;
+		CASE_TEST(width_trunc);  EXPECT_VFPRINTF(25, "                    ", "%25d", 1); break;
 		CASE_TEST(scanf);        EXPECT_ZR(1, test_scanf()); break;
 		case __LINE__:
 			return ret; /* must be last */

-- 
2.48.1



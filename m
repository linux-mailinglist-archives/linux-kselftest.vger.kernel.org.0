Return-Path: <linux-kselftest+bounces-30568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CDCA8577B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638741BC2199
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179D72D3A79;
	Fri, 11 Apr 2025 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UM8acNMw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IICcBQqn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA442D1F47;
	Fri, 11 Apr 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362127; cv=none; b=VncrrYvG91TC8KnWM23fSmtbqzO7Qc73y06QYkjtIHBmbk0ipw9SUOXe7G11lupsykcQKYJ6PmIe8vXWeYWcyhMqgDbGN+kXrxwfW7mewLUq9xk8HwrM3J6sLYDjVl+Ok4urCK1aCXGKoeGf8BngpJSk8BsuFitiMf9VpzA27CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362127; c=relaxed/simple;
	bh=4PWMuyjdFGi/rGm+eh3+GEBgJVFiFZN51q5MAPLIuoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VkRdPj/pO3vanScfqxhS0H+g4u9MYh+jJjsroDVpyvxhtDcxvFE7qdQ5VQwklAZi1/b7JV478DuvRNz6sLsXF6/TgTgkAI97HfkD4G8GkyZ36tmdB4Mks0u6/GaIrvBihVc1UPbNVSbhir5QNhhVk8prrPDjw31Ozmb2pMgTuyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UM8acNMw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IICcBQqn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WupVzBzhpR9wEE1wxtcIpqdyGm1uGqU4Sj1sAih5bIM=;
	b=UM8acNMwlbNtilAsoJBq3NNM2v5cPLGJq0pzkbH1McBkXfh5nrZOEU4RPJQaSk0fm/Sr4a
	E+x6AXK20VzMbgEHZKPQ/1ZwWXzJtqwVIhgFjpzKOLUPr0PU6ZYxUDNJWrNq1HyhiXQFV4
	jLxKdSZS3g4Fflk5FYfRpFif1sPo8+cbFPsHTceYhU80H4QVU2dkGxa0DXaPUsHehRCDL/
	QxUujNGtdvSmGaJwFCmfxLfE/9wntJqLkNYtUDibJ8sUKl/Ucgqfn3jQnkfTEzy3utfrBT
	Pf1uXvME30V5gnDpaCnRwblL1EVstB5bW5jbEPqBcI97Rzz3mA24WgeRq90X5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WupVzBzhpR9wEE1wxtcIpqdyGm1uGqU4Sj1sAih5bIM=;
	b=IICcBQqnXLEJSOd4B3tzfGRBH2GVLFFL9B+7gRP+bwd5jRQweCZ/a28dW5wr3xU38n8Pyu
	2CdoY8v99782bJDw==
Date: Fri, 11 Apr 2025 11:00:55 +0200
Subject: [PATCH v3 31/32] tools/nolibc: implement width padding in printf()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-31-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=2908;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=4PWMuyjdFGi/rGm+eh3+GEBgJVFiFZN51q5MAPLIuoQ=;
 b=UkxEY9GedZRL5ANsdnHTP2map3v1Ep3TNo6I+jZuB/S7IBb1ORcYjXiMtEK1NsLeGb9iaZXfm
 qgi1IdJCe8PA5nQEYjaD2/hbl7ciWG1/Ik0/FksDYTx3Da4evKPC7Gj
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

printf can pad each argument to a certain width.
Implement this for compatibility with the kselftest harness.
Currently only padding with spaces is supported.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdio.h                 | 17 ++++++++++++++++-
 tools/testing/selftests/nolibc/nolibc-test.c |  3 +++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 46bd90f96d654fadda20292baddc98358a3afc62..fb0417477759ee6c9663e84807c1d1067e735dec 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -220,7 +220,7 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char
 {
 	char escape, lpref, c;
 	unsigned long long v;
-	unsigned int written;
+	unsigned int written, width;
 	size_t len, ofs, w;
 	char tmpbuf[21];
 	const char *outstr;
@@ -228,10 +228,20 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char
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
 
@@ -309,6 +319,11 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char
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
index 9bd0a9c68b903cbd660ff81d4b0386b0b7c13977..16ec4f658bbec43440679c5d5c35014827c377bc 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1415,6 +1415,9 @@ static int run_printf(int min, int max)
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
2.49.0



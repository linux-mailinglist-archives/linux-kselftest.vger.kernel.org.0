Return-Path: <linux-kselftest+bounces-30217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CFDA7D4C4
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD19188F402
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB4122E41B;
	Mon,  7 Apr 2025 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X5dQqlsB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q+srFaGl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0005225784;
	Mon,  7 Apr 2025 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008800; cv=none; b=It6Zq+pxb8fuol7/C+hpEU4gYIEUwI0URaNXGWVZv4U750BsbEmHkBCTRH+T+pCgOfKjPXU30jPttSMD6W0kcMjDVhea4dMW3ANAAkOChyDK99Ej4o7gvlNk2v/+m1vCzIiVFokwmPbRdjlUpdrPIxP5a5zqSCkK1+Xpgat4U0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008800; c=relaxed/simple;
	bh=4PWMuyjdFGi/rGm+eh3+GEBgJVFiFZN51q5MAPLIuoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vEWIqAndMlbyxCdOn8u8ZgCdQRioo3fGnwsFXr5JRuJPJ4RDDhn181nZ4ckXQbj0greYmV3h6DMmZpGhWe9oV1fEPBNgYjmFz3+VSy16P7WRQK3rLyWrAHFYQExr6zVrTgGTucajApmRbmsGlD3RRHV6NMMAgWWRk4YxESLWRtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X5dQqlsB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q+srFaGl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WupVzBzhpR9wEE1wxtcIpqdyGm1uGqU4Sj1sAih5bIM=;
	b=X5dQqlsB2qejMY5VwwQrIGL7uQuxqOxjboziLRreUAeXK0A+I0I/uvkc5+WjC//9a0nT2p
	eG5Ks1JqYx0xB8P1iLdH55RwXyTJqe6BOpj7Q8WwG0kAchkpJRONqXNbdpEyHhlJ6LDjP2
	H1Q9w/JRNSGEhFkiu4zWncnlp9bZz9QzZb7X6jCnsk+dI/dov6pHYbuvuLI6DY8cF5IF+H
	2zgix4LziP+vFL+KhuUr26AefZq5PJDYBDuD7YXGbH2bS/wZDHOsw+neNUaUpXymH1VgDN
	krogqRDE0q0V1+EovLIX8n1o743FxpVErf5WuvwXspOvdZSYELI3w3NMM9Qq5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WupVzBzhpR9wEE1wxtcIpqdyGm1uGqU4Sj1sAih5bIM=;
	b=Q+srFaGlhXFsvsBtvQ0hUpNowVQiTUCA7hKkS2XhacfQbJuTxWjRD45INjwrQ7bu9NsatC
	MmBHclYib3kaXuBA==
Date: Mon, 07 Apr 2025 08:52:54 +0200
Subject: [PATCH v2 31/32] tools/nolibc: implement width padding in printf()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-31-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=2908;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=4PWMuyjdFGi/rGm+eh3+GEBgJVFiFZN51q5MAPLIuoQ=;
 b=TJ90SRsc2feIExru4VXFrumYdLrrO7jtqgIU4tDVzCdQpxyG9QTl8b1REeXRTplAa9OkknO0G
 DscsRnUhMgbBf/LggjenAALK0oHHfPS5EF4qqBG+HBI74drrMCDbPjj
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



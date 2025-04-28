Return-Path: <linux-kselftest+bounces-31768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B757A9F0F2
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 14:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0416B17271E
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 12:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031E026A0AF;
	Mon, 28 Apr 2025 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4WMwG53Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6LzyQtiB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C7D269806;
	Mon, 28 Apr 2025 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844012; cv=none; b=bP4ZvSqQLFRM4kb9WnXI/8mIKylMxcIEC9dN1tzt05wKKgPTrQ5uDS5FA9VvM92HL/DQn+UPBL3QG5jD2zX8UM2q9+5IPuP3WycjrScgkwg50ihqF9B8IhmaW8g7JSxTZCe3dfvtSpcCWyE76i2kd1BeNqgsZdeW1zwvBwQAtyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844012; c=relaxed/simple;
	bh=Vq4SFsSgvfFXkCLM/1TQB88Lq9bzobGeGU1hpdpPaFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UoYWSsz8XbFGfEFpdZzGjY6kZq9jgV7tRPdDW+rmYN4HCE0mFy4ndBH6TJT1eU1zQyK1qDFqZwL0Y1O5yTTy/omu3TYcZuwUthETXftNGpCCqnSOXqzpHMYWQmhWB7KtiUBI/G4KMSrps8EUStOpPBUZNYFXLb0kH8ZyG/17rRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4WMwG53Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6LzyQtiB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745844009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEFTUn4BS38AAuPwQQHUG5575AdUi7Dnv0iae5/KCck=;
	b=4WMwG53QcdWARNCImm+LjGRvsameEd0JAI8BGQWeamxRJ+4Sx9nzBu1c8Mhyg3RLnH6d1M
	VcuHl64i77IeWWZsFJg0MhmImcgOOY9rNyyW83Q0c9Sk2FY5R9MIkOEFURq5LNO+o5ym9s
	QPAWaFVMkCV38iPoDjjv90e92Rtu1mW8Wmn2onILIn6CQuF54GTG4env3+Ne5KwDncJc5N
	bTIe3v6gG9y3P90UzEyEB/FMzWOd1wOnXrapyQ6bOQh1AfmTUvaFp0KfmizRwy+EqH3Gee
	jidtnK3/Q0Bl7CiXQ+Bofv6lQrijnbLrXr52SICONn4cO61tUSVgna3qdNLlPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745844009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEFTUn4BS38AAuPwQQHUG5575AdUi7Dnv0iae5/KCck=;
	b=6LzyQtiBwO2xchRtfZOJHLZjutdwbX8amfd4RIBCnRMqAjahWYnu/3rdeCP+KmoI5FpVmM
	v6SYsC6rU2kT10Dg==
Date: Mon, 28 Apr 2025 14:40:03 +0200
Subject: [PATCH v2 02/15] tools/nolibc: add %m printf format
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-nolibc-misc-v2-2-3c043eeab06c@linutronix.de>
References: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
In-Reply-To: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745844007; l=2425;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Vq4SFsSgvfFXkCLM/1TQB88Lq9bzobGeGU1hpdpPaFA=;
 b=PuC5di+9lSy4fE6RdSoe/5UBiHNOw/jzW0kLP8zmbSHFnUOW/ZkWzpLlsjj6th+T8RQXq9V9d
 5ExH1qhSP14AlJLpbtSYU7Fn1jeT8Uba/sxya5w1/n98S4iXabLnmT4
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The %m format can be used to format the current errno.
It is non-standard but supported by other commonly used libcs like glibc and
musl, so applications do rely on them.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdio.h                 |  7 +++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 8fa98abab2127c2cd175201d2f50d71b78d03559..df5717d591826c8468e3473581ac0d6e76629aa3 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -20,6 +20,8 @@
 #include "string.h"
 #include "compiler.h"
 
+static const char *strerror(int errnum);
+
 #ifndef EOF
 #define EOF (-1)
 #endif
@@ -292,6 +294,11 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char
 				if (!outstr)
 					outstr="(null)";
 			}
+#ifndef NOLIBC_IGNORE_ERRNO
+			else if (c == 'm') {
+				outstr = strerror(errno);
+			}
+#endif /* NOLIBC_IGNORE_ERRNO */
 			else if (c == '%') {
 				/* queue it verbatim */
 				continue;
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 3e15a25ccddf5135db1f59bce1eefdff2ffe57f6..b7440a667db6b541a2548bdf5182bee0277100ed 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1393,6 +1393,23 @@ static int test_scanf(void)
 	return 0;
 }
 
+int test_strerror(void)
+{
+	char buf[100];
+	ssize_t ret;
+
+	memset(buf, 'A', sizeof(buf));
+
+	errno = EINVAL;
+	ret = snprintf(buf, sizeof(buf), "%m");
+	if (is_nolibc) {
+		if (ret < 6 || memcmp(buf, "errno=", 6))
+			return 1;
+	}
+
+	return 0;
+}
+
 static int run_printf(int min, int max)
 {
 	int test;
@@ -1421,6 +1438,7 @@ static int run_printf(int min, int max)
 		CASE_TEST(number_width); EXPECT_VFPRINTF(10, "         1", "%10d", 1); break;
 		CASE_TEST(width_trunc);  EXPECT_VFPRINTF(25, "                    ", "%25d", 1); break;
 		CASE_TEST(scanf);        EXPECT_ZR(1, test_scanf()); break;
+		CASE_TEST(strerror);     EXPECT_ZR(1, test_strerror()); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */

-- 
2.49.0



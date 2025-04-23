Return-Path: <linux-kselftest+bounces-31408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3EBA98F3E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47539179E13
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3721C2857C0;
	Wed, 23 Apr 2025 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jbtB/kQ9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B1MKPmVt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57228134C;
	Wed, 23 Apr 2025 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420504; cv=none; b=FkI228dBZvSCHcPPRryfMALu6OBBCqIElyB7OYAFOgcX5Q2p/bkdjFC0ikXscbfk8gHto+gUga+K3l5lmSZ9Gu5cpW32j3sbh+22jL33HHQ4cKxq1h/VHD24AggbV+xZJH5XML1j2/pBxyH3+zjDP/EoKsmynjMDcKItw6kJg5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420504; c=relaxed/simple;
	bh=Np0oBwLMhPpLv5pP1PIcbr1JsW8qIWPf7vPBJHuBFys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OBjBx285Wo4Vf2CEk3Yx2+z+qmMJSUvyjwQqZot+tYRqr6f2AkdPggC9Ku9eaTCTEO3jVf89Y9T4FmkAhYcKIH3hij8dQLhL9ZErdbyNC16SqQkQMLXArx7MX2Xv9IlPUAD7VQuTJ3Rw+G8ODtUtecR+2mEcZ1qSni/svRSHx/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jbtB/kQ9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B1MKPmVt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745420499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWxX6o0dhF/CJHuGOM1VGqf2IcTvjrF7WP0MZxIu7Cw=;
	b=jbtB/kQ9uWgE8OJyqblfpQdCc566e7cWcybH7ZhhxNcn3Xkq7BQq1EIMqpB0PwCuW4I/pi
	KYnjjRFF84Tepn5tMw0lmaVKuxnuLI+7Oi+omFxOU7yFCIrxA8TxxHVCDqql75FB0LWPWy
	MPkeIG6zqbKjhlCJFo201inSPQOzSZ/sCsjpTGJKt6L8C7Xzozbfl8V7I7jYm8Z0ji7zaC
	fNFd/5n+TiQ1vZyB+n8hYLGylh9YTRqFKQzNLoNhIaGQpm6qvv3Ey5QJ0xtFi1pgRKaFvX
	Q0avVghWwIc/2ZCuR8D5Di78vKt/TCBdLk07veyYBC2KyEBvrMnDPMujUtt+Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745420499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWxX6o0dhF/CJHuGOM1VGqf2IcTvjrF7WP0MZxIu7Cw=;
	b=B1MKPmVtDKLHYiGBPYwysN0lO2LGd3UVh1pxW3QZg/029dnm8wT+lwirUnDX6dlwggKIxQ
	mNN6L+sxRKnFUMCg==
Date: Wed, 23 Apr 2025 17:01:32 +0200
Subject: [PATCH 02/15] tools/nolibc: add %m printf format
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250423-nolibc-misc-v1-2-a925bf40297b@linutronix.de>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
In-Reply-To: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745420497; l=2389;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Np0oBwLMhPpLv5pP1PIcbr1JsW8qIWPf7vPBJHuBFys=;
 b=ussC6c5aR9ND9nLzJ/CGUwKIQnZCxYOMAiRj2GOVyUniMrJp24lVNVClu071tTSARr7UmcRlp
 UngxaWScOpIDZxeSJmH1hBMNgWBJO3V5PSRfIW72tOjliHCuWu3grYw
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The %m format can be used to format the current errno.
It is non-standard but supported by other commonly used libcs like glibc and
musl, so applications do rely on them.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/stdio.h                 |  7 +++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index fb0417477759ee6c9663e84807c1d1067e735dec..02426682c34bcd82d9556036c6c3e73a6a5a3b4d 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -17,6 +17,8 @@
 #include "string.h"
 #include "compiler.h"
 
+static const char *strerror(int errnum);
+
 #ifndef EOF
 #define EOF (-1)
 #endif
@@ -289,6 +291,11 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char
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



Return-Path: <linux-kselftest+bounces-31779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46688A9F10A
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 14:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4151A8291D
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 12:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F1F270561;
	Mon, 28 Apr 2025 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TKCVKwdt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="etbcRAP5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3AD26F478;
	Mon, 28 Apr 2025 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844019; cv=none; b=LIYSKsU0Xrg09lbafUGo8bkyAYuUCBMO3E+T4LzykCgVbkBLpwA5uk9mTRBOPRaNW0JqKnmkWch0QrNv5vS745XaQiqCBVbh5MMOLwwNlkMCU2Z+aAqV/8gQVQzfk496YO58CBSKqvN8+R3AcixFQbM+1ohXBqTMb4cWTu3GeZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844019; c=relaxed/simple;
	bh=aEBBgnNmmm0oiSb4EWtCJKDiJ+chaLjNWUeDK6AsQpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T/yJ6NeZnZ4/UWPSX/s/Mc37uloAgpXMEV52lfvgRPt7z5bH2uQ4aeHIeJVXVw5xcaQVFXiY3TdxQdDuugR7CO1UECYqznHGVcinMpxDusp16i3dZbpfueRM9fVfn34WU0gbblx6lrz8Ue4thQwlLeXCsn+GVlhE4yqEGfe0cnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TKCVKwdt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=etbcRAP5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745844015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fPPjFV4RDhqoeNYAqhvlDYRxfhJhfDARBxfUjI2goc=;
	b=TKCVKwdtniUW58Qi22M5qeDi/5bV9vlLCivi2Hj0Oo4ry4xAaye9EUcSsRGViMcrKJKANg
	+rawG+NZ5EUT8gXC4vYkibgP+uuz9n75EZzh5/uFRrL5NcX33oEl0HXYGV50iMlHYEotiE
	QqVyKHTjSxu5mmh9HHkUbKCv4g/3Qp1GwMVO7pXW5TFhDdraonHOZxASvdjLE0XJ++RryG
	V0CiYGwOfZzYTi8wIAQmNqIGL+n+EbjaPwheYTQ8cFm2SKHsme3k+VMMLfqO9NlUGy4tk+
	ds6yPQm/EU6pPBV8x123SImWDqX7RbZOb+ZhM1m85Pp+zU6es31F7ziWfxDKZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745844015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fPPjFV4RDhqoeNYAqhvlDYRxfhJhfDARBxfUjI2goc=;
	b=etbcRAP5oZxqUp4Dp0xXV70itDcjFF+jJ3uPXga1OAsM0gjwSZrzlalq2RKdSqiGN7jdbF
	6Czj3zLjJPkosqBg==
Date: Mon, 28 Apr 2025 14:40:14 +0200
Subject: [PATCH v2 13/15] tools/nolibc: add fopen()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-nolibc-misc-v2-13-3c043eeab06c@linutronix.de>
References: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
In-Reply-To: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745844007; l=3191;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=aEBBgnNmmm0oiSb4EWtCJKDiJ+chaLjNWUeDK6AsQpQ=;
 b=9g9Cx13ipSPIi5V1VBh7clhuvR0pcjkf/qwgM29Tm8PNBTpW32jfpxuVMkOyvxSaN8A5CJaez
 sdkfJBNZo/FCijDEIllRwxtAEbzjxnE/cxQATn2S0LvOuLkS7qcJxrC
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Only the standard POSIX modes are supported.
No extensions nor the (noop) "b" from ISO C are accepted.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdio.h                 | 20 ++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 24 ++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index df5717d591826c8468e3473581ac0d6e76629aa3..61b7252ab6d04f8758367f5265687146326456a3 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -13,6 +13,7 @@
 #include "std.h"
 #include "arch.h"
 #include "errno.h"
+#include "fcntl.h"
 #include "types.h"
 #include "sys.h"
 #include "stdarg.h"
@@ -55,6 +56,25 @@ FILE *fdopen(int fd, const char *mode __attribute__((unused)))
 	return (FILE*)(intptr_t)~fd;
 }
 
+static __attribute__((unused))
+FILE *fopen(const char *pathname, const char *mode)
+{
+	int flags, fd;
+
+        switch (*mode) {
+                case 'r': flags = O_RDONLY; break;
+                case 'w': flags = O_WRONLY | O_CREAT | O_TRUNC; break;
+                case 'a': flags = O_WRONLY | O_CREAT | O_APPEND; break;
+                default : SET_ERRNO(EINVAL); return NULL;
+        }
+
+        if (mode[1] == '+')
+                flags = (flags & ~(O_RDONLY|O_WRONLY)) | O_RDWR;
+
+	fd = open(pathname, flags, 0666);
+	return fdopen(fd, mode);
+}
+
 /* provides the fd of stream. */
 static __attribute__((unused))
 int fileno(FILE *stream)
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index d1157319b5d715dbc94ff9203b1d2a2e932aabcf..0391c7d01380ea2f20d1d07497ea1964bcb6a9f4 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -859,6 +859,29 @@ int test_getpagesize(void)
 	return !c;
 }
 
+int test_file_stream(void)
+{
+	FILE *f;
+	int r;
+
+	f = fopen("/dev/null", "r");
+	if (!f)
+		return -1;
+
+	errno = 0;
+	r = fwrite("foo", 1, 3, f);
+	if (r != 0 || errno != EBADF) {
+		fclose(f);
+		return -1;
+	}
+
+	r = fclose(f);
+	if (r == EOF)
+		return -1;
+
+	return 0;
+}
+
 int test_fork(void)
 {
 	int status;
@@ -1311,6 +1334,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(dup3_0);            tmp = dup3(0, 100, 0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
 		CASE_TEST(dup3_m1);           tmp = dup3(-1, 100, 0); EXPECT_SYSER(1, tmp, -1, EBADF); if (tmp != -1) close(tmp); break;
 		CASE_TEST(execve_root);       EXPECT_SYSER(1, execve("/", (char*[]){ [0] = "/", [1] = NULL }, NULL), -1, EACCES); break;
+		CASE_TEST(file_stream);       EXPECT_SYSZR(1, test_file_stream()); break;
 		CASE_TEST(fork);              EXPECT_SYSZR(1, test_fork()); break;
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
 		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;

-- 
2.49.0



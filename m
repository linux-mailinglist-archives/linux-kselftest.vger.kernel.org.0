Return-Path: <linux-kselftest+bounces-31418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B08A98FA1
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795411B84221
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C225028A410;
	Wed, 23 Apr 2025 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j5e0cxjM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eAp/itsm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9EC28134C;
	Wed, 23 Apr 2025 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420509; cv=none; b=Zj0IKO0GeSIgIFkV6EZuN5MZmLhUKiwDeNZi5+KfGRswzl41ZjeCjH0VpH/8VQ/oHmda3uE3tl990zeGsVQt7DYhfyHMdxnecv1+wezukYmOGeSdCTVhCT8lUB0ljII/4Nm6YlLebIKGKie0MWSQAjFuCOZIyAVtomC4ksQ9mvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420509; c=relaxed/simple;
	bh=iyOqOWRt84OTzJZitLtaFwLAoRvMX+MnJAIWfcOuDmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3gS/Vs/RugxKoDvFFg+CFFUYhZsKfeCerZhzA3d1EYKbf1WH9LQ0wnBzPQDjuzV/t02L5loN9+SaLX0cJfi2WGm4MDCTa2NsQU4Ubsx5MG1YSiEdhGFztpijxVguE0AaKPp5xZZWNsyvFy6XQJ49Grkji0AHiRPtu5h/W7zK0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j5e0cxjM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eAp/itsm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745420506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLR/z7YIqr5I7FIwQeuOg1fHdrCyaNJ8I9tSX8q3nFc=;
	b=j5e0cxjM81SuyAJbPdhF4ypyPUlWYpteIDjTuFYMFW/zVbyQHj+pt7qKlRLLl4dhaVrpvz
	6NWlRR3wblMhKQEXKb2ykdjBXPMf1K6G0KuRFYd3w5pwyohPVnSvZ5H18NwP0vxqFT59uH
	eB0s7+hCcsPvVPGpbC2SmWGsJC2HtRcQ/pbBVQ4OJUJNLH6p3g0DF3x+Bj+F1albte8fem
	iu8wZEeMNga1J67ePjvxlXs/m20toWKxItUblKvt17wy1nmaiwWtkET/kHB/jPqCdUf4zR
	sIWU5sDqEnf51eruQwC0orGqH9X7xIxDetXDDfsW/bi++s/tolm9VU0gAn5Qqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745420506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLR/z7YIqr5I7FIwQeuOg1fHdrCyaNJ8I9tSX8q3nFc=;
	b=eAp/itsmXsv97IACjC0wVeBsSSHpld1NMqf4RovJ9/mUxHfAqeU0pcdz2JDKvwmPM1/Nun
	tyJKLU9qsugLXzAg==
Date: Wed, 23 Apr 2025 17:01:43 +0200
Subject: [PATCH 13/15] tools/nolibc: add fopen()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250423-nolibc-misc-v1-13-a925bf40297b@linutronix.de>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
In-Reply-To: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745420497; l=3216;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=iyOqOWRt84OTzJZitLtaFwLAoRvMX+MnJAIWfcOuDmU=;
 b=gnt6p0DkYCDpq0sC9fE9l3NG/heviYXE4qQmSHd8tYSkecwhF1AxRXCadYkIujBsDc0Kx9YEw
 c7tVhxgPeiQAUBaWXLpAg0nCkh++UP3ahKEYujCl7/3ytmkQDjKz7kC
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Only the standard POSIX modes are supported.
No extensions nor the (noop) "b" from ISO C are accepted.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/stdio.h                 | 27 +++++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 24 ++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 02426682c34bcd82d9556036c6c3e73a6a5a3b4d..86a1132abcd4e5e5b0f821cfe974aca8a6d4966f 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -10,6 +10,7 @@
 #include "std.h"
 #include "arch.h"
 #include "errno.h"
+#include "fcntl.h"
 #include "types.h"
 #include "sys.h"
 #include "stdarg.h"
@@ -52,6 +53,32 @@ FILE *fdopen(int fd, const char *mode __attribute__((unused)))
 	return (FILE*)(intptr_t)~fd;
 }
 
+static __attribute__((unused))
+FILE *fopen(const char *pathname, const char *mode)
+{
+	int flags, fd;
+
+	if (!strcmp(mode, "r"))
+		flags = O_RDONLY;
+	else if (!strcmp(mode, "w"))
+		flags = O_WRONLY | O_CREAT | O_TRUNC;
+	else if (!strcmp(mode, "a"))
+		flags = O_WRONLY | O_CREAT | O_APPEND;
+	else if (!strcmp(mode, "r+"))
+		flags = O_RDWR;
+	else if (!strcmp(mode, "w+"))
+		flags = O_RDWR | O_CREAT | O_TRUNC;
+	else if (!strcmp(mode, "a+"))
+		flags = O_RDWR | O_CREAT | O_APPEND;
+	else {
+		SET_ERRNO(EINVAL);
+		return NULL;
+	}
+
+	fd = open(pathname, flags, 0666);
+	return fdopen(fd, mode);
+}
+
 /* provides the fd of stream. */
 static __attribute__((unused))
 int fileno(FILE *stream)
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index ab9c3bcffd9750981d68c6d16245d285ce0657c8..f576edc3725b42ce086d6d83d989f38d3fab6eb8 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -856,6 +856,29 @@ int test_getpagesize(void)
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
@@ -1308,6 +1331,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(dup3_0);            tmp = dup3(0, 100, 0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
 		CASE_TEST(dup3_m1);           tmp = dup3(-1, 100, 0); EXPECT_SYSER(1, tmp, -1, EBADF); if (tmp != -1) close(tmp); break;
 		CASE_TEST(execve_root);       EXPECT_SYSER(1, execve("/", (char*[]){ [0] = "/", [1] = NULL }, NULL), -1, EACCES); break;
+		CASE_TEST(file_stream);       EXPECT_SYSZR(1, test_file_stream()); break;
 		CASE_TEST(fork);              EXPECT_SYSZR(1, test_fork()); break;
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
 		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;

-- 
2.49.0



Return-Path: <linux-kselftest+bounces-45100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F408C4044B
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 15:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3254274AB
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 14:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F082328612;
	Fri,  7 Nov 2025 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l+mqtFSe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gtA08c+p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F170322541;
	Fri,  7 Nov 2025 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524831; cv=none; b=j4X+/KTaxGCBb14Hb3e9vznZsvWBrGhM8ck8Hq0KNDGq5skVWLURyt234BvtFqM18VKvbLDy+iOnwA+HfIH66E77KVY8GL/I93LcFkoIkSVrDEOYwrGk4C9IADIV+rq7NA1owHWHryBepP0lekCRK+4WZP0yTCA6EdhA+GDG9ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524831; c=relaxed/simple;
	bh=WV5FPIIQ0i3DEYVmZhlBm8yA6G/UsyKSoEFCNJFfCk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fVSReH5cTmBIJR0XMcizQYgyO78Ng/TkZSSz63Xa0fC/tOQxovPfsdjjBLaW5L30nPizutWk02emWy99GduIQn6T6PZE1nHUW7eOrmvS9e1PAQfHL/YNkrrpsecjAwXGFyjc6Mb6In151IJmsxiYHvWXE9qd3/+U4vtdv6mYxew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l+mqtFSe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gtA08c+p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762524824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uwrD8sj8pAGNqMxSEVn8+Q0j58iGwRXFt4Y4zZTLAWg=;
	b=l+mqtFSeSfbRiTrpq163XYxJvW3DaSi47j60F1A/1LamipJ5jxK5GfQwL1d1YEkuupmn59
	ZSCwz2zzP9gJ/PN/3R4rZoko+vK7nCrDta9+hvApYcrXGcwrDINhjzVS2tMvlQp1g984VZ
	HGbtXFoRNHlEfQ87tLbJC1+nfAAC1nE/YwY+6qRlcoGvte7qnXpAroQL31zRGJe3w7d7T8
	XHkz03Vp3evs79/J+hr5Ubvkmtfu3tXBAffE7l3mX7x+zKV6VbgJ6LED6SlXwFA1qq/OpW
	NNGNSmsIMXPWB7uPfR/OCoRC/wilZHk/XSjS55qjJKv9Jp0jMS9Q3ZJg/S7G9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762524824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uwrD8sj8pAGNqMxSEVn8+Q0j58iGwRXFt4Y4zZTLAWg=;
	b=gtA08c+pCHkQx5B2shHcSkAmxNePpFewgeKlmrjOImD7tWQgOwb4M14X5n8fEdGnjGsWf9
	8+yYHBIf9X8CU8Dw==
Date: Fri, 07 Nov 2025 15:13:38 +0100
Subject: [PATCH] tools/nolibc: add support for fchdir()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251107-nolibc-fchdir-v1-1-4a1ab8141f68@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAJH+DWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwNz3bz8nMykZN205IyUzCJdIzMT02QjS4tEU2MLJaCegqLUtMwKsHn
 RsbW1AO+wKrpfAAAA
X-Change-ID: 20251107-nolibc-fchdir-2645c298a538
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762524819; l=2388;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=WV5FPIIQ0i3DEYVmZhlBm8yA6G/UsyKSoEFCNJFfCk8=;
 b=hJuxWrIT/kyzeRcbrVAV8qA7dmcla3vsS4PVeLw6MH6ol2TBxauzr9DSEDysVYg1r1UMV9c4w
 OXCvrT+ulQNAoshWtMxgxMxEEa1Q3n1cznpV6p7AZ0oC6ZhOE+RZ2lz
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add support for the file descriptor based variant of chdir().

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/sys.h                   | 13 +++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index c5564f57deec88b8aa70291fcf6f9ca4dbc1d03f..a4b0fdb9b641230174f5e62d62762f59af81a00e 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -118,6 +118,7 @@ void *sbrk(intptr_t inc)
 
 /*
  * int chdir(const char *path);
+ * int fchdir(int fildes);
  */
 
 static __attribute__((unused))
@@ -132,6 +133,18 @@ int chdir(const char *path)
 	return __sysret(sys_chdir(path));
 }
 
+static __attribute__((unused))
+int sys_fchdir(int fildes)
+{
+	return my_syscall1(__NR_fchdir, fildes);
+}
+
+static __attribute__((unused))
+int fchdir(int fildes)
+{
+	return __sysret(sys_fchdir(fildes));
+}
+
 
 /*
  * int chmod(const char *path, mode_t mode);
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 29de21595fc95341c2aa975375a8d471cb3933fc..5927a84466cc0ede3b99611e134a8c6b8ab91e72 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1343,6 +1343,8 @@ int run_syscall(int min, int max)
 		CASE_TEST(dup3_0);            tmp = dup3(0, 100, 0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
 		CASE_TEST(dup3_m1);           tmp = dup3(-1, 100, 0); EXPECT_SYSER(1, tmp, -1, EBADF); if (tmp != -1) close(tmp); break;
 		CASE_TEST(execve_root);       EXPECT_SYSER(1, execve("/", (char*[]){ [0] = "/", [1] = NULL }, NULL), -1, EACCES); break;
+		CASE_TEST(fchdir_stdin);      EXPECT_SYSER(1, fchdir(STDIN_FILENO), -1, ENOTDIR); break;
+		CASE_TEST(fchdir_badfd);      EXPECT_SYSER(1, fchdir(-1), -1, EBADF); break;
 		CASE_TEST(file_stream);       EXPECT_SYSZR(1, test_file_stream()); break;
 		CASE_TEST(fork);              EXPECT_SYSZR(1, test_fork(FORK_STANDARD)); break;
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251107-nolibc-fchdir-2645c298a538

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>



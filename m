Return-Path: <linux-kselftest+bounces-30207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E128BA7D4BA
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A643B20F3
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F63D22CBF1;
	Mon,  7 Apr 2025 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="haV6Mavk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WYS6HE84"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042B922B8C8;
	Mon,  7 Apr 2025 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008795; cv=none; b=XAVPqsyjnHWnidVP6whIHEHeJYOOsq41MofG0hVIH/qBrhIQ8oiwtdWklOZRX5QzybIX2r9sSJDnKZ6RHin/JJ6jvAW3+34Yfhfw3UknmuZ/fIHro7QX7Wd9CBOoQv+Enby/fcB34ZNZH/QqEyB/hqwB09SqQ46Y8VKNS1Hn5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008795; c=relaxed/simple;
	bh=eueIMfuhJ+J1yj2bA5e9rnF4yzqTd/ncjRAHWOjdMl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bjHHtjFEuzCQzOxkboahn89D88w0oHHsXw/zrQqMB+AFbJcl3md0NbOtDCBJkDNKo9eWPA5fJyCNRfUo29eYfLgOsNAvUlus1Yg4aQtUVsUWOUzrNRFdPwfdvVG8upAO+KQUO1qiIFYwYp7ENpB8K3Vft2PcXq3vD3AnRbZxCQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=haV6Mavk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WYS6HE84; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tz+K3JzFCxIC1WzEuZHw4kf96d8I8QM3F1CQ6V2mVsY=;
	b=haV6MavkJ3INLV/sb12G6p+5mwA0rJLvRRfv/Qnh5t5RCuivBOHBbzrDoD2JEAaFZk44ed
	WdguII8++cXG9sDM6oOpZyTB2XC0Nno2B+nm41c+45/KKw3JGYL3Tc2Q/zKNp9rnxzpjue
	32iLMzORkw3c/3j0dkKdy8DgQBJpTqH/FlncfmkH5qyAjcpKsS5C5BZEHVZr3eWmZKEUF6
	5AAAG3ZrnxxgkuR/8M/Mngfi2lo3BbRfDvFfPo1w/jVUs63suFA56ShgkTnBoFvpPevF4f
	RmNA8oFfUOL/q+KL7JJasqtQ76jP3+jLBK8EfE92vw3eBJdfpCSxNMnOGTJfYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tz+K3JzFCxIC1WzEuZHw4kf96d8I8QM3F1CQ6V2mVsY=;
	b=WYS6HE84mqpV4OI//j5AWim59+SRTAsqN4WCtR+O6ecEfnuZvdkTm+z/LJiNuzMfb4PPeP
	K+BAwvNY+e6vrCCw==
Date: Mon, 07 Apr 2025 08:52:44 +0200
Subject: [PATCH v2 21/32] tools/nolibc: implement waitpid() in terms of
 waitid()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-21-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=2732;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=eueIMfuhJ+J1yj2bA5e9rnF4yzqTd/ncjRAHWOjdMl8=;
 b=c1Y/9C5M8EZrpldyWRKJa8tv+1Ke9Pz0esyc0zHkgHGB1PokScLvzl+UcSFQJMxUfhwY9eSeI
 3XKgZkZVQkJAoW0/thfJln2R5Ipt+jThg2uv0qKRNGqleHxCNYo4hWQ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The old wait4() syscall used by waitpid() before is not available everywhere.
Switch to the waitid() syscall which is the new replacement.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys.h | 71 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 12 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 5c71a2f65c7bd93f6f516a54f7e63244466fad47..e39eefb2b82cc97eccfc030005fe0321632f12c4 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1267,6 +1267,7 @@ int unlink(const char *path)
  * pid_t wait(int *status);
  * pid_t wait4(pid_t pid, int *status, int options, struct rusage *rusage);
  * pid_t waitpid(pid_t pid, int *status, int options);
+ * int waitid(idtype_t idtype, id_t id, siginfo_t *infop, int options);
  */
 
 static __attribute__((unused))
@@ -1291,18 +1292,6 @@ pid_t wait4(pid_t pid, int *status, int options, struct rusage *rusage)
 	return __sysret(sys_wait4(pid, status, options, rusage));
 }
 
-
-static __attribute__((unused))
-pid_t waitpid(pid_t pid, int *status, int options)
-{
-	return __sysret(sys_wait4(pid, status, options, NULL));
-}
-
-
-/*
- * int waitid(idtype_t idtype, id_t id, siginfo_t *infop, int options);
- */
-
 static __attribute__((unused))
 int sys_waitid(int which, pid_t pid, siginfo_t *infop, int options, struct rusage *rusage)
 {
@@ -1316,6 +1305,64 @@ int waitid(int which, pid_t pid, siginfo_t *infop, int options)
 }
 
 
+static __attribute__((unused))
+pid_t waitpid(pid_t pid, int *status, int options)
+{
+	int idtype, ret;
+	siginfo_t info;
+	pid_t id;
+
+	if (pid == INT_MIN) {
+		SET_ERRNO(ESRCH);
+		return -1;
+	} else if (pid < -1) {
+		idtype = P_PGID;
+		id = -pid;
+	} else if (pid == -1) {
+		idtype = P_ALL;
+		id = 0;
+	} else if (pid == 0) {
+		idtype = P_PGID;
+		id = 0;
+	} else {
+		idtype = P_PID;
+		id = pid;
+	}
+
+	options |= WEXITED;
+
+	ret = waitid(idtype, id, &info, options);
+	if (ret)
+		return ret;
+
+	switch (info.si_code) {
+	case 0:
+		*status = 0;
+		break;
+	case CLD_EXITED:
+		*status = (info.si_status & 0xff) << 8;
+		break;
+	case CLD_KILLED:
+		*status = info.si_status & 0x7f;
+		break;
+	case CLD_DUMPED:
+		*status = (info.si_status & 0x7f) | 0x80;
+		break;
+	case CLD_STOPPED:
+	case CLD_TRAPPED:
+		*status = (info.si_status << 8) + 0x7f;
+		break;
+	case CLD_CONTINUED:
+		*status = 0xffff;
+		break;
+	default:
+		return -1;
+	}
+
+	return info.si_pid;
+}
+
+
 /*
  * ssize_t write(int fd, const void *buf, size_t count);
  */

-- 
2.49.0



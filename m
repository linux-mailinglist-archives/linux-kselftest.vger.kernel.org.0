Return-Path: <linux-kselftest+bounces-30558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2E4A8575F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575BF1B811D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107AA2BD5B5;
	Fri, 11 Apr 2025 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MRVwZCMZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q0hHE5eQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BE229B22C;
	Fri, 11 Apr 2025 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362119; cv=none; b=d2TPx1IESbo84YK+uP3m2SQSPP7e7/oBJXDSBWtlvVXAYqOsMl7wGhAFfahAGFtX04wcoSbTxsXyIUq2yX3UqmpgqHk1Yip7LabdGEnjZUe7zuvhdFwy98CNLlOrM+oXslU6tdMZ7a7r2MBoS31uBarwFiZ5vzEI0oNAW3QKQzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362119; c=relaxed/simple;
	bh=eueIMfuhJ+J1yj2bA5e9rnF4yzqTd/ncjRAHWOjdMl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b56y+ZLhAXXz3ggD+AzdUkCGAZgVkNFE4zw4/09uFHO9T8yk+kiM1mUqY8CFyYXfL2uqlYXIGqrDcmVAY5iKj3FGxjrSARSOfUJXBJ3t/2GRVBcRqwwtoIRKQqhobpCxlykMnbaxftnsej/018j7qXyIBJqsjGJGOnx54E6AMpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MRVwZCMZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q0hHE5eQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tz+K3JzFCxIC1WzEuZHw4kf96d8I8QM3F1CQ6V2mVsY=;
	b=MRVwZCMZfLjjaOrOvHe6aIXV3Ca8uHVAvXBvKrUUZIX8Lb6U9croCVzsD2AdG6TB8DzMW3
	Wu5J9GvlLPFJoZm2zY3JBy9XD1z0kBB6wOg+Rgl4FEJVpUl1vxXs5RqDnf4t0OHsdOH4bk
	RURjnhk6alrodPHDaWZXzASxKrMkc+YcD5UIACb0/8dEYB/+vwJg0cTV+1ImS4R1niPDkQ
	5MCg83mW3KpY3eK5woMm30fHuK/n8K86HyGeIJCtSuYXVY/cYPUUsJTT5s1/gdgqrFEXBv
	83ybLF2HhX5OWKEnBJEVp3y7gyFfS7Q/clTFY4HBh31jEkB4L3+Iv66OQnPUzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tz+K3JzFCxIC1WzEuZHw4kf96d8I8QM3F1CQ6V2mVsY=;
	b=Q0hHE5eQdYQlZua1CGlMC0EL01V1RcDHSBWCxPBMLgKbYJ1pYmRXpuww2xW7JIjyXY0FS2
	ohGZcMA7VhdRySBQ==
Date: Fri, 11 Apr 2025 11:00:45 +0200
Subject: [PATCH v3 21/32] tools/nolibc: implement waitpid() in terms of
 waitid()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-21-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=2732;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=eueIMfuhJ+J1yj2bA5e9rnF4yzqTd/ncjRAHWOjdMl8=;
 b=irK2AN8RJ3zBH44AteK3nrFBiTnIMePIEw45lccoT3Fmv4Rhak7TpMb/gXm9m8fz7CoNPSVbJ
 iRScBbtzHlTA9gUkK//Vp61ykkG4bylt6UheEoKqOh0LAxNA5vEPTVL
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



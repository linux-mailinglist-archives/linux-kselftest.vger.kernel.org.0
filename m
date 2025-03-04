Return-Path: <linux-kselftest+bounces-28168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BBFA4D472
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1694B7A7C55
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7741FDA7B;
	Tue,  4 Mar 2025 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Awgo2k5E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kp4Z/+KY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DAA1FCD03;
	Tue,  4 Mar 2025 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072283; cv=none; b=vCOsfaa0IN3bo7V4dZnR7MWDXK4Au3F+jQ3Rj6hc+nCG2SB5saCbglGj8Yj9G66H1HIG/e92QQN5vTsj0bXeWtAl0Ucktt78Pu1HBmh1eL/NfhaA45JONGRyWSGKFd1kvDOfhtAKQ0Gc9Hfu3ZMh6X/AIjrqjvaBl3R524WV2/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072283; c=relaxed/simple;
	bh=9j4nBghxOLCnwD0YNy8UxsaC9WSegGRZTLagG8pb+Gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cloQySc3gWGOwcz5f6mRmfX/SqbUcSyKUovCydM95hJTCK+qddqsZUgoa69ui1b0Tz6OurOP0dLTQWBHSnNcJx1j8Bck0IOE1zZzH2gyZVkQd0EgaVf/gLiWIt+pzAFi1TAwVzH1B6RV/K0w28a1y7Yb0pqU0ycYHNFP0qViW78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Awgo2k5E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kp4Z/+KY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V44ch+lkWYAy1zwm35rG7H8jl4JyVX7DdzhpML16BWQ=;
	b=Awgo2k5ErX1VbC/Ao8sSvgHbl47tdQS25BW9vDpDWa19nhpvMYrTCfjpcs/TOEEy2n4m+i
	RmsnLo3TMrB9XpPMUkoGrWbQa2O5AZsSIL9t54Z48BCsrKx1ui/Oyrgd/O/aAWFcfae2ra
	78OaVgawuKE83Yu8HwnN6QHc5prFCnnhmlaO/x0MHegTQ+pVLz0GiQiGFJmo7LjozZ4wgy
	LV7PI3OSAnJkRFt0cThg66L2duAi2f6gkB+NxwBc1RtDlgeizD6BHwVY8t0aQskGBUoDMe
	r9xoEoh5BwL8RHioAn5YcktJHU+72UV4c6fYq99zDSfQ2rOJw1JQSTRR2wb6CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V44ch+lkWYAy1zwm35rG7H8jl4JyVX7DdzhpML16BWQ=;
	b=kp4Z/+KY0IZhfgW6Z9C9rrGwj71YQfQM/36vxtjJEHhyrrq1Qc3/ZNv1UEe69ggj1AdgPc
	P9MnIvZKrQ1rvPCw==
Date: Tue, 04 Mar 2025 08:10:51 +0100
Subject: [PATCH 21/32] tools/nolibc: implement waitpid() in terms of
 waitid()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-21-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=2627;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=9j4nBghxOLCnwD0YNy8UxsaC9WSegGRZTLagG8pb+Gg=;
 b=VPWIP81JbzHWjHvAhALs2QoIyXghLQ2ofYj+p6WdTjPuUsvccMJHt0i7yCN/4dsEtVyrbal0B
 PVoQmLjwBMOCP85pk9xt2zcXm63+f1KZqlw4CiUQAdAc3ccN6ILCQTS
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The old wait4() syscall used by waitpid() before is not available everywhere.
Switch to the waitid() syscall which is the new replacement.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/sys.h | 68 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 12 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 43b1bfa7a582ea926a062ff17fcf3e1b79be187d..8c929ddb62eae81d4e0d36dec72bc1718d9a1082 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1249,6 +1249,7 @@ int unlink(const char *path)
  * pid_t wait(int *status);
  * pid_t wait4(pid_t pid, int *status, int options, struct rusage *rusage);
  * pid_t waitpid(pid_t pid, int *status, int options);
+ * int waitid(idtype_t idtype, id_t id, siginfo_t *infop, int options);
  */
 
 static __attribute__((unused))
@@ -1273,18 +1274,6 @@ pid_t wait4(pid_t pid, int *status, int options, struct rusage *rusage)
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
@@ -1298,6 +1287,61 @@ int waitid(int which, pid_t pid, siginfo_t *infop, int options)
 }
 
 
+static __attribute__((unused))
+pid_t waitpid(pid_t pid, int *status, int options)
+{
+	int idtype, ret;
+	siginfo_t info;
+	pid_t id;
+
+	if (pid < -1) {
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
2.48.1



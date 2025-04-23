Return-Path: <linux-kselftest+bounces-31412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B93EA98F90
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7898E106C
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5173928A3F7;
	Wed, 23 Apr 2025 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dN6Eza9Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mTKZ6gOJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68284288CBC;
	Wed, 23 Apr 2025 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420507; cv=none; b=ZJY3FqjSQ7B5JWTTx3TWuPhpdda14eU9Nyd3kuIa/yYkF8Z3vsd2PXiC6j05zMane7gbjXvnS/WuehQORRXx4fYcwtM+agu55zpoLXlnHJzDxs+MrzlvjZYhQJkG65Vr+SRYk2jqvHndUzzsWKb4c+mTq6NQR/WCyeER/es0emQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420507; c=relaxed/simple;
	bh=CTwSi83UyUElkeC0d9YnXD36OkjwZYrnlRYHpExmrVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uKWI5yxHSYhY06zknGBsum7xjKIc52NIksep18yfsG/lDk4zApBHDS2Z0IrVrhMjhYN7H4QBvHhZoZYhHgDS78KCnbUBszAH0S/Fx3cWVs+35/GSapM0bGK8Yl2t8GyeH88ZfkJrEQAGzMh4xg/YOIK4btLP3HBSwlI1DIPjcdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dN6Eza9Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mTKZ6gOJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745420502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3GrxsqYvKvy8k2dAEo8dPbUQENIK7ngV+AfA0g2P8g=;
	b=dN6Eza9YY6IMTtum6GsKhZGWXJBThpD42XrOna8P9CiIsgsSHnvhoHn0vNagO7TM4rm0nQ
	Vf63Z1lGRWFNfV1/RiW1IRYoga7E7oCKKyEe4i3fow3SC/0zLTtYZsYqlPSFNflDSt6Za1
	BZT1PApYk703hiFc2P1/ma/TReI387bDL4ZqrRmyKcrYRxFASJUG/LxraKznsJuSoxbtmC
	ugeOtlJZ9zZthfGdAXxGkBmpCSaTyrDCkU4EH6zzjchRrO6QzrEGd3B5ryrd6K59GzKwRT
	8qXvq+ds/IpxswEpIR98OlirhWW+TdvjJIQPorqY/8WTyArn1z8fNXsnG737xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745420502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3GrxsqYvKvy8k2dAEo8dPbUQENIK7ngV+AfA0g2P8g=;
	b=mTKZ6gOJuB2Tn1mHcUDVglWFIXp1XLNv3Uoi5ea6Wo9S7m1x0mjWLZlCdjYHVhIG49qhYz
	GT54ZsQ7AGydvrBw==
Date: Wed, 23 Apr 2025 17:01:37 +0200
Subject: [PATCH 07/15] tools/nolibc: add support for access() and
 faccessat()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250423-nolibc-misc-v1-7-a925bf40297b@linutronix.de>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
In-Reply-To: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745420497; l=2263;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=CTwSi83UyUElkeC0d9YnXD36OkjwZYrnlRYHpExmrVo=;
 b=UqGH1aGCfEzS6/oLJxkgMGaZH2L5tCyM0AvFdWoA450JYNOGve96Q0D1JfdCUsQrI4H+GKm0i
 vYksaYRzOfBAQRys26cAv7RH4CP9PPs4vihTZWSFkIRihT1sKo5uG+l
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/unistd.h                | 28 ++++++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
index ac7d53d986cd11ac84dd0a17e5a7055c779b2b10..a18e318399880dec12284ea86cb91cf46cfc4aaa 100644
--- a/tools/include/nolibc/unistd.h
+++ b/tools/include/nolibc/unistd.h
@@ -17,6 +17,34 @@
 #define STDOUT_FILENO 1
 #define STDERR_FILENO 2
 
+#define F_OK 0
+#define X_OK 1
+#define W_OK 2
+#define R_OK 4
+
+/*
+ * int access(const char *path, int amode);
+ * int faccessat(int fd, const char *path, int amode, int flag);
+ */
+
+static __attribute__((unused))
+int sys_faccessat(int fd, const char *path, int amode, int flag)
+{
+       return my_syscall4(__NR_faccessat, fd, path, amode, flag);
+}
+
+static __attribute__((unused))
+int faccessat(int fd, const char *path, int amode, int flag)
+{
+	return __sysret(sys_faccessat(fd, path, amode, flag));
+}
+
+static __attribute__((unused))
+int access(const char *path, int amode)
+{
+	return faccessat(AT_FDCWD, path, amode, 0);
+}
+
 
 static __attribute__((unused))
 int msleep(unsigned int msecs)
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index b6724c314766b0cf34d7cae5cac28a9102ebe66e..7090e6b7c37e49afe751835bbff6a7af4f4fcf2a 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1109,6 +1109,8 @@ int run_syscall(int min, int max)
 		 * test numbers.
 		 */
 		switch (test + __LINE__ + 1) {
+		CASE_TEST(access);            EXPECT_SYSZR(proc, access("/proc/self", R_OK)); break;
+		CASE_TEST(access_bad);        EXPECT_SYSER(proc, access("/proc/self", W_OK), -1, EPERM); break;
 		CASE_TEST(getpid);            EXPECT_SYSNE(1, getpid(), -1); break;
 		CASE_TEST(getppid);           EXPECT_SYSNE(1, getppid(), -1); break;
 		CASE_TEST(gettid);            EXPECT_SYSNE(has_gettid, gettid(), -1); break;

-- 
2.49.0



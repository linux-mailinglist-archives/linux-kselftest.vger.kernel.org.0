Return-Path: <linux-kselftest+bounces-31771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C03BA9F0FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 14:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D84497AD3EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 12:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2839026D4DC;
	Mon, 28 Apr 2025 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xkS7MhE9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cTq+Brhn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B38A26B2A5;
	Mon, 28 Apr 2025 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844016; cv=none; b=tl1d7kq8dZ5k55D+GKS4hbOlAqgLqbi1ybJW7OUEI/U7RTQTprgbjAspa5K9QdgK3Nh71nw9+Okx5+fxk7MK7ITtfpQzm+hSXtG8/4tf+GX7geL+K52IE9wsuMZoDpRydnOQ/rrSTGNXcjxAXiDKuAOKFjCehjbN/CGGz86Z7Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844016; c=relaxed/simple;
	bh=2XfhIYrUpwPiS3xNMEeUtDZt+yUx0Is6L7LMEnS4xiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FAaD4ZPx3G9W8COm760duzLy/9p9PNmNBGeisseNYgTL9QN8mK0/wMKYe4em6+jt5tYzhYaK195RADpUbLSNIrHvWMxr0fILDgE9VpVJk+pXCL/c6ZQpJLblAn1JEV51h5dezzxdRv80nna71MFt6Xdm4tgkNVRsgj4y6jGqbDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xkS7MhE9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cTq+Brhn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745844012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKovy5nOL4qPV4KCSZjTnwgma6hkKTxr26X+/tQlD6c=;
	b=xkS7MhE9vXG6V3ZzGaeAIEGqggxQP6Ii+aw3DcwndvQkO5WBYa7YXBim1wh8vkfK7Po27w
	8fKSpx3nwbk3y5LYrOYc0CCggRgpOl0absLeohbBRV4r4IJJNiVDg61vIGUl7vdqySVW5y
	Gm4mzugcc3+7OEx6EMYEt6YG4OfDxi1+CPCNr15f1xnIwYxsi4bFl7HGCno4lProSo2tqE
	xMEbXiREIp0QTOiBO2h+kIZEMN57c6A2rcKb5VxIPoq/g+WxlfLOoOnynU3Eap0w4PV87G
	xD/ePGeA+S18G1pG16RsZWxqR5B/n5Zb0Fp8qAfU6wj4bv3Ydsr7WZjiTwcpfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745844012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKovy5nOL4qPV4KCSZjTnwgma6hkKTxr26X+/tQlD6c=;
	b=cTq+Brhnh/O4B9RxZfiPxS2B3Jhv8/1GuSwGh9ZDIrpl4VHHuBV0RJxJnNYBzG2IPBKZe2
	mQOQg4eSrfKY2KBQ==
Date: Mon, 28 Apr 2025 14:40:08 +0200
Subject: [PATCH v2 07/15] tools/nolibc: add support for access() and
 faccessat()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-nolibc-misc-v2-7-3c043eeab06c@linutronix.de>
References: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
In-Reply-To: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745844007; l=2299;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=2XfhIYrUpwPiS3xNMEeUtDZt+yUx0Is6L7LMEnS4xiI=;
 b=R/X5VEjcDnfZETbZ9ZKyE6N3oDm78sxoUudDSbHg8TvpDPuyZVfG7wbrp3cHq3mFCkwWR1VFN
 eWDq11G/7rpCuDpyrBUvmSkAWLGMn6VlJ9HjOBOtn7CwHZBSPO09gwT
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/unistd.h                | 28 ++++++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
index ed253305fdbafd040ca5820207d8c53c6ea9f9fc..25bfc7732ec7e72a60f445588a233f72c008f7ef 100644
--- a/tools/include/nolibc/unistd.h
+++ b/tools/include/nolibc/unistd.h
@@ -20,6 +20,34 @@
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
index 14a27bc6c83e4fda595b10dc29cf56b63904272a..10db118b8b111ec17f713d57240f193c7b18c70f 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1112,6 +1112,8 @@ int run_syscall(int min, int max)
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



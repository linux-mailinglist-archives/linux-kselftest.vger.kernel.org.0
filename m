Return-Path: <linux-kselftest+bounces-25433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8F2A234DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 20:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF6C18858B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 19:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCCE1F0E3A;
	Thu, 30 Jan 2025 19:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="blLNdttd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85DF18E743;
	Thu, 30 Jan 2025 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738266856; cv=none; b=pauuUTMvD6jWna5E4k5jBQGQ5iUD55hFRQttNEAEkJn4ZxxpDULhKrK8OQznX1Xt9IuHD1khIqdw34uATcOITNRVySlCtvNFA1DsfMGR5svbp9C0Y6MPM6lB5+GVXQNpUIsXseOa0TsO90s2oNrgsLPGIJ25pETX0bkLigDBwD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738266856; c=relaxed/simple;
	bh=NWl6BAV2wY190s/uHWqNlHEh3dQI3ydDUjDGin6zRPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eiJX60eR23GMcr0E4COrasUi9t3xGbu62u/dM/xjmZY6JMYg+O10ky1jXEMoqLWdQC4AG0OgsPBx5D9XiRRz/mLlO5urqkhDlEXWtOlG7snPgZjCrUrpT9Re4NJw4SL9wuYoGYDl567JKvkZrVKvQxoZAIZ/t/cdZPz2cLgADSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=blLNdttd; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1738266852;
	bh=NWl6BAV2wY190s/uHWqNlHEh3dQI3ydDUjDGin6zRPw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=blLNdttdoTix4ae8NhNbOwFv2qtEuzG72wFvfuoIYLfO8akVbFuD4AqT11NoLRZ5h
	 /Rn8IU2jIZDYeBwqkFZqX8wW9wIH9cVNn2/ByHI0nfXp+vhcToEboASzMTTzOOyg0p
	 oTpkfa8eF42rYO5iXcoq0ktE3U4L34WRTPFcWHEc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 30 Jan 2025 20:54:02 +0100
Subject: [PATCH 1/2] tools/nolibc: add support for sys_llseek()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250130-nolibc-dir-v1-1-ea9950b52e29@weissschuh.net>
References: <20250130-nolibc-dir-v1-0-ea9950b52e29@weissschuh.net>
In-Reply-To: <20250130-nolibc-dir-v1-0-ea9950b52e29@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738266851; l=1636;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=neAo9EcNZpbpbE+KnBnO2yFYOBsCTUBOGnoY4vOaCog=;
 b=IgRa9fB9fMxyLZU2kXqNpf8ihgww42ItmutJNSnkIlPSYJd8kXa46X6ignywH/saGndvj68Jh
 v/7sUeHLBSuDulSmJ2ZsXMeyp/G21Mm1/MvVPMirSOy4DNi78MNBfQv
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Not all architectures have the old sys_lseek(), notably riscv32.
Implement lseek() in terms of sys_llseek() in that case.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index d4a5c2399a66b200ebf7ab249569cce2285481a5..cf8d72f99c87c99622eca410cf80b0c5c1aab8f0 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -601,10 +601,37 @@ off_t sys_lseek(int fd, off_t offset, int whence)
 #endif
 }
 
+static __attribute__((unused))
+int sys_llseek(int fd, unsigned long offset_high, unsigned long offset_low,
+	       __kernel_loff_t *result, int whence)
+{
+#ifdef __NR_llseek
+	return my_syscall5(__NR_llseek, fd, offset_high, offset_low, result, whence);
+#else
+	return __nolibc_enosys(__func__, fd, offset_high, offset_low, result, whence);
+#endif
+}
+
 static __attribute__((unused))
 off_t lseek(int fd, off_t offset, int whence)
 {
-	return __sysret(sys_lseek(fd, offset, whence));
+	__kernel_loff_t loff = 0;
+	off_t result;
+	int ret;
+
+	result = sys_lseek(fd, offset, whence);
+	if (result == -ENOSYS) {
+		/* Only exists on 32bit where nolibc off_t is also 32bit */
+		ret = sys_llseek(fd, 0, offset, &loff, whence);
+		if (ret < 0)
+			result = ret;
+		else if (loff != (off_t)loff)
+			result = -EOVERFLOW;
+		else
+			result = loff;
+	}
+
+	return __sysret(result);
 }
 
 

-- 
2.48.1



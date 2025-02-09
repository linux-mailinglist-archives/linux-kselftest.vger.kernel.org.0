Return-Path: <linux-kselftest+bounces-26131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4943A2DE0A
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 14:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B683A6A09
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 13:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FB71DE3A7;
	Sun,  9 Feb 2025 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="aXSDEd9X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3B91E517;
	Sun,  9 Feb 2025 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739107556; cv=none; b=S3quiQ6zruPok13kgHGKLHOJn6ZIvMZZPcdJE5w5PBUK31bV0SVjO7kdOFON+dH2KEMjlrzxBkpHpmL/1n0ZgSVwRE7jOpZ5y6pkRAQRhtPEXMZJxdlV4ALWdyY/yC1VaDTlL+cK6mmEapdOyo5TxqLFYnVptb42Z0fdKz6GgsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739107556; c=relaxed/simple;
	bh=mEEMkcjvTtCyor7dpnn8bdN8llsVCQHrxLAKxOd7fBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LxXlBf0M0p/SVlk/a25VLGB6lgIzrY51yTkJVJuvHggTfzc3wJ0OqWPUY2J4ipwczZ/ISvcr1kd83JT1sEAfypRlhAcIfHIemO0A4wFUdJzOq8hC0zJoGFT1P7Sk5jaGFVq5pt9JiV+fjK9MBFpbQvjJOwhOA7qpYCzVeAHbIcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=aXSDEd9X; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1739107550;
	bh=mEEMkcjvTtCyor7dpnn8bdN8llsVCQHrxLAKxOd7fBA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aXSDEd9XKDFg5WAwg04TedHdtvOXM+fy+6C08stvrhLS21t6RfiGl6IFpq0QEadHs
	 ZM//tLWSDbi8WxDnX9Rg8zF9gU2W5wxzT/Yy3v3k2JTnJx4rkByp/1O4KVLkdDjV/E
	 NT5tEHp8o2dnOGNqRWuqE+UJxe6bNli1FSsNSujg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 09 Feb 2025 14:25:45 +0100
Subject: [PATCH v2 1/2] tools/nolibc: add support for sys_llseek()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250209-nolibc-dir-v2-1-57cc1da8558b@weissschuh.net>
References: <20250209-nolibc-dir-v2-0-57cc1da8558b@weissschuh.net>
In-Reply-To: <20250209-nolibc-dir-v2-0-57cc1da8558b@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739107550; l=1636;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Zovel61Qpv41HF33wjaMZK8SDq1GqzRm5THabbUQX00=;
 b=vCkm7qjPgIckCDNi854lESUyvwCP9OwXsniDF/5XdOm/h8YR7q0u5x915u+72wScm+kj1bj48
 1zsWyOEHATlAEW9JKFtDwBce+FbDuMKuwcKZhcbsK/KiHILE1VXi2WF
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
index 8c0a55bc9dc3aacd110db0195975fe4f85480fc5..8f44c33b121300e80b41c971019484007d050b17 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -597,10 +597,37 @@ off_t sys_lseek(int fd, off_t offset, int whence)
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



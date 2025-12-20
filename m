Return-Path: <linux-kselftest+bounces-47773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C672CD3052
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 14:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21D81301F5E2
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 13:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F9430F554;
	Sat, 20 Dec 2025 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pGfEbjLX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723CA30C612;
	Sat, 20 Dec 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766238972; cv=none; b=O4wCtyoFeqil11gbJB4uGLzC8f6qY3n5VYMwvDZ0zEQkmbbh+Aojyynren45TcyjeeNCk40ZLzEeanpeEjhASBUEJl8ml1Pi39/h4CZLcpKz3o4o6Z+mXs+V8CRPswCzK553fCbZ/mM5P7NiKxqdV1zjK01eQbU5JHmcZYSKKGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766238972; c=relaxed/simple;
	bh=K6K6XlIR438WXwjKl+1C/rJ/i+yI+SXJhICEMTIPyAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EGTMHMgpFSQx6WO8vEWdLcU1EGwAX7wCm+5IZQqm63gaCe0XqqWgs/tYV4O0/qkCraFFbOHsUZs6LN8vi5c5EgskXyZ31xYNx5wLaQ88nAm3arPHmtQ2QMFzvpMF23m3ecFr9apBJOLGzTbb8kRdCiTdJGFfFp1/ikiJJLtp/cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pGfEbjLX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1766238957;
	bh=K6K6XlIR438WXwjKl+1C/rJ/i+yI+SXJhICEMTIPyAI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pGfEbjLXycu4Pq2WWaIbVVV8iYMX0Gzznh6/rZIO0OqOQmn2fb1Nlnxig9xvweqPd
	 PWfOcT3S98+5VfNPpGLVl9bZsXNs6ZD2vqUo3fSD7FqCvjwd79VNjSA470R4J19BhO
	 3QOpIt6DIromxoxZkVwVDVbAXkwzjPVtcks22yms=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 20 Dec 2025 14:55:53 +0100
Subject: [PATCH v3 09/14] tools/nolibc: always use 64-bit time types
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-nolibc-uapi-types-v3-9-c662992f75d7@weissschuh.net>
References: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
In-Reply-To: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766238956; l=1525;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=K6K6XlIR438WXwjKl+1C/rJ/i+yI+SXJhICEMTIPyAI=;
 b=455jKb7E25SzRb3OhxpnHcYPomJHwLdgcoaxe8JlFEDpxwXl36UF0ZRaTtBuVpe7wn17eceKA
 MYjk6ltiBiaCr4sNMdxD0ALZmTIrUs05mvn4jZz5fB93S0wQjffQQH9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

32-bit time types will stop working in 2038.

Switch to 64-bit time types everywhere.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/lkml/cec27d94-c99d-4c57-9a12-275ea663dda8@app.fastmail.com/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/std.h   | 2 +-
 tools/include/nolibc/types.h | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index 392f4dd94158..b9a116123902 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -29,6 +29,6 @@ typedef unsigned long       nlink_t;
 typedef  int64_t              off_t;
 typedef   signed long     blksize_t;
 typedef   signed long      blkcnt_t;
-typedef __kernel_time_t      time_t;
+typedef __kernel_time64_t    time_t;
 
 #endif /* _NOLIBC_STD_H */
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 5d180ffabcb6..8f3cb18df7f1 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -17,14 +17,15 @@
 #include <linux/wait.h>
 
 struct timespec {
-	__kernel_old_time_t	tv_sec;
-	long			tv_nsec;
+	time_t	tv_sec;
+	int64_t	tv_nsec;
 };
 #define _STRUCT_TIMESPEC
 
+/* Never use with system calls */
 struct timeval {
-	__kernel_old_time_t	tv_sec;
-	__kernel_suseconds_t	tv_usec;
+	time_t	tv_sec;
+	int64_t	tv_usec;
 };
 
 #define timeval __nolibc_kernel_timeval

-- 
2.52.0



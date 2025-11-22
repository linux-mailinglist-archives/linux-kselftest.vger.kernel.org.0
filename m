Return-Path: <linux-kselftest+bounces-46329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4A7C7D479
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 18:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2334A4E612B
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 17:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656BD2FE582;
	Sat, 22 Nov 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="FILubYNw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C352F28EC;
	Sat, 22 Nov 2025 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763830799; cv=none; b=s8LmmRrPBgDfvI0dISCV+/CT9VL0OgKjsC/aC0LMWL576+nIaF0mMzBSjsm2GyF8gW/e/Pdam+0aNO8SUAr9/xX9gslM91dA5SSqVSx1FnTWgq4WV3k/MNwN6dnm5jLrAxI0AKkM3JrVpXhaSsmCybmveP/L7NJBMgEhJFn6eKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763830799; c=relaxed/simple;
	bh=/10X4PhbIf+Sqc14wCkpJwL51CxgUwakpQp4brgLpgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B5B44zbkyyRwcXhypafVYXdQ3itdVQfYj/aYMcQ9GhoAtsA8vuL0b0PUaTXop+tPu2EXk/asEgNERYeuxKm1bM9gZIlIdjDkThol0p5piD8japy/6Jd//PhyrJI9kY+y5Xy3SRCRXCOxHBIuJgWJ/OjShH+XlVeQ/hsgQtcHH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=FILubYNw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1763830791;
	bh=/10X4PhbIf+Sqc14wCkpJwL51CxgUwakpQp4brgLpgw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FILubYNwbKbKBdhSxera6hs+lkqJqsx6BsJuj7oA3QfFJ/hDVz0UmwvhoeigsV3MB
	 XmXwnunCem2kkCZKwDwVeQUGIfUaOkfvYW9PG4q83OageaRLyafDyMKu9Om/UNqssd
	 DCwb0mvWSqX3+/REZTnmqH+jRAk2BovmPtQKhPBM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 22 Nov 2025 17:59:15 +0100
Subject: [PATCH v2 09/13] tools/nolibc: always use 64-bit time types
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-nolibc-uapi-types-v2-9-b814a43654f5@weissschuh.net>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
In-Reply-To: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763830790; l=1489;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=/10X4PhbIf+Sqc14wCkpJwL51CxgUwakpQp4brgLpgw=;
 b=0/glYwR1rBVaO832oYGnsGgf8LyzS5lycUJcqWn0BV4zPcsQU6k/TwkX6L9K9r6qZBSIPiFzY
 ph7OJ9GyI5iDhABmM0p5Mexx2uvoDv5VgvbJHAfHgYwFekNodLrNKB/
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

32-bit time types will stop working in 2038.

Switch to 64-bit time types everywhere.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/lkml/cec27d94-c99d-4c57-9a12-275ea663dda8@app.fastmail.com/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
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



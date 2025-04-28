Return-Path: <linux-kselftest+bounces-31769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9FEA9F0F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 14:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68E417AB2DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 12:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CF526A1AF;
	Mon, 28 Apr 2025 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FMv0EaxQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RJXUnjCQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EAE268FFF;
	Mon, 28 Apr 2025 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844013; cv=none; b=JKNV18syUevZzcDaYEQwGDNEj0dfxhctdaPNU4idHFSU4x5rtd5/xnTniPZzVtWCEp45rqpYHAXpT4FjYoRDwhG6ut7YF+z3ksPj5juI2Npcx5BmU7z6Mddtc7huUXObvRkotozaG5sRQ7abffCB23U/Z2ZRReo6sko9VlNW2WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844013; c=relaxed/simple;
	bh=UPpcbSd0G1pS5+bG0ky3u+DXim5LqFVkhaH6YpvhkxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XC1GOzSGzYD/q0LS1QQ5btIY1DeiHpPw4XuNwJVGUkeSwtsg8VHu3/ke2CBm2dy8wq9Z5qQQGijCjOOYJXEVShJJHQ7fPSMtpl5cHNQCWKno8rmtiLXoSvnoyFZ5M7LiEk5BrYefOEbeq5a7wzZWI7FxwKQYn2KAkTYk8vddJyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FMv0EaxQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RJXUnjCQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745844010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALdbIXVv5ve0GoNFjKFhCmLKhoEWDD+m7TIEQsPXqyo=;
	b=FMv0EaxQMvWr5osWE/pqxt6toCXq/dpwNK2aVeE6cQUJkyNyuXhAWx6wxNO30Fdqg4tx9r
	rcM1NziOULLebYJ+SvHkJvS76/T2c1ZudkTs/pOJsCQtC0LG1Vng9zD+ZIaVLOYB6ztrNa
	OdUi+8cXXbEfggzWsdJJr+kLpD0nLBpvHd2MvAcBryzGilPW68c5VvOkzY9oyuSkEJ06Kb
	UdTT05uuyn51d7PrYZyzg4i1QHqhY0Vsq7SXE114pUuqb6cN3PfV+D5XWhm+UmTzLX1lb6
	LUxPEP9ug8/SYSwMWL6E1eOYFrF+e9NYWSnrItaeaivj1V3Hlje2Op9e8/mWPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745844010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALdbIXVv5ve0GoNFjKFhCmLKhoEWDD+m7TIEQsPXqyo=;
	b=RJXUnjCQvaGEK3KmjORw9AccyaaQ5ToLlSh0VSIwrDdU7lhOWia72z+yoARFtbHz0oUu1m
	6cY5zzneT1KM1HBw==
Date: Mon, 28 Apr 2025 14:40:04 +0200
Subject: [PATCH v2 03/15] tools/nolibc: add more stat() variants
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-nolibc-misc-v2-3-3c043eeab06c@linutronix.de>
References: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
In-Reply-To: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745844007; l=2037;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=UPpcbSd0G1pS5+bG0ky3u+DXim5LqFVkhaH6YpvhkxI=;
 b=PzkSXe3FRqaVx/4B73/MKKn6hZ/+CVnulZKhi2OUVdOSDEVTneCN1b8Ttp022hJvxHH6AnibS
 3yZ0laP0a00A00rjfY3G60aVZis85m1REbkei3JJ2i3aMEi6Ddm6H6h
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add fstat(), fstatat() and lstat(). All of them use the existing implementation
based on statx().

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys/stat.h | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/sys/stat.h b/tools/include/nolibc/sys/stat.h
index 987c8bb52502f1f758005b0afdfb2e39fc8ea1c6..8b4d80e3ea0360e3e6280f6c6166e87f793ddee4 100644
--- a/tools/include/nolibc/sys/stat.h
+++ b/tools/include/nolibc/sys/stat.h
@@ -17,6 +17,9 @@
 /*
  * int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf);
  * int stat(const char *path, struct stat *buf);
+ * int fstatat(int fd, const char *path, struct stat *buf, int flag);
+ * int fstat(int fildes, struct stat *buf);
+ * int lstat(const char *path, struct stat *buf);
  */
 
 static __attribute__((unused))
@@ -37,12 +40,12 @@ int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *
 
 
 static __attribute__((unused))
-int stat(const char *path, struct stat *buf)
+int fstatat(int fd, const char *path, struct stat *buf, int flag)
 {
 	struct statx statx;
 	long ret;
 
-	ret = __sysret(sys_statx(AT_FDCWD, path, AT_NO_AUTOMOUNT, STATX_BASIC_STATS, &statx));
+	ret = __sysret(sys_statx(fd, path, flag | AT_NO_AUTOMOUNT, STATX_BASIC_STATS, &statx));
 	if (ret == -1)
 		return ret;
 
@@ -70,4 +73,22 @@ int stat(const char *path, struct stat *buf)
 	return 0;
 }
 
+static __attribute__((unused))
+int stat(const char *path, struct stat *buf)
+{
+	return fstatat(AT_FDCWD, path, buf, 0);
+}
+
+static __attribute__((unused))
+int fstat(int fildes, struct stat *buf)
+{
+	return fstatat(fildes, "", buf, AT_EMPTY_PATH);
+}
+
+static __attribute__((unused))
+int lstat(const char *path, struct stat *buf)
+{
+	return fstatat(AT_FDCWD, path, buf, AT_SYMLINK_NOFOLLOW);
+}
+
 #endif /* _NOLIBC_SYS_STAT_H */

-- 
2.49.0



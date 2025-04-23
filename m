Return-Path: <linux-kselftest+bounces-31407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C72C7A98F3D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A499E16741B
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDBC285417;
	Wed, 23 Apr 2025 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Erf9YT9h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0xZNGsLx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F50727CB12;
	Wed, 23 Apr 2025 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420504; cv=none; b=hAYlzRrTGcBRrH7gkX6xwH3O9Z3FqtpXsuL7p5oIRJrhI4dwPOZk4OmcQPH3tMW+8W2Ot6cjSrkjcn5qAI7FMqOpBTR8RrCLsPKEVeJyVdS3NFJlY/iJUNDiXu9phQBJgueg3l428WBXQQKmycX+hLzb6CbbFK9zvMJDyayRYVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420504; c=relaxed/simple;
	bh=fVoLFuGSUSVnAazZi4qvsdowRwhDO8H618HmxSKX/6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQoerVO95ncxWC/VdN7MqMlDHw/RpB7PWJ3Sgo8Y4xE2OzKckQNhpjOJ2NlC5Ig7t6ACL9S36zuQKnYa0VL4JO6KvUhhHJJ1EFnA9EXVpSptFwIhvDokpAKgc3qgp6gVQsAKpNObTMGapQAQbyZARQvHPG2AeCQo8uUx1q0vafw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Erf9YT9h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0xZNGsLx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745420500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18Iz/Bdikt1dQavoAudy/VOxjZ22ac5YRQQjF3CfKfg=;
	b=Erf9YT9hH8Wc8KCfGxy9tOhyxctIqoCx6lSvW9rkK86pp8431yPEPlF1a+0TJ5OHAxv5AQ
	o/ukqqj1aF8+fKedqbpOotSkTUgSEt6u74AtDhwaiWyjlzMO40ctWIWrLnvZPtknKMY8sI
	zHmFgO02Qk6sWFL3bFcqAH3Em/F/BKzRU6gQlj20iGPylWq+PudEIiluysunyeAtZQI1O3
	ZhIYqNG9NBJDb10ItZNIvZAnHBe1yASjZq64nbBBZ6wTRuu0bD7BWyQw0IheHuy+YORC9o
	m80qEJKjhJ3cKQDjuyiGsnWaksih+nW0OZi9o+WyYGStOWHgYAbX8rey8bd9tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745420500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18Iz/Bdikt1dQavoAudy/VOxjZ22ac5YRQQjF3CfKfg=;
	b=0xZNGsLxTpGphEZ7vcHb+Zl68twFgwGFsVZ8VSy1DyiqxmZwZkVCQ7/MBGi4FnO5zGNV63
	egW+qm/KdZ5SH9Cw==
Date: Wed, 23 Apr 2025 17:01:33 +0200
Subject: [PATCH 03/15] tools/nolibc: add more stat() variants
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250423-nolibc-misc-v1-3-a925bf40297b@linutronix.de>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
In-Reply-To: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745420497; l=2043;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=fVoLFuGSUSVnAazZi4qvsdowRwhDO8H618HmxSKX/6A=;
 b=cgGrOPnhG6fND0X5FFTnFL2p//uNE0yDgWprFYXinT7QAj6i+5pQJjbLqHBdWorotMUUEqbcy
 woEHHrMsy4fC1VGQQrwmncqb/nlgeC3ZE4iGJEJ1aHqJpkKY70CukNN
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add fstat(), fstatat() and lstat(). All of them use the existing implementation
based on statx().

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/sys/stat.h | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/sys/stat.h b/tools/include/nolibc/sys/stat.h
index 0eaf5496ce233a4d8b5a239eef5ecefe05a39dd6..53c5c8addc829e36b927c3dd39b2a24f3472dcf0 100644
--- a/tools/include/nolibc/sys/stat.h
+++ b/tools/include/nolibc/sys/stat.h
@@ -14,6 +14,9 @@
 /*
  * int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf);
  * int stat(const char *path, struct stat *buf);
+ * int fstatat(int fd, const char *path, struct stat *buf, int flag);
+ * int fstat(int fildes, struct stat *buf);
+ * int lstat(const char *path, struct stat *buf);
  */
 
 static __attribute__((unused))
@@ -34,12 +37,12 @@ int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *
 
 
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
 
@@ -67,6 +70,24 @@ int stat(const char *path, struct stat *buf)
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
 
 /* make sure to include all global symbols */
 #include "../nolibc.h"

-- 
2.49.0



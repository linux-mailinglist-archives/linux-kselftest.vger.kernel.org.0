Return-Path: <linux-kselftest+bounces-39531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0C1B2FF48
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6941CE0EA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 15:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F4635A281;
	Thu, 21 Aug 2025 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="NaEuc0pP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D7353362;
	Thu, 21 Aug 2025 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790847; cv=none; b=U+aMXaMbGmuiB8/ZmQwa/Jon5LZIQtZK8aWcsYyumeCsfIep8E0MTHDOLQznvpsU73gaioNTLmSmBcHWt9qXawvD40twCP87r9LqfuVsgW/3I87NDYiWyoRHIZFhwF5+HFMeyklZOx3jq3SWdPHxsj6sW+MU6BtHB9yiUdlydwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790847; c=relaxed/simple;
	bh=K3Flvop9DgAFaUxrOP24qwqt1AB7pgft6CYh8LQ9d1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F3964Owx27DNd+O+OKowe3ZBOyMRn2/Fo5/jvBqfyCN/TjHWPJtCtuYdJJTlsB3c5PEergDjYlUqF3iAYZO6sShKBA+/6Ybuld/yn4do7mEJRikQ+83lRPOrdbUB3satmtKknIM9tV/sdn/dRcGMKdXBgHyr73GXGNxLTn4q3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=NaEuc0pP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1755790835;
	bh=K3Flvop9DgAFaUxrOP24qwqt1AB7pgft6CYh8LQ9d1M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NaEuc0pPH/OfFQXUYS/0KYY2jT7bdW/6rWs6H3VQ3Oj9QdljGJTB0FJuq7FAhJTkX
	 r7hgm3fpfXVGi2kRIL9P8FBfAqIdvuUHoZskfU+S+cHLV4sOEyrvMUVR10EmUrdk3Y
	 RBore3JB0gSnXCkiCDLv0RyJa+ZbK/k+n8FCV6RI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 21 Aug 2025 17:40:38 +0200
Subject: [PATCH 7/7] tools/nolibc: drop wait4() support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-nolibc-enosys-v1-7-4b63f2caaa89@weissschuh.net>
References: <20250821-nolibc-enosys-v1-0-4b63f2caaa89@weissschuh.net>
In-Reply-To: <20250821-nolibc-enosys-v1-0-4b63f2caaa89@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755790835; l=1555;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=K3Flvop9DgAFaUxrOP24qwqt1AB7pgft6CYh8LQ9d1M=;
 b=LCj6oInxdTg/ApcY0tpjs/r3Gc/B9XIij3VZTtL++fFqMqZwWdJJ6hp7UJas8KDXdMjkJbidm
 5kO4uAgF4ZxDqliD9oncd0c58Alr0+p2Ym8YEQxZRXqJykrR0eL4jlu
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Not all architectures implement the wait4() syscall. It can be
implemented in terms of the waitid() syscall, but that would require
some rework of the other wait-related functions in wait.h.

As wait4() is non-standard and deprecated, remove it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys/wait.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/tools/include/nolibc/sys/wait.h b/tools/include/nolibc/sys/wait.h
index 56ddb806da7f2466be5523b52fd01480b711daec..4e66e1f7a03e4585c91ec4ea68333b910600239a 100644
--- a/tools/include/nolibc/sys/wait.h
+++ b/tools/include/nolibc/sys/wait.h
@@ -16,27 +16,10 @@
 
 /*
  * pid_t wait(int *status);
- * pid_t wait4(pid_t pid, int *status, int options, struct rusage *rusage);
  * pid_t waitpid(pid_t pid, int *status, int options);
  * int waitid(idtype_t idtype, id_t id, siginfo_t *infop, int options);
  */
 
-static __attribute__((unused))
-pid_t sys_wait4(pid_t pid, int *status, int options, struct rusage *rusage)
-{
-#ifdef __NR_wait4
-	return my_syscall4(__NR_wait4, pid, status, options, rusage);
-#else
-	return __nolibc_enosys(__func__, pid, status, options, rusage);
-#endif
-}
-
-static __attribute__((unused))
-pid_t wait4(pid_t pid, int *status, int options, struct rusage *rusage)
-{
-	return __sysret(sys_wait4(pid, status, options, rusage));
-}
-
 static __attribute__((unused))
 int sys_waitid(int which, pid_t pid, siginfo_t *infop, int options, struct rusage *rusage)
 {

-- 
2.50.1



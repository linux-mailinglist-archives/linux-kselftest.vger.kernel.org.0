Return-Path: <linux-kselftest+bounces-23722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B71D19FA117
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 15:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13CD188EBE4
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 14:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD2F1FD797;
	Sat, 21 Dec 2024 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KT0linBf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F0F1F8668;
	Sat, 21 Dec 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734792278; cv=none; b=QLTqHd9DygMKnllFTd2KCGGktnMvM/zfM3ag0kgtnZIQ6G73FNk6yZtQSnx7YoPi/XaCdpib6GCNSL7yghDXRPwQ7Nx5VZDlZMtxrRmjbkGbaCe8b6QfZ1/DM/DzTP4o30AxE6gxnGCcrU4SpY+NljnHJA74/JZDIY2bsMOhu+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734792278; c=relaxed/simple;
	bh=nlgKA1aWXtMZ4vLJ+M3UslYSVWgrW4lQ46FIgxLbuk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mu9ybgVbdyf7OOcO93BZdNHFVZ0rie8PvXxs27MG7THZ5ujoiSeWoqk/0ByS90ll+IfLnhg/kxb6c3h/VjIEYEOn6+u7A2/PylMtvn72djMfZ8Py0sJTrV+yHYDZX91sSYjhHvAjw9Q8YF+h2qKA/407ijoGKWrwTnBkMLAx7dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KT0linBf; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734792272;
	bh=nlgKA1aWXtMZ4vLJ+M3UslYSVWgrW4lQ46FIgxLbuk0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KT0linBfSK3yb1tVBfOsrUo0Qmsy5DtV5NcKzkVfQADhnVJN5E0BXAJCApmsPsHr3
	 zVQ0RXn1dybDs65olAHAF0Rn8yy9IR9JJcg+jYFJGtfGw1QqslTzaN5dc1I3IX/PcO
	 i5EQl6N4KZ5WUhbhi1y94htVb3UCXl/uEKsEVeZA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 21 Dec 2024 15:44:28 +0100
Subject: [PATCH 1/6] tools/nolibc: add support for waitid()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241221-nolibc-rv32-v1-1-d9ef6dab7c63@weissschuh.net>
References: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
In-Reply-To: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Zhangjin Wu <falcon@tinylab.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734792271; l=1451;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=nlgKA1aWXtMZ4vLJ+M3UslYSVWgrW4lQ46FIgxLbuk0=;
 b=Ig+cd8xPaVLdOY8TmrPbOeWu/tTdW9wbIV95eO+fM2u8WdX0eUj3Ua2COzeHZgYnv1GPCWsmN
 o6sEOaa5ANfBUMHGbBZVGucYzVcpNMAel6JpLdzkUuzwQvKrCwZnr79
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

waitid() is the modern variant of the family of wait-like syscalls.
Some architectures have dropped support for wait(), wait4() and waitpid()
but all of them support waitid().
It is more flexible and easier to use than the older ones.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 7b82bc3cf107439a3f09f98b99d4d540ffb9ba2a..d4a5c2399a66b200ebf7ab249569cce2285481a5 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -23,6 +23,7 @@
 #include <linux/prctl.h>
 #include <linux/resource.h>
 #include <linux/utsname.h>
+#include <linux/signal.h>
 
 #include "arch.h"
 #include "errno.h"
@@ -1225,6 +1226,23 @@ pid_t waitpid(pid_t pid, int *status, int options)
 }
 
 
+/*
+ * int waitid(idtype_t idtype, id_t id, siginfo_t *infop, int options);
+ */
+
+static __attribute__((unused))
+int sys_waitid(int which, pid_t pid, siginfo_t *infop, int options, struct rusage *rusage)
+{
+	return my_syscall5(__NR_waitid, which, pid, infop, options, rusage);
+}
+
+static __attribute__((unused))
+int waitid(int which, pid_t pid, siginfo_t *infop, int options)
+{
+	return __sysret(sys_waitid(which, pid, infop, options, NULL));
+}
+
+
 /*
  * ssize_t write(int fd, const void *buf, size_t count);
  */

-- 
2.47.1



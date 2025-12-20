Return-Path: <linux-kselftest+bounces-47765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ED9CD301C
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 14:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E25C30173B1
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 13:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ACE309EE3;
	Sat, 20 Dec 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="b7p2bnFz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C5E2C0F6E;
	Sat, 20 Dec 2025 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766238968; cv=none; b=jbINRTkNAThbAWpGOeXhI8DbFpBjfPJkJOPaAd1dMtHvjHusE7XFNPu0f106VjeW+Zh2OAfeFE5c/wFv248slVeI9YvSgK8tnBnhMDSuG3wN+ZhpCn7P4PUjeEzSO3HvTGuMWROQ4kKPu/zuC75xkyIJS8zsjuy8+wmwTm442UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766238968; c=relaxed/simple;
	bh=FT8CdfUkzV1aTJPORp5DGeTUobkV9iWHje/A/ujkzzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CM2CXjQaEAtLPCnGcgzko8LMnhIKeXlKmEeH5IcDqoT2XPthb4N/kzbF0h+nV6eaKreqKgzJerxP7wiAM2FhzGpiamCyx/WfEH3fWs4noJbgx3bqe+OHGHQCDmYbhKIY5Lgc42QECqDG+sMrqKIGm8/Adl6HaEJqko4Nj/grIcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=b7p2bnFz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1766238957;
	bh=FT8CdfUkzV1aTJPORp5DGeTUobkV9iWHje/A/ujkzzM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b7p2bnFzDvw/oqN5cpWoH+UexM0JZtKBRmoAUozyrGTvyNbHZaSlYdjwSaE/KVg1e
	 o9e73rOACCnW57BA5UI9ENR9Oj//O+Mppf/W5F8CvLsyu/gMTTr2iMEGZug9OF5yri
	 czWWRwE3VFs+GMyYWyeDfGaaAwI6ZbgdAUIQOTyQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 20 Dec 2025 14:55:47 +0100
Subject: [PATCH v3 03/14] tools/nolibc/select: drop non-pselect based
 implementations
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-nolibc-uapi-types-v3-3-c662992f75d7@weissschuh.net>
References: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
In-Reply-To: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766238956; l=1539;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FT8CdfUkzV1aTJPORp5DGeTUobkV9iWHje/A/ujkzzM=;
 b=r83c2AbazMLzozlyuD9SbfcpVAXDEllwdxYCGa8QW3GPcB0P+WWYFi0sh+9zIdkaFskiddRXu
 1EHazmqQm9rCETn4/r7LsMJE88i2qppvNGLTTcd7NqAbNI7OkwQ2dRs
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

These implementations use the libc 'struct timeval' with system calls
which can lead to type mismatches. Currently this is fine, but will
break with upcoming changes to 'struct timeval'.

If the structure needs to be converted anyways, the implementations
based on pselect can be used for all architectures. This simplifies the
logic.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys/select.h | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tools/include/nolibc/sys/select.h b/tools/include/nolibc/sys/select.h
index 9a29e5b98a3c..50b77dace7ef 100644
--- a/tools/include/nolibc/sys/select.h
+++ b/tools/include/nolibc/sys/select.h
@@ -63,18 +63,7 @@ typedef struct {
 static __attribute__((unused))
 int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeval *timeout)
 {
-#if defined(__ARCH_WANT_SYS_OLD_SELECT) && !defined(__NR__newselect)
-	struct sel_arg_struct {
-		unsigned long n;
-		fd_set *r, *w, *e;
-		struct timeval *t;
-	} arg = { .n = nfds, .r = rfds, .w = wfds, .e = efds, .t = timeout };
-	return my_syscall1(__NR_select, &arg);
-#elif defined(__NR__newselect)
-	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
-#elif defined(__NR_select)
-	return my_syscall5(__NR_select, nfds, rfds, wfds, efds, timeout);
-#elif defined(__NR_pselect6)
+#if defined(__NR_pselect6)
 	struct __kernel_old_timespec t;
 
 	if (timeout) {

-- 
2.52.0



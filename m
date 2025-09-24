Return-Path: <linux-kselftest+bounces-42191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC59DB9A3A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 16:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 384227A9CC8
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 14:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2F330DEAD;
	Wed, 24 Sep 2025 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="d2JMJbLx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F87307AEB;
	Wed, 24 Sep 2025 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723731; cv=none; b=O1yemQr1Hrb/mt/TouCyFa0nsUYniNdjR5bwW4rEEfoGL0UDSsOObOZTl5CIrWNgSvF4zh9tjF+dRx7fbU4jn2hMVL0+CJEo8SARNYbJb9ZQVp1aAzxiL49xtISEReoFGS1j0Y2pJMIcwjnIIvXyA9gZ9lNNfURa1eONychgrhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723731; c=relaxed/simple;
	bh=JHmhFFy3YycfuHtBvf9yxATgV1mZYvcB4VKEeyw6hqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2BQZqVrVaG0lpzQ0ZWvy2Fu0OH5dMPmzSEjch34GkI7jIAdkUtbtpQfY/IYBqZdATpO+OVRHZU6qBkpat9gV4pCYgWgoehRZz5DdCErtBD1kZnfOsB2aA9MDPbFv1qu2dI+dBkv4tsp0mi0LouTCUweOROEOBVDbV5/9C5wrxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=d2JMJbLx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sC8Bv+IHsX6wUs//ST+Kb4J52aBiV724ykUwuhZDdgY=;
	t=1758723730; x=1759933330; b=d2JMJbLxowLhB8kNmUYiA9wxwCXA+bYCgCbdSS43f9/T+t7
	hX1CuIOJlOHNkNFikeQ82zFLp0wkakGv02MzT8mEFrNOQb7oXhHom+3Gi99/57fpSA+r1+p051LyA
	4USC8jh+HXNJy4v/0lyo7hvjI1LC1C29EDZ1ri2FRVzy7LCbfR/+K1jD55MV6tZjIJXkKiN6Cz44c
	Vc/Lb0lmXXI+vmHptYmMbBIJGPvvH0hrQhARwEzIdlNhl4M7nPMyWPWlZn+1R1iMobT22u6KPViaS
	2ooM7UqRPWpvvynT9kN5oLpxDFkAeAO6f1sJlozo3Efn1Q0dQxHCCArz/btCQIPA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1QNi-000000090Bz-1RrK;
	Wed, 24 Sep 2025 16:22:07 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 12/12] um: switch ptrace FP register access to nolibc
Date: Wed, 24 Sep 2025 16:20:59 +0200
Message-ID: <20250924142059.527768-13-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924142059.527768-1-benjamin@sipsolutions.net>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The registers.c file only contains the routines for floating point
register access in ptrace mode and initial size detection. After the
addition of sys/uio.h and sys/ptrace.h to nolibc it can be moved to use
it by using the sys_ptrace() wrapper.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---
v3:
- Cast argument to (void *)
- Remove unused sys/user.h include which does not exist in nolibc

v2:
- Use new sys_ptrace from nolibc
---
 arch/x86/um/os-Linux/Makefile    |  5 ++++-
 arch/x86/um/os-Linux/registers.c | 20 +++++---------------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/x86/um/os-Linux/Makefile b/arch/x86/um/os-Linux/Makefile
index 77a308aaa5ec..d37320430822 100644
--- a/arch/x86/um/os-Linux/Makefile
+++ b/arch/x86/um/os-Linux/Makefile
@@ -3,10 +3,13 @@
 # Licensed under the GPL
 #
 
-obj-y = registers.o mcontext.o
+obj-y = mcontext.o
 
 obj-$(CONFIG_X86_32) += tls.o
 
 USER_OBJS := $(obj-y)
 
+obj-y += registers.o
+NOLIBC_OBJS := registers.o
+
 include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
index eb1cdadc8a61..72c7493f3b89 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -7,9 +7,6 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <sys/ptrace.h>
-#ifdef __i386__
-#include <sys/user.h>
-#endif
 #include <longjmp.h>
 #include <sysdep/ptrace_user.h>
 #include <sys/uio.h>
@@ -28,9 +25,7 @@ int get_fp_registers(int pid, unsigned long *regs)
 		.iov_len = host_fp_size,
 	};
 
-	if (ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov) < 0)
-		return -errno;
-	return 0;
+	return sys_ptrace(PTRACE_GETREGSET, pid, (void *)ptrace_regset, &iov);
 }
 
 int put_fp_registers(int pid, unsigned long *regs)
@@ -40,9 +35,7 @@ int put_fp_registers(int pid, unsigned long *regs)
 		.iov_len = host_fp_size,
 	};
 
-	if (ptrace(PTRACE_SETREGSET, pid, ptrace_regset, &iov) < 0)
-		return -errno;
-	return 0;
+	return sys_ptrace(PTRACE_SETREGSET, pid, (void *)ptrace_regset, &iov);
 }
 
 int arch_init_registers(int pid)
@@ -60,9 +53,7 @@ int arch_init_registers(int pid)
 
 	/* GDB has x86_xsave_length, which uses x86_cpuid_count */
 	ptrace_regset = NT_X86_XSTATE;
-	ret = ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
-	if (ret)
-		ret = -errno;
+	ret = sys_ptrace(PTRACE_GETREGSET, pid, (void *)ptrace_regset, &iov);
 
 	if (ret == -ENODEV) {
 #ifdef CONFIG_X86_32
@@ -71,9 +62,8 @@ int arch_init_registers(int pid)
 		ptrace_regset = NT_PRFPREG;
 #endif
 		iov.iov_len = 2 * 1024 * 1024;
-		ret = ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
-		if (ret)
-			ret = -errno;
+		ret = sys_ptrace(PTRACE_GETREGSET, pid,
+				 (void *)ptrace_regset, &iov);
 	}
 
 	munmap(iov.iov_base, 2 * 1024 * 1024);
-- 
2.51.0



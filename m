Return-Path: <linux-kselftest+bounces-41461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC35B57147
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 09:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8688E3B1671
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 07:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258692D8368;
	Mon, 15 Sep 2025 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OjpYR4o0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385DE2D7DD0;
	Mon, 15 Sep 2025 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920935; cv=none; b=LFcskZmFkPspvAYqzs6zGzzL8D4fXYVvzJaCU1B2CMVJ5n8i2mxdi8TqeUKEx0/bVP2SGYYd+67i0kw8Qy8tO2hVXKTOD8vipmZnDBA8Wj+GE2Zm7pCtJSXdXiueGFpWwXNBnqkTGmZY+V2WpncXSW+q/VyHoHzwk1CosXpTD3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920935; c=relaxed/simple;
	bh=D1njsi3Dc3pm+FEmPaeoan3fmVED/gaa/845805VSmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeAlElPuBC0l7eV0c50WVTjep0MzeJW+yl81rdYiM26HZzJxq+d5zapy08VVHKLfTJJLuvL/zLldhoWEJ9mmkUILvGUedEg6Hq/oPNbiaj7J2gRgiNLgZ4jMDPxxfFdEkhzH/smYGSrRYeg+Ckomt5McgfjCxtVm0G3tx3KcJHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OjpYR4o0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=EzGYOyHyBK8XRCpIi1QlHK5VKphrWANC8ROrsS0E19Q=;
	t=1757920933; x=1759130533; b=OjpYR4o0tQBaelHAEQh4eaJY/Y0hlVFkY+foOTsAQpfQWbC
	r9QZWxa0Jz3zVpSM1mYawHZ1B8JwKIPFxyPVpvokiOcH44kkyru9QXYRSbKgyu41TZrz/3aqtWI/d
	3+5YuIg5b4Pbe5OfMiwHDmZc0wwQRdHX7q0T1VxB+5IRHZaEPv6z7hr4GxLn9vYvupczLTItgh55d
	e4qfwHyqKbtol5U/Gz6vn0+ElwgJgNFPkb57js4WGCWPXe4KcYxPvVldl/+pfE8yK2T2dh5kqph0d
	gvl8niGNcQfjcg9KfDd7yAxNVkKg+orl6FZF0VCYILu9t+r9F95eB5jYbPt2/SRg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uy3XO-00000005w6o-0YuW;
	Mon, 15 Sep 2025 09:22:10 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 9/9] um: switch ptrace FP register access to nolibc
Date: Mon, 15 Sep 2025 09:11:15 +0200
Message-ID: <20250915071115.1429196-10-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915071115.1429196-1-benjamin@sipsolutions.net>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The registers.c file only contain the routines for floating point
register access in ptrace mode and initial size detection. The file can
be moved over to nolibc by replacing the ptrace libc call with a simple
wrapper that does a direct syscall.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/x86/um/os-Linux/Makefile    |  5 ++++-
 arch/x86/um/os-Linux/registers.c | 22 ++++++++--------------
 2 files changed, 12 insertions(+), 15 deletions(-)

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
index eb1cdadc8a61..55bce0d3f5d2 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -6,18 +6,20 @@
 
 #include <errno.h>
 #include <stdlib.h>
-#include <sys/ptrace.h>
+#include <linux/ptrace.h>
 #ifdef __i386__
 #include <sys/user.h>
 #endif
 #include <longjmp.h>
 #include <sysdep/ptrace_user.h>
-#include <sys/uio.h>
+#include <linux/uio.h>
 #include <asm/sigcontext.h>
 #include <linux/elf.h>
 #include <registers.h>
 #include <sys/mman.h>
 
+#define my_ptrace(...) my_syscall4(__NR_ptrace, __VA_ARGS__)
+
 static unsigned long ptrace_regset;
 unsigned long host_fp_size;
 
@@ -28,9 +30,7 @@ int get_fp_registers(int pid, unsigned long *regs)
 		.iov_len = host_fp_size,
 	};
 
-	if (ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov) < 0)
-		return -errno;
-	return 0;
+	return my_ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
 }
 
 int put_fp_registers(int pid, unsigned long *regs)
@@ -40,9 +40,7 @@ int put_fp_registers(int pid, unsigned long *regs)
 		.iov_len = host_fp_size,
 	};
 
-	if (ptrace(PTRACE_SETREGSET, pid, ptrace_regset, &iov) < 0)
-		return -errno;
-	return 0;
+	return my_ptrace(PTRACE_SETREGSET, pid, ptrace_regset, &iov);
 }
 
 int arch_init_registers(int pid)
@@ -60,9 +58,7 @@ int arch_init_registers(int pid)
 
 	/* GDB has x86_xsave_length, which uses x86_cpuid_count */
 	ptrace_regset = NT_X86_XSTATE;
-	ret = ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
-	if (ret)
-		ret = -errno;
+	ret = my_ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
 
 	if (ret == -ENODEV) {
 #ifdef CONFIG_X86_32
@@ -71,9 +67,7 @@ int arch_init_registers(int pid)
 		ptrace_regset = NT_PRFPREG;
 #endif
 		iov.iov_len = 2 * 1024 * 1024;
-		ret = ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
-		if (ret)
-			ret = -errno;
+		ret = my_ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
 	}
 
 	munmap(iov.iov_base, 2 * 1024 * 1024);
-- 
2.51.0



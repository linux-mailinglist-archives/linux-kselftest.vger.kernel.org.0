Return-Path: <linux-kselftest+bounces-41972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C40B8A572
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 17:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8431CC2EDF
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE60631E884;
	Fri, 19 Sep 2025 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="papsG43X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F431D753;
	Fri, 19 Sep 2025 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296177; cv=none; b=qJPNj6jCszpnQu5BBIv+WygLn2M+IuqP16a9nC04/hiwbOoFh9FeQ2j2JHADXMtncWXuLLwZLwSyXe/nFAR6pYDYkO9xGIXWqQ8j7vDp69fEVh2ic8eHelceb3/Roc+86CcFidUEPUq5Lu6YV/GZ1hiu6EbUrd1GMPDE0AkEiaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296177; c=relaxed/simple;
	bh=uXhIw5zxMb39SCOcYyn2/s8W7NvYLQ4cNhq6hCD5gAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZqwD2T+OZXcbdFqQ10qLhAPeqariBmsIKCnvjRSkGWOUuFGRzlsRz3bY1spwrrusI9Zgt5JxSaUGbvYJsUXhrsMv+Fz6/bksnZoAFP32D8COfS2+qXGJNkXcZeXt12g3y3GP2+gaqCbhyzsTTcOGfgj69q9gNJh4AZNSQiCHE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=papsG43X; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xO+mVCdWx08eTZ/4OCDNFnsQTwYMKX45MEVddt3khI4=;
	t=1758296176; x=1759505776; b=papsG43XvMRSg+BRjdqjPlwpTANAiJy/UZS8+DyLzRMK44I
	r9PUAneVF7eFNYdWaOa2O/8ZPUbrBeLsAusZCFiCXXSUMmxWRuwTBOSAdq4f4xb38sbPwNHwmpGLn
	zRzwhvUkyKO2biFM/gH3mkUuq+XaehHLjMrvAP5u32i/ML55xV9t3XQ0hyNhi1VJZM0nMdyP06ioi
	LONmjghvX4ZxO/veYD/uENkWgdLIrzeYhEvmfatG8AHPqx54U5V2W34AnTS/uK3OJJ41tks2+K/uL
	siJBDBeMka3WTnh03phCpMkrJYFRt2p+MywloQ5F0RKsWWs8A6NNNAtH2c06xqRA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uzd9f-0000000G6O6-44uB;
	Fri, 19 Sep 2025 17:36:12 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 11/11] um: switch ptrace FP register access to nolibc
Date: Fri, 19 Sep 2025 17:34:20 +0200
Message-ID: <20250919153420.727385-12-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919153420.727385-1-benjamin@sipsolutions.net>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
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
v2:
- Use new sys_ptrace from nolibc
---
 arch/x86/um/os-Linux/Makefile    |  5 ++++-
 arch/x86/um/os-Linux/registers.c | 16 ++++------------
 2 files changed, 8 insertions(+), 13 deletions(-)

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
index eb1cdadc8a61..e570e29c3d73 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -28,9 +28,7 @@ int get_fp_registers(int pid, unsigned long *regs)
 		.iov_len = host_fp_size,
 	};
 
-	if (ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov) < 0)
-		return -errno;
-	return 0;
+	return sys_ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
 }
 
 int put_fp_registers(int pid, unsigned long *regs)
@@ -40,9 +38,7 @@ int put_fp_registers(int pid, unsigned long *regs)
 		.iov_len = host_fp_size,
 	};
 
-	if (ptrace(PTRACE_SETREGSET, pid, ptrace_regset, &iov) < 0)
-		return -errno;
-	return 0;
+	return sys_ptrace(PTRACE_SETREGSET, pid, ptrace_regset, &iov);
 }
 
 int arch_init_registers(int pid)
@@ -60,9 +56,7 @@ int arch_init_registers(int pid)
 
 	/* GDB has x86_xsave_length, which uses x86_cpuid_count */
 	ptrace_regset = NT_X86_XSTATE;
-	ret = ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
-	if (ret)
-		ret = -errno;
+	ret = sys_ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
 
 	if (ret == -ENODEV) {
 #ifdef CONFIG_X86_32
@@ -71,9 +65,7 @@ int arch_init_registers(int pid)
 		ptrace_regset = NT_PRFPREG;
 #endif
 		iov.iov_len = 2 * 1024 * 1024;
-		ret = ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
-		if (ret)
-			ret = -errno;
+		ret = sys_ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
 	}
 
 	munmap(iov.iov_base, 2 * 1024 * 1024);
-- 
2.51.0



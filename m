Return-Path: <linux-kselftest+bounces-46305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D834BC7C848
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 06:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149A03A8759
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 05:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CCB2C159A;
	Sat, 22 Nov 2025 05:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VZsm4dJQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17C42C0F84;
	Sat, 22 Nov 2025 05:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763790687; cv=none; b=lCnIjcOueIAxt1g+QAzecV8C6Rt+dG0QLdvxLo8WiXhh/DVcCaO/IZctBQ3kGE4n5z4gazbYBoN8t5H7+oimEVepvLFGctYtsinolCIQQH7twumpCHHbQQm9La7XGQJX5sOL2NrsnqOVgXcoUjYCagR39lC8Vp1aEP+3RhvOe70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763790687; c=relaxed/simple;
	bh=fWZH+ZH9sPvul/cfP6mD+erj4KfRIqOD7PMjYsJKDUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pHDdaZdhPtH79hVTdq/o+O2+dv29CUhQw46ML0OtsNiOpoiYuMJEHEVASHOxltAYqIsdzw5xmlRPwMf2vBzdmnQ6nntjrfKNMJe/4JPxHPzwO5+VbD86sq6+lPZgWslQf46D0gVJ2eYw5tpnd1pmjJP5pUBPflaQKQCdhrHuGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VZsm4dJQ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OD0jRZ+fXfSPscUraJUmOXDMEdIwvwVQwdCE0K2Bw0c=; b=VZsm4dJQKxCn8DfwBt+0qxXvC4
	Nnd38kNtPKGwVk0WG885tsFwGLsnTze/Z8Cn3Sljtnq0gbkhW+WP0YP5VF3IrsH+0Vb0eJQ2NHgQI
	O38ZiDOr87yuTkuHsTFP0LyDhI0XtmCna1bc7kCdNov+vK5tuBdifOGRNgxE4/Arx9ELX40ClyMik
	gUzAFfQ9OKM9y8kG0iR673ObypSDSiI0EN1XNXXX46uOIcT5ae9cVn7u5JkNxzQ+yTCXQEtp1mofP
	LSEGVYjuqWn23/gAo610xaxUyHlCJisJYAS5km5QP1R5CxgKbwxauJyUReZQAHSUt/dHQrBmJW8Ic
	s98/u5tA==;
Received: from [187.101.0.152] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vMgWp-003xEt-5N; Sat, 22 Nov 2025 06:51:22 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sat, 22 Nov 2025 02:50:47 -0300
Subject: [PATCH v6 5/9] futex: Wire up set_robust_list2 syscall
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-tonyk-robust_futex-v6-5-05fea005a0fd@igalia.com>
References: <20251122-tonyk-robust_futex-v6-0-05fea005a0fd@igalia.com>
In-Reply-To: <20251122-tonyk-robust_futex-v6-0-05fea005a0fd@igalia.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Waiman Long <longman@redhat.com>, Ryan Houdek <Sonicadvance1@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.3

Wire up the new set_robust_list2 syscall in all available architectures.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
 arch/arm/tools/syscall.tbl                  | 1 +
 arch/m68k/kernel/syscalls/syscall.tbl       | 1 +
 arch/microblaze/kernel/syscalls/syscall.tbl | 1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 1 +
 arch/parisc/kernel/syscalls/syscall.tbl     | 1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    | 1 +
 arch/s390/kernel/syscalls/syscall.tbl       | 1 +
 arch/sh/kernel/syscalls/syscall.tbl         | 1 +
 arch/sparc/kernel/syscalls/syscall.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_32.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl      | 1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     | 1 +
 include/uapi/asm-generic/unistd.h           | 5 ++++-
 kernel/sys_ni.c                             | 1 +
 scripts/syscall.tbl                         | 1 +
 18 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 16dca28ebf17..d0cb7b902cc6 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -509,3 +509,4 @@
 577	common	open_tree_attr			sys_open_tree_attr
 578	common	file_getattr			sys_file_getattr
 579	common	file_setattr			sys_file_setattr
+580	common	set_robust_list2		sys_set_robust_list2
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index b07e699aaa3c..910e6e14ccf0 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -484,3 +484,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	set_robust_list2		sys_set_robust_list2
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index f41d38dfbf13..eee3f320483d 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -469,3 +469,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common  set_robust_list2		sys_set_robust_list2
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 580af574fe73..6c69d8ebbc38 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -475,3 +475,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	set_robust_list2		sys_set_robust_list2
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index d824ffe9a014..f70db3741b0e 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -408,3 +408,4 @@
 467	n32	open_tree_attr			sys_open_tree_attr
 468	n32	file_getattr			sys_file_getattr
 469	n32	file_setattr			sys_file_setattr
+470	n32	set_robust_list2		sys_set_robust_list2
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 7a7049c2c307..9480488f9495 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -384,3 +384,4 @@
 467	n64	open_tree_attr			sys_open_tree_attr
 468	n64	file_getattr			sys_file_getattr
 469	n64	file_setattr			sys_file_setattr
+470	n64	set_robust_list2		sys_set_robust_list2
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index d330274f0601..2761c9cd8946 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -457,3 +457,4 @@
 467	o32	open_tree_attr			sys_open_tree_attr
 468	o32	file_getattr			sys_file_getattr
 469	o32	file_setattr			sys_file_setattr
+470	o32	set_robust_list2		sys_set_robust_list2
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 88a788a7b18d..eb37fda5c48f 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -468,3 +468,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	set_robust_list2		sys_set_robust_list2
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index b453e80dfc00..472bebec449d 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -560,3 +560,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	set_robust_list2		sys_set_robust_list2
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 8a6744d658db..ba7fac304941 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -472,3 +472,4 @@
 467  common	open_tree_attr		sys_open_tree_attr		sys_open_tree_attr
 468  common	file_getattr		sys_file_getattr		sys_file_getattr
 469  common	file_setattr		sys_file_setattr		sys_file_setattr
+470  common	set_robust_list2	sys_set_robust_list2		sys_set_robust_list2
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 5e9c9eff5539..c05c94a742be 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -473,3 +473,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	set_robust_list2		sys_set_robust_list2
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index ebb7d06d1044..3a59f3008325 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -515,3 +515,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	set_robust_list2		sys_set_robust_list2
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 4877e16da69a..e9d6e1a1d777 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -475,3 +475,4 @@
 467	i386	open_tree_attr		sys_open_tree_attr
 468	i386	file_getattr		sys_file_getattr
 469	i386	file_setattr		sys_file_setattr
+470	i386	set_robust_list2	sys_set_robust_list2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index ced2a1deecd7..8fdcf090300d 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -394,6 +394,7 @@
 467	common	open_tree_attr		sys_open_tree_attr
 468	common	file_getattr		sys_file_getattr
 469	common	file_setattr		sys_file_setattr
+470	common	set_robust_list2	sys_set_robust_list2
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 374e4cb788d8..d7bb6b9104dd 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -440,3 +440,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	set_robust_list2		sys_set_robust_list2
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 04e0077fb4c9..44fc87287983 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -858,8 +858,11 @@ __SYSCALL(__NR_file_getattr, sys_file_getattr)
 #define __NR_file_setattr 469
 __SYSCALL(__NR_file_setattr, sys_file_setattr)
 
+#define __NR_set_robust_list2 470
+__SYSCALL(__NR_set_robust_list2, sys_set_robust_list2)
+
 #undef __NR_syscalls
-#define __NR_syscalls 470
+#define __NR_syscalls 471
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index bf5d05c635ff..0ca2cfe69b11 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -172,6 +172,7 @@ COND_SYSCALL_COMPAT(fadvise64_64);
 COND_SYSCALL(lsm_get_self_attr);
 COND_SYSCALL(lsm_set_self_attr);
 COND_SYSCALL(lsm_list_modules);
+COND_SYSCALL(set_robust_list2);
 
 /* CONFIG_MMU only */
 COND_SYSCALL(swapon);
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index d1ae5e92c615..58c334aa8922 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -410,3 +410,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	set_robust_list2		sys_set_robust_list2

-- 
2.52.0


